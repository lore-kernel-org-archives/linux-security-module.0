Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409FC28F52E
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856092; cv=none; b=n3xaMnIM1XPAg4bBgrtORuSOGo7EdtuPUPPXsEBbfNfIUGIBxdHdAsWPtW7Hw+CnUNc/ODmf+eUQ2p9RI/wsR/Fqj2C3f/r/BKS4wX9wNrluBSgJp5ATmZD0EXjZc4UpAm473TUn/LVO7iD+19jhPGt+J5aO9HfOe/iOwUXODo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856092; c=relaxed/simple;
	bh=YQoti8Gi3R48h7AYclMLc+RKs3wDxQAclFEVH6SaewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r11FP4CzFu5uw1tB+KHWicKlfvYbATiB6yGg7C3kS2iXTCrMLqC+uqROv2nRJo4jKQzZlCZA4acBc+dqCETpaoVhprwgdug6G3yjqT/KMDDFVuCOhNdtHPld3S4MYiG7bco3wNMch6lXg7KRjliMF4m6DNXsVI0evcgxgaiq4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ZAXrR2Yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LM6BiPeX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ZAXrR2Yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM6BiPeX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 341581140131;
	Wed, 21 May 2025 15:34:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 15:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747856088; x=
	1747942488; bh=bf0WZdGoAHD3ADn2pNADGVkO2uRMJK1vYGxmAdQTqdc=; b=Z
	AXrR2YrpK0ZShplSKQLNDfwOavNAYNxPLymZSxMC3ft1bEAkAaNnV+511U8uFOJA
	aC8WFMKTzmNswHB1wVrRZdloCd9YWLNis4LQfxeCiaJnUifEW7hbgKEmqYzWL0tr
	WWKmBfJq8hdOsB1BPgiJ7b7yzXGtHWyUmpE/gD2V5GHa4vA8ab/uDRsp/pLq9f+3
	DnsNImhsgvoSb82m6vJqgvElkE+cqF+l12UvYudvMKrWVx5R0+XcFgw5wPg1sawP
	bjr6F/1eD34JJfpgA2EeUhmba9IOTpZqcF9xAZehOG7IxralFIh4BiNNR228A/sp
	682SfqAnLZ+2cgAEExI9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747856088; x=1747942488; bh=b
	f0WZdGoAHD3ADn2pNADGVkO2uRMJK1vYGxmAdQTqdc=; b=LM6BiPeXGmX6W3txU
	VnYUBogZ1a8MfOpntPNpdU5NHsteXnRytBI6qzAOTtbB7MRG3tljK95X1cnwMZMC
	qEaafEIZdVCnUAmtU8x7/DOXJo0D++LKtjFTppWbtJD2DlaS/i59fqgAu6T8e7My
	ZyIsyaIPmmJA1SyhYnwcvBWAsDQpEZrB8wgjlQdFxNI5vGWAqPshdcVj2YLq5TOk
	Df99QIxFwUq5abiOMGQd1950iQ0AG85vapSWau5CfAZk42xP9n7efMLKF84ipPav
	My9xUJSpoE3cKGZqhFo91HK9F4XhDGQ4UbpcyjwA/CmT3b/QB7XEwQB899Yvdwqq
	WJieQ==
X-ME-Sender: <xms:1youaHJB5XVYiwEUBbF2KZDPTOmcrk-4jLArpL0fVNMmDwNxbFXFhg>
    <xme:1youaLJld6QM7p61dQr2jLuKiHO4IlhAAhi5MR7HVaZ6IJ4B0T_hn-i_gDy6K7qzx
    OpqWOQZ3hBM__WJS4w>
X-ME-Received: <xmr:1youaPuQrF8c9abDiiZgfa_nWEcaYkw_PmmbKXLPjT3bq4HsmlPzDZjvkT8GzaxZ365gRVFeQ2L9NXqeL9zDC_6T1hcYEYJbnP1REymC_bcsjWd4UU4_Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmh
    grohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddv
    teefffegteetueegueeljeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurh
    hithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2CouaAapAl1y6CJ5BMWzUyU_i_2wjcqvBsatOz58t_EoLCqXy_108Q>
    <xmx:2CouaOYfyT_kmrWEJRm7xk0nE0J3RO85zoIIV7FHV0Ebfb7VtiYE4Q>
    <xmx:2CouaEDVOTiCmx7pleCCMysNeIe0tmbGOh2zQxO55EbK5CM8Hj9TKQ>
    <xmx:2CouaMbd1G_qPZW5QyfWldi0aRqLWvxjf4kGWscAtm2Gg4dIBtMlIQ>
    <xmx:2CouaH5poleQ1MG4op5eCVx5DnQDkStuCazrr9u4zFPXFFx4PHL9oLkB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:47 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 04/10] landlock/ruleset: Rename and extract create_rule
Date: Wed, 21 May 2025 20:32:00 +0100
Message-ID: <87c105bd4b8f02f485ae1c1490ce63179fee4739.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be used in domain.h in a later patch

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.c | 80 +------------------------------------
 security/landlock/ruleset.h | 77 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea51..37f25f8f27f2 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -77,71 +77,6 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 	return new_ruleset;
 }
 
