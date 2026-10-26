Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008660;
	b=45hbCsfN3w4bLVIw6GlbMxmgHv7d/RW+/cH+AwnhEwfg7AQI/1PBVV6PuhdJhxwTuhmP
	 y/uDsGde7ElhvL8w7CzKObaxE7Kf38bphL8OeKZRT87iepNSwxc7fPM/VdHeEC8P14PCM
	 mCRsAbzaHshZf+SYUD+AJc4e2hyTc4SMrdgODoHmR4zsGTh5IOQ3PEM+Th3FZVT3qccMQ
	 ZNLxW0hC5zFBAnn7vgcGcEje0IVirH7A0FFT1oCkORkGBtpcQU5j68KZ/KqTkBuAPSKj9
	 Lf7JUIDipbfSOu+TJ3qj7AtZTBUUYTuW87NE3b0dJFApAwfKLcXgdGUpsVT4FSRKvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008660;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=huMAv/MzkZHv8ZJEYejVMacxD/PxKsIrlWJhNzi1drI=;
	b=xfXQzNLe+ujFvjsAmQaTBi5TpXcLxF3ME1E1UmA/blumrW7szi/vJlChlkdWEeZdPIva
	 h5cBM6KpvvPWg2Usdrkx9dF/8O5Xtpwb570yfoZgnEfDinl9/Z//Z5l4J4hpuAxy5doUD
	 l9NOvDOdansnD9x23VMHgJh7geF//VbwtY5YvhgXNKiGOJbchiIC/XyAzt6lfnpM6UakH
	 dNMqwrybILHgf5f0qOZfE+YCF8G2wrHhAck8ojtyyo3Ta2i1YbZXgmIe1IeLgquLF62zX
	 LHit9vb0txQL80rPrkMcpfoiuVmYEJxV+uk7mMmUwr3wqaBshfkp8ReBdeJEZK7bzig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+T9XbEG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51C60A3802;
	Mon, 26 Oct 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+T9XbEG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37E31F031E6;
	Mon, 26 Oct 2026 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008660;
	bh=huMAv/MzkZHv8ZJEYejVMacxD/PxKsIrlWJhNzi1drI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a+T9XbEGu+ksGiDsKUfTFc1fbYYnxj/tw7sIyT5Vw46jbZdpyCN7OQdiGCMgHiPXe
	 rxrHJMws7LC4f9tG0w7No2P0YJ+jA5TqNfYIxzUm8gy6jHpan/hlI54FAmZHzWnR7g
	 2kuBC1NXB0BQnUexutnH6QQhs/uoR+/qP6wByrYNeJTX2l2+kCdQU0xuWItZtFFSM3
	 qfD2Tdk/Wg92lcDGWzZY2u15+rjP37c0pfISXyJCNQFXNh0uiT8oWvtGySE1aM8vOa
	 qRPEyifSKYQT+5pJ9WN8pQYT6dNWJG037o4dydgKgCdrgD8OXS5ZnpWw6sTWZ5tafb
	 /m9VKCEnX0B4w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:13 +0100
Subject: [PATCH 5/8] ns: allocate the namespace id before the
 namespace_init hook
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
Message-Id: <20261026-work-security-namespace_free-v1-5-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TjZdS5UFkbg1jRuAtiPWcQO2vk8gSxX8Lk/xTy5dU+8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2G6Ydig9czunvTxkvr6NKPZe++d9tPb6tHwxzrtm
 mv9ZpmNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNp1mX4K2o9O4pttZVT2kWb
 aoerGu+PTdWyKnhcmXzxv2SAqEf1N0aGI1/7zI6abd5pniweM/fF0wc73in5xigujhCP556kkGH
 KCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently the namespace id is allocated only after __ns_common_init()
has called the namespace_init LSM hook. Most namespace types allocate it
in ns_tree_add() right before the namespace is added to the namespace
trees. So the namespace_init hook always sees an id of zero.

The namespace id is the only identifier of a namespace that is never
recycled. A bpf LSM wants to use it to track a namespace from
namespace_init until namespace_free, e.g., by using it as the key into a
map that associates data with the namespace. The inode number doesn't
work for that as it is quickly recycled.

So allocate the id in __ns_common_init() before calling the
namespace_init hook. Every namespace then has its id by the time it is
added to the namespace trees. The initial namespaces still get their
fixed ids, either statically from NS_COMMON_INIT() or for init_net from
ns_common_init(). So ns_tree_add() doesn't need to allocate an id
anymore. Ids are still handed out in creation order so mnt_ns_loop()
keeps working. Mount and ipc namespaces already allocated their id right
after ns_common_init() anyway.

If creating the namespace fails after the id has been allocated the id
is simply never used.

