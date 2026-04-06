Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB856382F32
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486260; cv=none; b=VtkhziBOj/qki8wCijLs/6vDQZ/AyUaYd/ZdjJ8ZPGd3hQSuXPi2J8vyQ8j0bEGpCMhC9nQtXk3laFe231gfBuZCsbOXZ7FEzUmXt17kTvP0M/xOLR12R6/yj7M6P1hAJceirX/nj9NkeDJqX3mvHf8NvkioZPPJx/CLegxPlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486260; c=relaxed/simple;
	bh=JEd/cd2nvCuIJIj8hpa84hy5+CxXaiCY8CKSCfdHWr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ9nCDUSm64yTAS+2UN0Yldsf31ttPXyhsMZ86ZvVe7+gRsHHdGQD+1UcscPTg3ocZHpIB9GnY213fWVIf4772LbV8Bo6wM3Y7mUh9uasTqqNbYnb6adH+avwrl7R8Ye8Bqr81bNpwptcdoSbiIm2tn7TxbhvlkhoTNVyVdPvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EWhAHBi8; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EWhAHBi8"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkK3gC8z35;
	Mon,  6 Apr 2026 16:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486249;
	bh=leEuJ+k2ZpgWJynDDukI/12kBwD8hN69+7l6/l3o9p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWhAHBi8KF40J7c3z6VQNJHbTp3Xgesfr8X3l/0cmVTd+efLJZX1xjwwc+RC9F0le
	 o4+AE/oE6ntIKjyMIVcCkW8gJD7vPqYgJeGpyGQGgVMqcLrq3BMPmmZ8kcEr8IloVE
	 7HoE69P/3ieSkWzRiTwQewsaN18/b+LznJbaK3Pg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkJ55lgzhjH;
	Mon,  6 Apr 2026 16:37:28 +0200 (CEST)
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
Subject: [PATCH v2 03/17] landlock: Split struct landlock_domain from struct landlock_ruleset
Date: Mon,  6 Apr 2026 16:37:01 +0200
Message-ID: <20260406143717.1815792-4-mic@digikod.net>
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

Switch all domain users to the new struct landlock_domain type
introduced by a previous commit.  This eliminates the conflation between
mutable rulesets and immutable domains.

Change the credential domain field to struct landlock_domain *, and
update all consumer functions.  Move the merge and inherit chain from
ruleset.c to domain.c; landlock_merge_ruleset() now returns struct
landlock_domain * and uses create_domain().  Lock assertions on the
destination are removed because domains have no lock.

Rename the per-layer FAM from access_masks to layers, and the single
ruleset field from access_masks to layer, to prepare for future
per-layer extensions beyond handled-access bitfields.

Clean up struct landlock_ruleset by removing domain-only fields
(hierarchy, work_free, num_layers) and replacing the layers[] FAM with a
single struct access_masks layer field.

Break the circular include between audit.h and cred.h by replacing the
cred.h include in audit.h with forward declarations.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 security/landlock/access.h   |   4 +-
 security/landlock/audit.c    |  12 +-
 security/landlock/audit.h    |   4 +-
 security/landlock/cred.c     |   6 +-
 security/landlock/cred.h     |  21 ++-
 security/landlock/domain.c   | 252 ++++++++++++++++++++++++++-
 security/landlock/domain.h   |  43 ++++-
 security/landlock/fs.c       |  28 ++-
 security/landlock/net.c      |   3 +-
 security/landlock/ruleset.c  | 329 ++++-------------------------------
 security/landlock/ruleset.h  | 129 ++------------
 security/landlock/syscalls.c |  10 +-
 security/landlock/task.c     |  20 +--
 13 files changed, 386 insertions(+), 475 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index c19d5bc13944..76ab447dfcf7 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -19,8 +19,8 @@
 
 /*
  * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
- * entries when we need to get the absolute handled access masks, see
+ * by a ruleset/layer.  This must be ORed with all domain->layers[] entries when
+ * we need to get the absolute handled access masks, see
  * landlock_upgrade_handled_access_masks().
  */
 /* clang-format off */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8d0edf94037d..75438b3cc887 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -135,7 +135,7 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 }
 
 static struct landlock_hierarchy *
-get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
+get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
 {
 	struct landlock_hierarchy *hierarchy = domain->hierarchy;
 	ssize_t i;
@@ -168,7 +168,7 @@ static void test_get_hierarchy(struct kunit *const test)
 		.parent = &dom1_hierarchy,
 		.id = 30,
 	};
