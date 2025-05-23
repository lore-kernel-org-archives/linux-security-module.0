Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5113297120
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019482; cv=none; b=lTAPDMvukfVSkuHFmhidh+EjpG2kAvjtDP2B64LpKHgnQk5iZSdHs+DZs/RoWEKdVdEScEKzJhuLjV79gWpwardDaifL795rLZX73ZkzzIgJA9kWXTNDewOn8mSNR65YgOU0kGBrgpC2QvZGPJ+uwQrn2trumibaF40CTUIAktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019482; c=relaxed/simple;
	bh=1qTn4SuVJHUZp8Rms6J1i7K3ZxWwQgcpliv7sfBa/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwlQVqxnkYFQADBtyhpOPPm6TxCwzd8ZGkASOeeZ9JV6VAyktwzArrviurMLt8H+CFk195N/NxfgJ1igQDpNqkIvE3ndJ8xku5eYXtzChIR9u/WC1vQ5hdorkCJsUHqtfKMZzls2ZHcKBSpu1CgQTL49SiXE6OhWcaOfS9mjZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RH4a6+wY; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RH4a6+wY"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv42MDqzMlN;
	Fri, 23 May 2025 18:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019472;
	bh=L/UbF8yL+GAvCTnLOYInuSUgHWwqdz/0TktSd0CTV1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH4a6+wYqDpG9tKcTkoHuI4MiyUy7cUSF3eDOlA7KvXC4gt46gZVUlAWcTEVLfu7Z
	 dKzuCBpCX6eBwyJxaNF4oNi73JFlOFRiblEtdi/6vbPTXvbMFLbBC7lYZrZwmFHyzl
	 GADL1eTbM07VtMdDXMwFZcyWsXaozD1ODA87EyOI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rv33bDWzJRv;
	Fri, 23 May 2025 18:57:51 +0200 (CEST)
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
Subject: [RFC PATCH v1 2/5] landlock: Merge landlock_find_rule() into landlock_unmask_layers()
Date: Fri, 23 May 2025 18:57:38 +0200
Message-ID: <20250523165741.693976-3-mic@digikod.net>
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

To be able to have useful traces, let's consolidate rule finding into
unmask checking.  landlock_unmask_layers() now gets a landlock_rule_ref
instead of a rule pointer.

This enables us to not deal with Landlock rule pointers outside of
ruleset.c, to avoid two calls, and to get all required information
available to landlock_unmask_layers().

We could make struct landlock_rule private because it is now only used
in the ruleset.c file.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c      | 144 ++++++++++++++++++++++--------------
 security/landlock/net.c     |   6 +-
 security/landlock/ruleset.c |  12 ++-
 security/landlock/ruleset.h |   9 +--
 4 files changed, 100 insertions(+), 71 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f5087688190a..73a20a501c3c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -356,30 +356,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 /* Access-control management */
 
 /*
- * The lifetime of the returned rule is tied to @domain.
- *
- * Returns NULL if no rule is found or if @dentry is negative.
+ * Returns true if an object is tied to @dentry, and updates @ref accordingly.
  */
