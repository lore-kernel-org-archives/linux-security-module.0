Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC00381B0C
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486258; cv=none; b=j6hRzIAohvoSMeVmYBq4rsLssZbZoGF+JtIGwwefdfzLv2nhh5tYu6JGQyNwLBr76RfYsTKFyp0cTY6aLyGZsWraAjJdvupRYKk3aS1ItWlvVuzaxQ3/sJoZ68akF+e9zP0UKEagIPDaIsZBqqxjaiXMmDP74Wcv9nVlh3X7RAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486258; c=relaxed/simple;
	bh=JR65+1+lPq9loNPOWq7LSruDGK+vTi31w2ZE9kAUkSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFTu7sf5femVE4reIB+iaoVAwjW32AQ4+yub/sRASUdaJoD2FZBGasHzpXLxOAgHA10XnhIetw6Tdqw4z4lFiXgiX4ZpBHBWXtvALZ3V+O5lEf2t43NXLdSfKdgTzlDHmo7BdzXfv9Bwo8EFnP/Z9Z5QSEg2SH8VHe+XlSc/mB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DrmyODtR; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DrmyODtR"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkJ0H3tzTtx;
	Mon,  6 Apr 2026 16:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486247;
	bh=1dV2IQvSRn/fdsueYQNYwQFGnZikJ/lh00m4taH2EyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrmyODtRHlLIQngOfpZMNItEQ04UD/IwPwI3rjadDsIe5v8YpePes1c/GgNhZNt7i
	 CLHm3qi2vDGhvKzTF7bQaJKMlarofKHx99WfATBx7APnEXaU2+AvmvEhsDggpimkd6
	 9LGa2LHXuc5FSSau6gBFo15yIQAMbSPuW7x4/SxY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkH2ydpzDGK;
	Mon,  6 Apr 2026 16:37:27 +0200 (CEST)
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
Subject: [PATCH v2 02/17] landlock: Move domain query functions to domain.c
Date: Mon,  6 Apr 2026 16:37:00 +0200
Message-ID: <20260406143717.1815792-3-mic@digikod.net>
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

Grouping domain-specific code in one compilation unit reduces coupling
between domain and ruleset implementations.

Move the access-check functions that only operate on domains:
- landlock_find_rule() (from ruleset.c to domain.c)
- landlock_unmask_layers() (from ruleset.c to domain.c)
- landlock_init_layer_masks() (from ruleset.c to domain.c)
- landlock_union_access_masks() (from ruleset.h to domain.h)

These functions are called during the pathwalk and network access checks
to evaluate whether a domain grants the requested access. They do not
modify the domain or its rules.

The merge and inherit chain (merge_tree, merge_ruleset, inherit_tree,
inherit_ruleset, landlock_merge_ruleset) stays in ruleset.c for now
because it calls the static create_ruleset() allocator.  A following
commit moves it when the domain type switch eliminates the dependency on
create_ruleset().

Expand the landlock_unmask_layers() comment to document the per-layer
composition semantics.

No behavioral change.  Function signatures are unchanged; only
mechanical adjustments for the struct landlock_rules embedding
introduced by the previous commit.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 security/landlock/domain.c  | 150 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h  |  38 +++++++++
 security/landlock/net.c     |   1 +
 security/landlock/ruleset.c | 135 --------------------------------
 security/landlock/ruleset.h |  38 ---------
 5 files changed, 189 insertions(+), 173 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 378d86974ffb..cb79edf5df02 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -10,11 +10,17 @@
 #include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/cred.h>
+#include <linux/err.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -26,6 +32,8 @@
 #include "common.h"
 #include "domain.h"
 #include "id.h"
+#include "limits.h"
+#include "object.h"
 #include "ruleset.h"
 
 static void free_domain(struct landlock_domain *const domain)
@@ -59,6 +67,148 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 	}
 }
 
