Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4A255F2D
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246057; cv=none; b=rXhqIM6cyBsIvABH9+DqPwm0y9Lrnydd6eUw5nGWlJ8SZBcYFQRhtejkoius3q6rqCg1AL48i9PqunoBmO5G/Vt4wzu4t3RzCTSGCOlsDmbbEyKkNCfr4i9MKlcWw2u2iu5LoHrmPxXeVH6246i6WhF78DG3SWxbiVxNwVpfzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246057; c=relaxed/simple;
	bh=nLVIASxgWstCHcpPrB9sc7/7FqvB1Fgv6Iz/AkruE/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+/WOuj9maE3J+hDUoLLEWgwbTNPqXe+8o7H1sS2UPyu4QVtiVtpaLD7MLKfYprzXYI0XRax87sLE+a+wMZ2yZ6iV0xyMPfFLoYiRayHvijGvecebKqzphFF1CCvxXN2I6hCnghPCkN5j26+p86u4AvYHixBcWJRPYr6nmq5V8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwmo5yba; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwmo5yba"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab3fd8adb1so23418127b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246054; x=1791850854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWMUrbRgZ7xqROGucF7YRMJGslpjM75Hq3V5+U5Bn+4=;
        b=cwmo5ybaGeaZnTrb04kN6VCP3SuCOLRmFtyH7WQsmoq+gaFIpgqDGEWWuN8+kCK057
         FMDY5mY1lxMKPOKTsOJl8bydEZ0Fm+RdZi/wRM+e3dH7buVN0x4bE9guZzGnF25sQIia
         /sBM8JfVBilqcclryC4xLWs1A3EJWPlEDtzfER1hozmCAScbW8BrkXE2VK+4/ESQPl0j
         FBib1nPC1NXxgsUWXxDzY7d1MCZV40vUNAdggAsrxGWsSxKXC5tChbHcHUlUofiMoGQF
         MR1bRVsTH+NKofv/jv6OUEGYlC+mcKhYrSZ9XJSYGcqYaauGQ3vs/8gOO7/uvQZbt2wo
         Elgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246054; x=1791850854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWMUrbRgZ7xqROGucF7YRMJGslpjM75Hq3V5+U5Bn+4=;
        b=jzKF2gxrk7WbUJR2ZROWDwaZocfwE7ddFoBggXjGLS8zJLMk/C1cG4soqThpHRnu30
         1hixjw+OORaETKBsXZ406LEBp3TOUi6OWZGgMnYFTsdy6k3smrx9eVATAp8RftF3LAA4
         8QrpsUlSS8/7S2ngqqgUyTy0doa7k32o5/o/b/0epnGpursUCgKOF4DC2FYMZ9y1bTDn
         IlbFKs0J8j0CpmcxbCelOtALtRSnRUb3HpX//G38+puAeZ623qZbZou0P2IEVh46Dfi5
         qohX13dD3fB51XTtCfX/2OicrjmxWMHiHWegzOsbR9POsIEEigL5I9uJEzD8zOiPKbhY
         TSmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrLZWsX6WYQ8pc14vaf3QOH2M9wZpfzwjc5OBzRla3oM6pgzMYxpOd6pUoAFgzoK2+ry8262Q9scV1Tc8MFkkI3ugy8vU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpIZZG9jqFsgG0xnQDcETU9n5KOVUmcv2eYBflW+oI3ljhfNdu
	yB0GM8bhPS9uUPP1xiNEy47btss6i9LKijnfBiG/YwB+I5UhP6m6m0De
X-Gm-Gg: AYBFou260tyNoeyXCh4JHfPglreR9zL7LZtAoLJQFEgJTuZvk+H/dLfyGexLqwixJyo
	ucer6Vwe9GB+AXyIEoLK1K+jvg2pp5i2SmWlECQ8Bl0qr2M+xx4oDXCpQv2BqNoglNAD3CBFyx/
	uZPUcCa3i/eNzb9YlWxC2vVLV4K0QwCVX4me/Z6pIO+g5YO3f4vEM5JMfVY2U1m9YoMmKnYsfQ7
	1XgVXmNg74MNc4qmiHvaN2LWzmZcjhjlqhDhoIqVxO/zn+g1rerwnAqgVQvORq8/QvsAY5b619v
	Gsvk8L2oWRb8ksnVrVFO9qHHrx/TZ/skDB0GpENNox9NQcSnRHp1rNS496KSPgGXuUr6kegvhCX
	tY9elryRweDp9YzS6cD7dc5zPFuCKcVvo+rW/xRGTyzRvd0LtQ5sxGtIMg8AeAGeQxqZxkb71ah
	U9b8a4KnXrJixMQ1DONiHv76Q9mG7FF1qAYYEuc5IxC4vFYoDm5mw+Tyx073PIDCdxGK+IrgGhj
	Q==
