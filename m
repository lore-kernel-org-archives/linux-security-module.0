Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A381CC3F2D7
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1CA24658
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/bBKJDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgCDPsR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:48:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39833 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbgCDPsC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2989229wrn.6
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwJ/lEQbGlXVsZnbKvzZuJddWa90yHQNeHuRAfmMm6M=;
        b=Z/bBKJDbn5h+caZsxbQzpuG01EeulxHBXtpmoPU++DWh/PGCUBWsXkOX4G4B6yT5y3
         ZoY3HdJvX/dYzx1zpkquuDbTpB0aq/zeGGTsnI5x0yaLJ6lF0nC37YVMHAVvzlKumpRO
         lKVXX2YQsbFgREwpfqz9oodMizrLw6X6MfJRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwJ/lEQbGlXVsZnbKvzZuJddWa90yHQNeHuRAfmMm6M=;
        b=HWzYaZUdwS7OCI9sE9fQXWzHPJSkQrUkXtk0u5AOUAYxYVwCgNHINw/WtuZIvlTc3v
         pTkc9wToddvM7QbpUYLwGLLR6OC93uzxAT0fce4l6IEZL4DJX1TNmpkpRZ7+gzJuNfL5
         6fvvuztQyUy4KbnY9urr+L4ubY0qTy2UCQfDnKZMpqC6be+0aA+RLa6yBaQ765LKi134
         9VrLsig9MTvvkyWIrwc6fzbFf5STp5k9/LqaFVLFMoLhOpG3F62YUOCQIQ6/7KkXKqQO
         Mq4CJUCedGSh5AcE/RjG6WAHU84JjvpYjjQwR31pwpVY2NMz4B0FGcNRAxOuSFPHgSCW
         I+vQ==
X-Gm-Message-State: ANhLgQ0eI4xu25eTOrBOh57mk5fMxPb+RGhNCgMJas16daS/8UVYgjy3
        I9ao3ApGAX2cX9VyjA6cvMUdMHsTN7o=
X-Google-Smtp-Source: ADFU+vtsW8lV16QtUsSY5f0Vy6L8J2ZSw2Fu9nlUV3iMOuA39ZN8OZjY1ijWBylWksaGnBtVGi+VGg==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr4716296wru.100.1583336878095;
        Wed, 04 Mar 2020 07:47:58 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id u25sm4816091wml.17.2020.03.04.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:47:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 3/7] bpf: Introduce BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 16:47:43 +0100
Message-Id: <20200304154747.23506-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304154747.23506-1-kpsingh@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

When multiple programs are attached, each program receives the return
value from the previous program on the stack and the last program
provides the return value to the attached function.

The fmod_ret bpf programs are run after the fentry programs and before
the fexit programs. The original function is only called if all the
fmod_ret programs return 0 to avoid any unintended side-effects. The
success value, i.e. 0 is not currently configurable but can be made so
where user-space can specify it at load time.

For example:

int func_to_be_attached(int a, int b)
{  <--- do_fentry

do_fmod_ret:
   <update ret by calling fmod_ret>
   if (ret != 0)
        goto do_fexit;

original_function:

    <side_effects_happen_here>

}  <--- do_fexit

The fmod_ret program attached to this function can be defined as:

SEC("fmod_ret/func_to_be_attached")
int BPF_PROG(func_name, int a, int b, int ret)
{
        // This will skip the original function logic.
        return 1;
}

The first fmod_ret program is passed 0 in its return argument.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    | 130 ++++++++++++++++++++++++++++++---
 include/linux/bpf.h            |   1 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/btf.c               |   3 +-
 kernel/bpf/syscall.c           |   1 +
 kernel/bpf/trampoline.c        |   5 +-
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   1 +
 8 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d6349e930b06..b1fd000feb89 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1362,7 +1362,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_prog *p, int stack_size)
+			   struct bpf_prog *p, int stack_size, bool mod_ret)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
@@ -1383,6 +1383,13 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	if (emit_call(&prog, p->bpf_func, prog))
 		return -EINVAL;
 
+	/* BPF_TRAMP_MODIFY_RETURN trampolines can modify the return
+	 * of the previous call which is then passed on the stack to
+	 * the next BPF program.
+	 */
+	if (mod_ret)
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32,
 		       (u32) (long) p);
@@ -1442,6 +1449,23 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 	return 0;
 }
 
+static int emit_mod_ret_check_imm8(u8 **pprog, int value)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (!is_imm8(value))
+		return -EINVAL;
+
+	if (value == 0)
+		EMIT2(0x85, add_2reg(0xC0, BPF_REG_0, BPF_REG_0));
+	else
+		EMIT3(0x83, add_1reg(0xF8, BPF_REG_0), value);
+
+	*pprog = prog;
+	return 0;
+}
+
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_progs *tp, int stack_size)
 {
@@ -1449,9 +1473,49 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size))
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, false))
+			return -EINVAL;
+	}
+	*pprog = prog;
+	return 0;
+}
+
+static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
+			      struct bpf_tramp_progs *tp, int stack_size,
+			      u8 **branches)
+{
+	u8 *prog = *pprog;
+	int i;
+
+	/* The first fmod_ret program will receive a garbage return value.
+	 * Set this to 0 to avoid confusing the program.
+	 */
+	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	for (i = 0; i < tp->nr_progs; i++) {
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, true))
 			return -EINVAL;
