Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E7261B8D
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246051; cv=none; b=YUmPXIqIZUXG5MYaoYQdsBEj+zB6LhSCJgEcTXvyrtW5oE5It0sMHWngFpyt0PfqwLGWr3gsjCnPkD8F9lmPhwwKuvo6Ve4hVTj7nbN4Lwmg9bKAeNtFIV6Wt78Krx4laS9vsSFya8FaFd+Up6RTlamaWRsrcm+qWopRRTk48Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246051; c=relaxed/simple;
	bh=foegcpolK4RYh+5Eq2nvbOK7aH3taBxZV9u0ZlH9xfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlBUfL+Mng+Vk5FG9v2TmoS+LYvZayh7usf95gQtJ1tAcgAiUBWdt890Y0+6qFIlZXrWPPUNqhmYQJ0wbLXy3yACP4DhXfgecsdSu3+OcrjQMEIuMZOKSpe8qmstUvpIIvV0WGZUhz6K+kzWhNYkWjC6FrfPztgRNIfMXGPeUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko+Hr0zv; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko+Hr0zv"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-675617094f5so1886449d50.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246046; x=1791850846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPPjiX1ELWg4Y9A3T/5p5m6mhotSAu6O/KGt9ophNcE=;
        b=ko+Hr0zvO1gUytohfn0vKTzgDlrbcJmQ1gNchnAy7ayNS2axle7A0iZeVjUuQOscU+
         +F24sKtgTnpH6ruD3ayNsBNA1t6kvYmcjvattkvCMgaVjUN4SmL/vkXD3IX37/kNPShd
         sv015cbOPeJ920Fkg4z1vmQzilESOVfcL0igH0PPpFJhVPUrOt7uByCfa0PkhL0GtzNv
         NGWp++X64mk5KxpeJJqjQ+kuG4ka42ZXBig8JJyHCjz4tQKvWFJVvsjYs9YLue3IyidB
         WWdUFOOoyzUFAYGnDGBC3FC+GljjRRgXtYbBfqHkI/V3M8HuVNaYw6CvQIC1S6BI01Qx
         Un3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246046; x=1791850846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPPjiX1ELWg4Y9A3T/5p5m6mhotSAu6O/KGt9ophNcE=;
        b=mnXUD7/LM290OIofob+d2gHsSp3ArezspqO/2FutINEej/+s5zfONO+2LYSufsWb69
         geSqh5rGUnXCiJOdzcZ6QUrJZuU1luTe/CG74vIESz3oGmXZEHXEh5q+ItJu35LhlL6B
         4BMwyo9/mSfhqboeo3tAuxyOzkJDAOnqh6q1zK0YNDRjw/+jZ4XRbC0u3hQ5M7lBqTnU
         N/l/5ithIxXg1PnDId+qbOw7DkllzPaEJ6BLlFi4L8Bhkf5uxpdQg5OQnDT4x3oTd/TQ
         0YftV3cuaAlwD8pwvX/UHgvLQHEiz93tcb9AnKO/Xl7cNaKiHTcgP1H11oc36hNHIc2o
         nZ3A==
X-Forwarded-Encrypted: i=1; AKwUvBz+PbEL8a1aL+SeR8EM8c8MRlwvyO/3VS/PutnVkIZNGKR5Ik8UKPYg7nNFTjUjz+W+647vg/3K8NvTZPj0nOQ5OMssw3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqQuFyPxfewXGWff+d32pNd/gUb1T+K0J3foenRW1fLOU2pZ/H
	R6sxjVERoFRSdCPLpegVdvcvTrd5qUECKD/3/GHoU7k8Doiv+5gp0iNB
X-Gm-Gg: AYBFou1g5ruggz+4ZlSVcFuXW1Aa3gmAadIZWltiJ1l3WB1Zbkrsgw7ZulCPW5kzDWG
	3XL4rp1m4UiOQoe73R8pRaUBLMh6VB24QBoRwxKTeX3pAO8o0zPKyHo1yxd0qyqjpFZopk7ENPr
	ObuPlYRESF6ecazKYx0ve8mbzd1ZGhZgqvtvblvxPx5b7W+TjjKBtIOHsvWsharFRqbY0Jc3N/Z
	dnp5zJ3Yyb7kxF0EJ4a1DOXc8TMfImZvtJDTiZie7eGroDXft1AcCc7kaWgWdo7fDkBpWdlvzHK
	lz2vnwjdW5u+2C825gSfaVWfv/2Lsj4Bn7WUhmYvIICOFp8id58fiYoa3yi4PMPt+y75pslWTp4
	UUYzfxhj/90bf4rVmAccVzsraDMCWrIDkjzCnyFx8aQBeB17FefKWTNaHnKP6lSz050JHYh0GBB
	IdtEQV5jQ9RMGdRxPN0ubtLRe3SP/FFcqg+WlBEyTgTI8XfoFhMriie5EJk3JrKwuUQgw5Cfzr1
	g==