+/* The returned access has the same lifetime as @ruleset. */
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_ruleset *const ruleset,
+		   const struct landlock_id id)
+{
+	const struct rb_root *root;
+	const struct rb_node *node;
+
+	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
+				      id.type);
+	if (IS_ERR(root))
+		return NULL;
+	node = root->rb_node;
+
+	while (node) {
+		struct landlock_rule *this =
+			rb_entry(node, struct landlock_rule, node);
+
+		if (this->key.data == id.key.data)
+			return this;
+		if (this->key.data < id.key.data)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
+
+/**
+ * landlock_unmask_layers - Remove the access rights in @masks which are
+ *                          granted in @rule
+ *
+ * Updates the set of (per-layer) unfulfilled access rights @masks so that all
+ * the access rights granted in @rule are removed from it (because they are now
+ * fulfilled).
+ *
+ * @rule: A rule that grants a set of access rights for each layer.
+ * @masks: A matrix of unfulfilled access rights for each layer.
+ *
+ * Return: True if the request is allowed (i.e. the access rights granted all
+ * remaining unfulfilled access rights and masks has no leftover set bits).
+ */
+bool landlock_unmask_layers(const struct landlock_rule *const rule,
+			    struct layer_access_masks *masks)
+{
+	if (!masks)
+		return true;
+	if (!rule)
+		return false;
+
+	/*
+	 * An access is granted if, for each policy layer, at least one rule
+	 * encountered on the pathwalk grants the requested access, regardless
+	 * of its position in the layer stack.  We must then check the remaining
+	 * layers for each inode, from the first added layer to the last one.
+	 * When there are multiple requested accesses, for each policy layer,
+	 * the full set of requested accesses may not be granted by only one
+	 * rule, but by the union (binary OR) of multiple rules.  For example,
+	 * /a/b <execute> + /a <read> grants /a/b <execute + read>.
+	 *
+	 * This function is called once per matching rule during the pathwalk,
+	 * progressively clearing bits in @masks.  The overall access decision
+	 * is: access is granted iff FOR-ALL layers l, masks->access[l] == 0.
+	 * When two independent mechanisms can each grant access within a layer
+	 * (e.g. a path rule OR a scope exception), the composition must
+	 * evaluate per-layer: FOR-ALL l (A(l) OR B(l)), not (FOR-ALL l A(l)) OR
+	 * (FOR-ALL l B(l)), to prevent bypass when different layers grant via
+	 * different mechanisms.
+	 */
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		/* Clear the bits where the layer in the rule grants access. */
+		masks->access[layer->level - 1] &= ~layer->access;
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
+		if (masks->access[i])
+			return false;
+	}
+	return true;
+}
+
+typedef access_mask_t
+get_access_mask_t(const struct landlock_ruleset *const ruleset,
+		  const u16 layer_level);
+
+/**
+ * landlock_init_layer_masks - Initialize layer masks from an access request
+ *
+ * Populates @masks such that for each access right in @access_request, the bits
+ * for all the layers are set where this access right is handled.
+ *
+ * @domain: The domain that defines the current restrictions.
+ * @access_request: The requested access rights to check.
+ * @masks: Layer access masks to populate.
+ * @key_type: The key type to switch between access masks of different types.
+ *
+ * Return: An access mask where each access right bit is set which is handled in
+ * any of the active layers in @domain.
+ */
+access_mask_t
+landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+			  const access_mask_t access_request,
+			  struct layer_access_masks *const masks,
+			  const enum landlock_key_type key_type)
+{
+	access_mask_t handled_accesses = 0;
+	get_access_mask_t *get_access_mask;
+
+	switch (key_type) {
+	case LANDLOCK_KEY_INODE:
+		get_access_mask = landlock_get_fs_access_mask;
+		break;
+
+#if IS_ENABLED(CONFIG_INET)
+	case LANDLOCK_KEY_NET_PORT:
+		get_access_mask = landlock_get_net_access_mask;
+		break;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	/* An empty access request can happen because of O_WRONLY | O_RDWR. */
+	if (!access_request)
+		return 0;
+
+	for (size_t i = 0; i < domain->num_layers; i++) {
+		const access_mask_t handled = get_access_mask(domain, i);
+
+		masks->access[i] = access_request & handled;
+		handled_accesses |= masks->access[i];
+	}
+	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->access); i++)
+		masks->access[i] = 0;
+
+	return handled_accesses;
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 66333b6122a9..afa97011ecd2 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -227,12 +227,50 @@ struct landlock_domain {
 	};
 };
 
+/**
+ * landlock_union_access_masks - Return all access rights handled in the
+ *				 domain
+ *
+ * @domain: Landlock ruleset (used as a domain)
+ *
+ * Return: An access_masks result of the OR of all the domain's access masks.
+ */
+static inline struct access_masks
+landlock_union_access_masks(const struct landlock_ruleset *const domain)
+{
+	union access_masks_all matches = {};
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
+		union access_masks_all layer = {
+			.masks = domain->access_masks[layer_level],
+		};
+
+		matches.all |= layer.all;
+	}
+
+	return matches.masks;
+}
+
 void landlock_put_domain(struct landlock_domain *const domain);
 void landlock_put_domain_deferred(struct landlock_domain *const domain);
 
 DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
 
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_ruleset *const ruleset,
+		   const struct landlock_id id);
+
+bool landlock_unmask_layers(const struct landlock_rule *const rule,
+			    struct layer_access_masks *masks);
+
+access_mask_t
+landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+			  const access_mask_t access_request,
+			  struct layer_access_masks *masks,
+			  const enum landlock_key_type key_type);
+
 static inline void landlock_get_domain(struct landlock_domain *const domain)
 {
 	if (domain)
diff --git a/security/landlock/net.c b/security/landlock/net.c
index c368649985c5..34a72a4f833d 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -15,6 +15,7 @@
 #include "audit.h"
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "limits.h"
 #include "net.h"
 #include "ruleset.h"
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a6835011af2b..0cf31a7e4c7b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -581,138 +581,3 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 
 	return no_free_ptr(new_dom);
 }