-	struct landlock_ruleset dom2 = {
+	struct landlock_domain dom2 = {
 		.hierarchy = &dom2_hierarchy,
 		.num_layers = 3,
 	};
@@ -182,7 +182,7 @@ static void test_get_hierarchy(struct kunit *const test)
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
 /* Get the youngest layer that denied the access_request. */
-static size_t get_denied_layer(const struct landlock_ruleset *const domain,
+static size_t get_denied_layer(const struct landlock_domain *const domain,
 			       access_mask_t *const access_request,
 			       const struct layer_access_masks *masks)
 {
@@ -202,7 +202,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 
 static void test_get_denied_layer(struct kunit *const test)
 {
-	const struct landlock_ruleset dom = {
+	const struct landlock_domain dom = {
 		.num_layers = 5,
 	};
 	const struct layer_access_masks masks = {
@@ -440,8 +440,8 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
  * Only domains which previously appeared in the audit logs are logged again.
  * This is useful to know when a domain will never show again in the audit log.
  *
- * Called in a work queue scheduled by landlock_put_ruleset_deferred() called
- * by hook_cred_free().
+ * Called in a work queue scheduled by landlock_put_domain_deferred() called by
+ * hook_cred_free().
  */
 void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
 {
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 56778331b58c..50452a791656 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -12,7 +12,9 @@
 #include <linux/lsm_audit.h>
 
 #include "access.h"
-#include "cred.h"
+
+struct landlock_cred_security;
+struct landlock_hierarchy;
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index cc419de75cd6..58b544993db4 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -22,7 +22,7 @@ static void hook_cred_transfer(struct cred *const new,
 	const struct landlock_cred_security *const old_llcred =
 		landlock_cred(old);
 
-	landlock_get_ruleset(old_llcred->domain);
+	landlock_get_domain(old_llcred->domain);
 	*landlock_cred(new) = *old_llcred;
 }
 
@@ -35,10 +35,10 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_ruleset *const dom = landlock_cred(cred)->domain;
+	struct landlock_domain *const dom = landlock_cred(cred)->domain;
 
 	if (dom)
-		landlock_put_ruleset_deferred(dom);
+		landlock_put_domain_deferred(dom);
 }
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4..c42b0d3ecec8 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "ruleset.h"
 #include "setup.h"
@@ -31,9 +32,9 @@
  */
 struct landlock_cred_security {
 	/**
-	 * @domain: Immutable ruleset enforced on a task.
+	 * @domain: Immutable domain enforced on a task.
 	 */
-	struct landlock_ruleset *domain;
+	struct landlock_domain *domain;
 
 #ifdef CONFIG_AUDIT
 	/**
@@ -70,22 +71,20 @@ landlock_cred(const struct cred *cred)
 static inline void landlock_cred_copy(struct landlock_cred_security *dst,
 				      const struct landlock_cred_security *src)
 {
-	landlock_put_ruleset(dst->domain);
+	landlock_put_domain(dst->domain);
 
 	*dst = *src;
 
-	landlock_get_ruleset(src->domain);
+	landlock_get_domain(src->domain);
 }
 
-static inline struct landlock_ruleset *landlock_get_current_domain(void)
+static inline struct landlock_domain *landlock_get_current_domain(void)
 {
 	return landlock_cred(current_cred())->domain;
 }
 
-/*
- * The call needs to come from an RCU read-side critical section.
- */
-static inline const struct landlock_ruleset *
+/* The call needs to come from an RCU read-side critical section. */
+static inline const struct landlock_domain *
 landlock_get_task_domain(const struct task_struct *const task)
 {
 	return landlock_cred(__task_cred(task))->domain;
@@ -126,7 +125,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	const union access_masks_all masks_all = {
 		.masks = masks,
 	};
-	const struct landlock_ruleset *domain;
+	const struct landlock_domain *domain;
 	ssize_t layer_level;
 
 	if (!cred)
@@ -139,7 +138,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layers[layer_level],
 		};
 
 		if (layer.all & masks_all.all) {
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index cb79edf5df02..317fd94d3ccd 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -36,6 +36,36 @@
 #include "object.h"
 #include "ruleset.h"
 
+static void build_check_domain(void)
+{
+	const struct landlock_domain domain = {
+		.num_layers = ~0,
+	};
+
+	BUILD_BUG_ON(domain.num_layers < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+static struct landlock_domain *create_domain(const u32 num_layers)
+{
+	struct landlock_domain *new_domain;
+
+	build_check_domain();
+	new_domain = kzalloc_flex(*new_domain, layers, num_layers,
+				  GFP_KERNEL_ACCOUNT);
+	if (!new_domain)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&new_domain->usage, 1);
+	new_domain->rules.root_inode = RB_ROOT;
+
+#if IS_ENABLED(CONFIG_INET)
+	new_domain->rules.root_net_port = RB_ROOT;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	new_domain->num_layers = num_layers;
+	return new_domain;
+}
+
 static void free_domain(struct landlock_domain *const domain)
 {
 	might_sleep();
@@ -67,15 +97,15 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 	}
 }
 
-/* The returned access has the same lifetime as @ruleset. */
+/* The returned access has the same lifetime as @domain. */
 const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
+landlock_find_rule(const struct landlock_domain *const domain,
 		   const struct landlock_id id)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
 
-	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
+	root = landlock_get_rule_root((struct landlock_rules *)&domain->rules,
 				      id.type);
 	if (IS_ERR(root))
 		return NULL;
@@ -151,7 +181,7 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 }
 
 typedef access_mask_t
-get_access_mask_t(const struct landlock_ruleset *const ruleset,
+get_access_mask_t(const struct landlock_domain *const domain,
 		  const u16 layer_level);
 
 /**
@@ -169,7 +199,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
  * any of the active layers in @domain.
  */
 access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
 			  struct layer_access_masks *const masks,
 			  const enum landlock_key_type key_type)
@@ -209,6 +239,218 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	return handled_accesses;
 }
 
+static int merge_tree(struct landlock_domain *const dst,
+		      struct landlock_ruleset *const src,
+		      const enum landlock_key_type key_type)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct rb_root *src_root;
+	int err = 0;
+
+	might_sleep();
+	lockdep_assert_held(&src->lock);
+
+	src_root = landlock_get_rule_root(&src->rules, key_type);
+	if (IS_ERR(src_root))
+		return PTR_ERR(src_root);
+
+	/* Merges the @src tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
+					     node) {
+		struct landlock_layer layers[] = { {
+			.level = dst->num_layers,
+		} };
+		const struct landlock_id id = {
+			.key = walker_rule->key,
+			.type = key_type,
+		};
+
+		if (WARN_ON_ONCE(walker_rule->num_layers != 1))
+			return -EINVAL;
+
+		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0))
+			return -EINVAL;
+
+		layers[0].access = walker_rule->layers[0].access;
+
+		err = landlock_rule_insert(&dst->rules, id, &layers,
+					   ARRAY_SIZE(layers));
+		if (err)
+			return err;
+	}
+	return err;
+}
+
+static int merge_ruleset(struct landlock_domain *const dst,
+			 struct landlock_ruleset *const src)
+{
+	int err = 0;
+
+	might_sleep();
+	/* Should already be checked by landlock_merge_ruleset() */
+	if (WARN_ON_ONCE(!src))
+		return 0;
+	/* Only merge into a domain. */
+	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
+		return -EINVAL;
+
+	mutex_lock(&src->lock);
+
+	/* Stacks the new layer. */
+	if (WARN_ON_ONCE(dst->num_layers < 1)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	dst->layers[dst->num_layers - 1] =
+		landlock_upgrade_handled_access_masks(src->layer);
+
+	/* Merges the @src inode tree. */
+	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
+	if (err)
+		goto out_unlock;
+
+#if IS_ENABLED(CONFIG_INET)
+	/* Merges the @src network port tree. */
+	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
+	if (err)
+		goto out_unlock;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+out_unlock:
+	mutex_unlock(&src->lock);
+	return err;
+}
+
+static int inherit_tree(struct landlock_domain *const parent,
+			struct landlock_domain *const child,
+			const enum landlock_key_type key_type)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct rb_root *parent_root;
+	int err = 0;
+
+	might_sleep();
+
+	parent_root = landlock_get_rule_root(
+		(struct landlock_rules *)&parent->rules, key_type);
+	if (IS_ERR(parent_root))
+		return PTR_ERR(parent_root);
+
+	/* Copies the @parent inode or network tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+					     parent_root, node) {
+		const struct landlock_id id = {
+			.key = walker_rule->key,
+			.type = key_type,
+		};
+
+		err = landlock_rule_insert(&child->rules, id,
+					   &walker_rule->layers,
+					   walker_rule->num_layers);
+		if (err)
+			return err;
+	}
+	return err;
+}
+
+static int inherit_ruleset(struct landlock_domain *const parent,
+			   struct landlock_domain *const child)
+{
+	int err = 0;
+
+	might_sleep();
+	if (!parent)
+		return 0;
+
+	/* Copies the @parent inode tree. */
+	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
+	if (err)
+		return err;
+
+#if IS_ENABLED(CONFIG_INET)
+	/* Copies the @parent network port tree. */
+	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
+	if (err)
+		return err;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers))
+		return -EINVAL;
+
+	/* Copies the parent layer stack and leaves a space for the new layer. */
+	memcpy(child->layers, parent->layers,
+	       flex_array_size(parent, layers, parent->num_layers));
+
+	if (WARN_ON_ONCE(!parent->hierarchy))
+		return -EINVAL;
+
+	landlock_get_hierarchy(parent->hierarchy);
+	child->hierarchy->parent = parent->hierarchy;
+
+	return 0;
+}
+
+/**
+ * landlock_merge_ruleset - Merge a ruleset with a domain
+ *
+ * @parent: Parent domain.
+ * @ruleset: New ruleset to be merged.
+ *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state. cf. landlock_init_hierarchy_log().
+ *
+ * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR() on
+ * failure.  If @parent is NULL, the new domain duplicates @ruleset.
+ */
+struct landlock_domain *
+landlock_merge_ruleset(struct landlock_domain *const parent,
+		       struct landlock_ruleset *const ruleset)
+{
+	struct landlock_domain *new_dom __free(landlock_put_domain) = NULL;
+	u32 num_layers;
+	int err;
+
+	might_sleep();
+	if (WARN_ON_ONCE(!ruleset))
+		return ERR_PTR(-EINVAL);
+
+	if (parent) {
+		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
+			return ERR_PTR(-E2BIG);
+		num_layers = parent->num_layers + 1;
+	} else {
+		num_layers = 1;
+	}
+
+	/* Creates a new domain... */
+	new_dom = create_domain(num_layers);
+	if (IS_ERR(new_dom))
+		return new_dom;
+
+	new_dom->hierarchy =
+		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
+	if (!new_dom->hierarchy)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&new_dom->hierarchy->usage, 1);
+
+	/* ...as a child of @parent... */
+	err = inherit_ruleset(parent, new_dom);
+	if (err)
+		return ERR_PTR(err);
+
+	/* ...and including @ruleset. */
+	err = merge_ruleset(new_dom, ruleset);
+	if (err)
+		return ERR_PTR(err);
+
+	err = landlock_init_hierarchy_log(new_dom->hierarchy);
+	if (err)
+		return ERR_PTR(err);
+
+	return no_free_ptr(new_dom);
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index afa97011ecd2..df11cb7d4f2b 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -196,7 +196,7 @@ struct landlock_domain {
 		 * @work_free: Enables to free a domain within a lockless
 		 * section.  This is only used by landlock_put_domain_deferred()
 		 * when @usage reaches zero.  The fields @usage, @num_layers and
-		 * @access_masks are then unused.
+		 * @layers are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -212,7 +212,7 @@ struct landlock_domain {
 			 */
 			u32 num_layers;
 			/**
-			 * @access_masks: Contains the subset of filesystem and
+			 * @layers: Contains the subset of filesystem and
 			 * network actions that are restricted by a domain.  A
 			 * domain saves all layers of merged rulesets in a stack
 			 * (FAM), starting from the first layer to the last one.
@@ -222,28 +222,51 @@ struct landlock_domain {
 			 * overlapping access rights.  These layers are set once
 			 * and never changed for the lifetime of the domain.
 			 */
-			struct access_masks access_masks[];
+			struct access_masks layers[];
 		};
 	};
 };
 
+static inline access_mask_t
+landlock_get_fs_access_mask(const struct landlock_domain *const domain,
+			    const u16 layer_level)
+{
+	/* Handles all initially denied by default access rights. */
+	return domain->layers[layer_level].fs |
+	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+}
+
+static inline access_mask_t
+landlock_get_net_access_mask(const struct landlock_domain *const domain,
+			     const u16 layer_level)
+{
+	return domain->layers[layer_level].net;
+}
+
+static inline access_mask_t
+landlock_get_scope_mask(const struct landlock_domain *const domain,
+			const u16 layer_level)
+{
+	return domain->layers[layer_level].scope;
+}
+
 /**
  * landlock_union_access_masks - Return all access rights handled in the
  *				 domain
  *
- * @domain: Landlock ruleset (used as a domain)
+ * @domain: Landlock domain
  *
  * Return: An access_masks result of the OR of all the domain's access masks.
  */
 static inline struct access_masks
-landlock_union_access_masks(const struct landlock_ruleset *const domain)
+landlock_union_access_masks(const struct landlock_domain *const domain)
 {
 	union access_masks_all matches = {};
 	size_t layer_level;
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layers[layer_level],
 		};
 
 		matches.all |= layer.all;
@@ -258,15 +281,19 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain);
 DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
 
+struct landlock_domain *
+landlock_merge_ruleset(struct landlock_domain *const parent,
+		       struct landlock_ruleset *const ruleset);
+
 const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
+landlock_find_rule(const struct landlock_domain *const domain,
 		   const struct landlock_id id);
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    struct layer_access_masks *masks);
 
 access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
 			  struct layer_access_masks *masks,
 			  const enum landlock_key_type key_type);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..3ef453fc14a6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -336,12 +336,10 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (!d_is_dir(path->dentry) &&
 	    !access_mask_subset(access_rights, ACCESS_FILE))
 		return -EINVAL;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1))
