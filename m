Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89041322B88
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486256; cv=none; b=NQeMQkuX15LOKlHqCqCMmqaNsTyH+t8JJgaM20L46vPs8XkYHWGlkYBXiBu8K1I85wMeG5V9DxjEclLktDEvaU8gzIjlpSnn+pp8Nuavy9315r8mY83DWO+pag9+v8wXGvslfcSFdQVm9IFiQOI2aiVNfm8NZ1ghfVtabFTxKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486256; c=relaxed/simple;
	bh=p1bYRZ7jVN/7Rwjha5jdrFWz+wC7x70iVJwvxvZB2hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByYBsDFk6XLqV2XOJQthJgU8/PS8I5NitipKXtOPZMQH4Ja7mLz6tzBxZgZWpU3+MxIxXeBldszfzF1UYgcPzXhbNq9Ld88AEK1hrgMgAwon0N9gkH8uvlHKb0BLaDiFrfdN1Fr6jcVPxxnhpV3Cgw+H6L3OrZkK1wV1lCL7kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zj30KS9T; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zj30KS9T"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkG56MQzTjW;
	Mon,  6 Apr 2026 16:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486246;
	bh=0AC+uvCZfloA0nwV++7juRmBsOi0J5drGXRBsTqeMLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zj30KS9Tbms3p2Kf3ufv2wAreeYAmOuGesPLZamyCjLgu05e3M/qqUAIwaf/Au6z+
	 dsQqCDAtJoVluDX3SfzZMzxbCtqMyIIgZ+Uw6RhqBZN65uJqjKxv3vZgBsX6mld0ow
	 856cIb6odp8mYYNe7U7QnbTBTDwl9S1n2kietlt4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkG0gGBzDnW;
	Mon,  6 Apr 2026 16:37:26 +0200 (CEST)
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
Subject: [PATCH v2 01/17] landlock: Prepare ruleset and domain type split
Date: Mon,  6 Apr 2026 16:36:59 +0200
Message-ID: <20260406143717.1815792-2-mic@digikod.net>
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

Rulesets and domains serve fundamentally different purposes: a ruleset
is mutable and user-facing, created by landlock_create_ruleset(), while
a domain is immutable after construction and enforced on tasks via
landlock_restrict_self().  Today both are represented by struct
landlock_ruleset, which conflates mutable and immutable state in a
single type: the lock field is unused by domains, the hierarchy field
is unused by rulesets, and lifecycle functions must handle both cases.

Prepare for a clean type split by introducing two new structures and
the helpers needed to construct domains from a separate compilation
unit:

- struct landlock_rules: holds the red-black tree roots and the rule
  count.  This storage type is shared by both rulesets and domains.
  This decouples rule storage from the domain API; the backing data
  structure could be changed independently (e.g. to a hash table,
  cf. [1]).

- struct landlock_domain: the immutable domain enforced on tasks.  It
  has no lock field because its rules and access masks are immutable
  once construction is complete.  The name reflects the role, not the
  internal data structure, to decouple the API from the
  implementation.

Embed struct landlock_rules in struct landlock_ruleset, replacing the
individual root_inode, root_net_port, and num_rules fields.  All field
accesses are updated mechanically.

Add landlock_get_rule_root() as a static inline helper in the header,
enabling constant propagation when the key type is known at compile
time.  Extract landlock_free_rules() so that free_domain() can reuse
the rule-freeing logic without duplicating it.

Add domain lifecycle functions: landlock_get_domain(),
landlock_put_domain(), and landlock_put_domain_deferred().  Move
domain.o from landlock-$(CONFIG_AUDIT) to landlock-y because these
lifecycle functions are needed unconditionally, not just for audit
logging.

