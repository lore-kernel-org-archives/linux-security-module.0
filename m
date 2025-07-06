Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BC4A3E
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815110; cv=none; b=VfCR9IF+aO+7uJ3JK4vI10s5wPHOXxqC4toQ6T+iCn3knqIuuYqpXSORYntKRE2hUt3rjqHAcTAOqDFZEdmTMwKfV5qTvNbq+G3YpDkyemyDQPLD3YyfPcJIxlebX+NsQ4tHA4YyS4XXmkoXbd1N2OjBtNpU/gPqS2EDKYFU3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815110; c=relaxed/simple;
	bh=+SuKGUc+A39OLSp3t2PPVRWUKWvP2o3Rk/hmWYCSMDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKZzp9KeSXfAjqmwVs0LT/GrBsl6urOIipGFVu6yr/x1PranwkxZAcOnrY8r1waPUutMpgSbnWfWWGitZCzh0S8540VRuRYmstCbi43zPSlVZav79eWH9WSmuFSaYXvCCqUF1gkqj1d/tcNASHas9kfVNfr6R8zggAom8HZJEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=e2YCdnEO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYycgjRq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="e2YCdnEO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYycgjRq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CA191D000E7;
	Sun,  6 Jul 2025 11:18:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751815107;
	 x=1751901507; bh=yyR3cfGpnyxrijxSheYyR6Ft61RJWdKONZEUC5/wa6I=; b=
	e2YCdnEOMNz4yyzN1TDFpv77m2dfpS4sZNXLDpEL8INhknySKK2H+F/VS+GqWKsh
	c7d/hYmXhF7f+txDaccfvBfqeSyvepBhcLSKW7R/qgFQXtLuUNTwI8clrNz+5xy8
	Qs/tzYLg0xRhmPRUtn9+yevKKasnWflvX+i0nViVva/X9vnH9rClE7sDT93Vp4ZV
	LmmW8pjZoD/760cjxTYTqK7dcv+Rbyk4q0VXwhu/22OW2dOivkfr8eJ6NFAYShAp
	QwBgWZj17X1tdlhmSgFVL3ZSi8b5B4RXKXtN0c1/zBVvbfSZ/O5+KO4sY5WeEIGE
	4xV4TImYXQgMyCRnsRVG0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751815107; x=
	1751901507; bh=yyR3cfGpnyxrijxSheYyR6Ft61RJWdKONZEUC5/wa6I=; b=K
	YycgjRquF4D2gFIR+9hbZy5lRJlfFMiZQVzCzzp0wDOom3OmXql4jfVbU5j6xbIE
	g+luvHHE/Xd9vjmly3VR72PLq3vhBvRMaRtopbZzsR0fQA+CPsOlH7HeqcHEbd69
	3Vo0t8J2RjlecLgFk8fBBhvTM2ty79F7+pTdw6hzwl30/k6SSKqTjSq7UZcbjUUw
	inio5JmP3r0CAps+B6kHeHWjPDfldOmZuKVTESQzCKmNHYZBnBrYLf0Jwn3MeQql
	PkkUtJOY/nz65L1SSOh4I3eyYMpDvRkpHMkr3UKi3uRgNh4b2nTkzFBUi3iyRwMf
	UAw5ONCaHjfvgFzd9MExg==
X-ME-Sender: <xms:w5NqaIl6t_Wt_QYWNpYDTy9WckyrbfO72XTCpYhCFuH4E21skJAQNg>
    <xme:w5NqaH1eeIOhlUN64bvJqzKbtl8cGJTcu4eEV2XA_g04iMILcekhLzvuJj8vStPa7
    30jqz9U2pbI5rG_X2w>
X-ME-Received: <xmr:w5NqaGrhwJf1py-04mNb7l5NUAgFtuZXlkJRz7e0KoykLBsEypxuhaui86IOAiyLLdemmY2wmW-4kbb-9mj_7sooutCIZ8l-Yr37HeKeLLlreFci3529>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedvff
    fhteelhffghefgieegkeejjeffteeuveehudefveegveeuffelheeuhfduueenucffohhm
    rghinhepkhgvhidruggrthgrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehmsehm
    rghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhvrdhm
    ihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhope
    hjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:w5NqaEmiQOb2jBKhLp_Sp7owgcyFkCbzJ67RCD6Yrl-Ew5dCz00Jjw>
    <xmx:w5NqaG1z4kD_77wn4TnpNc3BDkmiGP_m1aHfYePF1yK8_yZgCaVKjQ>
    <xmx:w5NqaLuvgYN8Tdcht7q0o-nYoLi8Pshg8svQKr3k21f49LxcM53Dhw>
    <xmx:w5NqaCVmGx-_p7NUmwEQyo6ouwhrVSyghtqIt8dlGntsH-O_1lbYbQ>
    <xmx:w5NqaC4hi4R0_Sg4nM66KITyPZA6fk3o6BmSVRI_DvQBw4c5Kkch23DQ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:26 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 06/12] landlock/domain: Implement merging of a parent domain and a ruleset