-		return -EINVAL;
-
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_FS &
-			 ~landlock_get_fs_access_mask(ruleset, 0);
+	access_rights |=
+		LANDLOCK_MASK_ACCESS_FS &
+		~(ruleset->layer.fs | _LANDLOCK_ACCESS_FS_INITIALLY_DENIED);
 	id.key.object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
@@ -364,7 +362,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
  * Returns NULL if no rule is found or if @dentry is negative.
  */
 static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
+find_rule(const struct landlock_domain *const domain,
 	  const struct dentry *const dentry)
 {
 	const struct landlock_rule *rule;
@@ -740,7 +738,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * Return: True if the access request is granted, false otherwise.
  */
 static bool
-is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
+is_access_to_paths_allowed(const struct landlock_domain *const domain,
 			   const struct path *const path,
 			   const access_mask_t access_request_parent1,
 			   struct layer_access_masks *layer_masks_parent1,
@@ -1026,7 +1024,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * Return: True if all the domain access rights are allowed for @dir, false if
  * the walk reached @mnt_root.
  */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
+static bool collect_domain_accesses(const struct landlock_domain *const domain,
 				    const struct dentry *const mnt_root,
 				    struct dentry *dir,
 				    struct layer_access_masks *layer_masks_dom)
@@ -1578,8 +1576,8 @@ static int hook_path_truncate(const struct path *const path)
  * @masks: Layer access masks to unmask
  * @access: Access bits that control scoping
  */
-static void unmask_scoped_access(const struct landlock_ruleset *const client,
-				 const struct landlock_ruleset *const server,
+static void unmask_scoped_access(const struct landlock_domain *const client,
+				 const struct landlock_domain *const server,
 				 struct layer_access_masks *const masks,
 				 const access_mask_t access)
 {
@@ -1633,7 +1631,7 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 static int hook_unix_find(const struct path *const path, struct sock *other,
 			  int flags)
 {
-	const struct landlock_ruleset *dom_other;
+	const struct landlock_domain *dom_other;
 	const struct landlock_cred_security *subject;
 	struct layer_access_masks layer_masks;
 	struct landlock_request request = {};
@@ -1914,7 +1912,7 @@ static bool control_current_fowner(struct fown_struct *const fown)
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *prev_dom;
+	struct landlock_domain *prev_dom;
 	struct landlock_cred_security fown_subject = {};
 	size_t fown_layer = 0;
 
@@ -1926,7 +1924,7 @@ static void hook_file_set_fowner(struct file *file)
 			landlock_get_applicable_subject(
 				current_cred(), signal_scope, &fown_layer);
 		if (new_subject) {
-			landlock_get_ruleset(new_subject->domain);
+			landlock_get_domain(new_subject->domain);
 			fown_subject = *new_subject;
 		}
 	}
@@ -1938,12 +1936,12 @@ static void hook_file_set_fowner(struct file *file)
 #endif /* CONFIG_AUDIT*/
 
 	/* May be called in an RCU read-side critical section. */
-	landlock_put_ruleset_deferred(prev_dom);
+	landlock_put_domain_deferred(prev_dom);
 }
 
 static void hook_file_free_security(struct file *file)
 {
-	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
+	landlock_put_domain_deferred(landlock_file(file)->fown_subject.domain);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 34a72a4f833d..de108b3277bc 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -32,8 +32,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_NET &
-			 ~landlock_get_net_access_mask(ruleset, 0);
+	access_rights |= LANDLOCK_MASK_ACCESS_NET & ~ruleset->layer.net;
 
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 0cf31a7e4c7b..c220e0f9cf5f 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -20,22 +20,27 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 
 #include "access.h"
-#include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
 
-static struct landlock_ruleset *create_ruleset(const u32 num_layers)
+struct landlock_ruleset *
+landlock_create_ruleset(const access_mask_t fs_access_mask,
+			const access_mask_t net_access_mask,
+			const access_mask_t scope_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
-				   GFP_KERNEL_ACCOUNT);
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask && !net_access_mask && !scope_mask)
+		return ERR_PTR(-ENOMSG);
+
+	new_ruleset = kzalloc(sizeof(*new_ruleset), GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
+
 	refcount_set(&new_ruleset->usage, 1);
 	mutex_init(&new_ruleset->lock);
 	new_ruleset->rules.root_inode = RB_ROOT;
@@ -44,34 +49,21 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	new_ruleset->rules.root_net_port = RB_ROOT;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	new_ruleset->num_layers = num_layers;
-	/*
-	 * hierarchy = NULL
-	 * rules.num_rules = 0
-	 * access_masks[] = 0
-	 */
-	return new_ruleset;
-}
-
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask,
-			const access_mask_t scope_mask)
-{
-	struct landlock_ruleset *new_ruleset;
-
-	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask && !scope_mask)
-		return ERR_PTR(-ENOMSG);
-	new_ruleset = create_ruleset(1);
-	if (IS_ERR(new_ruleset))
-		return new_ruleset;
-	if (fs_access_mask)
-		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
-	if (net_access_mask)
-		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
-	if (scope_mask)
-		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
+	/* Should already be checked in sys_landlock_create_ruleset(). */
+	if (fs_access_mask) {
+		WARN_ON_ONCE(fs_access_mask !=
+			     (fs_access_mask & LANDLOCK_MASK_ACCESS_FS));
+		new_ruleset->layer.fs |= fs_access_mask;
+	}
+	if (net_access_mask) {
+		WARN_ON_ONCE(net_access_mask !=
+			     (net_access_mask & LANDLOCK_MASK_ACCESS_NET));
+		new_ruleset->layer.net |= net_access_mask;
+	}
+	if (scope_mask) {
+		WARN_ON_ONCE(scope_mask != (scope_mask & LANDLOCK_MASK_SCOPE));
+		new_ruleset->layer.scope |= scope_mask;
+	}
 	return new_ruleset;
 }
 
@@ -128,7 +120,7 @@ create_rule(const struct landlock_id id,
 		return ERR_PTR(-ENOMEM);
 	RB_CLEAR_NODE(&new_rule->node);
 	if (is_object_pointer(id.type)) {
-		/* This should have been caught by insert_rule(). */
+		/* This should have been caught by landlock_rule_insert(). */
 		WARN_ON_ONCE(!id.key.object);
 		landlock_get_object(id.key.object);
 	}
@@ -144,12 +136,6 @@ create_rule(const struct landlock_id id,
 	return new_rule;
 }
 
-static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
-				const enum landlock_key_type key_type)
-{
-	return landlock_get_rule_root(&ruleset->rules, key_type);
-}
-
 static void free_rule(struct landlock_rule *const rule,
 		      const enum landlock_key_type key_type)
 {
@@ -166,16 +152,12 @@ static void build_check_ruleset(void)
 	const struct landlock_rules rules = {
 		.num_rules = ~0,
 	};
-	const struct landlock_ruleset ruleset = {
-		.num_layers = ~0,
-	};
 
 	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
-	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
 }
 
 /**
- * insert_rule - Create and insert a rule in a rule set
+ * landlock_rule_insert - Create and insert a rule in a rule set
  *
  * @rules: The rule storage to be updated.  The caller is responsible for
  *         any required locking.  For rulesets, this means holding
@@ -197,10 +179,10 @@ static void build_check_ruleset(void)
  *
  * Return: 0 on success, -errno on failure.
  */
-static int insert_rule(struct landlock_rules *const rules,
-		       const struct landlock_id id,
-		       const struct landlock_layer (*layers)[],
-		       const size_t num_layers)
+int landlock_rule_insert(struct landlock_rules *const rules,
+			 const struct landlock_id id,
+			 const struct landlock_layer (*layers)[],
+			 const size_t num_layers)
 {
 	struct rb_node **walker_node;
 	struct rb_node *parent_node = NULL;
@@ -240,7 +222,7 @@ static int insert_rule(struct landlock_rules *const rules,
 		if ((*layers)[0].level == 0) {
 			/*
 			 * Extends access rights when the request comes from
-			 * landlock_add_rule(2), i.e. contained by a ruleset.
+			 * landlock_add_rule(2), i.e. @rules is not a domain.
 			 */
 			if (WARN_ON_ONCE(this->num_layers != 1))
 				return -EINVAL;
@@ -301,176 +283,14 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
-		/* When @level is zero, insert_rule() extends @ruleset. */
+		/* When @level is zero, landlock_rule_insert() extends @ruleset. */
 		.level = 0,
 	} };
 
 	build_check_layer();
 	lockdep_assert_held(&ruleset->lock);
-	return insert_rule(&ruleset->rules, id, &layers, ARRAY_SIZE(layers));
-}
-
-static int merge_tree(struct landlock_ruleset *const dst,
-		      struct landlock_ruleset *const src,
-		      const enum landlock_key_type key_type)
-{
-	struct landlock_rule *walker_rule, *next_rule;
-	struct rb_root *src_root;
-	int err = 0;
-
-	might_sleep();
-	lockdep_assert_held(&dst->lock);
-	lockdep_assert_held(&src->lock);
-
-	src_root = get_root(src, key_type);
-	if (IS_ERR(src_root))
-		return PTR_ERR(src_root);
-
-	/* Merges the @src tree. */
-	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
-					     node) {
-		struct landlock_layer layers[] = { {
-			.level = dst->num_layers,
-		} };
-		const struct landlock_id id = {
-			.key = walker_rule->key,
-			.type = key_type,
-		};
-
-		if (WARN_ON_ONCE(walker_rule->num_layers != 1))
-			return -EINVAL;
-
-		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0))
-			return -EINVAL;
-
-		layers[0].access = walker_rule->layers[0].access;
-
-		err = insert_rule(&dst->rules, id, &layers, ARRAY_SIZE(layers));
-		if (err)
-			return err;
-	}
-	return err;
-}
-
-static int merge_ruleset(struct landlock_ruleset *const dst,
-			 struct landlock_ruleset *const src)
-{
-	int err = 0;
-
-	might_sleep();
-	/* Should already be checked by landlock_merge_ruleset() */
-	if (WARN_ON_ONCE(!src))
-		return 0;
-	/* Only merge into a domain. */
-	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
-		return -EINVAL;
-
-	/* Locks @dst first because we are its only owner. */
-	mutex_lock(&dst->lock);
-	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
-
-	/* Stacks the new layer. */
-	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	dst->access_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->access_masks[0]);
-
-	/* Merges the @src inode tree. */
-	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
-	if (err)
-		goto out_unlock;
-
-#if IS_ENABLED(CONFIG_INET)
-	/* Merges the @src network port tree. */
-	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
-	if (err)
-		goto out_unlock;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-out_unlock:
-	mutex_unlock(&src->lock);
-	mutex_unlock(&dst->lock);
-	return err;
-}
-
-static int inherit_tree(struct landlock_ruleset *const parent,
-			struct landlock_ruleset *const child,
-			const enum landlock_key_type key_type)
-{
-	struct landlock_rule *walker_rule, *next_rule;
-	struct rb_root *parent_root;
-	int err = 0;
-
-	might_sleep();
-	lockdep_assert_held(&parent->lock);
-	lockdep_assert_held(&child->lock);
-
-	parent_root = get_root(parent, key_type);
-	if (IS_ERR(parent_root))
-		return PTR_ERR(parent_root);
-
-	/* Copies the @parent inode or network tree. */
-	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
-					     parent_root, node) {
-		const struct landlock_id id = {
-			.key = walker_rule->key,
-			.type = key_type,
-		};
-
-		err = insert_rule(&child->rules, id, &walker_rule->layers,
-				  walker_rule->num_layers);
-		if (err)
-			return err;
-	}
-	return err;
-}
-
-static int inherit_ruleset(struct landlock_ruleset *const parent,
-			   struct landlock_ruleset *const child)
-{
-	int err = 0;
-
-	might_sleep();
-	if (!parent)
-		return 0;
-
-	/* Locks @child first because we are its only owner. */
-	mutex_lock(&child->lock);
-	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
-	/* Copies the @parent inode tree. */
-	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
-	if (err)
-		goto out_unlock;
-
-#if IS_ENABLED(CONFIG_INET)
-	/* Copies the @parent network port tree. */
-	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
-	if (err)
-		goto out_unlock;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	/* Copies the parent layer stack and leaves a space for the new layer. */
-	memcpy(child->access_masks, parent->access_masks,
-	       flex_array_size(parent, access_masks, parent->num_layers));
-
-	if (WARN_ON_ONCE(!parent->hierarchy)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	landlock_get_hierarchy(parent->hierarchy);
-	child->hierarchy->parent = parent->hierarchy;
-
-out_unlock:
-	mutex_unlock(&parent->lock);
-	mutex_unlock(&child->lock);
-	return err;
+	return landlock_rule_insert(&ruleset->rules, id, &layers,
+				    ARRAY_SIZE(layers));
 }
 
 void landlock_free_rules(struct landlock_rules *const rules)
@@ -493,7 +313,6 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	might_sleep();
 	landlock_free_rules(&ruleset->rules);
-	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
 
@@ -503,81 +322,3 @@ void landlock_put_ruleset(struct landlock_ruleset *const ruleset)
 	if (ruleset && refcount_dec_and_test(&ruleset->usage))
 		free_ruleset(ruleset);
 }
