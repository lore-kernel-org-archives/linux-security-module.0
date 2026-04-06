Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D9382F3C;
	Mon,  6 Apr 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486261; cv=none; b=pGTFUJx4vm8xAWjZZAswNjmDKUCN2i7+zpaEikq5y+Q3Z7JGUVg+ASxEboRismVzhKJNvxoRJB6jedfKNmoYAyDNFqb0b0wzkz78mOg7EfQwgx/khhbW6dmOhIikdykNxmMXlQcBs5l/doEteT1+zh4A/i+vtlBKV5o7ExD7FS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486261; c=relaxed/simple;
	bh=QUcw98Auago+kYPo2OvaH+BH6kikjcO27omyEduJYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4XlUvVWssiJUc9J32nBimcYImlgW2xECpNPZIkWO8JFKb+4cfrtp3mxbpumLt9kwzdvHDGRa+R25ZrgOP8X4RMDyx+PSFh2vqDrheFNqSH59b+nXYVOsbMyMJ3fqvlSlN4vlbKdA4rrH68i882BbMzGbw1sEvzCVGyLgRdQGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bIEtorIg; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bIEtorIg"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkT0jPLzwbM;
	Mon,  6 Apr 2026 16:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486256;
	bh=M7KBqnZpHZItC3TYeVXP66eCmr83JwuVvsB75CDWTCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIEtorIgiR6FODRNg3zDl/XKqUXoXFQIdYzO8SIEsjtjrxX2XIP6IWlhrTsQXsN1+
	 kZsyLCNTkSzafLYF4HFXIeqh8WKEf6KRvO/91pZIKQ5tu0xk5KcmAnestjZMvIP/gI
	 Yur/TQ09BCR+cywNi9Ak59wBvg8Xj+8WRYylEbeg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkS3XC4zbFQ;
	Mon,  6 Apr 2026 16:37:36 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] landlock: Add tracepoints for rule checking
Date: Mon,  6 Apr 2026 16:37:07 +0200
Message-ID: <20260406143717.1815792-10-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Merge landlock_find_rule() into landlock_unmask_layers() to consolidate
rule finding into unmask checking.  landlock_unmask_layers() now takes a
landlock_id and the domain instead of a rule pointer.

This enables us to not deal with Landlock rule pointers outside of the
domain implementation, to avoid two calls, and to get all required
information available to landlock_unmask_layers().

Use the per-type tracepoint wrappers unmask_layers_fs() and
unmask_layers_net() to emit tracepoints recording which rules matched
and what access masks were fulfilled.

Setting allowed_parent2 to true for non-dom-check requests when
get_inode_id() returns false preserves the pre-refactoring behavior: a
negative dentry (no backing inode) has no matching rule, so the access
is allowed at this path component.  Before the refactoring,
landlock_unmask_layers() with a NULL rule produced this result as a side
effect; now the caller must set it explicitly.

The check_rule tracepoints add up to 80 bytes of stack in the access
check path (dynamic layers array in TP_STRUCT__entry).  This cost is
only paid when a tracer is attached; the static branch is not taken
otherwise.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20250523165741.693976-6-mic@digikod.net
- Merged find-rule consolidation (v1 2/5) into this patch.
- Added check_rule_net tracepoint for network rules.
- Added get_inode_id() helper with rcu_access_pointer().
- Added allowed_parent2 behavioral fix.
---
 include/trace/events/landlock.h |  99 ++++++++++++++++++++++
 security/landlock/domain.c      |  32 ++++---
 security/landlock/domain.h      |  10 +--
 security/landlock/fs.c          | 145 +++++++++++++++++++++++---------
 security/landlock/net.c         |  21 ++++-
 5 files changed, 246 insertions(+), 61 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 533aea6152e1..e7bb8fa802bf 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -12,8 +12,10 @@
 
 #include <linux/tracepoint.h>
 
+struct dentry;
 struct landlock_domain;
 struct landlock_hierarchy;
