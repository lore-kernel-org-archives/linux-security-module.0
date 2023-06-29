Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C4C0015E
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 05:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjF2FTW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2FTN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:19:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC5294E
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:19:08 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0RbGN017678
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:19:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgye41srh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:19:08 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:19:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2480933AFB71C; Wed, 28 Jun 2023 22:19:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 13/14] libbpf: add BPF token support to bpf_prog_load() API
Date:   Wed, 28 Jun 2023 22:18:31 -0700
Message-ID: <20230629051832.897119-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fH9X1J_fGk75I3YumOff80uXjVdNAVQ2
X-Proofpoint-ORIG-GUID: fH9X1J_fGk75I3YumOff80uXjVdNAVQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Wire through token_fd into bpf_prog_load(). Also make sure to pass
allowed_{prog,attach}_types to kernel in bpf_token_create().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 5 ++++-
 tools/lib/bpf/bpf.h | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6fb915069be7..5f331bbf1ad2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -234,7 +234,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -263,6 +263,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_flags = OPTS_GET(opts, prog_flags, 0);
 	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
+	attr.prog_token_fd = OPTS_GET(opts, token_fd, 0);
 
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
@@ -1223,6 +1224,8 @@ int bpf_token_create(int pin_path_fd, const char *pin_pathname, struct bpf_token
 	attr.token_create.pin_flags = OPTS_GET(opts, pin_flags, 0);
 	attr.token_create.allowed_cmds = OPTS_GET(opts, allowed_cmds, 0);
 	attr.token_create.allowed_map_types = OPTS_GET(opts, allowed_map_types, 0);
+	attr.token_create.allowed_prog_types = OPTS_GET(opts, allowed_prog_types, 0);
+	attr.token_create.allowed_attach_types = OPTS_GET(opts, allowed_attach_types, 0);
 
 	ret = sys_bpf(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index dc7c4af21ad9..2ac56fba6027 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -104,9 +104,10 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field token_fd
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
@@ -561,9 +562,11 @@ struct bpf_token_create_opts {
 	__u32 pin_flags;
 	__u64 allowed_cmds;
 	__u64 allowed_map_types;
+	__u64 allowed_prog_types;
+	__u64 allowed_attach_types;
 	size_t :0;
 };
-#define bpf_token_create_opts__last_field allowed_map_types
+#define bpf_token_create_opts__last_field allowed_attach_types
 
 /**
  * @brief **bpf_token_create()** creates a new instance of BPF token, pinning
-- 
2.34.1

