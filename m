Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC56FC7EE2E
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 15:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjFBPB1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjFBPBC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:01:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90DE46
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:00:55 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Bcp6e001168
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:00:55 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxxpa8r4c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:00:54 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D064F31E04A8E; Fri,  2 Jun 2023 08:00:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 14/18] bpf: add BPF token support to BPF_PROG_LOAD command
Date:   Fri, 2 Jun 2023 08:00:07 -0700
Message-ID: <20230602150011.1657856-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Rp3M_xPh0CUNzo6dy7DcRCOwe5h0S_T7
X-Proofpoint-ORIG-GUID: Rp3M_xPh0CUNzo6dy7DcRCOwe5h0S_T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add basic support of BPF token to BPF_PROG_LOAD. Extend BPF token to
allow specifying BPF_PROG_LOAD as an allowed command, and also allow to
specify bit sets of program type and attach type combination that would
be allowed to be loaded by requested BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |   6 +
 include/uapi/linux/bpf.h                      |  19 +++
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/syscall.c                          | 118 ++++++++++++++----
 kernel/bpf/token.c                            |  11 ++
 tools/include/uapi/linux/bpf.h                |  19 +++
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |   3 +
 8 files changed, 154 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 657bec546351..320d93c542ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1411,6 +1411,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
 	struct bpf_func_info *func_info;
@@ -1540,6 +1541,8 @@ struct bpf_token {
 	atomic64_t refcnt;
 	u64 allowed_cmds;
 	u64 allowed_map_types;
+	u64 allowed_prog_types;
+	u64 allowed_attach_types;
 };
 
 struct bpf_struct_ops_value;
@@ -2095,6 +2098,9 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 bool bpf_token_capable(const struct bpf_token *token, int cap);
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d30fb567d22a..c2867e622c30 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -999,6 +999,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1201,6 +1202,14 @@ enum {
 	 * token_create.allowed_map_types bit set.
 	 */
 	BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	  = 1U << 1,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_prog_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES	  = 1U << 2,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_attach_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES	  = 1U << 3,
 };
 
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
@@ -1452,6 +1461,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1674,6 +1684,15 @@ union bpf_attr {
 		 * effect on validity checking of this set
 		 */
 		__u64		allowed_map_types;
+		/* similarly to allowed_map_types, bit sets of BPF program
+		 * types and BPF program attach types that are allowed to be
+		 * loaded by requested BPF token;
+		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES and
+		 * BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES for their
+		 * effect on validity checking of these sets
+		 */
+		__u64		allowed_prog_types;
+		__u64		allowed_attach_types;
 	} token_create;
 
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..cd0a93968009 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2597,6 +2597,7 @@ void bpf_prog_free(struct bpf_prog *fp)
 
 	if (aux->dst_prog)
 		bpf_prog_put(aux->dst_prog);
+	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b0a85ac9a42f..e02688bebf8e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2573,13 +2573,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
+	struct bpf_token *token = NULL;
+	bool bpf_cap;
 	int err;
 	char license[128];
 
@@ -2595,10 +2597,31 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
+	bpf_prog_load_fixup_attach_type(attr);
+
+	if (attr->prog_token_fd) {
+		token = bpf_token_get_from_fd(attr->prog_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if current token doesn't grant prog loading permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
+		    !bpf_token_allow_prog_type(token, attr->prog_type,
+					       attr->expected_attach_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	bpf_cap = bpf_token_capable(token, CAP_BPF);
+	err = -EPERM;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
@@ -2607,21 +2630,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * capability checks are still carried out for these
 	 * and other operations.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
+		goto put_token;
 
 	if (attr->insn_cnt == 0 ||
-	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
-		return -E2BIG;
+	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS)) {
+		err = -E2BIG;
+		goto put_token;
+	}
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (is_perfmon_prog_type(type) && !perfmon_capable())
-		return -EPERM;
+	if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_ADMIN))
+		goto put_token;
+	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
+		goto put_token;
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
@@ -2631,27 +2656,33 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		if (IS_ERR(dst_prog)) {
 			dst_prog = NULL;
 			attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
-			if (IS_ERR(attach_btf))
-				return -EINVAL;
+			if (IS_ERR(attach_btf)) {
+				err = -EINVAL;
+				goto put_token;
+			}
 			if (!btf_is_kernel(attach_btf)) {
 				/* attaching through specifying bpf_prog's BTF
 				 * objects directly might be supported eventually
 				 */
 				btf_put(attach_btf);
-				return -ENOTSUPP;
+				err = -ENOTSUPP;
+				goto put_token;
 			}
 		}
 	} else if (attr->attach_btf_id) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
-		if (IS_ERR(attach_btf))
-			return PTR_ERR(attach_btf);
-		if (!attach_btf)
-			return -EINVAL;
+		if (IS_ERR(attach_btf)) {
+			err = PTR_ERR(attach_btf);
+			goto put_token;
+		}
+		if (!attach_btf) {
+			err = -EINVAL;
+			goto put_token;
+		}
 		btf_get(attach_btf);
 	}
 
-	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
 				       dst_prog)) {
@@ -2659,7 +2690,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -EINVAL;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	/* plain bpf_prog allocation */
@@ -2669,7 +2701,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -ENOMEM;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
@@ -2680,6 +2713,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
+	/* move token into prog->aux, reuse taken refcnt */
+	prog->aux->token = token;
+	token = NULL;
+
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
@@ -2781,6 +2818,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
@@ -3537,7 +3576,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -5129,21 +5168,29 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 #define BPF_TOKEN_FLAGS_MASK (			\
 	BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS		\
 	| BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	\
+	| BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES	\
+	| BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES	\
 )
 #define BPF_TOKEN_CMDS_MASK (			\
 	(1ULL << BPF_TOKEN_CREATE)		\
 	| (1ULL << BPF_MAP_CREATE)		\
 	| (1ULL << BPF_BTF_LOAD)		\
