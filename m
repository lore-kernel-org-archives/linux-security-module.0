Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177827;
	b=Y9OOiruiGMz6Q+1GP+eTiVZGX4gu3I3vXFtPv3psb6VxyDg4V9xIPDyiu3V8IcAtONDB
	 2nLShlA5PLX8uhXdvRuJUNEeOiGOzZGAixmzs2t1PKU0Y6EyCCtL8w9lIu40moqi8P8vT
	 Nu1G+I+D/JISjFtgzHlyuUiUaKzIlDnmHghaxQ3JZLsHRqGlQ2HTGY13Jz0xYibzsCqal
	 10EYTJ95qm2ozgvQlILeDqnfj8Nl0HYJdnEScelVXEB/8uVgDUMy1UHUAKn7SEENXl+Fp
	 SYoLTdhtHq6luQbJBZHZVMiUERGqi3RvcFWIe0k4C7rmrXF/6TMAAqYLEAf3IW6wUxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177827;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=y3GtLcDsnQ6/IzDrJw7/G2SJZ4cUjtR4VZMzRimqXX8=;
	b=IWEoWGwtO+dE5vx9XBXlM1c/1QBuQOXsDpdtKoEOzrZfWulM0oiaCTcPBazsW8tTuR8u
	 q/MY5ZKu0jII69v2SRDCpIvxnn0caZKmDGQuFdZVUefae/n8l4oOnQ1TphwroJ0YCjc5D
	 c/DDoLY7R7xWMvpzE+9YZQwvQ3Br+KpgLOrE7W40QA1qhUMDXdiSc0jGN+oE2eD5FZCzq
	 Ps9LiXiDwj3Wy/IEvJQwQujdqj9pdlhgGkoGmh9ytsROQ8jkr1ghruBOxAuRlXpn+xEPI
	 1rSeBT7ZWhTe1jQ6jwJt7UD8R/n9uB8h64jH5CgiewNi1PT7neSg8ppx7jPMNcI5HBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XluLPZ4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B6606A32A;
	Fri, 20 Nov 2026 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XluLPZ4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E4C1F0089F;
	Fri, 20 Nov 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177826;
	bh=y3GtLcDsnQ6/IzDrJw7/G2SJZ4cUjtR4VZMzRimqXX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XluLPZ4+Gp14+08bt5TRFRtSK/ssDxNbZRdFSZX//xozBdCv+7xwYCDQQo83sv2os
	 KgW6X5mwsxKwdM3tleT82v9M3xc8oDuMcvBTjaHocksRPxqNhDu1oF39KcFgFrUm9D
	 R3PQwx9bnHJ/PZYBX5yZ9CDvlkTSMV14TlDy0uClTB/K8sUkQ/S2Yq3NF2nsdOKT1p
	 lJgmy+k9lnDkBbdaAVcTbVQdfY39raofIMZF8D3tEjaKvweGJOI6Ir9UdNy2i7chzF
	 zHY5cL8LzfBx1m8zE4qkCGn53A/Im3hHo3rpMgu3Nq5vclS9YjJcEwShjWqU+JunaQ
	 7f4vWV+yUhsLg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 13:29:59 +0100
Subject: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
In-Reply-To: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 bpf@vger.kernel.org, Zhiqi Zhang <zhiqizhangg@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=7517; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wTMjzBjIfS/zzzoIGdxud64NQW5230bewEdpFl0UyOU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz2EY4BWU9v/n05sKuJXJzZv3/enG59V8ryVtvHa7wf
 1A38741p6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifQ6MDAvuXq9yfWfSsJbn
 vr3Ul+BqxlIepbybKZ5b1/jOunF13k5GhgmbIyw+Z4Q/ME6dJ/3BY7ftrsYluxoP2r7wTFEUP6v
 ryggA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

mount_subtree() allocates a private anonymous mount namespace so that
automounts triggered while it looks up the path have somewhere to go.
That namespace never becomes anyone's namespace and it's gone again
before mount_subtree() returns. btrfs goes through it on every mount:

  btrfs_get_tree()
  -> btrfs_get_tree_subvol()
     -> mount_subvol()
        -> mount_subtree()

and NFS on every NFSv4 mount and whenever it follows a referral:

  nfs4_try_get_tree() / nfs4_get_referral_tree()
  -> do_nfs4_mount()
     -> mount_subtree()

But __ns_common_init() calls security_namespace_init() for it like for
any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
namespace use restrictions") Landlock enforces
LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a task
in a domain that handles that permission without allowing CLONE_NEWNS
can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
though the caller never asked for a mount namespace.

Mark such namespaces as kernel-internal and don't call the namespace
LSM hooks for them at all. That includes namespace_free. Currently
security_namespace_free() only calls the hook if an LSM requested a
namespace blob and none does. But we shouldn't rely on that. Otherwise
a bpf program attached to namespace_free would see namespaces go away
that it never saw being created.

