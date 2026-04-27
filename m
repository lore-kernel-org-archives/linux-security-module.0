Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBB288AD
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248975; cv=none; b=G7XHPA3GFaIagrXaetLvxeiMjUAseoFiRtoGgPDVOGuC/1iOHrT9CHzZ90k9YfGiXX1zMI5VRGMh8mckXuqlYpuif9C4Tzec+cQ9fQz0ATeivGDM8j4LYZI5ltpyKluBEBx9ppzvnVYti83ewt1tvsUJ6XBzQySuFqZ4ki+0kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248975; c=relaxed/simple;
	bh=Cbd9+63IoPzzL9McznBPID/EnwGBaqIAMWnH/j6LOqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzP4w7hmolc3WnOqiKi00GyJNmEoiUN9SFJEsiZWxB0C7PgfqJO+aJwy3mMP6XU95J6LaLXtdnbtZVi7ZfudSZkK/RJK9UTLfed6wjVY/hKW7FhCjTgXwNuq/AFF2cIU4E+rklSc0U72xcIdK5WNfAv/ujZvqLEyQaV7/ZsAUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAjGBR3p; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAjGBR3p"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8f231f3b130so232971685a.3
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248972; x=1777853772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzmWs9OqoEoSms7Eq4RQgXfZnijmKDQ6PrVyMCoixhs=;
        b=lAjGBR3pHDHQWFOUqomPSxWTp2DeCwGTAGWRG+++xi+8lmQN50UCRdVawwNw8Rc1cc
         ccDKS25IGFTYlHOugWyu9hgIOBlkMxeJDUGeh5f8lSy5MiyGRTq+0kiLvSlbtS15Tky8
         Rl/5wKJfSdltePnNAVnFKhVCfN7cztGDXnRFjXUk00V+xZG9pZA2ZWZsDo1/wd9whDYi
         whI1Dn9T5wFolWfTSfxJAL1IrCfGlL9MXZZMv6Z2OO93MGdXCa+9NQHi4SrCxKwXLpt2
         UeXPUVS7r0Hvh3y1PPMHgkfwQET9qPA4+7+iguWR8Xa62uu9S0GAz2eVOj1a6TtG/nj+
         VWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248972; x=1777853772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzmWs9OqoEoSms7Eq4RQgXfZnijmKDQ6PrVyMCoixhs=;
        b=Q8QojjLw9nTrARjnL49+V79T20UFLTeI5HLbBsUnfF9VzijEtPyQLmU4HOqptY8HgF
         YhhLvVnNBDrFGhmkm6J2F6m7HreN5v9OibOfdDjQA3qO9i7b/quCzOilqYPFFi6i5qAE
         UTTw1uNjusJTzceHhks3uhgdC+tcLR+jkCl3cqoQNVkR33OKQLtS9uHHglPiaL+1/4pu
         NZKZBu/NQETBJImGCCbsyCkZep8zjiefXJgDQm2kHXBj0VGaChUTXLyIy1n8gTEG18Bv
         JujRC5xKFybnhlhLpZ137gKChuipkgS0AH+GZSWZgxbskyRCS0DDmBYYy6OxqT7Vzbz2
         JyvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RQjYKetn5/KEj+gO4Y6LOmN/plTcgb5VWBuFi5/jVCXYhVYf3wE/z3pNoNy4tY4Vn39gvQusDCVq7ZXVG9FiSk+ls7Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg57s2449drWHUr/G2VWLh4/PYOIgNaQQodnJmeI8B+KBNUXgd
	KeWiz3ogWVPhu+Oz8IWQzEK1pgY3AqYGKW+LFjfhzgS9aod3nuK+8sYg
