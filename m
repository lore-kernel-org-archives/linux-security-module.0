Return-Path: <SRS0=qkJb=5O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC9C2D0EB
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFC92074F
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecjt+t8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgC2AoH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:44:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgC2AoG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so16549452wrw.12
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NClpa9OTqjXVYb4HzHQR31vWEe/lthorA38otzIJk8s=;
        b=ecjt+t8UulVsPa5iDcxiiKFq1IxDGmY+H4r3qyzT1KsJzgxLDLHHoeLukJqCgajvdO
         ltnhbOZL5E3SC/CF/qdvJG4jT1Wy0wgoeqxlK9C0p5xOvBAzWECBbpu3AfNOwlEKC37E
         cDcLDJDFFXiYo3pypLAdkTm8+2w3t+oXnBOag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NClpa9OTqjXVYb4HzHQR31vWEe/lthorA38otzIJk8s=;
        b=qWJI+JRpuFSN1mX1k83vl3v+jrle5NmaST6TFUF4K6qpdwC6RQokqiYm58/DPrRxu9
         wtmlEsNo17H9tnz0hPlmZr8Ai8JI5N3f4fxhaQ8EYTC8RQHM71zDJMIz1KR+UBSVMF6Z
         Abq59ulA8jN1xCkd4cu9Mpq2w3llklKVK4mmX3t3Vm7iFYL/sirIchfY2qDTl/vEMZci
         coZhNr+84qcnGtiLF/UQ86KoFQmyvN9qb8snyt3TBYXOlIPfARHm97p9GGJWZjfU23jn
         0AF7NRTj3EhUF4Dp730Qc/DH4hiKHxMNviyDdAbDC6DoAil8zzI75HNG/tZoyoLPjpJ3
         K3sw==
X-Gm-Message-State: ANhLgQ0hTk2WKl8P/66NMxtnHstwhINZC0/nnlZjylNtcFjGCdOJybcT
        EuY6GmI1g2OFP2ZncZ5bzVxnYA==
X-Google-Smtp-Source: ADFU+vvN7BVf+UWF8bVpHeSjk39UXyS/PYf5mk7IKvTGywyQ/sOP0kMExkEw+crzEnv66HPUrDCzhQ==
X-Received: by 2002:adf:f38e:: with SMTP id m14mr7324444wro.54.1585442645060;
        Sat, 28 Mar 2020 17:44:05 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:04 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v9 4/8] bpf: lsm: Implement attach, detach and execution
Date:   Sun, 29 Mar 2020 01:43:52 +0100
Message-Id: <20200329004356.27286-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

JITed BPF programs are dynamically attached to the LSM hooks
using BPF trampolines. The trampoline prologue generates code to handle
conversion of the signature of the hook to the appropriate BPF context.

The allocated trampoline programs are attached to the nop functions
initialized as LSM hooks.

BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
and need CAP_SYS_ADMIN (required for loading eBPF programs).

Upon attachment:

* A BPF fexit trampoline is used for LSM hooks with a void return type.
* A BPF fmod_ret trampoline is used for LSM hooks which return an
  int. The attached programs can override the return value of the
  bpf LSM hook to indicate a MAC Policy decision.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 include/linux/bpf_lsm.h | 11 ++++++++
 kernel/bpf/bpf_lsm.c    | 23 +++++++++++++++++
 kernel/bpf/btf.c        | 16 +++++++++++-
 kernel/bpf/syscall.c    | 57 ++++++++++++++++++++++++++++-------------
 kernel/bpf/trampoline.c | 17 +++++++++---
 kernel/bpf/verifier.c   | 19 +++++++++++---
 6 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 83b96895829f..af74712af585 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -17,6 +17,17 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog);
+
+#else /* !CONFIG_BPF_LSM */
+
+static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+				      const struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3b3bbb28603e..19636703b24e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -9,6 +9,8 @@
 #include <linux/btf.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <linux/kallsyms.h>
