Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D82EB64DC
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 05:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjF2FSr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF2FSp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:18:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878026BB
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35SHwSSG032748
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3rggbw8u9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:43 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7EA3133AFB43B; Wed, 28 Jun 2023 22:18:36 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 02/14] libbpf: add bpf_token_create() API
Date:   Wed, 28 Jun 2023 22:18:20 -0700
Message-ID: <20230629051832.897119-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 44LjDMQwIStpqJecu43cSoBsO00eRXis
X-Proofpoint-ORIG-GUID: 44LjDMQwIStpqJecu43cSoBsO00eRXis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 21 +++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 32 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 54 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..a247a1612f29 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1201,3 +1201,24 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int pin_path_fd, const char *pin_pathname, struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.pin_path_fd = pin_path_fd;
+	attr.token_create.pin_pathname = ptr_to_u64(pin_pathname);
+	attr.token_create.token_fd = OPTS_GET(opts, token_fd, 0);
+	attr.token_create.token_flags = OPTS_GET(opts, token_flags, 0);
+	attr.token_create.pin_flags = OPTS_GET(opts, pin_flags, 0);
+	attr.token_create.allowed_cmds = OPTS_GET(opts, allowed_cmds, 0);
+
+	ret = sys_bpf(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9aa0ee473754..ab0355d90a2c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -551,6 +551,38 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 token_fd;
+	__u32 token_flags;
+	__u32 pin_flags;
+	__u64 allowed_cmds;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field allowed_cmds
+
+/**
+ * @brief **bpf_token_create()** creates a new instance of BPF token, pinning
+ * it at the specified location in BPF FS.
+ *
+ * BPF token created and pinned with this API can be subsequently opened using
+ * bpf_obj_get() API to obtain FD that can be passed to bpf() syscall for
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param pin_path_fd O_PATH FD (see man 2 openat() for semantics) specifying,
+ * in combination with *pin_pathname*, target location in BPF FS at which to
+ * create and pin BPF token.
+ * @param pin_pathname absolute or relative path specifying, in combination
+ * with *pin_path_fd*, specifying in combination with *pin_path_fd*, target
+ * location in BPF FS at which to create and pin BPF token.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_token_create(int pin_path_fd, const char *pin_pathname,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..62cbe4775081 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_token_create;
 } LIBBPF_1.2.0;
-- 
2.34.1