No behavioral change.  The new types and lifecycle functions are not
yet used by any caller.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/20250523165741.693976-1-mic@digikod.net [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 security/landlock/Makefile  |  6 +--
 security/landlock/domain.c  | 35 ++++++++++++++++
 security/landlock/domain.h  | 69 +++++++++++++++++++++++++++++++
 security/landlock/ruleset.c | 71 ++++++++++++++++----------------
 security/landlock/ruleset.h | 81 +++++++++++++++++++++++++++----------
 5 files changed, 201 insertions(+), 61 deletions(-)

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index ffa7646d99f3..23e13644916f 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -8,11 +8,11 @@ landlock-y := \
 	cred.o \
 	task.o \
 	fs.o \
-	tsync.o
+	tsync.o \
+	domain.o
 
 landlock-$(CONFIG_INET) += net.o
 
 landlock-$(CONFIG_AUDIT) += \
 	id.o \
-	audit.o \
-	domain.o
+	audit.o
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 06b6bd845060..378d86974ffb 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -15,14 +15,49 @@
 #include <linux/mm.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
+#include <linux/slab.h>
 #include <linux/uidgid.h>
+#include <linux/workqueue.h>
 
 #include "access.h"
 #include "common.h"
 #include "domain.h"
 #include "id.h"
+#include "ruleset.h"
+
+static void free_domain(struct landlock_domain *const domain)
+{
+	might_sleep();
+	landlock_free_rules(&domain->rules);
+	landlock_put_hierarchy(domain->hierarchy);
+	kfree(domain);
+}
+
+void landlock_put_domain(struct landlock_domain *const domain)
+{
+	might_sleep();
+	if (domain && refcount_dec_and_test(&domain->usage))
+		free_domain(domain);
+}
+
+static void free_domain_work(struct work_struct *const work)
+{
+	struct landlock_domain *domain;
+
+	domain = container_of(work, struct landlock_domain, work_free);
+	free_domain(domain);
+}
+
+void landlock_put_domain_deferred(struct landlock_domain *const domain)
+{
+	if (domain && refcount_dec_and_test(&domain->usage)) {
+		INIT_WORK(&domain->work_free, free_domain_work);
+		schedule_work(&domain->work_free);
+	}
+}
 
 #ifdef CONFIG_AUDIT
 
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index a9d57db0120d..66333b6122a9 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,6 +10,7 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/cleanup.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/path.h>
@@ -17,9 +18,11 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "access.h"
 #include "audit.h"
+#include "ruleset.h"
 
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
@@ -170,4 +173,70 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	}
 }
 
+/**
+ * struct landlock_domain - Immutable Landlock domain
+ *
+ * A domain is created from a ruleset by landlock_merge_ruleset() and enforced
+ * on a task.  Once created, its rules and access masks are immutable.  Unlike
+ * &struct landlock_ruleset, a domain has no lock field.
+ */
+struct landlock_domain {
+	/**
+	 * @rules: Red-black tree storage for rules.
+	 */
+	struct landlock_rules rules;
+	/**
+	 * @hierarchy: Enables hierarchy identification even when a parent
+	 * domain vanishes.  This is needed for the ptrace and scope
+	 * restrictions.
+	 */
+	struct landlock_hierarchy *hierarchy;
+	union {
+		/**
+		 * @work_free: Enables to free a domain within a lockless
+		 * section.  This is only used by landlock_put_domain_deferred()
+		 * when @usage reaches zero.  The fields @usage, @num_layers and
+		 * @access_masks are then unused.
+		 */
+		struct work_struct work_free;
+		struct {
+			/**
+			 * @usage: Number of credentials referencing this
+			 * domain.
+			 */
+			refcount_t usage;
+			/**
+			 * @num_layers: Number of layers that are used in this
+			 * domain.  This enables to check that all the layers
+			 * allow an access request.
+			 */
+			u32 num_layers;
+			/**
+			 * @access_masks: Contains the subset of filesystem and
+			 * network actions that are restricted by a domain.  A
+			 * domain saves all layers of merged rulesets in a stack
+			 * (FAM), starting from the first layer to the last one.
+			 * These layers are used when merging rulesets, for user
+			 * space backward compatibility (i.e. future-proof), and
+			 * to properly handle merged rulesets without
+			 * overlapping access rights.  These layers are set once
+			 * and never changed for the lifetime of the domain.
+			 */
+			struct access_masks access_masks[];
+		};
+	};
+};
+
+void landlock_put_domain(struct landlock_domain *const domain);
+void landlock_put_domain_deferred(struct landlock_domain *const domain);
+
+DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
+	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
+
+static inline void landlock_get_domain(struct landlock_domain *const domain)
+{
+	if (domain)
+		refcount_inc(&domain->usage);
+}
+
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 181df7736bb9..a6835011af2b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -38,16 +38,16 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_ruleset->usage, 1);
 	mutex_init(&new_ruleset->lock);