-
-static void free_ruleset_work(struct work_struct *const work)
-{
-	struct landlock_ruleset *ruleset;
-
-	ruleset = container_of(work, struct landlock_ruleset, work_free);
-	free_ruleset(ruleset);
-}
-
-/* Only called by hook_cred_free(). */
-void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
-{
-	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
-		INIT_WORK(&ruleset->work_free, free_ruleset_work);
-		schedule_work(&ruleset->work_free);
-	}
-}
-
-/**
- * landlock_merge_ruleset - Merge a ruleset with a domain
- *
- * @parent: Parent domain.
- * @ruleset: New ruleset to be merged.
- *
- * The current task is requesting to be restricted.  The subjective credentials
- * must not be in an overridden state. cf. landlock_init_hierarchy_log().
- *
- * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR()
- * on failure.  If @parent is NULL, the new domain duplicates @ruleset.
- */
-struct landlock_ruleset *
-landlock_merge_ruleset(struct landlock_ruleset *const parent,
-		       struct landlock_ruleset *const ruleset)
-{
-	struct landlock_ruleset *new_dom __free(landlock_put_ruleset) = NULL;
-	u32 num_layers;
-	int err;
-
-	might_sleep();
-	if (WARN_ON_ONCE(!ruleset || parent == ruleset))
-		return ERR_PTR(-EINVAL);
-
-	if (parent) {
-		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
-			return ERR_PTR(-E2BIG);
-		num_layers = parent->num_layers + 1;
-	} else {
-		num_layers = 1;
-	}
-
-	/* Creates a new domain... */
-	new_dom = create_ruleset(num_layers);
-	if (IS_ERR(new_dom))
-		return new_dom;
-
-	new_dom->hierarchy =
-		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
-	if (!new_dom->hierarchy)
-		return ERR_PTR(-ENOMEM);
-
-	refcount_set(&new_dom->hierarchy->usage, 1);
-
-	/* ...as a child of @parent... */
-	err = inherit_ruleset(parent, new_dom);
-	if (err)
-		return ERR_PTR(err);
-
-	/* ...and including @ruleset. */
-	err = merge_ruleset(new_dom, ruleset);
-	if (err)
-		return ERR_PTR(err);
-
-	err = landlock_init_hierarchy_log(new_dom->hierarchy);
-	if (err)
-		return ERR_PTR(err);
-
-	return no_free_ptr(new_dom);
-}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1d3a9c36eb74..bf127ff7496e 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -14,14 +14,11 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
-#include <linux/workqueue.h>
 
 #include "access.h"
 #include "limits.h"
 #include "object.h"
 
