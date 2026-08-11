Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883042C51D
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441822; cv=none; b=VZdKhKVA0X06Er1Bly148HdoKGBKbyeb2cVmVfUoc0mLxt9b8K2flY5Lklb1D7tXdGJmFgKpsOt5wSdoCNEYdCbzXplA0GTaYKCNPEhHealIG+n1utHxzt6hW2aKk1Nvf+aYO20CP/odkBmDXiEz4SPPe7ieRC9rdiRqZ0pnGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441822; c=relaxed/simple;
	bh=k1urJY8ktpO1KkTHt/kjb19x69uaPaI4UHQe7zGLsrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDyXgNBbKLwFMP8DTw2hN+SWxAmGg/MJ4ijgYzgEYVCDGODUpZXKLPlkaVQspdA49825OUgN/25RlfXS7/le62fvlQsoskrDrAm6MxHD1Y385pKePHB+xeLcvn2SfmgPQqOHjblNfW1rnnSjvaEcUNE8FP7YyPrZAWeTOcmh3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eojwEDkX; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eojwEDkX"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6Bv3s5lzC3M;
	Tue, 11 Aug 2026 11:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441431;
	bh=M2gQzi5gSJ5yiKWIhDqFvP4F1ul9RSEchq4y/mMI5ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eojwEDkXEfH8LTd/XQLSvfxq/RthpO8eYMLq3sWUI9timQ0Nl4QIXwcbRsvHvYXaQ
	 oRtTLNW94RZmPUUGKuwamTiN/9olR5PASt9xlPUxfq2GMsBIWPrhWY7DfiIhss+JTJ
	 OtWHeCNnz2LB/xPgrpeIDyurKrtPPzODgCKnmOTU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6Bt2mcfzSfv;
	Tue, 11 Aug 2026 11:43:50 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 02/19] landlock: Move domain query functions to domain.c
Date: Tue, 11 Aug 2026 11:43:16 +0200
Message-ID: <20260811094338.288094-3-mic@digikod.net>
In-Reply-To: <20260811094338.288094-1-mic@digikod.net>
References: <20260811094338.288094-1-mic@digikod.net>
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

Move the access-check functions that only operate on a domain (rule
lookup, layer unmasking, layer-mask init, access-mask union) from
ruleset.[ch] to domain.[ch].  They evaluate whether a domain grants a
requested access during the pathwalk and network checks and do not
modify the domain.

The merge and inherit chain stays in ruleset.c for now because it calls
the static create_ruleset() allocator; a following commit moves it once
the domain type switch eliminates that dependency.

No behavioral change.  The functions move with unchanged signatures and
bodies.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-3-mic@digikod.net
- Adapt the moved access-check helpers to the base's struct layer_masks
  (renamed from struct layer_access_masks), including the per-layer
  quiet flag.

Changes since v1:
- New patch.
---
 security/landlock/domain.c  | 162 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h  |  38 +++++++++
 security/landlock/net.c     |   1 +
 security/landlock/ruleset.c | 150 ---------------------------------
 security/landlock/ruleset.h |  38 ---------
 5 files changed, 201 insertions(+), 188 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index c5efb7635a7b..8fb74107c2ef 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -10,11 +10,15 @@
 #include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/cred.h>
+#include <linux/err.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -26,6 +30,7 @@
 #include "common.h"
 #include "domain.h"
 #include "id.h"
+#include "limits.h"
 #include "ruleset.h"
 
 static void free_domain(struct landlock_domain *const domain)
@@ -59,6 +64,163 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 	}
 }
 
+/* The returned access has the same lifetime as the domain. */
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
+			    struct layer_masks *masks)
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
+	 * is per-layer: access is granted iff masks->layers[l].access == 0 for
+	 * all layers l.  When two independent mechanisms can each grant access
+	 * within a layer (e.g. a path rule OR a scope exception), the
+	 * composition must evaluate per-layer: FOR-ALL l (A(l) OR B(l)), not
+	 * (FOR-ALL l A(l)) OR (FOR-ALL l B(l)), to prevent bypass when
+	 * different layers grant via different mechanisms.
+	 */
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		/* Clear the bits where the layer in the rule grants access. */
+		masks->layers[layer->level - 1].access &= ~layer->access;
+
+#ifdef CONFIG_AUDIT
+		/* Collect rule flags for each layer. */
+		if (layer->flags.quiet)
+			masks->layers[layer->level - 1].quiet = true;
+#endif /* CONFIG_AUDIT */
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		if (masks->layers[i].access)
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
+ * for all the layers are set where this access right is handled.  Rule flags
+ * are also zeroed.
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
+			  struct layer_masks *const masks,
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
+		masks->layers[i].access = access_request & handled;
+		handled_accesses |= masks->layers[i].access;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
+	}
+	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
+	     i++) {
+		masks->layers[i].access = 0;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
+	}
+
+	return handled_accesses;
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index bcfd0452e260..9f9b892ab17d 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -233,12 +233,50 @@ struct landlock_domain {
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
+			    struct layer_masks *masks);
+
+access_mask_t
+landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+			  const access_mask_t access_request,
+			  struct layer_masks *masks,
+			  const enum landlock_key_type key_type);
+
 static inline void landlock_get_domain(struct landlock_domain *const domain)
 {
 	if (domain)
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 46c17116fcf4..feecc8c77ab4 100644
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
index 9e560aed64b6..96e65804d2ff 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -591,153 +591,3 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 
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
-			    struct layer_masks *masks)
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
-		masks->layers[layer->level - 1].access &= ~layer->access;
-
-#ifdef CONFIG_AUDIT
-		/* Collect rule flags for each layer. */
-		if (layer->flags.quiet)
-			masks->layers[layer->level - 1].quiet = true;
-#endif /* CONFIG_AUDIT */
-	}
-
-	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
-		if (masks->layers[i].access)
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
- * Populates @masks such that for each access right in @access_request, the bits
- * for all the layers are set where this access right is handled.  Rule flags
- * are also zeroed.
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
-			  struct layer_masks *const masks,
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
-		masks->layers[i].access = access_request & handled;
-		handled_accesses |= masks->layers[i].access;
-#ifdef CONFIG_AUDIT
-		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
-	}
-	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
-	     i++) {
-		masks->layers[i].access = 0;
-#ifdef CONFIG_AUDIT
-		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
-	}
-
-	return handled_accesses;
-}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c8c83efff4c5..f9486c06b7ec 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -235,10 +235,6 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id);
-
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
  *
@@ -272,31 +268,6 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
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
@@ -355,13 +326,4 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_masks *masks);
-
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  struct layer_masks *masks,
-			  const enum landlock_key_type key_type);
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.54.0

