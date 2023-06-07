Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541AEC7EE23
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFGXzH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjFGXzG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:55:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA45213F
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:55:02 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Hmeew014397
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:55:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a7su06s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:55:02 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7ADD232857E3C; Wed,  7 Jun 2023 16:54:22 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 13/18] bpf: keep BPF_PROG_LOAD permission checks clear of validations
Date:   Wed, 7 Jun 2023 16:53:47 -0700
Message-ID: <20230607235352.1723243-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZYA0DEWFudvbqD-uFXGbEnJhLRKQ0fPu
X-Proofpoint-GUID: ZYA0DEWFudvbqD-uFXGbEnJhLRKQ0fPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_12,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Move out flags validation and license checks out of the permission
checks. They were intermingled, which makes subsequent changes harder.
Clean this up: perform straightforward flag validation upfront, and
fetch and check license later, right where we use it. Also consolidate
capabilities check in one block, right after basic attribute sanity
checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d9f971ec227..8e5c42af978c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2582,7 +2582,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	struct btf *attach_btf = NULL;
 	int err;
 	char license[128];
-	bool is_gpl;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2601,16 +2600,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
 
-	/* copy eBPF program license from user space */
-	if (strncpy_from_bpfptr(license,
-				make_bpfptr(attr->license, uattr.is_kernel),
-				sizeof(license) - 1) < 0)
-		return -EFAULT;
-	license[sizeof(license) - 1] = 0;
-
-	/* eBPF programs must be GPL compatible to use GPL-ed functions */
-	is_gpl = license_is_gpl_compatible(license);
-
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
@@ -2703,12 +2692,20 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			     make_bpfptr(attr->insns, uattr.is_kernel),
 			     bpf_prog_insn_size(prog)) != 0)
 		goto free_prog_sec;
+	/* copy eBPF program license from user space */
+	if (strncpy_from_bpfptr(license,
+				make_bpfptr(attr->license, uattr.is_kernel),
+				sizeof(license) - 1) < 0)
+		goto free_prog_sec;
+	license[sizeof(license) - 1] = 0;
+
+	/* eBPF programs must be GPL compatible to use GPL-ed functions */
+	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
 
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
 	atomic64_set(&prog->aux->refcnt, 1);
-	prog->gpl_compatible = is_gpl ? 1 : 0;
 
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err = bpf_prog_dev_bound_init(prog, attr);
-- 
2.34.1