Date: Sun,  6 Jul 2025 16:16:47 +0100
Message-ID: <2d13e11a0a9ec20e424dbdafca9f288102877ce0.1751814658.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This implements a 3-stage merge, generic over the type of rules (so that
it can be repeated for fs and net).  It contains a small refactor to
re-use the rbtree search code in ruleset.c.

3 passes are needed because, aside from calculating the size of the arrays
to allocate, we also need to first populate the index table before we can
write out the layers sequentially, as the index will not be written
in-order.  Doing it this way means that one rule's layers ends where the
next rule's layers start.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/domain.c  | 218 +++++++++++++++++++++++++++++++++++-
 security/landlock/ruleset.c |  16 +--
 security/landlock/ruleset.h |  20 ++++
 3 files changed, 238 insertions(+), 16 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 83233bf3be6a..89d36736a59c 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -5,6 +5,7 @@
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
  * Copyright © 2024-2025 Microsoft Corporation
+ * Copyright © 2025      Tingmao Wang <m@maowtm.org>
  */
 
 #include <kunit/test.h>
@@ -24,7 +25,7 @@
 #include "domain.h"
 #include "id.h"
 
-static void __maybe_unused build_check_domain(void)
+static void build_check_domain(void)
 {
 	BUILD_BUG_ON(LANDLOCK_MAX_NUM_RULES >= U32_MAX - 1);
 	/* Non-inclusive end indices are involved, so needs to be U32_MAX - 1. */
@@ -32,6 +33,221 @@ static void __maybe_unused build_check_domain(void)
 		     U32_MAX - 1);
 }
 