+
+		/* Generate a branch:
+		 *
+		 * if (ret !=  0)
+		 *	goto do_fexit;
+		 *
+		 * If needed this can be extended to any integer value which can
+		 * be passed by user-space when the program is loaded.
+		 */
+		if (emit_mod_ret_check_imm8(&prog, 0))
+			return -EINVAL;
+
+		/* Save the location of the branch and Generate 6 nops
+		 * (4 bytes for an offset and 2 bytes for the jump) These nops
+		 * are replaced with a conditional jump once do_fexit (i.e. the
+		 * start of the fexit invocation) is finalized.
+		 */
+		branches[i] = prog;
+		emit_nops(&prog, 4 + 2);
 	}
+
 	*pprog = prog;
 	return 0;
 }
@@ -1521,10 +1585,12 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
-	int cnt = 0, nr_args = m->nr_args;
+	int ret, i, cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
 	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
+	u8 **branches = NULL;
 	u8 *prog;
 
 	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
@@ -1557,24 +1623,60 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		if (invoke_bpf(m, &prog, fentry, stack_size))
 			return -EINVAL;
 
+	if (fmod_ret->nr_progs) {
+		branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
+				   GFP_KERNEL);
+		if (!branches)
+			return -ENOMEM;
+
+		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, stack_size,
+				       branches)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (fentry->nr_progs)
+		if (fentry->nr_progs || fmod_ret->nr_progs)
 			restore_regs(m, &prog, nr_args, stack_size);
 
 		/* call original function */
-		if (emit_call(&prog, orig_call, prog))
-			return -EINVAL;
+		if (emit_call(&prog, orig_call, prog)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
+	if (fmod_ret->nr_progs) {
+		/* From Intel 64 and IA-32 Architectures Optimization
+		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
+		 * Coding Rule 11: All branch targets should be 16-byte
+		 * aligned.
+		 */
+		emit_align(&prog, 16);
+		/* Update the branches saved in invoke_bpf_mod_ret with the
+		 * aligned address of do_fexit.
+		 */
+		for (i = 0; i < fmod_ret->nr_progs; i++)
+			emit_cond_near_jump(&branches[i], prog, branches[i],
+					    X86_JNE);
+	}
+
 	if (fexit->nr_progs)
-		if (invoke_bpf(m, &prog, fexit, stack_size))
-			return -EINVAL;
+		if (invoke_bpf(m, &prog, fexit, stack_size)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, stack_size);
 
+	/* This needs to be done regardless. If there were fmod_ret programs,
+	 * the return value is only updated on the stack and still needs to be
+	 * restored to R0.
+	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG)
 		/* restore original return value back into RAX */
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
@@ -1586,9 +1688,15 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
 	EMIT1(0xC3); /* ret */
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY))
-		return -EFAULT;
-	return prog - (u8 *)image;
+	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+	ret = prog - (u8 *)image;
+
+cleanup:
+	kfree(branches);
+	return ret;
 }
 
 static int emit_fallback_jump(u8 **pprog)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 98ec10b23dbb..f748b31e5888 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -474,6 +474,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
 enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
 	BPF_TRAMP_FEXIT,
+	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d6b33ea27bcc..40b2d9476268 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -210,6 +210,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_MODIFY_RETURN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 787140095e58..30841fb8b3c0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,7 +3710,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+	     prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 	    arg == nr_args) {
 		if (!t)
 			/* Default prog with 5 args. 6th arg is retval. */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13de65363ba2..7ce0815793dd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2324,6 +2324,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 
 	if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 	    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+	    prog->expected_attach_type != BPF_MODIFY_RETURN &&
 	    prog->type != BPF_PROG_TYPE_EXT) {
 		err = -EINVAL;
 		goto out_put_prog;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 546198f6f307..221a17af1f81 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -232,7 +232,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	}
 
-	if (tprogs[BPF_TRAMP_FEXIT].nr_progs)
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs ||
+	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
 	/* Though the second half of trampoline page is unused a task could be
@@ -269,6 +270,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
 	switch (t) {
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
+	case BPF_MODIFY_RETURN:
+		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 289383edfc8c..2460c8e6b5be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9950,6 +9950,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!prog_extension)
 			return -EINVAL;
 		/* fallthrough */
+	case BPF_MODIFY_RETURN:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 		if (!btf_type_is_func(t)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d6b33ea27bcc..40b2d9476268 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -210,6 +210,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_MODIFY_RETURN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1