-struct landlock_hierarchy;
-
 /**
  * struct landlock_layer - Access rights for a given layer
  */
@@ -147,54 +144,20 @@ struct landlock_ruleset {
 	 * @rules: Red-black tree storage for rules.
 	 */
 	struct landlock_rules rules;
-
 	/**
-	 * @hierarchy: Enables hierarchy identification even when a parent
-	 * domain vanishes.  This is needed for the ptrace protection.
+	 * @lock: Protects against concurrent modifications of @rules, if @usage
+	 * is greater than zero.
+	 */
+	struct mutex lock;
+	/**
+	 * @usage: Number of file descriptors referencing this ruleset.
 	 */
-	struct landlock_hierarchy *hierarchy;
-	union {
-		/**
-		 * @work_free: Enables to free a ruleset within a lockless
-		 * section.  This is only used by
-		 * landlock_put_ruleset_deferred() when @usage reaches zero. The
-		 * fields @lock, @usage, @num_layers and @access_masks are then
-		 * unused.
-		 */
-		struct work_struct work_free;
-		struct {
-			/**
-			 * @lock: Protects against concurrent modifications of
-			 * @root, if @usage is greater than zero.
-			 */
-			struct mutex lock;
-			/**
-			 * @usage: Number of processes (i.e. domains) or file
-			 * descriptors referencing this ruleset.
-			 */
-			refcount_t usage;
-			/**
-			 * @num_layers: Number of layers that are used in this
-			 * ruleset.  This enables to check that all the layers
-			 * allow an access request.  A value of 0 identifies a
-			 * non-merged ruleset (i.e. not a domain).
-			 */
-			u32 num_layers;
-			/**
-			 * @access_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a ruleset.
-			 * A domain saves all layers of merged rulesets in a
-			 * stack (FAM), starting from the first layer to the
-			 * last one.  These layers are used when merging
-			 * rulesets, for user space backward compatibility
-			 * (i.e. future-proof), and to properly handle merged
-			 * rulesets without overlapping access rights.  These
-			 * layers are set once and never changed for the
-			 * lifetime of the ruleset.
-			 */
-			struct access_masks access_masks[];
-		};
-	};
+	refcount_t usage;
+	/**
+	 * @layer: Contains the subset of filesystem and network actions that
+	 * are handled by this ruleset.
+	 */
+	struct access_masks layer;
 };
 
 struct landlock_ruleset *