+struct landlock_rule;
 struct landlock_ruleset;
 struct path;
 
@@ -234,6 +236,103 @@ TRACE_EVENT(landlock_free_domain,
 	    TP_printk("domain=%llx denials=%llu", __entry->domain_id,
 		      __entry->denials));
 
+/**
+ * landlock_check_rule_fs - filesystem rule evaluated during access check
+ * @domain: Enforcing domain (never NULL)
+ * @dentry: Filesystem dentry being checked (never NULL)
+ * @access_request: Access mask being requested
+ * @rule: Matching rule with per-layer access masks (never NULL)
+ *
+ * Emitted for each rule that matches during a filesystem access check.
+ * The layers array shows the allowed access mask at each domain layer.
+ */
+TRACE_EVENT(landlock_check_rule_fs,
+
+	    TP_PROTO(const struct landlock_domain *domain,
+		     const struct dentry *dentry, access_mask_t access_request,
+		     const struct landlock_rule *rule),
+
+	    TP_ARGS(domain, dentry, access_request, rule),
+
+	    TP_STRUCT__entry(__field(__u64, domain_id) __field(
+		    access_mask_t,
+		    access_request) __field(dev_t, dev) __field(ino_t, ino)
+				     __dynamic_array(access_mask_t, layers,
+						     domain->num_layers)),
+
+	    TP_fast_assign(__entry->domain_id = domain->hierarchy->id;
+			   __entry->access_request = access_request;
+			   __entry->dev = dentry->d_sb->s_dev;
+			   __entry->ino = d_backing_inode(dentry)->i_ino;
+
+			   for (size_t level = 1, i = 0;
+				level <= __get_dynamic_array_len(layers) /
+						 sizeof(access_mask_t);
+				level++) {
+				   access_mask_t allowed;
+
+				   if (i < rule->num_layers &&
+				       level == rule->layers[i].level) {
+					   allowed = rule->layers[i].access;
+					   i++;
+				   } else {
+					   allowed = 0;
+				   }
+				   ((access_mask_t *)__get_dynamic_array(
+					   layers))[level - 1] = allowed;
+			   }),
+
+	    TP_printk("domain=%llx request=0x%x dev=%u:%u ino=%lu allowed=%s",
+		      __entry->domain_id, __entry->access_request,
+		      MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		      __print_dynamic_array(layers, sizeof(access_mask_t))));
+
+/**
+ * landlock_check_rule_net - network port rule evaluated during access check
+ * @domain: Enforcing domain (never NULL)
+ * @port: Network port being checked (host endianness)
+ * @access_request: Access mask being requested
+ * @rule: Matching rule with per-layer access masks (never NULL)
+ */
+TRACE_EVENT(landlock_check_rule_net,
+
+	    TP_PROTO(const struct landlock_domain *domain, __u64 port,
+		     access_mask_t access_request,
+		     const struct landlock_rule *rule),
+
+	    TP_ARGS(domain, port, access_request, rule),
+
+	    TP_STRUCT__entry(__field(__u64, domain_id) __field(
+		    access_mask_t, access_request) __field(__u64, port)
+				     __dynamic_array(access_mask_t, layers,
+						     domain->num_layers)),
+
+	    TP_fast_assign(__entry->domain_id = domain->hierarchy->id;
+			   __entry->access_request = access_request;
+			   __entry->port = port;
+
+			   for (size_t level = 1, i = 0;
+				level <= __get_dynamic_array_len(layers) /
+						 sizeof(access_mask_t);
+				level++) {
+				   access_mask_t allowed;
+
+				   if (i < rule->num_layers &&
+				       level == rule->layers[i].level) {
+					   allowed = rule->layers[i].access;
+					   i++;
+				   } else {
+					   allowed = 0;
+				   }
+				   ((access_mask_t *)__get_dynamic_array(
+					   layers))[level - 1] = allowed;
+			   }),
+
+	    TP_printk("domain=%llx request=0x%x port=%llu allowed=%s",
+		      __entry->domain_id, __entry->access_request,
+		      __entry->port,
+		      __print_dynamic_array(layers, sizeof(access_mask_t))));
+
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 45ee7ec87957..e8d82b8a14a3 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -98,9 +98,9 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 }
 
 /* The returned access has the same lifetime as @domain. */
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_domain *const domain,
-		   const struct landlock_id id)
+static const struct landlock_rule *
+find_rule(const struct landlock_domain *const domain,
+	  const struct landlock_id id)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
@@ -127,26 +127,38 @@ landlock_find_rule(const struct landlock_domain *const domain,
 
 /**
  * landlock_unmask_layers - Remove the access rights in @masks which are
- *                          granted in @rule
+ *                          granted by a matching rule
  *
- * Updates the set of (per-layer) unfulfilled access rights @masks so that all
- * the access rights granted in @rule are removed from it (because they are now
- * fulfilled).
+ * Looks up the rule matching @id in @domain, then updates the set of
+ * (per-layer) unfulfilled access rights @masks so that all the access rights
+ * granted by that rule are removed (because they are now fulfilled).
  *
- * @rule: A rule that grants a set of access rights for each layer.
+ * @domain: The Landlock domain to search for a matching rule.
+ * @id: Identifier for the rule target (e.g. inode, port).
  * @masks: A matrix of unfulfilled access rights for each layer.
+ * @matched_rule: Optional output for the matched rule (for tracing); set to
+ *                the matching rule when non-NULL, unchanged otherwise.
  *
  * Return: True if the request is allowed (i.e. the access rights granted all
  * remaining unfulfilled access rights and masks has no leftover set bits).
  */
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks)
+bool landlock_unmask_layers(const struct landlock_domain *const domain,
+			    const struct landlock_id id,
+			    struct layer_access_masks *masks,
+			    const struct landlock_rule **matched_rule)
 {
+	const struct landlock_rule *rule;
+
 	if (!masks)
 		return true;
+
+	rule = find_rule(domain, id);
 	if (!rule)
 		return false;
 
+	if (matched_rule)
+		*matched_rule = rule;
+
 	/*
 	 * An access is granted if, for each policy layer, at least one rule
 	 * encountered on the pathwalk grants the requested access, regardless
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 56f54efb65d1..35abae29677c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -289,12 +289,10 @@ struct landlock_domain *
 landlock_merge_ruleset(struct landlock_domain *const parent,
 		       struct landlock_ruleset *const ruleset);
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_domain *const domain,
-		   const struct landlock_id id);
-
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks);
+bool landlock_unmask_layers(const struct landlock_domain *const domain,
+			    const struct landlock_id id,
+			    struct layer_access_masks *masks,
+			    const struct landlock_rule **matched_rule);
 
 access_mask_t
 landlock_init_layer_masks(const struct landlock_domain *const domain,
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f627ecc537a5..fe211656f6d9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -375,31 +375,55 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 /* Access-control management */
 
-/*
- * The lifetime of the returned rule is tied to @domain.
+/**
+ * get_inode_id - Look up the Landlock object for a dentry
+ * @dentry: The dentry to look up.
+ * @id: Filled with the inode's Landlock object pointer on success.
+ *
+ * Extracts the Landlock object pointer from @dentry's inode security blob and
+ * stores it in @id for use as a rule-tree lookup key.
+ *
+ * When this returns false (negative dentry or no Landlock object), no rule can
+ * match this inode, so landlock_unmask_layers() need not be called.  Callers
+ * that gate landlock_unmask_layers() on this function must handle the NULL
+ * @masks case independently, since the !masks-returns-true early-return in
+ * landlock_unmask_layers() will not be reached.  See the allowed_parent2
+ * initialization in is_access_to_paths_allowed().
  *
- * Returns NULL if no rule is found or if @dentry is negative.
+ * Return: True if a Landlock object exists for @dentry, false otherwise.
  */
-static const struct landlock_rule *
-find_rule(const struct landlock_domain *const domain,
-	  const struct dentry *const dentry)
+static bool get_inode_id(const struct dentry *const dentry,
+			 struct landlock_id *id)
 {
-	const struct landlock_rule *rule;
-	const struct inode *inode;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
-	};
-
 	/* Ignores nonexistent leafs. */
 	if (d_is_negative(dentry))
-		return NULL;
+		return false;
 
-	inode = d_backing_inode(dentry);
-	rcu_read_lock();
-	id.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, id);
-	rcu_read_unlock();
-	return rule;
+	/*
+	 * rcu_access_pointer() is sufficient: the pointer is used only
+	 * as a numeric comparison key for rule lookup, not dereferenced.
+	 * The object cannot be freed while the domain exists because the
+	 * domain's rule tree holds its own reference to it.
+	 */
+	id->key.object = rcu_access_pointer(
+		landlock_inode(d_backing_inode(dentry))->object);
+	return !!id->key.object;
+}
+
+static bool unmask_layers_fs(const struct landlock_domain *const domain,
+			     const struct landlock_id id,
+			     const access_mask_t access_request,
+			     struct layer_access_masks *masks,
+			     const struct dentry *const dentry)
+{
+	const struct landlock_rule *rule = NULL;
+	bool ret;
+
+	ret = landlock_unmask_layers(domain, id, masks, &rule);
+	if (rule)
+		trace_landlock_check_rule_fs(domain, dentry, access_request,
+					     rule);
+	return ret;
 }
 
 /*
@@ -771,6 +795,9 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
 	     child1_is_directory = true, child2_is_directory = true;
 	struct path walker_path;
+	struct landlock_id id = {
+		.type = LANDLOCK_KEY_INODE,
+	};
 	access_mask_t access_masked_parent1, access_masked_parent2;
 	struct layer_access_masks _layer_masks_child1, _layer_masks_child2;
 	struct layer_access_masks *layer_masks_child1 = NULL,
@@ -810,24 +837,46 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		/* For a simple request, only check for requested accesses. */
 		access_masked_parent1 = access_request_parent1;
 		access_masked_parent2 = access_request_parent2;