+/**
+ * dom_calculate_merged_sizes - Calculate the eventual size of the part of
+ * a new domain for a given rule size (i.e. either fs or net).  Correct
+ * usage requires the caller to hold the ruleset lock throughout the
+ * merge.  Returns -E2BIG if limits would be exceeded.
+ *
+ * @dom_ind_array: The index table in the parent domain for the relevant
+ * rule type.  Can be NULL if there is no parent domain.
+ * @dom_num_indices: The length of @dom_ind_array, or 0 if no parent
+ * domain.
+ * @dom_num_layers: The total number of distinct layer objects in the
+ * parent domain for the relevant rule type.
+ * @child_rules: The root of the rules tree to be merged.
+ * @out_num_indices: Outputs the number of indices that would be needed in
+ * the new domain.
+ * @out_num_layers: Outputs the number of layer objects that would be
+ * needed in the new domain.
+ */
+static int __maybe_unused dom_calculate_merged_sizes(
+	const struct landlock_domain_index *const dom_ind_array,
+	const u32 dom_num_indices, const u32 dom_num_layers,
+	const struct rb_root *const child_rules, u32 *const out_num_indices,
+	u32 *const out_num_layers)
+{
+	u32 num_indices = dom_num_indices;
+	u32 num_layers = dom_num_layers;
+	const struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_domain_index find_key;
+	const struct landlock_domain_index *found;
+
+	build_check_domain();
+
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+					     child_rules, node) {
+		found = NULL;
+		if (dom_ind_array) {
+			find_key.key = walker_rule->key;
+			found = dom_hash_find(dom_ind_array, dom_num_indices,
+					      &find_key);
+		}
+		/* A new index is only needed if this is a non-overlapping new rule */
+		if (!found) {
+			if (num_indices >= LANDLOCK_MAX_NUM_RULES)
+				return -E2BIG;
+			num_indices++;
+		}
+
+		/* Regardless, we have a new layer. */
+		if (WARN_ON_ONCE(num_layers >= U32_MAX - 1))
+			/*
+			 * This situation should not be possible with the proper rule
+			 * number limit.
+			 */
+			return -E2BIG;
+		num_layers++;
+	}
+
+	*out_num_indices = num_indices;
+	*out_num_layers = num_layers;
+	return 0;
+}
+
+/**
+ * dom_populate_indices - Populate the index table of a new domain.
+ *
+ * @dom_ind_array: The index table in the parent domain for the relevant
+ * rule type.  Can be NULL if there is no parent domain.
+ * @dom_num_indices: The length of @dom_ind_array, or 0 if no parent
+ * domain.
+ * @child_rules: The root of the rules tree to be merged.
+ * @out_indices: The output indices array to be populated.
+ * @out_size: The size of @out_indices, in number of elements.
+ */
+static int __maybe_unused dom_populate_indices(
+	const struct landlock_domain_index *const dom_ind_array,
+	const u32 dom_num_indices, const struct rb_root *const child_rules,
+	struct landlock_domain_index *const out_indices, const u32 out_size)
+{
+	u32 indices_written = 0;
+	const struct landlock_domain_index *walker_index;
+	struct landlock_domain_index target = {};
+	const struct landlock_rule *walker_rule, *next_rule;
+	const struct landlock_domain_index *found;
+	struct h_insert_scratch scratch;
+	int ret;
+	size_t i;
+
+	dom_hash_initialize(out_indices, out_size);
+	for (i = 0; i < out_size; i++) {
+		out_indices[i].key.data = 0;
+		out_indices[i].layer_index = U32_MAX;
+	}
+
+	ret = h_init_insert_scratch(&scratch, out_indices, out_size,
+				    sizeof(*out_indices));
+	if (ret)
+		return ret;
+
+	/* Copy over all parent indices directly */
+	for (size_t i = 0; i < dom_num_indices; i++) {
+		walker_index = &dom_ind_array[i];
+		if (WARN_ON_ONCE(indices_written >= out_size)) {
+			ret = -E2BIG;
+			goto out_free;
+		}
+		/* Don't copy over layer_index */
+		target.key = walker_index->key;
+		dom_hash_insert(&scratch, &target);
+		indices_written++;
+	}
+
+	/* Copy over new child rules */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+					     child_rules, node) {
+		target.key = walker_rule->key;
+		found = NULL;
+		if (dom_ind_array)
+			found = dom_hash_find(dom_ind_array, dom_num_indices,
+					      &target);
+		if (!found) {
+			if (WARN_ON_ONCE(indices_written >= out_size)) {
+				ret = -E2BIG;
+				goto out_free;
+			}
+			dom_hash_insert(&scratch, &target);
+			indices_written++;
+		}
+	}
+
+out_free:
+	h_free_insert_scratch(&scratch);
+
+	if (ret)
+		return ret;
+
+	for (i = 0; i < out_size; i++) {
+		walker_index = &out_indices[i];
+		/* We are not supposed to leave empty slots behind. */
+		WARN_ON_ONCE(dom_index_is_empty(walker_index));
+	}
+
+	return 0;
+}
+
+/**
+ * dom_populate_layers - Populate the layer array of a new domain.
+ *
+ * @dom_ind_array: The index table in the parent domain for the relevant
+ * rule type.  Can be NULL if there is no parent domain.
+ * @dom_num_indices: The length of @dom_ind_array, or 0 if no parent
+ * domain.
+ * @dom_layer_array: The layer array in the parent domain for the relevant
+ * rule type.  Can be NULL if there is no parent domain.
+ * @dom_num_layers: The length of @dom_layer_array, or 0 if no parent
+ * domain.
+ * @child_rules: The root of the rules tree to be merged.
+ * @child_indices: The already populated index table in the child ruleset
+ * to be merged.  This function will set the layer_index field on each
+ * indices.
+ * @child_indices_size: The size of @child_indices, in number of elements.
+ * @new_level: The level number of any new layers that will be added to
+ * @out_layers.
+ * @out_layers: The output layers array to be populated.
+ * @out_size: The size of @out_layers, in number of elements.
+ */
+static int
+dom_populate_layers(const struct landlock_domain_index *const dom_ind_array,
+		    const u32 dom_num_indices,
+		    const struct landlock_layer *const dom_layer_array,
+		    const u32 dom_num_layers,
+		    const struct rb_root *const child_rules,
+		    struct landlock_domain_index *const child_indices,
+		    const u32 child_indices_size, const u32 new_level,
+		    struct landlock_layer *const out_layers, const u32 out_size)
+{
+	u32 layers_written = 0;
+	struct landlock_domain_index *merged_index;
+	struct landlock_found_rule found_in_parent;
+	const struct landlock_rule *found_in_child;
+	const struct landlock_layer *layer;
+	struct landlock_layer child_layer;
+
+	for (size_t i = 0; i < child_indices_size; i++) {
+		merged_index = &child_indices[i];
+		merged_index->layer_index = layers_written;
+
+		found_in_parent.layers_start = NULL;
+		found_in_parent.layers_end = NULL;
+		if (dom_ind_array)
+			found_in_parent = landlock_domain_find(
+				dom_ind_array, dom_num_indices, dom_layer_array,
+				dom_num_layers, merged_index->key);
+		dom_rule_for_each_layer(found_in_parent, layer)
+		{
+			if (WARN_ON_ONCE(layers_written >= out_size))
+				return -E2BIG;
+			out_layers[layers_written++] = *layer;
+		}
+
+		found_in_child =
+			landlock_find_in_tree(child_rules, merged_index->key);
+		if (found_in_child) {
+			if (WARN_ON_ONCE(layers_written >= out_size))
+				return -E2BIG;
+			if (WARN_ON_ONCE(found_in_child->num_layers != 1))
+				return -EINVAL;
+			child_layer.access = found_in_child->layers[0].access;
+			child_layer.level = new_level;
+			out_layers[layers_written++] = child_layer;
+		}
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea51..12fcea6a2a99 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -584,25 +584,11 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id)
 {
 	const struct rb_root *root;
-	const struct rb_node *node;
 
 	root = get_root((struct landlock_ruleset *)ruleset, id.type);
 	if (IS_ERR(root))
 		return NULL;
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
+	return landlock_find_in_tree(root, id.key);
 }
 
 /*
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5da9a64f5af7..e45abff968c5 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -208,6 +208,26 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
+static inline struct landlock_rule *
+landlock_find_in_tree(const struct rb_root *const root,
+		      const union landlock_key key)
+{
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		struct landlock_rule *this =
+			rb_entry(node, struct landlock_rule, node);
+
+		if (this->key.data == key.data)
+			return this;
+		if (this->key.data < key.data)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
+
 const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id);
-- 
2.49.0