-	new_ruleset->root_inode = RB_ROOT;
+	new_ruleset->rules.root_inode = RB_ROOT;
 
 #if IS_ENABLED(CONFIG_INET)
-	new_ruleset->root_net_port = RB_ROOT;
+	new_ruleset->rules.root_net_port = RB_ROOT;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
 	new_ruleset->num_layers = num_layers;
 	/*
 	 * hierarchy = NULL
-	 * num_rules = 0
+	 * rules.num_rules = 0
 	 * access_masks[] = 0
 	 */
 	return new_ruleset;
@@ -147,19 +147,7 @@ create_rule(const struct landlock_id id,
 static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
 				const enum landlock_key_type key_type)
 {
-	switch (key_type) {
-	case LANDLOCK_KEY_INODE:
-		return &ruleset->root_inode;
-
-#if IS_ENABLED(CONFIG_INET)
-	case LANDLOCK_KEY_NET_PORT:
-		return &ruleset->root_net_port;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	default:
-		WARN_ON_ONCE(1);
-		return ERR_PTR(-EINVAL);
-	}
+	return landlock_get_rule_root(&ruleset->rules, key_type);
 }
 
 static void free_rule(struct landlock_rule *const rule,
@@ -175,19 +163,24 @@ static void free_rule(struct landlock_rule *const rule,
 
 static void build_check_ruleset(void)
 {
-	const struct landlock_ruleset ruleset = {
+	const struct landlock_rules rules = {
 		.num_rules = ~0,
+	};
+	const struct landlock_ruleset ruleset = {
 		.num_layers = ~0,
 	};
 
-	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
+	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
 	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
 }
 
 /**
- * insert_rule - Create and insert a rule in a ruleset
+ * insert_rule - Create and insert a rule in a rule set
  *
- * @ruleset: The ruleset to be updated.
+ * @rules: The rule storage to be updated.  The caller is responsible for
+ *         any required locking.  For rulesets, this means holding
+ *         landlock_ruleset.lock.  For domains under construction, no lock is
+ *         needed because the domain is not yet visible to other tasks.
  * @id: The ID to build the new rule with.  The underlying kernel object, if
  *      any, must be held by the caller.
  * @layers: One or multiple layers to be copied into the new rule.
@@ -195,16 +188,16 @@ static void build_check_ruleset(void)
  *
  * When user space requests to add a new rule to a ruleset, @layers only
  * contains one entry and this entry is not assigned to any level.  In this
- * case, the new rule will extend @ruleset, similarly to a boolean OR between
+ * case, the new rule will extend @rules, similarly to a boolean OR between
  * access rights.
  *
  * When merging a ruleset in a domain, or copying a domain, @layers will be
- * added to @ruleset as new constraints, similarly to a boolean AND between
- * access rights.
+ * added to @rules as new constraints, similarly to a boolean AND between access
+ * rights.
  *
  * Return: 0 on success, -errno on failure.
  */
-static int insert_rule(struct landlock_ruleset *const ruleset,
+static int insert_rule(struct landlock_rules *const rules,
 		       const struct landlock_id id,
 		       const struct landlock_layer (*layers)[],
 		       const size_t num_layers)
@@ -215,14 +208,13 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 	struct rb_root *root;
 
 	might_sleep();
-	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!layers))
 		return -ENOENT;
 
 	if (is_object_pointer(id.type) && WARN_ON_ONCE(!id.key.object))
 		return -ENOENT;
 
-	root = get_root(ruleset, id.type);
+	root = landlock_get_rule_root(rules, id.type);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -248,7 +240,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		if ((*layers)[0].level == 0) {
 			/*
 			 * Extends access rights when the request comes from
-			 * landlock_add_rule(2), i.e. @ruleset is not a domain.
+			 * landlock_add_rule(2), i.e. contained by a ruleset.
 			 */
 			if (WARN_ON_ONCE(this->num_layers != 1))
 				return -EINVAL;
@@ -276,14 +268,14 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 
 	/* There is no match for @id. */
 	build_check_ruleset();
-	if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
+	if (rules->num_rules >= LANDLOCK_MAX_NUM_RULES)
 		return -E2BIG;
 	new_rule = create_rule(id, layers, num_layers, NULL);
 	if (IS_ERR(new_rule))
 		return PTR_ERR(new_rule);
 	rb_link_node(&new_rule->node, parent_node, walker_node);
 	rb_insert_color(&new_rule->node, root);
-	ruleset->num_rules++;
+	rules->num_rules++;
 	return 0;
 }
 
@@ -314,7 +306,8 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 	} };
 
 	build_check_layer();
