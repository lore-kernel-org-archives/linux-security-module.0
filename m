Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013B221547
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019477; cv=none; b=OGm+9ELDlKnyUn0gNt7SoIcliy1YVL/tpjpTZrXwkZ3clKTN4L8qYh3DDSP0ZXDNkRv6uN+jPXA4BGnLZaUnw9R5Kt2ypOfhq3sDXCitte1M3cF9CiR0OHIN6qnDMMKzIPm8CB1MUV63ESPgXFGHqO6ztl8OYhab0o7+ZufJToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019477; c=relaxed/simple;
	bh=+7159beUhhZbpPIl0BMBq0uCyehbAf5AlDTwixhUo7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiP3v6mt2FokrZIm0vojbtEoXuLvBEey5bOjqzHhxNGhEcI7z6dsc+p/rE0lDz/kLJHKuQfn1S+BIBQi7Y2cDeIwisdqvwstpRfukqSHDvkPdx1j1S+AQndCM6PBEYIm9koisthkmBImqFWSUkAPszsAw7nZedlOgob6QC4EwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AC3K3OZP; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AC3K3OZP"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv22tb1zjHh;
	Fri, 23 May 2025 18:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019470;
	bh=jHpCJddH6N4r5AUTEYYRxYAdaOVLLofBA07V/5TXuGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AC3K3OZPvAMOEcoqMDNSfM3Eae5b77NPF4ugUbmie/5KoHaCiO2gE4O4Y6jhTjDAN
	 t6W+SBNfWcqglyLETpEcYd2qf+tMp0fcoFdoy73HXaBsLjh94RbrHrzILZHpOdU/jf
	 IWSzStGWKxFHNID24jFkgWz82bmI2u87tmTNneVk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rv15qNyzD33;
	Fri, 23 May 2025 18:57:49 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Shervin Oloumi <enlightened@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/5] landlock: Rename landlock_id to landlock_rule_ref
Date: Fri, 23 May 2025 18:57:37 +0200
Message-ID: <20250523165741.693976-2-mic@digikod.net>
In-Reply-To: <20250523165741.693976-1-mic@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This avoids confusion with the new Landlock IDs.