X-Received: by 2002:a05:690e:b82:b0:677:c075:a57a with SMTP id 956f58d0204a3-677c075bf2emr2988993d50.108.1791246046123;
        Mon, 05 Oct 2026 17:20:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:45 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 06/12] bpf: add a path ancestor iterator
Date: Mon,  5 Oct 2026 20:20:13 -0400
Message-ID: <20261006002020.2890858-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let BPF programs evaluate a path's ancestry with an open-coded iterator
over the stepwise vfs_walk_ancestors() engine.  The iteration holds a
reference on its current position, which is what lets a program sleep
between positions - a dput() of the last reference may - so the kfuncs
are KF_SLEEPABLE and the iterator is available to sleepable programs
only.  That covers the LSM hooks a path-based policy attaches to:
file_open, file_permission, the path_* hooks, mmap_file and bprm_* are
all in the sleepable allowlist.

bpf_iter_path_ancestors_next() hands each position to the program as an
acquired reference of its own, to release with bpf_path_put().  The
walk's own reference moves on with the walk and is dropped at the next
step, so it cannot be what keeps a position alive: a program that saves
a position's dentry, or hands one to a sleepable kfunc, needs it to
outlive the step it came from.  struct path is a value type with nothing
a BPF reference could be taken on, so an acquired position is a copy of
its own; the allocation is a sleepable GFP_KERNEL one, and a failure
ends the iteration with %BPF_PATH_ANCESTORS_NOMEM rather than silently
truncating the ancestry.

An acquiring KF_ITER_NEXT needs one thing from the verifier: the state
that assumes the drained, NULL-returning branch must not keep the
reference the acquire bookkeeping created for the assumed non-NULL
return.  Open-coded iterators reach that branch through
process_iter_next_call() rather than through mark_ptr_or_null_regs(),
which is where a plain KF_ACQUIRE | KF_RET_NULL kfunc releases it.

The per-position VFS flags are not derivable from the position alone -
whether a disconnected root is a mountpoint a crossing landed on is
walk state - so they are read with bpf_path_ancestors_pos_flags(),
which a program needs to reproduce Landlock's evaluation of
disconnected positions.

The iterator state is deliberately larger than this walk mode needs:
its size is part of the contract with programs, which size their stack
slot from it, so growing it later would reject programs built against
the smaller one.  The walk mode is a parameter of the shared engine for
the same reason - so that a mode added later is not an ABI change.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/bpf_fs_kfuncs.c    | 147 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |   7 ++
 2 files changed, 154 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08f0847c4970..265cb414a08a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -13,7 +13,11 @@
 #include <linux/kernfs.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 #include <linux/net.h>
+#include <linux/slab.h>
+
+#include "internal.h"
 #include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
@@ -500,6 +504,143 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 
 __bpf_kfunc_end_defs();
 