X-Received: by 2002:a05:690c:ec4:b0:89a:63da:faa6 with SMTP id 00721157ae682-8ae95b44023mr34494227b3.97.1791246053799;
        Mon, 05 Oct 2026 17:20:53 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:53 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 09/12] namei: add an rcu-walk mode to the ancestor walk
Date: Mon,  5 Oct 2026 20:20:16 -0400
Message-ID: <20261006002020.2890858-10-utilityemal77@gmail.com>
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

Let the stepwise engine walk lockless, entered with %VFS_WALK_RCU under
the caller's rcu_read_lock: stepping shares follow_dotdot_rcu()'s core,
factored into __path_walk_parent_rcu(), with per-step d_seq validation,
choose_mountpoint_rcu() for crossings and mount_lock revalidation
before concluding at the real root.  Any lost race surfaces as -ECHILD
and the caller retries in the referenced mode.

vfs_walk_handover() continues a lockless walk with references, so that
a caller can do at a position what no lockless walk can.  It mirrors
unlazy_walk(): the position is legitimized and becomes the starting
position of a second, reference-based walk that owns the references
acquired on it.

Both halves of that are ordered so that nothing has to be put: a failed
legitimization leaves no partial references, and the one case where
__legitimize_mnt() obliges a sleepable mntput() goes to
mnt_undo_legitimize().  Handing the reference straight over rather than
copying it out and dropping a second one is what keeps the whole
operation callable inside the caller's RCU read-side critical section,
where even a path_put() that provably cannot sleep is still a dput()
and so still a might_sleep().

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/internal.h         |   7 ++
 fs/namei.c            | 196 ++++++++++++++++++++++++++++++++++++------
 include/linux/namei.h |   3 +
 3 files changed, 179 insertions(+), 27 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 3ce2220ff57f..8a5696157121 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -74,9 +74,14 @@ int lookup_noperm_common(struct qstr *qname, struct dentry *base);
 /*
  * The stepwise engine under vfs_walk_ancestors(); fs-internal so iterating
  * consumers (BPF) can drive it, with the walk invariants staying in namei.c.
+ * In rcu mode (%VFS_WALK_RCU) the caller holds rcu_read_lock() over the
+ * whole walk, no references are held, and vfs_walk_next() returning -ECHILD
+ * invalidates everything derived from the walk.
  */
 struct vfs_ancestor_walk {
 	struct path pos;
+	unsigned int seq;	/* pos.dentry->d_seq sample (rcu mode) */
+	unsigned int m_seq;	/* mount_lock sample (rcu mode) */
 	unsigned int pos_flags;	/* VFS_WALK_POS_* describing pos */
 	unsigned int flags;	/* VFS_WALK_* */
 };
@@ -85,6 +90,8 @@ void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
 		    unsigned int flags);
 int vfs_walk_next(struct vfs_ancestor_walk *aw);
 void vfs_walk_end(struct vfs_ancestor_walk *aw);
+bool vfs_walk_handover(struct vfs_ancestor_walk *to,
+		       struct vfs_ancestor_walk *from);
 
 void __init filename_init(void);
 
diff --git a/fs/namei.c b/fs/namei.c
index 73f25152d917..31f96602d4e9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2152,34 +2152,69 @@ static __always_inline const char *step_into(struct nameidata *nd, int flags,
 	return step_into_slowpath(nd, flags, dentry);
 }
 