@@ -203,7 +166,6 @@ landlock_create_ruleset(const access_mask_t access_mask_fs,
 			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
-void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 
 DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
@@ -212,11 +174,12 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
 
-void landlock_free_rules(struct landlock_rules *const rules);
+int landlock_rule_insert(struct landlock_rules *const rules,
+			 const struct landlock_id id,
+			 const struct landlock_layer (*layers)[],
+			 const size_t num_layers);
 
-struct landlock_ruleset *
-landlock_merge_ruleset(struct landlock_ruleset *const parent,
-		       struct landlock_ruleset *const ruleset);
+void landlock_free_rules(struct landlock_rules *const rules);
 
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
@@ -251,62 +214,4 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
-static inline void
-landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
-			    const access_mask_t fs_access_mask,
-			    const u16 layer_level)
-{
-	access_mask_t fs_mask = fs_access_mask & LANDLOCK_MASK_ACCESS_FS;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(fs_access_mask != fs_mask);
-	ruleset->access_masks[layer_level].fs |= fs_mask;
-}
-
-static inline void
-landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
-			     const access_mask_t net_access_mask,
-			     const u16 layer_level)
-{
-	access_mask_t net_mask = net_access_mask & LANDLOCK_MASK_ACCESS_NET;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(net_access_mask != net_mask);
-	ruleset->access_masks[layer_level].net |= net_mask;
-}
-
-static inline void
-landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
-			const access_mask_t scope_mask, const u16 layer_level)
-{
-	access_mask_t mask = scope_mask & LANDLOCK_MASK_SCOPE;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(scope_mask != mask);
-	ruleset->access_masks[layer_level].scope |= mask;
-}
-
-static inline access_mask_t
-landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
-			    const u16 layer_level)
-{
-	/* Handles all initially denied by default access rights. */
-	return ruleset->access_masks[layer_level].fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-}
-
-static inline access_mask_t
-landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
-			     const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].net;
-}
-
-static inline access_mask_t
-landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
-			const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].scope;
-}
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..73ccc32d0afd 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -283,8 +283,6 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
 	if (!(fd_file(ruleset_f)->f_mode & mode))
 		return ERR_PTR(-EPERM);
 	ruleset = fd_file(ruleset_f)->private_data;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1))
