Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF19AC3F2D1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D0620CC7
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLpaXKZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgCDBzm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:55:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54500 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387555AbgCDBzl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id i9so144714wml.4
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2020 17:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnWU9Tr02IfIRV60dHV1CddQWPx7YIK+rDCKqkdA7Tk=;
        b=gLpaXKZfYcqKEfMRdOqm0JHQgx6Jjv2j4k7F0xNcNexckgRYBXPd+cVfwBnwHyaOjn
         U7ZjewjIG1F/OEHiQwnV+HXxeb92k1/MrKKADIZ7nfop4i57jvmkiiCzbNuN9JCt7+ld
         rfdYMyK5+uSUNdZRlwaVUOKQR7NzacXU9uWZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnWU9Tr02IfIRV60dHV1CddQWPx7YIK+rDCKqkdA7Tk=;
        b=d5m3W+0LPs0qbBHc6brAurc8+stpxIMMM0i7+fyuhI5R4gARdzhhxaDrEmF/+1eCl7
         3QSjd/16SpzQUySu6f83u6sIlMCDtMu/TnjfygTqWmahH13yh8uHlWxkS4BgTJ8iS+Up
         SxcAuI3gj46MBHgvCMEWkCt+G0jb3DkPgF+MRHTe7nGHk7pcfET+W4UHeV4Uh9On3y6j
         uUQS2jm36dsaGs+Mh0mic/cxWovLAfIS6iPh5sO6bdnvwrYCM2GBzYMIU7pR0L70vxIs
         a87/4UNDdumpS0WK0C6rYxRH3t3oVu9sNip+V3cfHrTWGmMhSYCKq9f2y5sYay42Wvxa
         Ioxw==
X-Gm-Message-State: ANhLgQ1uewRsUSrC7hDoF55ghhO7tpPZ40IzMBuCCsI/ZzbYIUaDKK5k
        Tw2cgCnglCMj/XUUVd6os7R6s2T9ynY=
X-Google-Smtp-Source: ADFU+vuwyw1DZ8/XzM4fVH+cNXnzxYpewtFg4q+E8OBTBu1rgXP9sU1d9dn/Sb/I3qRpoeX7EU1d5w==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr557153wmi.105.1583286936292;
        Tue, 03 Mar 2020 17:55:36 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 1/7] bpf: Refactor trampoline update code
Date:   Wed,  4 Mar 2020 02:55:22 +0100
Message-Id: <20200304015528.29661-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304015528.29661-1-kpsingh@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

As we need to introduce a third type of attachment for trampolines, the
flattened signature of arch_prepare_bpf_trampoline gets even more
complicated.

Refactor the prog and count argument to arch_prepare_bpf_trampoline to
use bpf_tramp_progs to simplify the addition and accounting for new
attachment types.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 31 ++++++++++---------
 include/linux/bpf.h         | 13 ++++++--
 kernel/bpf/bpf_struct_ops.c | 12 ++++++-
 kernel/bpf/trampoline.c     | 62 +++++++++++++++++++++----------------
 4 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9ba08e9abc09..15c7d28bc05c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_prog **progs, int prog_cnt, int stack_size)
+		      struct bpf_tramp_progs *tp, int stack_size)
 {
 	u8 *prog = *pprog;
 	int cnt = 0, i;
 
-	for (i = 0; i < prog_cnt; i++) {
+	for (i = 0; i < tp->nr_progs; i++) {
 		if (emit_call(&prog, __bpf_prog_enter, prog))
 			return -EINVAL;
 		/* remember prog start time returned by __bpf_prog_enter */
@@ -1376,17 +1376,17 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		/* arg1: lea rdi, [rbp - stack_size] */
 		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 		/* arg2: progs[i]->insnsi for interpreter */
-		if (!progs[i]->jited)
+		if (!tp->progs[i]->jited)
 			emit_mov_imm64(&prog, BPF_REG_2,
-				       (long) progs[i]->insnsi >> 32,
-				       (u32) (long) progs[i]->insnsi);
+				       (long) tp->progs[i]->insnsi >> 32,
+				       (u32) (long) tp->progs[i]->insnsi);
 		/* call JITed bpf program or interpreter */
-		if (emit_call(&prog, progs[i]->bpf_func, prog))
+		if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
 			return -EINVAL;
 
 		/* arg1: mov rdi, progs[i] */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 32,
-			       (u32) (long) progs[i]);
+		emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] >> 32,
+			       (u32) (long) tp->progs[i]);
 		/* arg2: mov rsi, rbx <- start time in nsec */
 		emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 		if (emit_call(&prog, __bpf_prog_exit, prog))
@@ -1458,12 +1458,13 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
  */
 int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_prog **fentry_progs, int fentry_cnt,
-				struct bpf_prog **fexit_progs, int fexit_cnt,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
 	int cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
+	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
 	u8 *prog;
 
 	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
@@ -1492,12 +1493,12 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 
 	save_regs(m, &prog, nr_args, stack_size);
 
-	if (fentry_cnt)
-		if (invoke_bpf(m, &prog, fentry_progs, fentry_cnt, stack_size))
+	if (fentry->nr_progs)
+		if (invoke_bpf(m, &prog, fentry, stack_size))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (fentry_cnt)
+		if (fentry->nr_progs)
 			restore_regs(m, &prog, nr_args, stack_size);
 
 		/* call original function */