-static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
+/**
+ * __path_walk_parent_rcu - step towards the parent of the given struct path
+ * @path: position to step up from; updated in place on a mount crossing,
+ *        which is first if @path is the root of a mounted tree.  No
+ *        references are acquired; the callers layer their own bookkeeping
+ *        (path_connected(), nameidata updates, ...) on top
+ * @root: boundary as for choose_mountpoint_rcu(); if zero'ed, walk all the
+ *        way to the global root
+ * @flags: %LOOKUP_NO_XDEV fails a mount crossing with -ECHILD
+ * @m_seq: the walk's mount_lock sample
+ * @seqp: d_seq sample validating @path->dentry; updated to cover the new
+ *        @path->dentry when a mount is crossed
+ * @next_seqp: set to the returned parent's d_seq sample
+ *
+ * Returns: the parent dentry (which is @path->dentry itself if that is a
+ * disconnected root), NULL if @path is in the root with nothing to cross
+ * into, or ERR_PTR(-ECHILD) when a concurrent change was detected.
+ */
+static struct dentry *__path_walk_parent_rcu(struct path *path,
+					     const struct path *root, int flags,
+					     unsigned int m_seq, unsigned int *seqp,
+					     unsigned int *next_seqp)
 {
 	struct dentry *parent, *old;
 
-	if (path_equal(&nd->path, &nd->root))
-		goto in_root;
-	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path;
-		unsigned seq;
-		if (!choose_mountpoint_rcu(real_mount(nd->path.mnt),
-					   &nd->root, &path, &seq))
-			goto in_root;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+	if (unlikely(path->dentry == path->mnt->mnt_root)) {
+		struct path mounted;
+		unsigned int seq;
+
+		if (!choose_mountpoint_rcu(real_mount(path->mnt),
+					   root, &mounted, &seq))
+			return NULL;
+		if (unlikely(flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-ECHILD);
-		nd->path = path;
-		nd->inode = path.dentry->d_inode;
-		nd->seq = seq;
+		*path = mounted;
+		*seqp = seq;
 		// makes sure that non-RCU pathwalk could reach this state
-		if (read_seqretry(&mount_lock, nd->m_seq))
+		if (read_seqretry(&mount_lock, m_seq))
 			return ERR_PTR(-ECHILD);
 		/* we know that mountpoint was pinned */
 	}
-	old = nd->path.dentry;
+	old = path->dentry;
 	parent = old->d_parent;
-	nd->next_seq = read_seqcount_begin(&parent->d_seq);
+	*next_seqp = read_seqcount_begin(&parent->d_seq);
 	// makes sure that non-RCU pathwalk could reach this state
-	if (read_seqcount_retry(&old->d_seq, nd->seq))
+	if (read_seqcount_retry(&old->d_seq, *seqp))
 		return ERR_PTR(-ECHILD);
+	return parent;
+}
+
+static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
+{
+	struct dentry *parent;
+
+	if (path_equal(&nd->path, &nd->root))
+		goto in_root;
+	parent = __path_walk_parent_rcu(&nd->path, &nd->root, nd->flags,
+					nd->m_seq, &nd->seq, &nd->next_seq);
+	if (!parent)
+		goto in_root;
+	if (IS_ERR(parent))
+		return parent;
+	nd->inode = nd->path.dentry->d_inode;
 	if (unlikely(!path_connected(nd->path.mnt, parent)))
 		return ERR_PTR(-ECHILD);
 	return parent;
@@ -2247,7 +2282,9 @@ static const struct path vfs_walk_no_root;
  * vfs_walk_start - begin a stepwise ancestor walk
  * @aw: walk state, valid until vfs_walk_end()
  * @path: position to walk up from; never modified
- * @flags: %VFS_WALK_* flags; none defined yet, pass 0
+ * @flags: %VFS_WALK_RCU to walk lockless; the caller then holds
+ *         rcu_read_lock() from before vfs_walk_start() until after
+ *         vfs_walk_end(), and owns no references on yielded positions.
  */
 void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
 		    unsigned int flags)
@@ -2255,7 +2292,14 @@ void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
 	aw->pos = *path;
 	aw->flags = flags;
 	aw->pos_flags = 0;
-	path_get(&aw->pos);
+	if (flags & VFS_WALK_RCU) {
+		RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+				 "rcu-mode ancestor walk outside of RCU read-side critical section");
+		aw->m_seq = read_seqbegin(&mount_lock);
+		aw->seq = raw_seqcount_begin(&aw->pos.dentry->d_seq);
+	} else {
+		path_get(&aw->pos);
+	}
 }
 
 static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