-	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
+	lockdep_assert_held(&ruleset->lock);
+	return insert_rule(&ruleset->rules, id, &layers, ARRAY_SIZE(layers));
 }
 
 static int merge_tree(struct landlock_ruleset *const dst,
@@ -352,7 +345,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 
 		layers[0].access = walker_rule->layers[0].access;
 
-		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
+		err = insert_rule(&dst->rules, id, &layers, ARRAY_SIZE(layers));
 		if (err)
 			return err;
 	}
@@ -426,7 +419,7 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 			.type = key_type,
 		};
 
-		err = insert_rule(child, id, &walker_rule->layers,
+		err = insert_rule(&child->rules, id, &walker_rule->layers,
 				  walker_rule->num_layers);
 		if (err)
 			return err;
@@ -480,21 +473,26 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 	return err;
 }
 
-static void free_ruleset(struct landlock_ruleset *const ruleset)
+void landlock_free_rules(struct landlock_rules *const rules)
 {
 	struct landlock_rule *freeme, *next;
 
 	might_sleep();
-	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_inode,
+	rbtree_postorder_for_each_entry_safe(freeme, next, &rules->root_inode,
 					     node)
 		free_rule(freeme, LANDLOCK_KEY_INODE);
 
 #if IS_ENABLED(CONFIG_INET)
 	rbtree_postorder_for_each_entry_safe(freeme, next,
-					     &ruleset->root_net_port, node)
+					     &rules->root_net_port, node)
 		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
 #endif /* IS_ENABLED(CONFIG_INET) */
+}
 
