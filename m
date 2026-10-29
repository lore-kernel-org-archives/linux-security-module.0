Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292085;
	b=tY67g8wNgYkIcCgg6SBE05YPdm5zHmJB3ApEUVoHyyI5EWaoTQD0LJlOasVZJFwOtPWM
	 fPnbvAs12EtQQNyr1gDTT34tjMga1AGc0znI+RsSGy2v2JzI5HycRksHvOv6ZgJV1CqFR
	 LjhFHstJnmnG9Z+PciATq0G01XWvp/qDPlQxlex6+p185cnt1XWayTvhpX31/re/FIiZM
	 HY+PLhttm8HkUqEzJG0GMOjIfxqBv8fAAgWER0AEfkdymduPdmvIWQh/Tjc96ckG3fqBd
	 D+u74GrAgTpdsKX+ZZf7J4pPEuSrgIss4aUO8swdF4JaKy1v7v9YP679IZaKVwJ6uaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292085;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f4yalWXXSNIedpdmSjasV68YdTATiVUIW3zIVAq8TPY=;
	b=I3t5ND2KGxRYBHr5wTgKj/unz0KwGfGbEuQnh6S8udS7FFRr/DbMzi8RFuZh1wE9AqGA
	 KWvPMD8YmEDCtvpHhNoOEatlgwINMRhVWHKUTY/+eGf6rvhY6iH/YOf7rsRr3AirlygV7
	 mY/gqOHTfPUYPk504J1vhdQWe49NKF5+YU+7tyJ1iAfWr+1adrnbXtN+3zhAWiCK7mkAH
	 WAlmikQyYFin5GGIt5a5uQ0f79ZIG99gqxWh4oZG42YDbHxM6C4s+tjk1vW8Bkz3avqgj
	 qXKXNokhcoLqz6cRE9pdP9RDrriR6sGryy9/zyx/wMonHEJLzeKmpvM2LQsmgIIj+AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hpw/Af1Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E77606A332;
	Thu, 29 Oct 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hpw/Af1Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420371F01825;
	Thu, 29 Oct 2026 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292085;
	bh=f4yalWXXSNIedpdmSjasV68YdTATiVUIW3zIVAq8TPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hpw/Af1YvQCprQm7BHyhTSAWQVj1uoCXDgBOe8y5xbGp85vAWANjv6Scre3nWGYJ3
	 OkniaTTRUsOu/J4s+WfD033BV/b8XTMvxpL2xeuHwfHDcPrOZrvqKKDozJ4pUJ0YgE
	 2wMO54c+jBlfOEtMKMPAkMVchCHs4sQ2X+mUGFZSoSZFqIxUvR30zavdSfqvt8W9Ol
	 p0uUnY/LzkBDkgK3/Z+zkLCrGGJztVSzWnAO07RElsmeOZBf2U6/aSeCEc3rqwIm1h
	 cRYVogVIu7LtQs6qVXcq+7NvCVcBotDOMMywq3uerzhNCzw1Rme86+xthLatWliWod
	 1jvg0nFBbh9fw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 17:41:00 +0100
Subject: [PATCH v2 5/7] nstree: drop ns_tree_add_raw()
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
Message-Id: <20261029-work-security-namespace_free-v2-5-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4196; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tj9kd7vELKufiPKwD+vHRyW4owW63ehZ7HlsaRDfc/w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9LpdfzbXx0A+FZd3R80z/PGRvFOvd73Ol64cCx/6jO
 5ZKGnSrdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkcS/D/3qtnn81/qUlIeqL
 X8Y+uS/xd0mT3OUrvAbn5tTNmPTK5yLDP5163RVNUm5rfy9PmlTm97i77puFSFSPrOlu4X2+S2/
 1cQIA
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