@@ -2286,6 +2330,35 @@ static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
 	return 0;
 }
 
+static int vfs_walk_step_rcu(struct vfs_ancestor_walk *aw)
+{
+	struct dentry *parent;
+	unsigned int next_seq;
+
+	if (unlikely(aw->pos_flags & VFS_WALK_POS_DISCONNECTED)) {
+		/* Resume at the root of the disconnected position's mount. */
+		aw->pos.dentry = aw->pos.mnt->mnt_root;
+		aw->seq = raw_seqcount_begin(&aw->pos.dentry->d_seq);
+		aw->pos_flags = 0;
+		return read_seqretry(&mount_lock, aw->m_seq) ? -ECHILD : 0;
+	}
+
+	parent = __path_walk_parent_rcu(&aw->pos, &vfs_walk_no_root, 0,
+					aw->m_seq, &aw->seq, &next_seq);
+	if (!parent)
+		/* The real root, unless the mount tree moved. */
+		return read_seqretry(&mount_lock, aw->m_seq) ? -ECHILD : 1;
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+	/* A crossing onto a disconnected root, as in vfs_walk_step_ref(). */
+	aw->pos_flags = parent == aw->pos.dentry ?
+		VFS_WALK_POS_DISCONNECTED | VFS_WALK_POS_MOUNTPOINT :
+		vfs_walk_pos_flags(aw->pos.mnt, parent);
+	aw->pos.dentry = parent;
+	aw->seq = next_seq;
+	return 0;
+}
+
 /**
  * vfs_walk_next - yield the walk's next position in @aw->pos
  * @aw: the walk
@@ -2295,12 +2368,14 @@ static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
  * described at vfs_walk_ancestors().
  *
  * Returns: 0 with @aw->pos valid, 1 once the walk has passed the real
- * root.
+ * root, -ECHILD when an rcu-mode walk lost a race and must be retried
+ * (typically in the referenced mode).
  */
 int vfs_walk_next(struct vfs_ancestor_walk *aw)
 {
 	if (aw->flags & VFS_WALK_STARTED) {
-		int err = vfs_walk_step_ref(aw);
+		int err = (aw->flags & VFS_WALK_RCU) ?
+			vfs_walk_step_rcu(aw) : vfs_walk_step_ref(aw);
 
 		if (err)
 			return err;
@@ -2308,6 +2383,10 @@ int vfs_walk_next(struct vfs_ancestor_walk *aw)
 		aw->flags |= VFS_WALK_STARTED;
 		aw->pos_flags = vfs_walk_pos_flags(aw->pos.mnt, aw->pos.dentry);
 	}
+	/* The flags must describe the dentry the seq covers. */
+	if ((aw->flags & VFS_WALK_RCU) &&
+	    read_seqcount_retry(&aw->pos.dentry->d_seq, aw->seq))
+		return -ECHILD;
 	return 0;
 }
 
