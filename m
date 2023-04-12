Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F59C77B75
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 04:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDLEdZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 00:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDLEdX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD949FD
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:33:22 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTSFC011352
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:33:22 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwahbm2hb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 11 Apr 2023 21:33:21 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:19 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F341A2DCF4424; Tue, 11 Apr 2023 21:33:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/8] bpf: move unprivileged checks into map_create() and bpf_prog_load()
Date:   Tue, 11 Apr 2023 21:32:53 -0700
Message-ID: <20230412043300.360803-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X5SMYaGHPmGIXUwh3zg4D0IEPhypCtoX
X-Proofpoint-ORIG-GUID: X5SMYaGHPmGIXUwh3zg4D0IEPhypCtoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make each bpf() syscall command a bit more self-contained, making it
easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
handling down to map_create() and bpf_prog_load(), two special commands
in this regard.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d575505f89c..c1d268025985 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1130,6 +1130,17 @@ static int map_create(union bpf_attr *attr)
 	int f_flags;
 	int err;
 
+	/* Intent here is for unprivileged_bpf_disabled to block key object
+	 * creation commands for unprivileged users; other actions depend
+	 * of fd availability and access to bpffs, so are dependent on
+	 * object creation success.  Capabilities are later verified for
+	 * operations such as load and map create, so even with unprivileged
+	 * BPF disabled, capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
+		return -EPERM;
+
 	err = CHECK_ATTR(BPF_MAP_CREATE);
 	if (err)
 		return -EINVAL;
@@ -2512,6 +2523,17 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	char license[128];
 	bool is_gpl;
 
+	/* Intent here is for unprivileged_bpf_disabled to block key object
+	 * creation commands for unprivileged users; other actions depend
+	 * of fd availability and access to bpffs, so are dependent on
+	 * object creation success.  Capabilities are later verified for
+	 * operations such as load and map create, so even with unprivileged
+	 * BPF disabled, capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
+		return -EPERM;
+
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
 
@@ -5008,23 +5030,8 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
-	bool capable;
 	int err;
 
-	capable = bpf_capable() || !sysctl_unprivileged_bpf_disabled;
-
-	/* Intent here is for unprivileged_bpf_disabled to block key object
-	 * creation commands for unprivileged users; other actions depend
-	 * of fd availability and access to bpffs, so are dependent on
-	 * object creation success.  Capabilities are later verified for
-	 * operations such as load and map create, so even with unprivileged
-	 * BPF disabled, capability checks are still carried out for these
-	 * and other operations.
-	 */
-	if (!capable &&
-	    (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD))
-		return -EPERM;
-
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;
-- 
2.34.1