X-Gm-Gg: AeBDiesfJxvMZXCi8ko3VcJb5MtsMdtLPXxPHJES16YMTx2Et/gOSav3zupd1zZENox
	2iUapNL6/LJFFP9VAm3v0y+LOoP9WcgUCWvIxvkQNi8EFcW4ANyWffSiKgKrAFLdl3VHyQTqI8Z
	W+rTVWSa3BhegcbL9CngKERfbggyOlYCMUln5Hjtx0zj5YQL+DcPvhVrTeBjPcbEA+F/gGfo0Ad
	Q6q3eUjtMwgynczs+VDGOx2+1M/T5F0TiwFEgVnTg8h8QGWzui1EWJEq0DF7wg1BU5IJdXHD6sJ
	l1fjsEinmW6+NsUJHwcqSryB9y7OKB9R7Z+oeLDaqy9WVzYUIaIH21c+T+DMNDkuPKg2dSnizuj
	rfUfgIza9J8gIChzvfGSoRCpr7CZEcjoUQJKTAVLHlo0C2CRs2nCqHHojE9ZgJBvis7O7NtCuGg
	+ZuUDhcwGPd8OwB+8/KH63KGvgrcAOQG//OxDLbkf22vq4Xw8C1Brz+LlZAqEBtXmAQZ5eITR6k
	krdEMOPHbc9QOf8I0lBAL9NB0jN9l5OUy4Ex0K+7C78fjjV0Ebq
X-Received: by 2002:a05:620a:178a:b0:8cf:d3ca:535c with SMTP id af79cd13be357-8e78f72f16emr5512003385a.4.1777248971687;
        Sun, 26 Apr 2026 17:16:11 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d6ba19c3sm2464025485a.21.2026.04.26.17.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:16:11 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: David Windsor <dwindsor@gmail.com>,
	Song Liu <song@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Sun, 26 Apr 2026 20:15:57 -0400
Message-ID: <20260427001602.38353-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427001602.38353-1-dwindsor@gmail.com>
References: <20260427001602.38353-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via inode_init_security hook using lsm_get_xattr_slot().

lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
programs cannot do: hook arguments are not directly writable from BPF.
To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
value), and the verifier transparently rewrites each call into
bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
xattr_count are extracted from the hook context, which the verifier
spills to the stack at program entry since R1 is clobbered during normal
execution.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant. We take advantage of this by
passing the name directly. Because we rely on the hook-specific ctx
layout, the kfunc is restricted to lsm/inode_init_security.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c           | 80 +++++++++++++++++++++++++++++++++++-
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/fixups.c          | 20 +++++++++
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++
 security/bpf/hooks.c         |  3 ++
 5 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9d27be058494..5a5951006a3f 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/kernfs.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -353,6 +354,68 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 }
 #endif /* CONFIG_CGROUPS */
 