While at it, drop ns_tree_gen_id() as it has no users left.

Reproducer, 100 user and uts namespaces:

  bpftrace -e 'fentry:bpf_lsm_namespace_init {
      @[args.ns->ns_id ? "set" : "zero"] = count(); }' &
  for i in $(seq 100); do unshare -Uu true; done

  before: @[zero]: 200
  after:  @[set]: 200

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c            |  2 --
 include/linux/ns_common.h | 16 +++++++++-------
 include/linux/nstree.h    | 18 +++---------------
 ipc/namespace.c           |  1 -
 kernel/nscommon.c         |  7 +++++--
 net/core/net_namespace.c  |  2 +-
 6 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9f6ec35c7b9c..f81d6a4bc3fe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4394,8 +4394,6 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(ret);
 	}
-	ns_tree_gen_id(new_ns);
-
 	new_ns->is_anon = anon;
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index c8e227a3f9e2..e8b2bf0da5ed 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -9,7 +9,8 @@
 #include <uapi/linux/nsfs.h>
 
 bool is_current_namespace(struct ns_common *ns);
-int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
+int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
+		     int inum, u64 ns_id);
 void __ns_common_free(struct ns_common *ns);
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
@@ -41,17 +42,18 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 	.ns_owner_root.ns_list_head	= LIST_HEAD_INIT(nsname.ns.ns_owner_root.ns_list_head),		\
 }
 
-#define ns_common_init(__ns)                     \
-	__ns_common_init(to_ns_common(__ns),     \
-			 ns_common_type(__ns),   \
-			 to_ns_operations(__ns), \
-			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
+#define ns_common_init(__ns)						\
+	__ns_common_init(to_ns_common(__ns),				\
+			 ns_common_type(__ns),				\
+			 to_ns_operations(__ns),			\
+			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0), \
+			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
 
 #define ns_common_init_inum(__ns, __inum)        \
 	__ns_common_init(to_ns_common(__ns),     \
 			 ns_common_type(__ns),   \
 			 to_ns_operations(__ns), \
-			 __inum)
+			 __inum, 0)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 5b64d4572881..3293df17397d 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -41,10 +41,6 @@ void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root);
 		struct user_namespace *:   &(user_ns_tree),	\
 		struct uts_namespace *:    &(uts_ns_tree))
 
-#define ns_tree_gen_id(__ns)                 \
-	__ns_tree_gen_id(to_ns_common(__ns), \
-			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
-
 u64 __ns_tree_gen_id(struct ns_common *ns, u64 id);
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree);
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree_root *ns_tree);
@@ -53,12 +49,6 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 					 struct ns_tree_root *ns_tree,
 					 bool previous);
 
-static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_tree, u64 id)
-{
-	__ns_tree_gen_id(ns, id);
-	__ns_tree_add_raw(ns, ns_tree);
-}
-
 /**
  * ns_tree_add_raw - Add a namespace to a namespace
  * @__ns: Namespace to add
@@ -72,12 +62,10 @@ static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_t
  * ns_tree_add - Add a namespace to a namespace tree
  * @__ns: Namespace to add
  *
- * This function assigns a new id to the namespace and adds it to the
- * appropriate namespace tree and list.
+ * This function adds a namespace to the appropriate namespace tree and
+ * list. The namespace must already have been assigned an id.
  */
-#define ns_tree_add(__ns)                                   \
-	__ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns), \
-		      (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
+#define ns_tree_add(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
 
 /**
  * ns_tree_remove - Remove a namespace from a namespace tree
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 75aa7b469348..9084e0643017 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -66,7 +66,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (err)
 		goto fail_free;
 
-	ns_tree_gen_id(ns);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index e72426bba29a..4438c6b663f9 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -54,7 +54,8 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 }
 #endif
 
-int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
+int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
+		     int inum, u64 ns_id)
 {
 	int ret = 0;
 
@@ -64,7 +65,6 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns->ns_security = NULL;
 #endif
 	ns->ops = ops;
-	ns->ns_id = 0;
 	ns->ns_type = ns_type;
 	ns_tree_node_init(&ns->ns_tree_node);
 	ns_tree_node_init(&ns->ns_unified_node);
@@ -82,6 +82,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	if (ret)
 		return ret;
 
+	/* Allocate the id before the LSM hook so it can track the namespace by it. */
+	__ns_tree_gen_id(ns, ns_id);
+
 	ret = security_namespace_init(ns);
 	if (ret) {
 		if (!inum)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..ec4077b81389 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -437,7 +437,7 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
-	net->net_cookie = ns_tree_gen_id(net);
+	net->net_cookie = to_ns_common(net)->ns_id;
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);

-- 
2.53.0