+		/*
+		 * Simple requests have no parent2 to check, so parent2 is
+		 * trivially allowed.  This must be set explicitly because the
+		 * get_inode_id() gate in the pathwalk loop may prevent
+		 * landlock_unmask_layers() from being called (which would
+		 * otherwise return true for NULL masks as a side effect).
+		 */
+		allowed_parent2 = true;
 		is_dom_check = false;
 	}
 
 	if (unlikely(dentry_child1)) {
-		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-					      &_layer_masks_child1,
-					      LANDLOCK_KEY_INODE))
-			landlock_unmask_layers(find_rule(domain, dentry_child1),
-					       &_layer_masks_child1);
+		struct landlock_id id = {
+			.type = LANDLOCK_KEY_INODE,
+		};
+		access_mask_t handled;
+
+		handled = landlock_init_layer_masks(domain,
+						    LANDLOCK_MASK_ACCESS_FS,
+						    &_layer_masks_child1,
+						    LANDLOCK_KEY_INODE);
+		if (handled && get_inode_id(dentry_child1, &id))
+			unmask_layers_fs(domain, id, handled,
+					 &_layer_masks_child1, dentry_child1);
 		layer_masks_child1 = &_layer_masks_child1;
 		child1_is_directory = d_is_dir(dentry_child1);
 	}
 	if (unlikely(dentry_child2)) {
-		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-					      &_layer_masks_child2,
-					      LANDLOCK_KEY_INODE))
-			landlock_unmask_layers(find_rule(domain, dentry_child2),
-					       &_layer_masks_child2);
+		struct landlock_id id = {
+			.type = LANDLOCK_KEY_INODE,
+		};
+		access_mask_t handled;
+
+		handled = landlock_init_layer_masks(domain,
+						    LANDLOCK_MASK_ACCESS_FS,
+						    &_layer_masks_child2,
+						    LANDLOCK_KEY_INODE);
+		if (handled && get_inode_id(dentry_child2, &id))
+			unmask_layers_fs(domain, id, handled,
+					 &_layer_masks_child2, dentry_child2);
 		layer_masks_child2 = &_layer_masks_child2;
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
@@ -839,8 +888,6 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	 * restriction.
 	 */
 	while (true) {
-		const struct landlock_rule *rule;
-
 		/*
 		 * If at least all accesses allowed on the destination are
 		 * already allowed on the source, respectively if there is at
@@ -881,13 +928,20 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 				break;
 		}
 
-		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 =
-			allowed_parent1 ||
-			landlock_unmask_layers(rule, layer_masks_parent1);
-		allowed_parent2 =
-			allowed_parent2 ||
-			landlock_unmask_layers(rule, layer_masks_parent2);
+		if (get_inode_id(walker_path.dentry, &id)) {
+			allowed_parent1 =
+				allowed_parent1 ||
+				unmask_layers_fs(domain, id,
+						 access_masked_parent1,
+						 layer_masks_parent1,
+						 walker_path.dentry);
+			allowed_parent2 =
+				allowed_parent2 ||
+				unmask_layers_fs(domain, id,
+						 access_masked_parent2,
+						 layer_masks_parent2,
+						 walker_path.dentry);
+		}
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -1050,23 +1104,30 @@ static bool collect_domain_accesses(const struct landlock_domain *const domain,
 				    struct layer_access_masks *layer_masks_dom)
 {
 	bool ret = false;
+	access_mask_t access_masked_dom;
 
 	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
 		return true;
 	if (is_nouser_or_private(dir))
 		return true;
 
-	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-				       layer_masks_dom, LANDLOCK_KEY_INODE))
+	access_masked_dom =
+		landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+					  layer_masks_dom, LANDLOCK_KEY_INODE);
+	if (!access_masked_dom)
 		return true;
 
 	dget(dir);
 	while (true) {
 		struct dentry *parent_dentry;
+		struct landlock_id id = {
+			.type = LANDLOCK_KEY_INODE,
+		};
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir),
-					   layer_masks_dom)) {
+		if (get_inode_id(dir, &id) &&
+		    unmask_layers_fs(domain, id, access_masked_dom,
+				     layer_masks_dom, dir)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1e893123e787..a2aefc7967a1 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -53,6 +53,22 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
+static bool unmask_layers_net(const struct landlock_domain *const domain,
+			      const struct landlock_id id,
+			      struct layer_access_masks *masks,
+			      access_mask_t access_request)
+{
+	const struct landlock_rule *rule = NULL;
+	bool ret;
+
+	ret = landlock_unmask_layers(domain, id, masks, &rule);
+	if (rule)
+		trace_landlock_check_rule_net(
+			domain, ntohs((__force __be16)id.key.data),
+			access_request, rule);
+	return ret;
+}
+
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
@@ -60,7 +76,6 @@ static int current_check_access_socket(struct socket *const sock,
 {
 	__be16 port;
 	struct layer_access_masks layer_masks = {};
-	const struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
@@ -199,14 +214,14 @@ static int current_check_access_socket(struct socket *const sock,
 	id.key.data = (__force uintptr_t)port;
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
-	rule = landlock_find_rule(subject->domain, id);
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
 	if (!access_request)
 		return 0;
 
-	if (landlock_unmask_layers(rule, &layer_masks))
+	if (unmask_layers_net(subject->domain, id, &layer_masks,
+			      access_request))
 		return 0;
 
 	audit_net.family = address->sa_family;
-- 
2.53.0

