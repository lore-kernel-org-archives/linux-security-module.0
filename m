Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71513D891
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815124; cv=none; b=dOgAAAL4bEHcY+16yz6aNEGStobPejUWeEo20GT37MfWPGOLIHlPtqOc4bliVJzJiYeRQDm97d6Atx5bZkA9PYrCQE18xwFY2lKbW9A+yaTNhiFeC+VrbVJg5pk9ZMK5wQ2xdLm1M3nolOF8VCxmIFZrfkTO30K/G4yZTaB0NNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815124; c=relaxed/simple;
	bh=GGdj2UDP9Wptw5OSy2qih7ybDlk6yTcSlqQ1CJqEGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVYGNThQEj+AVO6RE5o4hOH41dhJEEcF4kekfNIfbk4TydzhRFOhqWD09WypKmhiL8Qshbhkj186iIPAAwZNriD3Xy+YVYPgSQajZb4E3vl/8cJpxjcVk20Cibduq9o22Smy/1lEbLtsb2WjcMhcEVxalHnAc/HGFKBE6rfRqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=EM+6qpPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoK24Djy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="EM+6qpPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoK24Djy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A7BE1D000E7;
	Sun,  6 Jul 2025 11:18:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 06 Jul 2025 11:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751815121; x=
	1751901521; bh=gUbev2sa2fe7nZR4sfFmRvQrZmxygt66cRms/7VWDdA=; b=E
	M+6qpPDOQ4yL3xfIv9nCxrNQ8AZuhdJqXHZ2trb1A+/CrOjiRk046LdE5ACFujC+
	9gVfCRrEuuB63X/jCyJKilD8u8HIsgD1pdIxOs6xw8z7uyTsrsKRl3vNkj8mFHKV
	zzVkcgAbdjk7xTOn+aJbqlajptPe55rYWcPI4ybSc32pIQcDaxCazZXd22gJ+ali
	T38Kju5C3nSLffL3NbBhP0n5R0slfAW6SWFYjdIoTpjRmk3le9W0YH1bHl6D252i
	Z7qa/zt1oncYT9HX8AyCqE4wFtC8eiFU7gJ8Prbntl3ps4pK9n4tBzxaTjdGgL+G
	U/Doxw8pZl78QoLc9rhZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751815121; x=1751901521; bh=g
	Ubev2sa2fe7nZR4sfFmRvQrZmxygt66cRms/7VWDdA=; b=BoK24DjyxGVXhT5IU
	ZLMSFd6qOGGGAvp96T4cw5eQoTfVERIqJD01Sbbvm6xfoUh5lIZMQHKjtAWmT6+F
	Ve+bB+Y0QW5+P129u1S/ODxm0+DJ28B8wgRGi6o7yYscb9d+vdOEeeKs5B5pOT0z
	9agbq0q45QhRe/nAN+xQ6gWvR35e6jlp2jEhPtkjaCpSTNcSHGLzoE0+trujpvFS
	yoEUV7xuM/nNAnZQhRwHPzLvy5s42WtBNyuSNtyuHHH7DUHoRpzH3FCXL9QuP0yR
	AiTdmKIBLPv9auITPbDIA3sr+FJNXMpKAWyMsMipgYDZKeMFrKizeFPvK4yiTMEz
	KLiRA==
X-ME-Sender: <xms:0ZNqaCoYVHU3kIn3xLwrY7_MI7403wGCXRVz1BQXlaCnXcD9N1Bt5w>
    <xme:0ZNqaAoiMn13rEy4_0dVhJPH2MLiAXLIRt4wSm_-98T7mZTrkBqRvPmJ4fw5uSoL3
    UsDDuJsrd2fMiAm0cE>
X-ME-Received: <xmr:0ZNqaHPShV3UXQj1TVqRf_K6XtmfD86Poss_r6KA2fmNektqp6g7CDS5_qW3VIxWBlBNsOIvWAu1tH7CKYtwJXh7OqNTPlkWblJ4pdWArdU5PT2n6RH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghr
    thhnvghrshdrtghomhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:0ZNqaB5Z9Q27V3OZ39qrkxf2scXwHUcPL3mpW_Q5vPKJMhiQBDxpNg>
    <xmx:0ZNqaB6qc8eiv6GRwr1RLyiDkxW5Sy6LbXB-o0TKoDfQeSeY2LkiOA>
    <xmx:0ZNqaBj_pC_5mnFCIyjrfASSrdBxlhgZ9EeI489s6LlEgZ2uiAaV5A>
    <xmx:0ZNqaL6-LfMxGQ5GzDzKVhox0O7QlrKlstQj5y8X_kuXkwiE044IAg>
    <xmx:0ZNqaEBIwMobeHM-i7mYKDbec1-YrJE8JauPmefJT2xnsck6cOQ99XXA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:39 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 10/12] landlock: Remove unused code
Date: Sun,  6 Jul 2025 16:16:51 +0100
Message-ID: <a156df7ed56cf94df84acf95eaed61c253a9592f.1751814659.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.c | 239 ------------------------------------
 security/landlock/ruleset.h |  10 +-
 2 files changed, 1 insertion(+), 248 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 6bea1cc16b62..8e95276486f8 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -309,169 +309,6 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
 }
 
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
-		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
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
-		err = insert_rule(child, id, &walker_rule->layers,
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
-}
-
 static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	struct landlock_rule *freeme, *next;
@@ -515,82 +352,6 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 	}
 }
 
-/**
- * landlock_merge_ruleset - Merge a ruleset with a domain
- *
- * @parent: Parent domain.
- * @ruleset: New ruleset to be merged.
- *
- * The current task is requesting to be restricted.  The subjective credentials
- * must not be in an overridden state. cf. landlock_init_hierarchy_log().
- *
- * Returns the intersection of @parent and @ruleset, or returns @parent if
- * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
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
-		kzalloc(sizeof(*new_dom->hierarchy), GFP_KERNEL_ACCOUNT);
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
-
-/*
- * The returned access has the same lifetime as @ruleset.
- */
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id)
-{
-	const struct rb_root *root;
-
-	root = get_root((struct landlock_ruleset *)ruleset, id.type);
-	if (IS_ERR(root))
-		return NULL;
-	return landlock_find_in_tree(root, id.key);
-}
-
 typedef access_mask_t
 get_dom_access_mask_t(const struct landlock_domain *const domain,
 		      const u16 layer_level);
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 418d18869916..517600b66d54 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -27,7 +27,7 @@ struct landlock_hierarchy;
  */
 struct landlock_layer {
 	/**
-	 * @level: Position of this layer in the layer stack.
+	 * @level: Position of this layer in the layer stack.  Starts from 1.
 	 */
 	u16 level;
 	/**
@@ -204,10 +204,6 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
 
-struct landlock_ruleset *
-landlock_merge_ruleset(struct landlock_ruleset *const parent,
-		       struct landlock_ruleset *const ruleset);
-
 static inline struct landlock_rule *
 landlock_find_in_tree(const struct rb_root *const root,
 		      const union landlock_key key)
@@ -228,10 +224,6 @@ landlock_find_in_tree(const struct rb_root *const root,
 	return NULL;
 }
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id);
-
 static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset)
-- 
2.49.0

