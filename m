Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437AAC4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 03:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbjKJDtb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Nov 2023 22:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbjKJDtT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 22:49:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4444BD
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 19:49:15 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYZFb029062
        for <linux-security-module@vger.kernel.org>; Thu, 9 Nov 2023 19:49:15 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3u97ht234n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 19:49:15 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:49:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 001453B41DC63; Thu,  9 Nov 2023 19:49:00 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 11/17] bpf,lsm: add BPF token LSM hooks
Date:   Thu, 9 Nov 2023 19:48:32 -0800
Message-ID: <20231110034838.1295764-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2iDzOVYcj61resvu1-c2i10X2DLsA-uJ
X-Proofpoint-GUID: 2iDzOVYcj61resvu1-c2i10X2DLsA-uJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
allocate LSM security blob (we add `void *security` field to struct
bpf_token for that), but also control who can instantiate BPF token.
This follows existing pattern for BPF map and BPF prog.

Also add security_bpf_token_allow_cmd() and security_bpf_token_capable()
LSM hooks that allow LSM implementation to control and negate (if
necessary) BPF token's delegation of a specific bpf_cmd and capability,
respectively.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h           |  3 ++
 include/linux/lsm_hook_defs.h |  5 +++
 include/linux/security.h      | 25 +++++++++++++++
 kernel/bpf/bpf_lsm.c          |  4 +++
 kernel/bpf/token.c            | 18 +++++++----
 security/security.c           | 60 +++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d44f252c3a1b..3a0ba85e1057 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1587,6 +1587,9 @@ struct bpf_token {
 	u64 allowed_maps;
 	u64 allowed_progs;
 	u64 allowed_attachs;
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 };
 
 struct bpf_struct_ops_value;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 795d3860c302..1b0ff65c9e63 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -404,6 +404,11 @@ LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
+	 struct path *path)
+LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
+LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
+LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 08fd777cbe94..00809d2d5c38 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <linux/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -2031,6 +2032,11 @@ extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
+extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				     struct path *path);
+extern void security_bpf_token_free(struct bpf_token *token);
+extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2065,6 +2071,25 @@ static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *
 
 static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
+
+static inline int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				     struct path *path)
+{
+	return 0;
+}
+
+static inline void security_bpf_token_free(struct bpf_token *token)
+{ }
+
+static inline int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	return 0;
+}
+
+static inline int security_bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return 0;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9e4e615f11eb..7d2f96413a57 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -265,6 +265,10 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog)
 BTF_ID(func, bpf_lsm_bpf_prog_load)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
+BTF_ID(func, bpf_lsm_bpf_token_create)
+BTF_ID(func, bpf_lsm_bpf_token_free)
+BTF_ID(func, bpf_lsm_bpf_token_cmd)
+BTF_ID(func, bpf_lsm_bpf_token_capable)
 BTF_ID(func, bpf_lsm_bprm_check_security)
 BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 7a5183578a69..71b6eb2e2774 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -7,15 +7,15 @@
 #include <linux/idr.h>
 #include <linux/namei.h>
 #include <linux/user_namespace.h>
+#include <linux/security.h>
 
 bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
 	/* BPF token allows ns_capable() level of capabilities */
 	if (token) {
-		if (ns_capable(token->userns, cap))
-			return true;
-		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
-			return true;
+		if (ns_capable(token->userns, cap) ||
+		    (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN)))
+			return security_bpf_token_capable(token, cap) == 0;
 	}
 	/* otherwise fallback to capable() checks */
 	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
@@ -28,6 +28,7 @@ void bpf_token_inc(struct bpf_token *token)
 
 static void bpf_token_free(struct bpf_token *token)
 {
+	security_bpf_token_free(token);
 	put_user_ns(token->userns);
 	kvfree(token);
 }
@@ -175,6 +176,10 @@ int bpf_token_create(union bpf_attr *attr)
 	token->allowed_progs = mnt_opts->delegate_progs;
 	token->allowed_attachs = mnt_opts->delegate_attachs;
 
+	err = security_bpf_token_create(token, attr, &path);
+	if (err)
+		goto out_token;
+
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err = fd;
@@ -219,8 +224,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 {
 	if (!token)
 		return false;
-
-	return token->allowed_cmds & (1ULL << cmd);
+	if (!(token->allowed_cmds & (1ULL << cmd)))
+		return false;
+	return security_bpf_token_cmd(token, cmd) == 0;
 }
 
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)
diff --git a/security/security.c b/security/security.c
index ad24cf36da94..088a79c35c26 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5201,6 +5201,55 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
 
+/**
+ * security_bpf_token_create() - Check if creating of BPF token is allowed
+ * @token: BPF token object
+ * @attr: BPF syscall attributes used to create BPF token
+ * @path: path pointing to BPF FS mount point from which BPF token is created
+ *
+ * Do a check when the kernel instantiates a new BPF token object from BPF FS
+ * instance. This is also the point where LSM blob can be allocated for LSMs.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+			      struct path *path)
+{
+	return call_int_hook(bpf_token_create, 0, token, attr, path);
+}
+
+/**
+ * security_bpf_token_cmd() - Check if BPF token is allowed to delegate
+ * requested BPF syscall command
+ * @token: BPF token object
+ * @cmd: BPF syscall command requested to be delegated by BPF token
+ *
+ * Do a check when the kernel decides whether provided BPF token should allow
+ * delegation of requested BPF syscall command.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	return call_int_hook(bpf_token_cmd, 0, token, cmd);
+}
+
+/**
+ * security_bpf_token_capable() - Check if BPF token is allowed to delegate
+ * requested BPF-related capability
+ * @token: BPF token object
+ * @cap: capabilities requested to be delegated by BPF token
+ *
+ * Do a check when the kernel decides whether provided BPF token should allow
+ * delegation of requested BPF-related capabilities.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return call_int_hook(bpf_token_capable, 0, token, cap);
+}
+
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
@@ -5222,6 +5271,17 @@ void security_bpf_prog_free(struct bpf_prog *prog)
 {
 	call_void_hook(bpf_prog_free, prog);
 }
+
+/**
+ * security_bpf_token_free() - Free a BPF token's LSM blob
+ * @token: BPF token struct
+ *
+ * Clean up the security information stored inside BPF token.
+ */
+void security_bpf_token_free(struct bpf_token *token)
+{
+	call_void_hook(bpf_token_free, token);
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 /**
-- 
2.34.1