-		return ERR_PTR(-EINVAL);
 	landlock_get_ruleset(ruleset);
 	return ruleset;
 }
@@ -341,7 +339,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->access_masks[0].fs;
+	mask = ruleset->layer.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
@@ -377,7 +375,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = landlock_get_net_access_mask(ruleset, 0);
+	mask = ruleset->layer.net;
 	if ((net_port_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
@@ -556,7 +554,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		 * manipulating the current credentials because they are
 		 * dedicated per thread.
 		 */
-		struct landlock_ruleset *const new_dom =
+		struct landlock_domain *const new_dom =
 			landlock_merge_ruleset(new_llcred->domain, ruleset);
 		if (IS_ERR(new_dom)) {
 			abort_creds(new_cred);
@@ -571,7 +569,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #endif /* CONFIG_AUDIT */
 
 		/* Replaces the old (prepared) domain. */
-		landlock_put_ruleset(new_llcred->domain);
+		landlock_put_domain(new_llcred->domain);
 		new_llcred->domain = new_dom;
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 6d46042132ce..2e7ee62958b2 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -41,8 +41,8 @@
  * Return: True if @parent is an ancestor of or equal to @child, false
  * otherwise.
  */
-static bool domain_scope_le(const struct landlock_ruleset *const parent,
-			    const struct landlock_ruleset *const child)
+static bool domain_scope_le(const struct landlock_domain *const parent,
+			    const struct landlock_domain *const child)
 {
 	const struct landlock_hierarchy *walker;
 
@@ -63,8 +63,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
 	return false;
 }
 
-static int domain_ptrace(const struct landlock_ruleset *const parent,
-			 const struct landlock_ruleset *const child)
+static int domain_ptrace(const struct landlock_domain *const parent,
+			 const struct landlock_domain *const child)
 {
 	if (domain_scope_le(parent, child))
 		return 0;
@@ -97,7 +97,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 
 	scoped_guard(rcu)
 	{
-		const struct landlock_ruleset *const child_dom =
+		const struct landlock_domain *const child_dom =
 			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
 	}
@@ -136,7 +136,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
 	const struct landlock_cred_security *parent_subject;
-	const struct landlock_ruleset *child_dom;
+	const struct landlock_domain *child_dom;
 	int err;
 
 	child_dom = landlock_get_current_domain();
@@ -177,8 +177,8 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
  * Return: True if @server is in a different domain from @client and @client
  * is scoped to access @server (i.e. access should be denied), false otherwise.
  */
-static bool domain_is_scoped(const struct landlock_ruleset *const client,
-			     const struct landlock_ruleset *const server,
+static bool domain_is_scoped(const struct landlock_domain *const client,
+			     const struct landlock_domain *const server,
 			     access_mask_t scope)
 {
 	int client_layer, server_layer;
@@ -237,9 +237,9 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 }
 
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_ruleset *const domain)
+			   const struct landlock_domain *const domain)
 {
-	const struct landlock_ruleset *dom_other;
+	const struct landlock_domain *dom_other;
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
-- 
2.53.0

