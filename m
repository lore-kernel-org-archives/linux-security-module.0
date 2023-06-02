Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6FC7EE29
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjFBPAx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjFBPAe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:00:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19313E43
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:00:31 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3528jSis021504
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:00:30 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qyd6ptc95-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:00:30 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 488ED31E0484F; Fri,  2 Jun 2023 08:00:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 04/18] bpf: move unprivileged checks into map_create() and bpf_prog_load()
Date:   Fri, 2 Jun 2023 07:59:57 -0700
Message-ID: <20230602150011.1657856-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2VOqSPE9_9TPXn6rAWbxpXVMGF77vY7v
X-Proofpoint-ORIG-GUID: 2VOqSPE9_9TPXn6rAWbxpXVMGF77vY7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make each bpf() syscall command a bit more self-contained, making it
easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
handling down to map_create() and bpf_prog_load(), two special commands
in this regard.

Also swap the order of checks, calling bpf_capable() only if
sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audit
messages.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index edafb0f3053f..4c9e79ec40e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1157,6 +1157,15 @@ static int map_create(union bpf_attr *attr)
 	     !node_online(numa_node)))
 		return -EINVAL;
 
+	/* Intent here is for unprivileged_bpf_disabled to block BPF map
+	 * creation for unprivileged users; other actions depend
+	 * on fd availability and access to bpffs, so are dependent on
+	 * object creation success. Even with unprivileged BPF disabled,
+	 * capability checks are still carried out.
+	 */
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+		return -EPERM;
+
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map = find_and_alloc_map(attr);
 	if (IS_ERR(map))
@@ -2532,6 +2541,16 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	is_gpl = license_is_gpl_compatible(license);
 
+	/* Intent here is for unprivileged_bpf_disabled to block BPF program
+	 * creation for unprivileged users; other actions depend
+	 * on fd availability and access to bpffs, so are dependent on
+	 * object creation success. Even with unprivileged BPF disabled,
+	 * capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+		return -EPERM;
+
 	if (attr->insn_cnt == 0 ||
 	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
@@ -5098,23 +5117,8 @@ static int token_create(union bpf_attr *attr)
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