-static void build_check_rule(void)
-{
-	const struct landlock_rule rule = {
-		.num_layers = ~0,
-	};
-
-	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
-}
-
-static bool is_object_pointer(const enum landlock_key_type key_type)
-{
-	switch (key_type) {
-	case LANDLOCK_KEY_INODE:
-		return true;
-
-#if IS_ENABLED(CONFIG_INET)
-	case LANDLOCK_KEY_NET_PORT:
-		return false;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	default:
-		WARN_ON_ONCE(1);
-		return false;
-	}
-}
-
-static struct landlock_rule *
-create_rule(const struct landlock_id id,
-	    const struct landlock_layer (*const layers)[], const u32 num_layers,
-	    const struct landlock_layer *const new_layer)
-{
-	struct landlock_rule *new_rule;
-	u32 new_num_layers;
-
-	build_check_rule();
-	if (new_layer) {
-		/* Should already be checked by landlock_merge_ruleset(). */
-		if (WARN_ON_ONCE(num_layers >= LANDLOCK_MAX_NUM_LAYERS))
-			return ERR_PTR(-E2BIG);
-		new_num_layers = num_layers + 1;
-	} else {
-		new_num_layers = num_layers;
-	}
-	new_rule = kzalloc(struct_size(new_rule, layers, new_num_layers),
-			   GFP_KERNEL_ACCOUNT);
-	if (!new_rule)
-		return ERR_PTR(-ENOMEM);
-	RB_CLEAR_NODE(&new_rule->node);
-	if (is_object_pointer(id.type)) {
-		/* This should have been caught by insert_rule(). */
-		WARN_ON_ONCE(!id.key.object);
-		landlock_get_object(id.key.object);
-	}
-
-	new_rule->key = id.key;
-	new_rule->num_layers = new_num_layers;
-	/* Copies the original layer stack. */
-	memcpy(new_rule->layers, layers,
-	       flex_array_size(new_rule, layers, num_layers));
-	if (new_layer)
-		/* Adds a copy of @new_layer on the layer stack. */
-		new_rule->layers[new_rule->num_layers - 1] = *new_layer;
-	return new_rule;
-}
-
 static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
 				const enum landlock_key_type key_type)
 {
@@ -160,17 +95,6 @@ static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
 	}
 }
 
-static void free_rule(struct landlock_rule *const rule,
-		      const enum landlock_key_type key_type)
-{
-	might_sleep();
-	if (!rule)
-		return;
-	if (is_object_pointer(key_type))
-		landlock_put_object(rule->key.object);
-	kfree(rule);
-}
-
 static void build_check_ruleset(void)
 {
 	const struct landlock_ruleset ruleset = {
@@ -261,7 +185,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		 * Intersects access rights when it is a merge between a
 		 * ruleset and a domain.
 		 */
-		new_rule = create_rule(id, &this->layers, this->num_layers,
+		new_rule = landlock_create_rule(id, &this->layers, this->num_layers,
 				       &(*layers)[0]);
 		if (IS_ERR(new_rule))
 			return PTR_ERR(new_rule);
@@ -274,7 +198,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 	build_check_ruleset();
 	if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
 		return -E2BIG;
-	new_rule = create_rule(id, layers, num_layers, NULL);
+	new_rule = landlock_create_rule(id, layers, num_layers, NULL);
 	if (IS_ERR(new_rule))
 		return PTR_ERR(new_rule);
 	rb_link_node(&new_rule->node, parent_node, walker_node);
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5da9a64f5af7..215578ad82f7 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -200,6 +200,83 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
 
+static void build_check_rule(void)
+{
+	const struct landlock_rule rule = {
+		.num_layers = ~0,
+	};
+
+	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+static bool is_object_pointer(const enum landlock_key_type key_type)
+{
+	switch (key_type) {
+	case LANDLOCK_KEY_INODE:
+		return true;
+
+#if IS_ENABLED(CONFIG_INET)
+	case LANDLOCK_KEY_NET_PORT:
+		return false;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
+
+static inline struct landlock_rule *
+landlock_create_rule(const struct landlock_id id,
+		     const struct landlock_layer (*const layers)[],
+		     const u32 num_layers,
+		     const struct landlock_layer *const new_layer)
+{
+	struct landlock_rule *new_rule;
+	u32 new_num_layers;
+
+	build_check_rule();
+	if (new_layer) {
+		/* Should already be checked by landlock_merge_ruleset(). */
+		if (WARN_ON_ONCE(num_layers >= LANDLOCK_MAX_NUM_LAYERS))
+			return ERR_PTR(-E2BIG);
+		new_num_layers = num_layers + 1;
+	} else {
+		new_num_layers = num_layers;
+	}
+	new_rule = kzalloc(struct_size(new_rule, layers, new_num_layers),
+			   GFP_KERNEL_ACCOUNT);
+	if (!new_rule)
+		return ERR_PTR(-ENOMEM);
+	RB_CLEAR_NODE(&new_rule->node);
+	if (is_object_pointer(id.type)) {
+		/* This should have been caught by insert_rule(). */
+		WARN_ON_ONCE(!id.key.object);
+		landlock_get_object(id.key.object);
+	}
+
+	new_rule->key = id.key;
+	new_rule->num_layers = new_num_layers;
+	/* Copies the original layer stack. */
+	memcpy(new_rule->layers, layers,
+	       flex_array_size(new_rule, layers, num_layers));
+	if (new_layer)
+		/* Adds a copy of @new_layer on the layer stack. */
+		new_rule->layers[new_rule->num_layers - 1] = *new_layer;
+	return new_rule;
+}
+
+static inline void free_rule(struct landlock_rule *const rule,
+			     const enum landlock_key_type key_type)
+{
+	might_sleep();
+	if (!rule)
+		return;
+	if (is_object_pointer(key_type))
+		landlock_put_object(rule->key.object);
+	kfree(rule);
+}
+
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
-- 
2.49.0