+	| (1ULL << BPF_PROG_LOAD)		\
 )
 #define BPF_TOKEN_MAP_TYPES_MASK \
 	((BIT_ULL(__MAX_BPF_MAP_TYPE) - 1) & ~BIT_ULL(BPF_MAP_TYPE_UNSPEC))
+#define BPF_TOKEN_PROG_TYPES_MASK \
+	((BIT_ULL(__MAX_BPF_PROG_TYPE) - 1) & ~BIT_ULL(BPF_PROG_TYPE_UNSPEC))
+#define BPF_TOKEN_ATTACH_TYPES_MASK \
+	(BIT_ULL(__MAX_BPF_ATTACH_TYPE) - 1)
 
-#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_map_types
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_attach_types
 
 static int token_create(union bpf_attr *attr)
 {
 	struct bpf_token *new_token, *token = NULL;
 	u64 allowed_cmds, allowed_map_types;
+	u64 allowed_prog_types, allowed_attach_types;
 	int fd, err;
 
 	if (CHECK_ATTR(BPF_TOKEN_CREATE))
@@ -5177,6 +5224,18 @@ static int token_create(union bpf_attr *attr)
 		err = -ENOTSUPP;
 		goto err_out;
 	}
+	allowed_prog_types = attr->token_create.allowed_prog_types;
+	if (!(attr->token_create.flags & BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES) &&
+	    allowed_prog_types & ~BPF_TOKEN_PROG_TYPES_MASK) {
+		err = -ENOTSUPP;
+		goto err_out;
+	}
+	allowed_attach_types = attr->token_create.allowed_attach_types;
+	if (!(attr->token_create.flags & BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES) &&
+	    allowed_attach_types & ~BPF_TOKEN_ATTACH_TYPES_MASK) {
+		err = -ENOTSUPP;
+		goto err_out;
+	}
 
 	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
 		err = -EPERM;
@@ -5193,6 +5252,13 @@ static int token_create(union bpf_attr *attr)
 		err = -EPERM;
 		goto err_out;
 	}
+	/* requested prog/attach types should be a subset of associated token's set */
+	if (token &&
+	    (((token->allowed_prog_types & allowed_prog_types) != allowed_prog_types) ||
+	    ((token->allowed_attach_types & allowed_attach_types) != allowed_attach_types))) {
+		err = -EPERM;
+		goto err_out;
+	}
 
 	new_token = bpf_token_alloc();
 	if (!new_token) {
@@ -5202,6 +5268,8 @@ static int token_create(union bpf_attr *attr)
 
 	new_token->allowed_cmds = allowed_cmds & BPF_TOKEN_CMDS_MASK;
 	new_token->allowed_map_types = allowed_map_types & BPF_TOKEN_MAP_TYPES_MASK;
+	new_token->allowed_prog_types = allowed_prog_types & BPF_TOKEN_PROG_TYPES_MASK;
+	new_token->allowed_attach_types = allowed_attach_types & BPF_TOKEN_ATTACH_TYPES_MASK;
 
 	fd = bpf_token_new_fd(new_token);
 	if (fd < 0) {
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index ef053c48d7db..e9f651ba07da 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -124,6 +124,17 @@ bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type t
 	return token->allowed_map_types & (1ULL << type);
 }
 
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type)
+{
+	if (!token || prog_type >= __MAX_BPF_PROG_TYPE || attach_type >= __MAX_BPF_ATTACH_TYPE)
+		return false;
+
+	return (token->allowed_prog_types & (1ULL << prog_type)) &&
+	       (token->allowed_attach_types & (1ULL << attach_type));
+}
+
 bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
 	return token || capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d30fb567d22a..c2867e622c30 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -999,6 +999,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1201,6 +1202,14 @@ enum {
 	 * token_create.allowed_map_types bit set.
 	 */
 	BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES	  = 1U << 1,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_prog_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES	  = 1U << 2,
+	/* Similar to BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag, but for
+	 * token_create.allowed_attach_types bit set.
+	 */
+	BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES	  = 1U << 3,
 };
 
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
@@ -1452,6 +1461,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1674,6 +1684,15 @@ union bpf_attr {
 		 * effect on validity checking of this set
 		 */
 		__u64		allowed_map_types;
+		/* similarly to allowed_map_types, bit sets of BPF program
+		 * types and BPF program attach types that are allowed to be
+		 * loaded by requested BPF token;
+		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES and
+		 * BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES for their
+		 * effect on validity checking of these sets
+		 */
+		__u64		allowed_prog_types;
+		__u64		allowed_attach_types;
 	} token_create;
 
 } __attribute__((aligned(8)));
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 573249a2814d..4ed46ed58a7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -30,6 +30,8 @@ void test_libbpf_probe_prog_types(void)
 
 		if (prog_type == BPF_PROG_TYPE_UNSPEC)
 			continue;
+		if (strcmp(prog_type_name, "__MAX_BPF_PROG_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(prog_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index e677c0435cec..ea2a8c4063a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -185,6 +185,9 @@ static void test_libbpf_bpf_prog_type_str(void)
 		const char *prog_type_str;
 		char buf[256];
 
+		if (prog_type == __MAX_BPF_PROG_TYPE)
+			continue;
+
 		prog_type_name = btf__str_by_offset(btf, e->name_off);
 		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
 		ASSERT_OK_PTR(prog_type_str, prog_type_name);
-- 
2.34.1