+static void free_ruleset(struct landlock_ruleset *const ruleset)
+{
+	might_sleep();
+	landlock_free_rules(&ruleset->rules);
 	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
@@ -594,7 +592,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 	const struct rb_root *root;
 	const struct rb_node *node;
 
-	root = get_root((struct landlock_ruleset *)ruleset, id.type);
+	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
+				      id.type);
 	if (IS_ERR(root))
 		return NULL;
 	node = root->rb_node;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 889f4b30301a..e7875a8b15df 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -57,13 +57,12 @@ union landlock_key {
  */
 enum landlock_key_type {
 	/**
-	 * @LANDLOCK_KEY_INODE: Type of &landlock_ruleset.root_inode's node
-	 * keys.
+	 * @LANDLOCK_KEY_INODE: Type of &landlock_rules.root_inode's node keys.
 	 */
 	LANDLOCK_KEY_INODE = 1,
 	/**
-	 * @LANDLOCK_KEY_NET_PORT: Type of &landlock_ruleset.root_net_port's
-	 * node keys.
+	 * @LANDLOCK_KEY_NET_PORT: Type of &landlock_rules.root_net_port's node
+	 * keys.
 	 */
 	LANDLOCK_KEY_NET_PORT,
 };
@@ -111,30 +110,44 @@ struct landlock_rule {
 };
 
 /**
- * struct landlock_ruleset - Landlock ruleset
+ * struct landlock_rules - Red-black tree storage for Landlock rules
  *
- * This data structure must contain unique entries, be updatable, and quick to
- * match an object.
+ * This structure holds the rule trees shared by both rulesets and domains.
  */
-struct landlock_ruleset {
+struct landlock_rules {
 	/**
 	 * @root_inode: Root of a red-black tree containing &struct
-	 * landlock_rule nodes with inode object.  Once a ruleset is tied to a
-	 * process (i.e. as a domain), this tree is immutable until @usage
-	 * reaches zero.
+	 * landlock_rule nodes with inode object.  Immutable for domains.
 	 */
 	struct rb_root root_inode;
 
 #if IS_ENABLED(CONFIG_INET)
 	/**
 	 * @root_net_port: Root of a red-black tree containing &struct
-	 * landlock_rule nodes with network port. Once a ruleset is tied to a
-	 * process (i.e. as a domain), this tree is immutable until @usage
-	 * reaches zero.
+	 * landlock_rule nodes with network port.  Immutable for domains.
 	 */
 	struct rb_root root_net_port;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+	/**
+	 * @num_rules: Number of non-overlapping (i.e. not for the same object)
+	 * rules in this tree storage.
+	 */
+	u32 num_rules;
+};
+
+/**
+ * struct landlock_ruleset - Landlock ruleset
+ *
+ * This data structure must contain unique entries, be updatable, and quick to
+ * match an object.
+ */
+struct landlock_ruleset {
+	/**
+	 * @rules: Red-black tree storage for rules.
+	 */
+	struct landlock_rules rules;
+
 	/**
 	 * @hierarchy: Enables hierarchy identification even when a parent
 	 * domain vanishes.  This is needed for the ptrace protection.
@@ -144,9 +157,9 @@ struct landlock_ruleset {
 		/**
 		 * @work_free: Enables to free a ruleset within a lockless
 		 * section.  This is only used by
-		 * landlock_put_ruleset_deferred() when @usage reaches zero.
-		 * The fields @lock, @usage, @num_rules, @num_layers and
-		 * @access_masks are then unused.
+		 * landlock_put_ruleset_deferred() when @usage reaches zero. The
+		 * fields @lock, @usage, @num_layers and @access_masks are then
+		 * unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -160,11 +173,6 @@ struct landlock_ruleset {
 			 * descriptors referencing this ruleset.
 			 */
 			refcount_t usage;
-			/**
-			 * @num_rules: Number of non-overlapping (i.e. not for
-			 * the same object) rules in this ruleset.
-			 */
-			u32 num_rules;
 			/**
 			 * @num_layers: Number of layers that are used in this
 			 * ruleset.  This enables to check that all the layers
@@ -204,6 +212,8 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
 
+void landlock_free_rules(struct landlock_rules *const rules);
+
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
@@ -212,6 +222,33 @@ const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id);
 
+/**
+ * landlock_get_rule_root - Get the root of a rule tree by key type
+ *
+ * @rules: The rules storage to look up.
+ * @key_type: The type of key to select the tree for.
+ *
+ * Return: A pointer to the rb_root, or ERR_PTR(-EINVAL) on unknown type.
+ */
+static inline struct rb_root *
+landlock_get_rule_root(struct landlock_rules *const rules,
+		       const enum landlock_key_type key_type)
+{
+	switch (key_type) {
+	case LANDLOCK_KEY_INODE:
+		return &rules->root_inode;
+
+#if IS_ENABLED(CONFIG_INET)
+	case LANDLOCK_KEY_NET_PORT:
+		return &rules->root_net_port;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	default:
+		WARN_ON_ONCE(1);
+		return ERR_PTR(-EINVAL);
+	}
+}
+
 static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset)
-- 
2.53.0