+enum bpf_path_ancestors_flag {
+	/* bpf_path_ancestors_pos_flags() bits */
+	BPF_PATH_ANCESTORS_DISCONNECTED	= (1 << 0),
+	/* the position is a mountpoint a mount crossing landed on */
+	BPF_PATH_ANCESTORS_MOUNTPOINT	= (1 << 1),
+	/* the iteration ended on a failed allocation, not at the root */
+	BPF_PATH_ANCESTORS_NOMEM	= (1 << 2),
+};
+
+/*
+ * Walks over a path's ancestors.
+ *
+ * bpf_iter_path_ancestors runs with references.  Its kfuncs are
+ * sleepable, so the iteration may sleep between positions.
+ *
+ * Each position is handed to the program as an acquired reference of its
+ * own, to release with bpf_path_put().  The walk's own reference moves on
+ * with the walk, so a position that outlives the step it came from - a
+ * dentry saved for later, or the path a sleepable kfunc is still working
+ * on - has to be kept alive by the program's reference rather than by the
+ * iterator's.
+ */
+struct bpf_iter_path_ancestors {
+	__u64 __opaque[5];
+} __aligned(8);
+
+struct bpf_path_ancestors_kern {
+	struct vfs_ancestor_walk aw;
+	int step;	/* last vfs_walk_next() result, or -ENOMEM */
+} __aligned(8);
+
+static int bpf_path_ancestors_new(struct bpf_path_ancestors_kern *kit,
+				  struct path *path, u64 flags,
+				  unsigned int walk_flags)
+{
+	BUILD_BUG_ON(sizeof(struct bpf_path_ancestors_kern) >
+		     sizeof(struct bpf_iter_path_ancestors));
+	BUILD_BUG_ON(__alignof__(struct bpf_path_ancestors_kern) !=
+		     __alignof__(struct bpf_iter_path_ancestors));
+
+	if (flags) {
+		/* A zeroed walk makes destroying the iterator a no-op. */
+		memset(kit, 0, sizeof(*kit));
+		kit->step = 1;
+		return -EINVAL;
+	}
+	kit->step = 0;
+	vfs_walk_start(&kit->aw, path, walk_flags);
+	return 0;
+}
+
+/* The walk's own view of the next position, which the step after it ends. */
+static struct path *bpf_path_ancestors_step(struct bpf_path_ancestors_kern *kit)
+{
+	if (kit->step)
+		return NULL;
+	kit->step = vfs_walk_next(&kit->aw);
+	return kit->step ? NULL : &kit->aw.pos;
+}
+
+static u32 bpf_path_ancestors_flags(const struct bpf_path_ancestors_kern *kit)
+{
+	u32 flags = 0;
+
+	if (kit->step == -ENOMEM)
+		return BPF_PATH_ANCESTORS_NOMEM;
+	if (!kit->step) {
+		if (kit->aw.pos_flags & VFS_WALK_POS_DISCONNECTED)
+			flags |= BPF_PATH_ANCESTORS_DISCONNECTED;
+		if (kit->aw.pos_flags & VFS_WALK_POS_MOUNTPOINT)
+			flags |= BPF_PATH_ANCESTORS_MOUNTPOINT;
+	}
+	return flags;
+}
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_path_ancestors_new(struct bpf_iter_path_ancestors *it,
+					    struct path *path, u64 flags)
+{
+	return bpf_path_ancestors_new((void *)it, path, flags, 0);
+}
+
+/**
+ * bpf_iter_path_ancestors_next - acquire the walk's next position
+ * @it: the iterator
+ *
+ * Return: the next position with a reference held, to release with
+ * bpf_path_put(), or NULL once the walk has passed the real root - or on
+ * an allocation failure, which ends the iteration and is reported as
+ * %BPF_PATH_ANCESTORS_NOMEM by bpf_path_ancestors_pos_flags().
+ */
+__bpf_kfunc struct path *
+bpf_iter_path_ancestors_next(struct bpf_iter_path_ancestors *it)
+{
+	struct bpf_path_ancestors_kern *kit = (void *)it;
+	struct path *pos = bpf_path_ancestors_step(kit);
+	struct path *held;
+
+	if (!pos)
+		return NULL;
+	/*
+	 * The position must outlive the walk's own view of it, so it gets a
+	 * reference and a struct path of its own to live in: struct path is
+	 * a value type, with nothing a BPF reference could be taken on
+	 * otherwise.  Sleepable, so no atomic allocation.
+	 */
+	held = kmalloc_obj(*held);
+	if (!held) {
+		kit->step = -ENOMEM;
+		return NULL;
+	}
+	*held = *pos;
+	path_get(held);
+	return held;
+}
+
+__bpf_kfunc void
+bpf_iter_path_ancestors_destroy(struct bpf_iter_path_ancestors *it)
+{
+	vfs_walk_end(&((struct bpf_path_ancestors_kern *)it)->aw);
+}
+
+__bpf_kfunc u32
+bpf_path_ancestors_pos_flags(struct bpf_iter_path_ancestors *it__iter)
+{
+	return bpf_path_ancestors_flags((void *)it__iter);
+}
+
+__bpf_kfunc void bpf_path_put(struct path *path)
+{
+	path_put(path);
+	kfree(path);
+}
+
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
@@ -513,6 +654,12 @@ BTF_ID_FLAGS(func, bpf_inode_init_xattr)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_next,
+	     KF_ITER_NEXT | KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_path_ancestors_pos_flags)
+BTF_ID_FLAGS(func, bpf_path_put, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 /* Side-effecting kfuncs that stay exclusive to LSM programs. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24ec4b037de7..066c4b838b85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8648,6 +8648,13 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	/* switch to DRAINED state, but keep the depth unchanged */
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
+	/*
+	 * An acquiring iter_next() hands out nothing once drained: the
+	 * acquired reference exists only in the forked active state, not on
+	 * this NULL-returning branch.
+	 */
+	if (meta->kfunc_flags & KF_ACQUIRE)
+		WARN_ON_ONCE(release_reference_nomark(env, cur_fr->regs[BPF_REG_0].id));
 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
 
 	return 0;
-- 
2.55.0