+/* Called from the verifier fixup of bpf_init_inode_xattr(). */
+__bpf_kfunc int bpf_init_inode_xattr_impl(struct xattr *xattrs, int *xattr_count,
+					  const char *name__str,
+					  const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	size_t name_len;
+	void *xattr_value;
+	struct xattr *xattr;
+	const void *value;
+	u32 value_len;
+
+	if (!xattrs || !xattr_count || !name__str)
+		return -EINVAL;
+
+	name_len = strlen(name__str);
+	if (name_len == 0 || name_len > XATTR_NAME_MAX)
+		return -EINVAL;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
+		return -EINVAL;
+
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	xattr_value = kmemdup(value, value_len, GFP_ATOMIC);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	if (!xattr) {
+		kfree(xattr_value);
+		return -ENOSPC;
+	}
+
+	xattr->name = name__str;
+	xattr->value = xattr_value;
+	xattr->value_len = value_len;
+
+	return 0;
+}
+
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs. The verifier rewrites
+ * calls to bpf_init_inode_xattr_impl() with xattrs/xattr_count extracted from
+ * the hook context.
+ *
+ * Return: 0 on success, negative error on failure.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	WARN_ONCE(1, "%s called without verifier fixup\n", __func__);
+	return -EFAULT;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -363,13 +426,28 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr_impl)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
+BTF_ID(func, bpf_lsm_inode_init_security)
+
+BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
+BTF_ID(func, bpf_init_inode_xattr)
+BTF_ID(func, bpf_init_inode_xattr_impl)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM) {
+		/* bpf_init_inode_xattr[_impl] only attach to inode_init_security. */
+		if ((kfunc_id == bpf_init_inode_xattr_btf_ids[0] ||
+		     kfunc_id == bpf_init_inode_xattr_btf_ids[1]) &&
+		    prog->aux->attach_btf_id != bpf_lsm_inode_init_security_btf_ids[0])
+			return -EACCES;
 		return 0;
+	}
 	return -EACCES;
 }
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 101ca6cc5424..e73bb2222c3d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -682,6 +682,7 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	u8 init_inode_xattr_fixup:1;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
@@ -903,6 +904,8 @@ struct bpf_verifier_env {
 	bool bypass_spec_v4;
 	bool seen_direct_write;
 	bool seen_exception;
+	bool needs_ctx_spill;
+	s16 ctx_stack_off;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fba9e8c00878..18d612a9fe29 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -725,6 +725,26 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
+	if (env->needs_ctx_spill) {
+		if (epilogue_cnt) {
+			/* gen_epilogue already saved ctx to the stack */
+			env->ctx_stack_off = -(s16)subprogs[0].stack_depth;
+		} else {
+			cnt = 0;
+			subprogs[0].stack_depth += 8;
+			env->ctx_stack_off = -(s16)subprogs[0].stack_depth;
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP,
+						      BPF_REG_1,
+						      env->ctx_stack_off);
+			insn_buf[cnt++] = env->prog->insnsi[0];
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = new_prog;
+			delta += cnt - 1;
+		}
+	}
+
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..af5753ffb16b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10794,6 +10794,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_init_inode_xattr,
+	KF_bpf_init_inode_xattr_impl,
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
@@ -10882,6 +10884,13 @@ BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+#ifdef CONFIG_BPF_LSM
+BTF_ID(func, bpf_init_inode_xattr)
+BTF_ID(func, bpf_init_inode_xattr_impl)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
@@ -12701,6 +12710,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_init_inode_xattr_impl]) {
+		verbose(env, "bpf_init_inode_xattr_impl is not callable directly\n");
+		return -EACCES;
+	}
+
+	if (meta.func_id == special_kfunc_list[KF_bpf_init_inode_xattr]) {
+		if (env->cur_state->curframe != 0) {
+			verbose(env, "bpf_init_inode_xattr cannot be called from subprograms\n");
+			return -EINVAL;
+		}
+		env->needs_ctx_spill = true;
+		insn_aux->init_inode_xattr_fixup = true;
+		err = bpf_add_kfunc_call(env,
+					 special_kfunc_list[KF_bpf_init_inode_xattr_impl], 0);
+		if (err < 0)
+			return err;
+	}
+
 	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_rbtree_add_callback_state);
@@ -19272,6 +19299,33 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (env->insn_aux_data[insn_idx].init_inode_xattr_fixup) {
+		struct bpf_kfunc_desc *impl_desc;
+
+		impl_desc = find_kfunc_desc(env->prog,
+					    special_kfunc_list[KF_bpf_init_inode_xattr_impl], 0);
+		if (!impl_desc) {
+			verifier_bug(env, "bpf_init_inode_xattr_impl desc not found");
+			return -EFAULT;
+		}
+
+		/* Rewrite bpf_init_inode_xattr(name, value) to inject xattrs and
+		 * xattr_count loaded from the saved inode_init_security ctx.
+		 */
+		insn_buf[0] = BPF_MOV64_REG(BPF_REG_3, BPF_REG_1);
+		insn_buf[1] = BPF_MOV64_REG(BPF_REG_4, BPF_REG_2);
+		insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP,
+					  env->ctx_stack_off);
+		insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2,
+					  3 * sizeof(u64));
+		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2,
+					  4 * sizeof(u64));
+		insn_buf[5] = *insn;
+		if (!bpf_jit_supports_far_kfunc_call())
+			insn_buf[5].imm = BPF_CALL_IMM(impl_desc->addr);
+		else
+			insn_buf[5].imm = impl_desc->func_id;
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..1e61baa821bd 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -28,8 +28,11 @@ static int __init bpf_lsm_init(void)
 	return 0;
 }
 
+#define BPF_LSM_INODE_INIT_XATTRS 1
+
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
-- 
2.53.0