The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
and fsmount() are handed to userspace and keep going through the hooks.
Landlock covers them on purpose.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
Closes: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c                     |  9 +++++++--
 include/linux/ns/ns_common_types.h |  2 ++
 include/linux/ns_common.h          | 20 +++++++++++++-------
 kernel/nscommon.c                  |  9 ++++++---
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 756f9011cbf1d..82738b818c1d0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2355,6 +2355,7 @@ void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 
 enum mnt_ns_flags_t {
 	MNT_NS_ANON	= (1 << 0),
+	MNT_NS_KERNEL	= (1 << 1),
 };
 
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
@@ -4377,10 +4378,14 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns,
 					  enum mnt_ns_flags_t flags)
 {
+	enum ns_common_flags_t ns_flags = 0;
 	struct mnt_namespace *new_ns;
 	struct ucounts *ucounts;
 	int ret;
 
+	if (flags & MNT_NS_KERNEL)
+		ns_flags |= NS_COMMON_KERNEL;
+
 	ucounts = inc_mnt_namespaces(user_ns);
 	if (!ucounts)
 		return ERR_PTR(-ENOSPC);
@@ -4392,7 +4397,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns,
 	}
 
 	if (flags & MNT_NS_ANON)
-		ret = ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
+		ret = ns_common_init_inum(new_ns, MNT_NS_ANON_INO, ns_flags);
 	else
 		ret = ns_common_init(new_ns);
 	if (ret) {
@@ -4515,7 +4520,7 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 	struct path path;
 	int err;
 
-	ns = alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
+	ns = alloc_mnt_ns(&init_user_ns, MNT_NS_ANON | MNT_NS_KERNEL);
 	if (IS_ERR(ns)) {
 		mntput(m);
 		return ERR_CAST(ns);
diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
index 47a5cfe2326a3..5f8b0930ae065 100644
--- a/include/linux/ns/ns_common_types.h
+++ b/include/linux/ns/ns_common_types.h
@@ -102,6 +102,7 @@ extern const struct proc_ns_operations utsns_operations;
  *   __ns_ref_active = 1 and remain active forever.
  *
  * @ns_type: type of namespace (e.g., CLONE_NEWNET)
+ * @ns_flags: NS_COMMON_* flags
  * @stashed: cached dentry to be used by the vfs
  * @ops: namespace operations
  * @inum: namespace inode number (quickly recycled for non-initial namespaces)
@@ -113,6 +114,7 @@ struct ns_common {
 		refcount_t __ns_ref; /* do not use directly */
 	} ____cacheline_aligned_in_smp;
 	u32 ns_type;
+	u32 ns_flags;
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index e8b2bf0da5ede..524b77904d3b4 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -8,9 +8,14 @@
 #include <uapi/linux/sched.h>
 #include <uapi/linux/nsfs.h>
 
+enum ns_common_flags_t {
+	/* Kernel-internal namespace. The LSM namespace hooks never see it. */
+	NS_COMMON_KERNEL	= (1 << 0),
+};
+
 bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
-		     int inum, u64 ns_id);
+		     int inum, u64 ns_id, enum ns_common_flags_t flags);
 void __ns_common_free(struct ns_common *ns);
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
@@ -47,13 +52,14 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 			 ns_common_type(__ns),				\
 			 to_ns_operations(__ns),			\
 			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0), \
-			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
+			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0), \
+			 0)
 
-#define ns_common_init_inum(__ns, __inum)        \
-	__ns_common_init(to_ns_common(__ns),     \
-			 ns_common_type(__ns),   \
-			 to_ns_operations(__ns), \
-			 __inum, 0)
+#define ns_common_init_inum(__ns, __inum, __flags) \
+	__ns_common_init(to_ns_common(__ns),       \
+			 ns_common_type(__ns),     \
+			 to_ns_operations(__ns),   \
+			 __inum, 0, __flags)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 4438c6b663f91..20fc0d0e98212 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -55,7 +55,7 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 #endif
 
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
-		     int inum, u64 ns_id)
+		     int inum, u64 ns_id, enum ns_common_flags_t flags)
 {
 	int ret = 0;
 
@@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 #endif
 	ns->ops = ops;
 	ns->ns_type = ns_type;
+	ns->ns_flags = flags;
 	ns_tree_node_init(&ns->ns_tree_node);
 	ns_tree_node_init(&ns->ns_unified_node);
 	ns_tree_node_init(&ns->ns_owner_node);
@@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	/* Allocate the id before the LSM hook so it can track the namespace by it. */
 	__ns_tree_gen_id(ns, ns_id);
 
-	ret = security_namespace_init(ns);
+	if (!(flags & NS_COMMON_KERNEL))
+		ret = security_namespace_init(ns);
 	if (ret) {
 		if (!inum)
 			proc_free_inum(ns->inum);
@@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 void __ns_common_free(struct ns_common *ns)
 {
-	security_namespace_free(ns);
+	if (!(ns->ns_flags & NS_COMMON_KERNEL))
+		security_namespace_free(ns);
 
 	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
 		proc_free_inum(ns->inum);

-- 
2.53.0