-
-/*
- * The returned access has the same lifetime as @ruleset.
- */
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id)
-{
-	const struct rb_root *root;
-	const struct rb_node *node;
-
-	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
-				      id.type);
-	if (IS_ERR(root))
-		return NULL;
-	node = root->rb_node;
-
-	while (node) {
-		struct landlock_rule *this =
-			rb_entry(node, struct landlock_rule, node);
-
-		if (this->key.data == id.key.data)
-			return this;
-		if (this->key.data < id.key.data)
-			node = node->rb_right;
-		else
-			node = node->rb_left;
-	}
-	return NULL;
-}
-
-/**
- * landlock_unmask_layers - Remove the access rights in @masks
- *                          which are granted in @rule
- *
- * Updates the set of (per-layer) unfulfilled access rights @masks
- * so that all the access rights granted in @rule are removed from it
- * (because they are now fulfilled).
- *
- * @rule: A rule that grants a set of access rights for each layer
- * @masks: A matrix of unfulfilled access rights for each layer
- *
- * Return: True if the request is allowed (i.e. the access rights granted all
- * remaining unfulfilled access rights and masks has no leftover set bits).
- */
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks)
-{
-	if (!masks)
-		return true;
-	if (!rule)
-		return false;
-
-	/*
-	 * An access is granted if, for each policy layer, at least one rule
-	 * encountered on the pathwalk grants the requested access,
-	 * regardless of its position in the layer stack.  We must then check
-	 * the remaining layers for each inode, from the first added layer to
-	 * the last one.  When there is multiple requested accesses, for each
-	 * policy layer, the full set of requested accesses may not be granted
-	 * by only one rule, but by the union (binary OR) of multiple rules.
-	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
-	 */
-	for (size_t i = 0; i < rule->num_layers; i++) {
-		const struct landlock_layer *const layer = &rule->layers[i];
-
-		/* Clear the bits where the layer in the rule grants access. */
-		masks->access[layer->level - 1] &= ~layer->access;
-	}
-
-	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
-		if (masks->access[i])
-			return false;
-	}
-	return true;
-}
-
-typedef access_mask_t
-get_access_mask_t(const struct landlock_ruleset *const ruleset,
-		  const u16 layer_level);
-
-/**
- * landlock_init_layer_masks - Initialize layer masks from an access request
- *
- * Populates @masks such that for each access right in @access_request,
- * the bits for all the layers are set where this access right is handled.
- *
- * @domain: The domain that defines the current restrictions.
- * @access_request: The requested access rights to check.
- * @masks: Layer access masks to populate.
- * @key_type: The key type to switch between access masks of different types.
- *
- * Return: An access mask where each access right bit is set which is handled
- * in any of the active layers in @domain.
- */
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  struct layer_access_masks *const masks,
-			  const enum landlock_key_type key_type)
-{
-	access_mask_t handled_accesses = 0;
-	get_access_mask_t *get_access_mask;
-
-	switch (key_type) {
-	case LANDLOCK_KEY_INODE:
-		get_access_mask = landlock_get_fs_access_mask;
-		break;
-
-#if IS_ENABLED(CONFIG_INET)
-	case LANDLOCK_KEY_NET_PORT:
-		get_access_mask = landlock_get_net_access_mask;
-		break;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	/* An empty access request can happen because of O_WRONLY | O_RDWR. */
-	if (!access_request)
-		return 0;
-
-	for (size_t i = 0; i < domain->num_layers; i++) {
-		const access_mask_t handled = get_access_mask(domain, i);
-
-		masks->access[i] = access_request & handled;
-		handled_accesses |= masks->access[i];
-	}
-	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->access); i++)
-		masks->access[i] = 0;
-
-	return handled_accesses;
-}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index e7875a8b15df..1d3a9c36eb74 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -218,10 +218,6 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id);
-
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
  *
@@ -255,31 +251,6 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
-/**
- * landlock_union_access_masks - Return all access rights handled in the
- *				 domain
- *
- * @domain: Landlock ruleset (used as a domain)
- *
- * Return: An access_masks result of the OR of all the domain's access masks.
- */
-static inline struct access_masks
-landlock_union_access_masks(const struct landlock_ruleset *const domain)
-{
-	union access_masks_all matches = {};
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
-		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
-		};
-
-		matches.all |= layer.all;
-	}
-
-	return matches.masks;
-}
-
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -338,13 +309,4 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks);
-
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  struct layer_access_masks *masks,
-			  const enum landlock_key_type key_type);
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.53.0

