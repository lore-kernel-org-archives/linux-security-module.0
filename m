Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAD5218A8
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910118; cv=none; b=ll0Za1UotSP1yiXiJz97/nEEOdEQblzfMXmCGWJAGjmj8Fj/+8jY+uiyyETGJKxX4Fz2l5REBdzmYH1SWbjI61Ig8jeKxstdLsNhPnvMQu+kpxlz4o5pnF2/tMz0fU4AYoI9aGrozLPhfxRcxqoAK3X42lcCR4RIIfXNz8VX9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910118; c=relaxed/simple;
	bh=BCAqj/oNSIkxhy9f/faC3Z5BynLYIvDhcZSyMpX87Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwHbouMJlAGnvD2XjbHM3bnJj/azzul1aU/r39x0yRhMk96MIeaXlFL80URdL0as02fLNpIVigne6jl0IiZ7h3dMUGfHz84db1iig+/BfCZdHYO919p++pOdKfy4U9EygPslJl6eOKsVgUuCtHJlbXxh4cvT27fig6U3artE3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e78J4nq4; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e78J4nq4"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-677bc4704cbso2847118d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910114; x=1792514914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2aok334Q7ZttY1fa/TkNexJGvRAyT6M5LhoQHJ0F1s=;
        b=e78J4nq4/OnDmBZsB8aIb6KwrkysJNsh3ipCQhpk+WdJsGa/VG0V6tHhMrcdDtNwAo
         okHoz184MZoBXHb/4SGQG/qbyLgJwjncl4KKL+gViRTYSPZ2BpFkdg3jjdgygBHk+KEw
         PJ6Z5Y6zVDebfOcxQq6V6v9td2WnVEDfv4CVwHf7xfbesWdDKB6A/A0+Uu92xAmKDAAM
         8A3qQCoaZ0loMYFCvvB0E3MaqBSTMWnqwJ7J0KSVFhMZRbRyE7+H/hSc4E3pA+hjENec
         YfcweV438BuGdd/vmgzSfj+OanCOkymIIGKz7xYceeyKECIRQRLJ4ZpYGZSGYinzhikh
         5acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910114; x=1792514914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2aok334Q7ZttY1fa/TkNexJGvRAyT6M5LhoQHJ0F1s=;
        b=NzvkInONyZhgFoksJX6nex54wMP7gtMBcz8er82HJ2hnjTwz2TN3Z10NYRsHoEAUgq
         qe9/hH2yMhCdLSnU5Ln60H/Z2+NEH2LQgfAQT0SnA43vZUEycqo/EMsdkVq7Jy/QqgzU
         Pin2QspIzGNPtWfE08qmoy6tnTuXPSdZ7C5wbMMPcufcIvQeuDlpWE9u1/7noJKxBxbf
         7xz8X4nK2anWzTePSYo2uiyFrMON5mOLCB7ZdmXjWHXbCfxi3Qw0mgufUepHa+Vl7qUx
         DYeojbcF97oVLnIW+rFZpjVkO3VpYVVxhgH9cZr6j65xD6Esb1rx/DTuvyap9G/06NKR
         1CCw==
X-Forwarded-Encrypted: i=1; AKwUvByrts/4uyf2KrbnPJX6CQmPpguPbRsWX/WJaZKzyv705jrVTQHxk02TXQ8DJ+UydVdX2n8HhKIavcnAbVjf126Rzkx1DtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg0Pvk4cguq5XPaL7U6K3LwwA3qLJd3SxucqVbgyi2lMNA3It+
	Akduh1FBd0QPszdQf4Mh1IHwcnDNmRuqTP14gaLQhIsyMDVMvvG49HXp
X-Gm-Gg: AYBFou28z8CGsi68su/rkuFSh/tyVgwJ/aSFu3ltBfh++TbW7Rz71z4MpY8dkH2FqSq
	mRNZRcVHoj3mYnA7S5OLk6kCnGsW/nvcjGewFZyH3RnE+UBfcCpyU5uiShk4qfq0fwVqHD3qDSv
	S0uScYRloxwekeRFdt1hXZY2C30UDiS3a8kf8rVYX2C10V1ue507VcF1wum8TYMz58mJe8boaoa
	J6QQvrFDQ4KRbIXMzSCsMLUyo4WOQxVicQkIntgzHhT9YIT/kiPyYJlIYBC1f3XsxK8Q5UtG59/
	gUOaa4KD6ojIsRNi0TsvvkCVMZWQJpas3DoeyhwI9aINhW5ixgpT6khOpj3Igc/VO8GSsxQrbgR
	CbAvYpV8BuvvnMg2Q7vOpd2qj9fp9NriPqPXhLACo5DN6uFDqs4n0R90GuI3c+03JRLWjStoEes
	MCL6Jae2najWYIb/qRZY2yXd+EUwmQLqcFBHyG9+9Ep43u0EvX9JP9W60BwBjJRm0iQzrapwO9V
	fzRl9UxsHk=
X-Received: by 2002:a05:690e:144d:b0:677:ae40:c403 with SMTP id 956f58d0204a3-679362d060amr4853322d50.89.1791910114264;
        Tue, 13 Oct 2026 09:48:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 05/11] bpf: add a path ancestor iterator
Date: Tue, 13 Oct 2026 12:47:54 -0400
Message-ID: <20261013164800.2906577-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
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
only.

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
index 08f0847c4970..02398f5a46d5 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -13,9 +13,13 @@
 #include <linux/kernfs.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 #include <linux/net.h>
+#include <linux/slab.h>
 #include <linux/xattr.h>
 
+#include "internal.h"
+
 __bpf_kfunc_start_defs();
 
 /**
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
index 2f190abe3448..4b3e1d4f8a80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8835,6 +8835,13 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
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