@@ -1507,8 +1508,8 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
-	if (fexit_cnt)
-		if (invoke_bpf(m, &prog, fexit_progs, fexit_cnt, stack_size))
+	if (fexit->nr_progs)
+		if (invoke_bpf(m, &prog, fexit, stack_size))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f13c78c6f29d..98ec10b23dbb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -433,6 +433,16 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
 
+/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
+ * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
+ */
+#define BPF_MAX_TRAMP_PROGS 40
+
+struct bpf_tramp_progs {
+	struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
+	int nr_progs;
+};
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags = BPF_TRAMP_F_RESTORE_REGS
@@ -455,8 +465,7 @@ struct btf_func_model {
  */
 int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_prog **fentry_progs, int fentry_cnt,
-				struct bpf_prog **fexit_progs, int fexit_cnt,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
 u64 notrace __bpf_prog_enter(void);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c498f0fffb40..9f7e0328a644 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
+	struct bpf_tramp_progs *tprogs = NULL;
 	void *udata, *kdata;
 	int prog_fd, err = 0;
 	void *image;
@@ -425,10 +426,18 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+		if (!tprogs) {
+			err = -ENOMEM;
+			goto reset_unlock;
+		}
+
+		tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
+		tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
 		err = arch_prepare_bpf_trampoline(image,
 						  st_map->image + PAGE_SIZE,
 						  &st_ops->func_models[i], 0,
-						  &prog, 1, NULL, 0, NULL);
+						  tprogs, NULL);
 		if (err < 0)
 			goto reset_unlock;
 
@@ -469,6 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
+	kfree(tprogs);
 	mutex_unlock(&st_map->lock);
 	return err;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 704fa787fec0..cfe96d4cd89f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -190,40 +190,49 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return ret;
 }
 
-/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
- * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
- */
-#define BPF_MAX_TRAMP_PROGS 40
+static struct bpf_tramp_progs *
+bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
+{
+	struct bpf_tramp_progs *tprogs;
+	struct bpf_prog **progs;
+	struct bpf_prog_aux *aux;
+	int kind;
+
+	*total = 0;
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs)
+		return ERR_PTR(-ENOMEM);
+
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+		tprogs[kind].nr_progs = tr->progs_cnt[kind];
+		*total += tr->progs_cnt[kind];
+		progs = tprogs[kind].progs;
+
+		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist)
+			*progs++ = aux->prog;
+	}
+	return tprogs;
+}
 
 static int bpf_trampoline_update(struct bpf_trampoline *tr)
 {
 	void *old_image = tr->image + ((tr->selector + 1) & 1) * BPF_IMAGE_SIZE/2;
 	void *new_image = tr->image + (tr->selector & 1) * BPF_IMAGE_SIZE/2;
-	struct bpf_prog *progs_to_run[BPF_MAX_TRAMP_PROGS];
-	int fentry_cnt = tr->progs_cnt[BPF_TRAMP_FENTRY];
-	int fexit_cnt = tr->progs_cnt[BPF_TRAMP_FEXIT];
-	struct bpf_prog **progs, **fentry, **fexit;
+	struct bpf_tramp_progs *tprogs;
 	u32 flags = BPF_TRAMP_F_RESTORE_REGS;
-	struct bpf_prog_aux *aux;
-	int err;
+	int err, total;
+
+	tprogs = bpf_trampoline_update_progs(tr, &total);
+	if (IS_ERR(tprogs))
+		return PTR_ERR(tprogs);
 
-	if (fentry_cnt + fexit_cnt == 0) {
+	if (total == 0) {
 		err = unregister_fentry(tr, old_image);
 		tr->selector = 0;
 		goto out;
 	}
 
-	/* populate fentry progs */
-	fentry = progs = progs_to_run;
-	hlist_for_each_entry(aux, &tr->progs_hlist[BPF_TRAMP_FENTRY], tramp_hlist)
-		*progs++ = aux->prog;
-
-	/* populate fexit progs */
-	fexit = progs;
-	hlist_for_each_entry(aux, &tr->progs_hlist[BPF_TRAMP_FEXIT], tramp_hlist)
-		*progs++ = aux->prog;
-
-	if (fexit_cnt)
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
 	/* Though the second half of trampoline page is unused a task could be
@@ -232,12 +241,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	 * preempted task. Hence wait for tasks to voluntarily schedule or go
 	 * to userspace.
 	 */
+
 	synchronize_rcu_tasks();
 
 	err = arch_prepare_bpf_trampoline(new_image, new_image + BPF_IMAGE_SIZE / 2,
-					  &tr->func.model, flags,
-					  fentry, fentry_cnt,
-					  fexit, fexit_cnt,
+					  &tr->func.model, flags, tprogs,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
@@ -252,6 +260,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	tr->selector++;
 out:
+	kfree(tprogs);
 	return err;
 }
 
@@ -409,8 +418,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 int __weak
 arch_prepare_bpf_trampoline(void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
-			    struct bpf_prog **fentry_progs, int fentry_cnt,
-			    struct bpf_prog **fexit_progs, int fexit_cnt,
+			    struct bpf_tramp_progs *tprogs,
 			    void *orig_call)
 {
 	return -ENOTSUPP;
-- 
2.20.1