+#include <linux/bpf_verifier.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -22,6 +24,27 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
+
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog)
+{
+	if (!prog->gpl_compatible) {
+		bpf_log(vlog,
+			"LSM programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
+		    sizeof(BPF_LSM_SYM_PREFX) - 1)) {
+		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
+			prog->aux->attach_btf_id, prog->aux->attach_func_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6f397c4da05e..de335cd386f0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,7 +3710,21 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	if (arg == nr_args) {
-		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
+		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		    prog->expected_attach_type == BPF_LSM_MAC) {
+			/* When LSM programs are attached to void LSM hooks
+			 * they use FEXIT trampolines and when attached to
+			 * int LSM hooks, they use MODIFY_RETURN trampolines.
+			 *
+			 * While the LSM programs are BPF_MODIFY_RETURN-like
+			 * the check:
+			 *
+			 *	if (ret_type != 'int')
+			 *		return -EINVAL;
+			 *
+			 * is _not_ done here. This is still safe as LSM hooks
+			 * have only void and int return types.
+			 */
 			if (!t)
 				return true;
 			t = btf_type_by_id(btf, t->type);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2584b25748c..a616b63f23b4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -25,6 +25,7 @@
 #include <linux/nospec.h>
 #include <linux/audit.h>
 #include <uapi/linux/btf.h>
+#include <linux/bpf_lsm.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -1935,6 +1936,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 
 		switch (prog_type) {
 		case BPF_PROG_TYPE_TRACING:
+		case BPF_PROG_TYPE_LSM:
 		case BPF_PROG_TYPE_STRUCT_OPS:
 		case BPF_PROG_TYPE_EXT:
 			break;
@@ -2366,10 +2368,28 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 	struct file *link_file;
 	int link_fd, err;
 
-	if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
-	    prog->expected_attach_type != BPF_TRACE_FEXIT &&
-	    prog->expected_attach_type != BPF_MODIFY_RETURN &&
-	    prog->type != BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
+		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	case BPF_PROG_TYPE_EXT:
+		if (prog->expected_attach_type != 0) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	case BPF_PROG_TYPE_LSM:
+		if (prog->expected_attach_type != BPF_LSM_MAC) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	default:
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -2448,16 +2468,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
-	    prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_EXT &&
-	    prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
-		err = -EINVAL;
-		goto out_put_prog;
-	}
-
-	if (prog->type == BPF_PROG_TYPE_TRACING ||
-	    prog->type == BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
 		if (attr->raw_tracepoint.name) {
 			/* The attach point for this category of programs
 			 * should be specified via btf_id during program load.
@@ -2465,11 +2479,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 			err = -EINVAL;
 			goto out_put_prog;
 		}
-		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+		if (prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 			tp_name = prog->aux->attach_func_name;
-		else
-			return bpf_tracing_prog_attach(prog);
-	} else {
+			break;
+		}
+		return bpf_tracing_prog_attach(prog);
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf,
 				      u64_to_user_ptr(attr->raw_tracepoint.name),
 				      sizeof(buf) - 1) < 0) {
@@ -2478,6 +2495,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 		}
 		buf[sizeof(buf) - 1] = 0;
 		tp_name = buf;
+		break;
+	default:
+		err = -EINVAL;
+		goto out_put_prog;
 	}
 
 	btp = bpf_get_raw_tracepoint(tp_name);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f30bca2a4d01..9be85aa4ec5f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -6,6 +6,7 @@
 #include <linux/ftrace.h>
 #include <linux/rbtree_latch.h>
 #include <linux/perf_event.h>
+#include <linux/btf.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -233,15 +234,23 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	return err;
 }
 
-static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
+static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
-	switch (t) {
+	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_LSM_MAC:
+		if (!prog->aux->attach_func_proto->type)
+			/* The function returns void, we cannot modify its
+			 * return value.
+			 */
+			return BPF_TRAMP_FEXIT;
+		else
+			return BPF_TRAMP_MODIFY_RETURN;
 	default:
 		return BPF_TRAMP_REPLACE;
 	}
@@ -255,7 +264,7 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog)
 	int cnt;
 
 	tr = prog->aux->trampoline;
-	kind = bpf_attach_type_to_tramp(prog->expected_attach_type);
+	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (tr->extension_prog) {
 		/* cannot attach fentry/fexit if extension prog is attached.
@@ -305,7 +314,7 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
 	int err;
 
 	tr = prog->aux->trampoline;
-	kind = bpf_attach_type_to_tramp(prog->expected_attach_type);
+	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 46ba86c540e2..047b2e876399 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20,6 +20,7 @@
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
 #include <linux/error-injection.h>
+#include <linux/bpf_lsm.h>
 
 #include "disasm.h"
 
@@ -6492,8 +6493,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum range = tnum_range(0, 1);
 	int err;
 
-	/* The struct_ops func-ptr's return type could be "void" */
-	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	/* LSM and struct_ops func-ptr's return type could be "void" */
+	if ((env->prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	     env->prog->type == BPF_PROG_TYPE_LSM) &&
 	    !prog->aux->attach_func_proto->type)
 		return 0;
 
@@ -9923,7 +9925,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return check_struct_ops_btf_id(env);
 
-	if (prog->type != BPF_PROG_TYPE_TRACING && !prog_extension)
+	if (prog->type != BPF_PROG_TYPE_TRACING &&
+	    prog->type != BPF_PROG_TYPE_LSM &&
+	    !prog_extension)
 		return 0;
 
 	if (!btf_id) {
@@ -10054,8 +10058,16 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return -EINVAL;
 		/* fallthrough */
 	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+		prog->aux->attach_func_name = tname;
+		if (prog->type == BPF_PROG_TYPE_LSM) {
+			ret = bpf_lsm_verify_prog(&env->log, prog);
+			if (ret < 0)
+				return ret;
+		}
+
 		if (!btf_type_is_func(t)) {
 			verbose(env, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -10070,7 +10082,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		tr = bpf_trampoline_lookup(key);
 		if (!tr)
 			return -ENOMEM;
-		prog->aux->attach_func_name = tname;
 		/* t is either vmlinux type or another program's type */
 		prog->aux->attach_func_proto = t;
 		mutex_lock(&tr->mutex);
-- 
2.20.1