-static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
-	  const struct dentry *const dentry)
+static bool find_rule_ref(const struct dentry *const dentry,
+			  struct landlock_rule_ref *ref)
 {
-	const struct landlock_rule *rule;
 	const struct inode *inode;
-	struct landlock_rule_ref ref = {
-		.type = LANDLOCK_KEY_INODE,
-	};
+
+	/*
+	 * We do not strictly need an RCU read-side critical section if
+	 * ref->key.object is not dereferenced or if a domain's rule own a reference
+	 * to it, but it is simpler and safer to always require one.
+	 */
+	lockdep_assert_in_rcu_read_lock();
 
 	/* Ignores nonexistent leafs. */
-	if (d_is_negative(dentry))
-		return NULL;
+	if (!dentry || d_is_negative(dentry))
+		return false;
 
 	inode = d_backing_inode(dentry);
-	rcu_read_lock();
-	ref.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, ref);
-	rcu_read_unlock();
-	return rule;
+	ref->key.object = rcu_dereference(landlock_inode(inode)->object);
+	return true;
 }
 
 /*
@@ -809,25 +806,36 @@ static bool is_access_to_paths_allowed(
 		is_dom_check = false;
 	}
 
-	if (unlikely(dentry_child1)) {
-		landlock_unmask_layers(
-			find_rule(domain, dentry_child1),
-			landlock_init_layer_masks(
-				domain, LANDLOCK_MASK_ACCESS_FS,
-				&_layer_masks_child1, LANDLOCK_KEY_INODE),
-			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1));
-		layer_masks_child1 = &_layer_masks_child1;
-		child1_is_directory = d_is_dir(dentry_child1);
-	}
-	if (unlikely(dentry_child2)) {
-		landlock_unmask_layers(
-			find_rule(domain, dentry_child2),
-			landlock_init_layer_masks(
-				domain, LANDLOCK_MASK_ACCESS_FS,
-				&_layer_masks_child2, LANDLOCK_KEY_INODE),
-			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2));
-		layer_masks_child2 = &_layer_masks_child2;
-		child2_is_directory = d_is_dir(dentry_child2);
+	scoped_guard(rcu)
+	{
+		struct landlock_rule_ref ref = {
+			.type = LANDLOCK_KEY_INODE,
+		};
+
+		if (unlikely(find_rule_ref(dentry_child1, &ref))) {
+			landlock_unmask_layers(domain, ref,
+					       landlock_init_layer_masks(
+						       domain,
+						       LANDLOCK_MASK_ACCESS_FS,
+						       &_layer_masks_child1,
+						       LANDLOCK_KEY_INODE),
+					       &_layer_masks_child1,
+					       ARRAY_SIZE(_layer_masks_child1));
+			layer_masks_child1 = &_layer_masks_child1;
+			child1_is_directory = d_is_dir(dentry_child1);
+		}
+		if (unlikely(find_rule_ref(dentry_child2, &ref))) {
+			landlock_unmask_layers(domain, ref,
+					       landlock_init_layer_masks(
+						       domain,
+						       LANDLOCK_MASK_ACCESS_FS,
+						       &_layer_masks_child2,
+						       LANDLOCK_KEY_INODE),
+					       &_layer_masks_child2,
+					       ARRAY_SIZE(_layer_masks_child2));
+			layer_masks_child2 = &_layer_masks_child2;
+			child2_is_directory = d_is_dir(dentry_child2);
+		}
 	}
 
 	walker_path = *path;
@@ -838,7 +846,6 @@ static bool is_access_to_paths_allowed(
 	 */
 	while (true) {
 		struct dentry *parent_dentry;
-		const struct landlock_rule *rule;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -880,17 +887,32 @@ static bool is_access_to_paths_allowed(
 				break;
 		}
 
-		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 = allowed_parent1 ||
-				  landlock_unmask_layers(
-					  rule, access_masked_parent1,
-					  layer_masks_parent1,
-					  ARRAY_SIZE(*layer_masks_parent1));
-		allowed_parent2 = allowed_parent2 ||
-				  landlock_unmask_layers(
-					  rule, access_masked_parent2,
-					  layer_masks_parent2,
-					  ARRAY_SIZE(*layer_masks_parent2));
+		scoped_guard(rcu)
+		{
+			struct landlock_rule_ref ref = {
+				.type = LANDLOCK_KEY_INODE,
+			};
+
+			if (find_rule_ref(walker_path.dentry, &ref)) {
+				allowed_parent1 =
+					allowed_parent1 ||
+					landlock_unmask_layers(
+						domain, ref,
+						access_masked_parent1,
+						layer_masks_parent1,
+						ARRAY_SIZE(
+							*layer_masks_parent1));
+
+				allowed_parent2 =
+					allowed_parent2 ||
+					landlock_unmask_layers(
+						domain, ref,
+						access_masked_parent2,
+						layer_masks_parent2,
+						ARRAY_SIZE(
+							*layer_masks_parent2));
+			}
+		}
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -1050,15 +1072,23 @@ static bool collect_domain_accesses(
 		struct dentry *parent_dentry;
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
-					   layer_masks_dom,
-					   ARRAY_SIZE(*layer_masks_dom))) {
-			/*
-			 * Stops when all handled accesses are allowed by at
-			 * least one rule in each layer.
-			 */
-			ret = true;
-			break;
+		scoped_guard(rcu)
+		{
+			struct landlock_rule_ref ref = {
+				.type = LANDLOCK_KEY_INODE,
+			};
+
+			if (find_rule_ref(dir, &ref) &&
+			    landlock_unmask_layers(
+				    domain, ref, access_dom, layer_masks_dom,
+				    ARRAY_SIZE(*layer_masks_dom))) {
+				/*
+				* Stops when all handled accesses are allowed by at
+				* least one rule in each layer.
+				*/
+				ret = true;
+				break;
+			}
 		}
 
 		/* We should not reach a root other than @mnt_root. */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index cd7327b5f43e..44489760e8ec 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -48,7 +48,6 @@ static int current_check_access_socket(struct socket *const sock,
 {
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
-	const struct landlock_rule *rule;
 	struct landlock_rule_ref ref = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
@@ -174,12 +173,11 @@ static int current_check_access_socket(struct socket *const sock,
 	ref.key.data = (__force uintptr_t)port;
 	BUILD_BUG_ON(sizeof(port) > sizeof(ref.key.data));
 
-	rule = landlock_find_rule(subject->domain, ref);
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
-	if (landlock_unmask_layers(rule, access_request, &layer_masks,
-				   ARRAY_SIZE(layer_masks)))
+	if (landlock_unmask_layers(subject->domain, ref, access_request,
+				   &layer_masks, ARRAY_SIZE(layer_masks)))
 		return 0;
 
 	audit_net.family = address->sa_family;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 647ee570475b..20a4bbb2526f 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -579,9 +579,9 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 /*
  * The returned access has the same lifetime as @ruleset.
  */
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_rule_ref ref)
+static const struct landlock_rule *
+find_rule(const struct landlock_ruleset *const ruleset,
+	  const struct landlock_rule_ref ref)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
@@ -613,15 +613,19 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
  * Returns true if the request is allowed (i.e. relevant layer masks for the
  * request are empty).
  */
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
+bool landlock_unmask_layers(const struct landlock_ruleset *const domain,
+			    const struct landlock_rule_ref ref,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
 			    const size_t masks_array_size)
 {
 	size_t layer_level;
+	const struct landlock_rule *rule;
 
 	if (!access_request || !layer_masks)
 		return true;
+
+	rule = find_rule(domain, ref);
 	if (!rule)
 		return false;
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 967d0123cb73..9f25dbd3022a 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -44,7 +44,7 @@ union landlock_key {
 	/**
 	 * @object: Pointer to identify a kernel object (e.g. an inode).
 	 */
-	struct landlock_object *object;
+	struct landlock_object __rcu *object;
 	/**
 	 * @data: Raw data to identify an arbitrary 32-bit value
 	 * (e.g. a TCP port).
@@ -208,10 +208,6 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_rule_ref ref);
-
 static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset)
@@ -301,7 +297,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
+bool landlock_unmask_layers(const struct landlock_ruleset *const domain,
+			    const struct landlock_rule_ref ref,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
 			    const size_t masks_array_size);
-- 
2.49.0

