Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBDAC7619A
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 04:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDLEfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLEfv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 00:35:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFFE66
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:35:50 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTnNk005888
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:35:49 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pw3jc6h5u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:35:49 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:35:48 -0700
Received: from twshared6687.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:35:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5B7492DCF455A; Tue, 11 Apr 2023 21:33:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 6/8] bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
Date:   Tue, 11 Apr 2023 21:32:58 -0700
Message-ID: <20230412043300.360803-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K75pWBtJBbBedWry3W6moOFs6zaQ6enf
X-Proofpoint-ORIG-GUID: K75pWBtJBbBedWry3W6moOFs6zaQ6enf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
unintentionally left when we switched to a model that all BPF map
operations should be allowed regardless of CAP_BPF (or any other
capabilities), as long as process got BPF map FD somehow.

This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
writeable access check, given conceptually freezing the map is modifying
it: map becomes unmodifiable for subsequent updates.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d1165814efc..42d8473237ab 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2001,6 +2001,11 @@ static int map_freeze(const union bpf_attr *attr)
 		return -ENOTSUPP;
 	}
 
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	mutex_lock(&map->freeze_mutex);
 	if (bpf_map_write_active(map)) {
 		err = -EBUSY;
@@ -2010,10 +2015,6 @@ static int map_freeze(const union bpf_attr *attr)
 		err = -EBUSY;
 		goto err_put;
 	}
-	if (!bpf_capable()) {
-		err = -EPERM;
-		goto err_put;
-	}
 
 	WRITE_ONCE(map->frozen, true);
 err_put:
-- 
2.34.1