TODO: Split in several commits to ease potential backports according to
stable branches

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c      | 18 ++++++-------
 security/landlock/net.c     | 14 +++++-----
 security/landlock/ruleset.c | 52 ++++++++++++++++++-------------------
 security/landlock/ruleset.h |  8 +++---
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..f5087688190a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -325,7 +325,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    access_mask_t access_rights)
 {
 	int err;
-	struct landlock_id id = {
+	struct landlock_rule_ref ref = {
 		.type = LANDLOCK_KEY_INODE,
 	};
 
@@ -339,17 +339,17 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	/* Transforms relative access rights to absolute ones. */
 	access_rights |= LANDLOCK_MASK_ACCESS_FS &
 			 ~landlock_get_fs_access_mask(ruleset, 0);
-	id.key.object = get_inode_object(d_backing_inode(path->dentry));
-	if (IS_ERR(id.key.object))
-		return PTR_ERR(id.key.object);
+	ref.key.object = get_inode_object(d_backing_inode(path->dentry));
+	if (IS_ERR(ref.key.object))
+		return PTR_ERR(ref.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, ref, access_rights);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
 	 * increments the refcount for the new object if needed.
 	 */
-	landlock_put_object(id.key.object);
+	landlock_put_object(ref.key.object);
 	return err;
 }
 
@@ -366,7 +366,7 @@ find_rule(const struct landlock_ruleset *const domain,
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
-	struct landlock_id id = {
+	struct landlock_rule_ref ref = {
 		.type = LANDLOCK_KEY_INODE,
 	};
 
@@ -376,8 +376,8 @@ find_rule(const struct landlock_ruleset *const domain,
 
 	inode = d_backing_inode(dentry);
 	rcu_read_lock();
-	id.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, id);
+	ref.key.object = rcu_dereference(landlock_inode(inode)->object);
+	rule = landlock_find_rule(domain, ref);
 	rcu_read_unlock();
 	return rule;
 }
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1f3915a90a80..cd7327b5f43e 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -23,19 +23,19 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			     const u16 port, access_mask_t access_rights)
 {
 	int err;
-	const struct landlock_id id = {
+	const struct landlock_rule_ref ref = {
 		.key.data = (__force uintptr_t)htons(port),
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
 
-	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
+	BUILD_BUG_ON(sizeof(port) > sizeof(ref.key.data));
 
 	/* Transforms relative access rights to absolute ones. */
 	access_rights |= LANDLOCK_MASK_ACCESS_NET &
 			 ~landlock_get_net_access_mask(ruleset, 0);
 
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, ref, access_rights);
 	mutex_unlock(&ruleset->lock);
 
 	return err;
@@ -49,7 +49,7 @@ static int current_check_access_socket(struct socket *const sock,
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
 	const struct landlock_rule *rule;
-	struct landlock_id id = {
+	struct landlock_rule_ref ref = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
 	const struct access_masks masks = {
@@ -171,10 +171,10 @@ static int current_check_access_socket(struct socket *const sock,
 			return -EINVAL;
 	}
 
-	id.key.data = (__force uintptr_t)port;
-	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
+	ref.key.data = (__force uintptr_t)port;
+	BUILD_BUG_ON(sizeof(port) > sizeof(ref.key.data));
 
-	rule = landlock_find_rule(subject->domain, id);
+	rule = landlock_find_rule(subject->domain, ref);
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea51..647ee570475b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -104,7 +104,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 }
 
 static struct landlock_rule *
-create_rule(const struct landlock_id id,
+create_rule(const struct landlock_rule_ref ref,
 	    const struct landlock_layer (*const layers)[], const u32 num_layers,
 	    const struct landlock_layer *const new_layer)
 {
@@ -125,13 +125,13 @@ create_rule(const struct landlock_id id,
 	if (!new_rule)
 		return ERR_PTR(-ENOMEM);
 	RB_CLEAR_NODE(&new_rule->node);
-	if (is_object_pointer(id.type)) {
+	if (is_object_pointer(ref.type)) {
 		/* This should have been caught by insert_rule(). */
-		WARN_ON_ONCE(!id.key.object);
-		landlock_get_object(id.key.object);
+		WARN_ON_ONCE(!ref.key.object);
+		landlock_get_object(ref.key.object);
 	}
 
-	new_rule->key = id.key;
+	new_rule->key = ref.key;
 	new_rule->num_layers = new_num_layers;
 	/* Copies the original layer stack. */
 	memcpy(new_rule->layers, layers,
@@ -186,8 +186,8 @@ static void build_check_ruleset(void)
  * insert_rule - Create and insert a rule in a ruleset
  *
  * @ruleset: The ruleset to be updated.
- * @id: The ID to build the new rule with.  The underlying kernel object, if
- *      any, must be held by the caller.
+ * @ref: The reference to build the new rule with.  The underlying kernel
+ *       object, if any, must be held by the caller.
  * @layers: One or multiple layers to be copied into the new rule.
  * @num_layers: The number of @layers entries.
  *
@@ -201,7 +201,7 @@ static void build_check_ruleset(void)
  * access rights.
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
-		       const struct landlock_id id,
+		       const struct landlock_rule_ref ref,
 		       const struct landlock_layer (*const layers)[],
 		       const size_t num_layers)
 {
@@ -215,10 +215,10 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 	if (WARN_ON_ONCE(!layers))
 		return -ENOENT;
 
-	if (is_object_pointer(id.type) && WARN_ON_ONCE(!id.key.object))
+	if (is_object_pointer(ref.type) && WARN_ON_ONCE(!ref.key.object))
 		return -ENOENT;
 
-	root = get_root(ruleset, id.type);
+	root = get_root(ruleset, ref.type);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -227,9 +227,9 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		struct landlock_rule *const this =
 			rb_entry(*walker_node, struct landlock_rule, node);
 
-		if (this->key.data != id.key.data) {
+		if (this->key.data != ref.key.data) {
 			parent_node = *walker_node;
-			if (this->key.data < id.key.data)
+			if (this->key.data < ref.key.data)
 				walker_node = &((*walker_node)->rb_right);
 			else
 				walker_node = &((*walker_node)->rb_left);
@@ -261,20 +261,20 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		 * Intersects access rights when it is a merge between a
 		 * ruleset and a domain.
 		 */
-		new_rule = create_rule(id, &this->layers, this->num_layers,
+		new_rule = create_rule(ref, &this->layers, this->num_layers,
 				       &(*layers)[0]);
 		if (IS_ERR(new_rule))
 			return PTR_ERR(new_rule);
 		rb_replace_node(&this->node, &new_rule->node, root);
-		free_rule(this, id.type);
+		free_rule(this, ref.type);
 		return 0;
 	}
 
-	/* There is no match for @id. */
+	/* There is no match for @ref. */
 	build_check_ruleset();
 	if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
 		return -E2BIG;
-	new_rule = create_rule(id, layers, num_layers, NULL);
+	new_rule = create_rule(ref, layers, num_layers, NULL);
 	if (IS_ERR(new_rule))
 		return PTR_ERR(new_rule);
 	rb_link_node(&new_rule->node, parent_node, walker_node);
@@ -296,7 +296,7 @@ static void build_check_layer(void)
 
 /* @ruleset must be locked by the caller. */
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
+			 const struct landlock_rule_ref ref,
 			 const access_mask_t access)
 {
 	struct landlock_layer layers[] = { {
@@ -306,7 +306,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 	} };
 
 	build_check_layer();
-	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
+	return insert_rule(ruleset, ref, &layers, ARRAY_SIZE(layers));
 }
 
 static int merge_tree(struct landlock_ruleset *const dst,
@@ -331,7 +331,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 		struct landlock_layer layers[] = { {
 			.level = dst->num_layers,
 		} };
-		const struct landlock_id id = {
+		const struct landlock_rule_ref ref = {
 			.key = walker_rule->key,
 			.type = key_type,
 		};
@@ -344,7 +344,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 
 		layers[0].access = walker_rule->layers[0].access;
 
-		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
+		err = insert_rule(dst, ref, &layers, ARRAY_SIZE(layers));
 		if (err)
 			return err;
 	}
@@ -413,12 +413,12 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 	/* Copies the @parent inode or network tree. */
 	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
 					     parent_root, node) {
-		const struct landlock_id id = {
+		const struct landlock_rule_ref ref = {
 			.key = walker_rule->key,
 			.type = key_type,
 		};
 
-		err = insert_rule(child, id, &walker_rule->layers,
+		err = insert_rule(child, ref, &walker_rule->layers,
 				  walker_rule->num_layers);
 		if (err)
 			return err;
@@ -581,12 +581,12 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
  */
 const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id)
+		   const struct landlock_rule_ref ref)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
 
-	root = get_root((struct landlock_ruleset *)ruleset, id.type);
+	root = get_root((struct landlock_ruleset *)ruleset, ref.type);
 	if (IS_ERR(root))
 		return NULL;
 	node = root->rb_node;
@@ -595,9 +595,9 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		struct landlock_rule *this =
 			rb_entry(node, struct landlock_rule, node);
 
-		if (this->key.data == id.key.data)
+		if (this->key.data == ref.key.data)
 			return this;
-		if (this->key.data < id.key.data)
+		if (this->key.data < ref.key.data)
 			node = node->rb_right;
 		else
 			node = node->rb_left;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5da9a64f5af7..967d0123cb73 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -69,9 +69,9 @@ enum landlock_key_type {
 };
 
 /**
- * struct landlock_id - Unique rule identifier for a ruleset
+ * struct landlock_rule_ref - Rule reference for a ruleset
  */
-struct landlock_id {
+struct landlock_rule_ref {
 	/**
 	 * @key: Identifies either a kernel object (e.g. an inode) or
 	 * a raw value (e.g. a TCP port).
@@ -201,7 +201,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
+			 const struct landlock_rule_ref ref,
 			 const access_mask_t access);
 
 struct landlock_ruleset *
@@ -210,7 +210,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 
 const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id);
+		   const struct landlock_rule_ref ref);
 
 static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 {
-- 
2.49.0