@@ -2317,7 +2396,59 @@ int vfs_walk_next(struct vfs_ancestor_walk *aw)
  */
 void vfs_walk_end(struct vfs_ancestor_walk *aw)
 {
-	path_put(&aw->pos);
+	if (!(aw->flags & VFS_WALK_RCU))
+		path_put(&aw->pos);
+}
+
+/**
+ * vfs_walk_handover - continue an rcu-mode walk with references
+ * @to: walk state to begin at @from's current position, owning the
+ *      references acquired on it; valid until vfs_walk_end() either way
+ * @from: an rcu-mode walk, positioned by a 0 return from vfs_walk_next()
+ *
+ * Mirrors unlazy_walk(): @from's current position is legitimized and
+ * becomes the starting position of the referenced walk @to, which the
+ * first vfs_walk_next() on it yields.  A failed legitimization leaves no
+ * partial references behind and a successful one moves straight into @to,
+ * so nothing is ever put here and the handover is safe within the caller's
+ * RCU read-side critical section - where a path_put() would not be, dput()
+ * being allowed to sleep.  @to itself is only usable once the caller has
+ * left it, its walk being reference-based.
+ *
+ * @from is untouched on success and may keep stepping, lockless, from
+ * where it stands.  The references do not conclude its walk: a concurrent
+ * rename may relocate the position the instant they are taken, as it may
+ * during any reference-based walk.
+ *
+ * Returns: false iff @from lost a race; it is then dead, as after -ECHILD
+ * from vfs_walk_next(), and @to is zeroed - safe to vfs_walk_end(), but
+ * not to step, so the caller has to remember it never started.
+ */
+bool vfs_walk_handover(struct vfs_ancestor_walk *to,
+		       struct vfs_ancestor_walk *from)
+{
+	struct path pos = from->pos;
+	int err;
+
+	err = __legitimize_mnt(pos.mnt, from->m_seq);
+	if (unlikely(err)) {
+		if (err < 0)
+			mnt_undo_legitimize(real_mount(pos.mnt));
+		goto dead;
+	}
+	if (unlikely(read_seqcount_retry(&pos.dentry->d_seq, from->seq) ||
+		     !lockref_get_not_dead(&pos.dentry->d_lockref))) {
+		mnt_undo_legitimize(real_mount(pos.mnt));
+		goto dead;
+	}
+	to->pos = pos;
+	to->flags = 0;
+	to->pos_flags = 0;
+	return true;
+
+dead:
+	memset(to, 0, sizeof(*to));
+	return false;
 }
 
 /**
@@ -2326,18 +2457,25 @@ void vfs_walk_end(struct vfs_ancestor_walk *aw)
  * @cb: callback invoked on @path, then on each ancestor up to the real
  *      root, crossing mount boundaries.  @cb must not sleep and returns
  *      %VFS_WALK_CONTINUE, %VFS_WALK_STOP or a negative errno to abort the
- *      walk.  @ancestor is only valid during the invocation; @cb must take
- *      its own references to keep a position.
+ *      walk; -ECHILD is reserved (see below).  @ancestor is only valid
+ *      during the invocation; @cb must take its own references to keep a
+ *      position.
  *      A position whose dentry is a disconnected root is flagged with
  *      %VFS_WALK_POS_DISCONNECTED (plus %VFS_WALK_POS_MOUNTPOINT when it
  *      is a mountpoint a mount crossing landed on rather than a parent);
  *      if @cb continues over it, the walk resumes at the root of that
  *      position's mount.
+ *      With %VFS_WALK_RCU, @cb accepts positions the walk holds no
+ *      references on: the walk then runs lockless (under rcu_read_lock)
+ *      and returns -ECHILD when it loses a race, or when @cb returns
+ *      -ECHILD.  The caller should then discard any state @cb accumulated
+ *      and retry without %VFS_WALK_RCU.
  * @data: opaque argument passed to @cb
- * @flags: %VFS_WALK_* flags; none defined yet, pass 0
+ * @flags: %VFS_WALK_RCU if @cb copes with unreferenced positions
  *
- * Returns: 0 once the real root was reached, 1 if @cb stopped the walk, or
- * the negative errno @cb aborted with.
+ * Returns: 0 once the real root was reached, 1 if @cb stopped the walk,
+ * -ECHILD if a lockless walk must be retried with references, or the
+ * negative errno @cb aborted with.
  */
 int vfs_walk_ancestors(const struct path *path,
 		       int (*cb)(const struct path *ancestor,
@@ -2347,6 +2485,8 @@ int vfs_walk_ancestors(const struct path *path,
 	struct vfs_ancestor_walk aw;
 	int ret;
 
+	if (flags & VFS_WALK_RCU)
+		rcu_read_lock();
 	vfs_walk_start(&aw, path, flags);
 	for (;;) {
 		ret = vfs_walk_next(&aw);
@@ -2365,6 +2505,8 @@ int vfs_walk_ancestors(const struct path *path,
 		}
 	}
 	vfs_walk_end(&aw);
+	if (flags & VFS_WALK_RCU)
+		rcu_read_unlock();
 	return ret;
 }
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3e198de7a0d3..8820a2833213 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -162,6 +162,9 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+/* vfs_walk_ancestors() flags */
+#define VFS_WALK_RCU			BIT(0)
+
 /* per-position flags passed to the vfs_walk_ancestors() callback */
 #define VFS_WALK_POS_DISCONNECTED	BIT(0)
 /* the position is a mountpoint landed on by a mount crossing */
-- 
2.55.0

