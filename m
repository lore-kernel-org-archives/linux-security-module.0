Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008663;
	b=VlRcmcwyfvbVHXYl971u6CK62hQwSsrGEKKT5tb4BwtOOznFbvstdi+ZwhRBha6b7Cch
	 67CV/Hw5P+17xpRq08u2b+CDU8H8lFsikkwwerIY+RcvzXdi8c4OWA906lZ00frLG49HO
	 p1Rpljs/XJ4x6MmKLc/TK5olQuEgC3a16uL8aZN7moGjtH65lnsOaCnt/CwcyBc87hBWd
	 3lAewFfsANKkNP6eDuL3pnk7Ro3Ceo2mjI6ye2nWNBYeI7mgYAPuQL0kYxnJKPxKzZWgI
	 aDuLfkMxOjG9+Ez2spEA1M76tqn49SjWbWqtEc1G02PbJsItbVvn0W0eVSGNOg8Redg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008663;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f4yalWXXSNIedpdmSjasV68YdTATiVUIW3zIVAq8TPY=;
	b=G3ZTdLkOuVCjwnazaWe4GoM7sau3q6SVuc+2w/ysr1/AAtJUG4eqC2A2mTyeDGTakC2p
	 +491S+M7N/s1OkD6L3m6vT3d3cVe8XoZ1JRrnxWdd43+4NhjCNSGvZ8ZU5G39bCchDHec
	 sYbwQ9sLtyy+V8HgYD8oco00pGdrubLhF+k77eTMpBeTgwjM/5bIl8HoKCInuWd2li3CL
	 +xRJ+mWJd/OVifFeHf8IwtgJL+qOBiEP6YQh7Ct/eGBAZt4nhNONvbbLKZxlwC/f7L84C
	 u6BGa91Rjkty4QhFsaSkYcOU/T6Yp9i6O1av9XDUZjMZBTm9cOV+cTb2Atu+qV5gIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+lPtduY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36560A5BDE;
	Mon, 26 Oct 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+lPtduY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915A11F01182;
	Mon, 26 Oct 2026 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008662;
	bh=f4yalWXXSNIedpdmSjasV68YdTATiVUIW3zIVAq8TPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k+lPtduYklIQMpzUU0MU9EY1fHU0Verw3mdxP7U1x7a0CABvVKMoBxwFqENg7uMF2
	 66SSliZlJB9M4CafdYK/zCOrsRtx19BLwfrBtey3YdiTJPvs3W35s0h3KaSlSZrWsR
	 PvWQiCAJqPLdAJcunLQhC1HoPP84B0cCWkwh6KDJv98WQy7sMJT3W2PYeztE00Qbp6
	 +yhbq9mPwgvGz1CTx82QzeSV7pEgAvczuy1WcWoHcKP+bFZ0xqUtERib3wWeQepBkB
	 Ys5h9y+4EFQvIixHM0+KcB8C8AZ77Z1+cXtKiqf6vrFjp/j+/BrfMgoPSQi65Q8ArU
	 Xn0CuaNcqDo7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:14 +0100
Subject: [PATCH 6/8] nstree: drop ns_tree_add_raw()
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
Message-Id: <20261026-work-security-namespace_free-v1-6-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4196; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tj9kd7vELKufiPKwD+vHRyW4owW63ehZ7HlsaRDfc/w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2Fqc/QN3rHSbH7VLd7ZsbNitSoeCuddq6x/tPXmL
 YsLWisTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiconhJ+N9jdqLrP5TFM/e
 SlyltdjkXTWLd4DKQokMN4tlacXvHzEyPHq/x7+tfaum/8WgyKVpUupV7aZGf9uvs63zu6J4/m4
 sLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that ns_tree_add() doesn't allocate an id anymore it does the same
thing as ns_tree_add_raw(). Switch the remaining ns_tree_add_raw() users
over to ns_tree_add() and drop it. Rename __ns_tree_add_raw() to
__ns_tree_add() while at it.

No functional changes.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c           |  4 ++--
 include/linux/nstree.h   | 13 ++-----------
 ipc/namespace.c          |  2 +-
 kernel/nstree.c          |  2 +-
 net/core/net_namespace.c |  2 +-
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f81d6a4bc3fe..2f9a1460b4ac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3296,7 +3296,7 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	}
 
 	new_ns->root = new_ns_root;
-	ns_tree_add_raw(new_ns);
+	ns_tree_add(new_ns);
 	return new_ns;
 }
 
@@ -4497,7 +4497,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 				p = next_mnt(skip_mnt_tree(p), old);
 		}
 	}
-	ns_tree_add_raw(new_ns);
+	ns_tree_add(new_ns);
 	return new_ns;
 }
 
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 3293df17397d..eeed713804be 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -42,22 +42,13 @@ void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root);
 		struct uts_namespace *:    &(uts_ns_tree))
 
 u64 __ns_tree_gen_id(struct ns_common *ns, u64 id);
-void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree);
+void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_tree);
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree_root *ns_tree);
 struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type);
 struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 					 struct ns_tree_root *ns_tree,
 					 bool previous);
 
-/**
- * ns_tree_add_raw - Add a namespace to a namespace
- * @__ns: Namespace to add
- *
- * This function adds a namespace to the appropriate namespace tree
- * without assigning a id.
- */
-#define ns_tree_add_raw(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
-
 /**
  * ns_tree_add - Add a namespace to a namespace tree
  * @__ns: Namespace to add
@@ -65,7 +56,7 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
  * This function adds a namespace to the appropriate namespace tree and
  * list. The namespace must already have been assigned an id.
  */
-#define ns_tree_add(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
+#define ns_tree_add(__ns) __ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns))
 
 /**
  * ns_tree_remove - Remove a namespace from a namespace tree
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 9084e0643017..b4fab86aee27 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -86,7 +86,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	sem_init_ns(ns);
 	shm_init_ns(ns);
-	ns_tree_add_raw(ns);
+	ns_tree_add(ns);
 
 	return ns;
 
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 831f279d174a..94153dfddb3d 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -194,7 +194,7 @@ static int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
 	return ns_id_cmp(node_to_ns_owner(a)->ns_id, node_to_ns_owner(b)->ns_id);
 }
 
-void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree)
+void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_tree)
 {
 	struct rb_node *node;
 	const struct proc_ns_operations *ops = ns->ops;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ec4077b81389..54ba07eba003 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -447,7 +447,7 @@ static __net_init int setup_net(struct net *net)
 	down_write(&net_rwsem);
 	list_add_tail_rcu(&net->list, &net_namespace_list);
 	up_write(&net_rwsem);
-	ns_tree_add_raw(net);
+	ns_tree_add(net);
 out:
 	return error;
 

-- 
2.53.0

