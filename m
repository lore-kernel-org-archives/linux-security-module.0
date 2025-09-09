Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D8381BA
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376419; cv=none; b=dQrhl2ioUjer/fW0s349mFsQdRocJvsH3IETeGQQay4EvKJOZr1VZu2fXx3XdTOeUTO1I/0ACGCFV27iJg1PZ7U3PzCCq2bi7rZrbAQf6Ym2eFxBGqiWe06Xd3AuRBdhwB9JIEak8CbtuFZHkTr7uAvytMv6gDKjPfaI3z0BVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376419; c=relaxed/simple;
	bh=t5dIvc89xPokf+xuM1mUbUDcw0gVJm2o/gxJAPUrtmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8iH0S2w0eFIJq3jeELiLrMFf3vgaHg9Rr6JGpFI70XxGlcW1SrWq7O3QEyu1v28USzoJxgxh0CBbN1FbX4664nEC5UgfgY3dsIAIiwBkRs7p5gBD7SVbH/WGFUwOqTXQ5RRVw6whDzfvTkrArOJvNVIUDPk6wuEJYBSNTx+6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=E36ymfSo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNYEWIw1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="E36ymfSo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNYEWIw1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 230591D00188;
	Mon,  8 Sep 2025 20:06:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 20:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376415; x=
	1757462815; bh=rO+bM9yKNYUsVTysYTAqt0LhJa2QYHwnWYa06z7wOFo=; b=E
	36ymfSo6rUSpq9MRwksjlJZ7oHm5EWbc2wlzGbFE6IKS7imi2Q4kKi6fns/VDQ5v
	BMIYgpK7S/clb/T3fvHxNMlHH/EJr/1DILehUJutuo5DfbL/d2Tj91oKM62HcUuK
	eJwClH8kW3OMWtyVKO/RFxEZSBQYgBZyHMx0Rd25UTt3X1RRo4Hl7rfSWntlDZoO
	gp9b6lf0M7rTz/g1pCY0HnEvKkE9YfKoUv61lXGtTD81s8QITD84TxvyDI1Knd11
	tWVQbDfBsSZ5t4CdsyTmcke4W1A2+HbxqBXr9zy+1VDYfMdkjkOCgwfkDVrQLzU+
	ALNCmKBsuxhdxfSJHzmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376415; x=1757462815; bh=r
	O+bM9yKNYUsVTysYTAqt0LhJa2QYHwnWYa06z7wOFo=; b=bNYEWIw1nObK6E9en
	SLYOsGjipQXEiViJDlFOCLTyRooN6pBzBjKVjh1PJfhL0V77i1oTDRrCkHWXb8CB
	EZNrNZoBYUE4HjgJOOjNU8TR1FVlSnLV02g6Qjsl19yYwjnFEI+Zv/XTfcC7maju
	NPR7oVscbOiqW0W86C86HxP5yuyZnnkhCvKjwBYyFAmoabhyhzG2QK27M9zUyLe4
	2T0q17/XBEvU1V91rFMv85S9Uj6mni4zsq5ROD02aVmAPkc3kR4WHAd28l2EvXPY
	Md6evQIfOGF2nu2P0/ZYygufbJWcA5xuTPochN//I960FWh+bBsVRCTdlCMrrYn9
	qGRrg==
X-ME-Sender: <xms:n2-_aHC-tlCRXEFYmz3E4O2gbsN3wcTh0vi7skDqkMB0ZYjCKzXPsg>
    <xme:n2-_aJBIOt-MSy0R7QBC_voWg5QqtPSpK3Sssfpwwtknf17cifpneGmnQWgMIP6oK
    NoyG0usffmWXaLIFTs>
X-ME-Received: <xmr:n2-_aJBvY7N2nO4z8Cc8jfZxbGsk1vJqLhn7TKnngSMVmTLVVAT4IAA1UW26xnGSwJQc_DP8_SRyKaMQLPM20hu8ix_N0E-URz4xsOuZDHGs7eaTKuvkrxH0qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n2-_aEqdZ6VnDbNTNZuLGcULuHzPpf0avh_7zbYa1ue6NvuRFB_LEQ>
    <xmx:n2-_aDnOorS9f0RkYow1cGTVpLC0AHjV5yLRx-MHy01j7i4z_N3SIg>
    <xmx:n2-_aExMXg9zIv33fQAsUFdt4hO46HACyFlTISVzHX5mGCQiZp156w>
    <xmx:n2-_aL8FNHlY8aqPxiT6nrlQ_Qm29TYuYMF4XdJhsvTteNbUWDOSgw>
    <xmx:n2-_aFvCENb6Xv05Y9zl_ei0jQS3OJXGEAd7RCu-B1qh53SV2kITcMMU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:06:54 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
Date: Tue,  9 Sep 2025 01:06:35 +0100
Message-ID: <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
References: <cover.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid unnecessarily increasing the size of struct landlock_layer, we
make the layer level a u8 and use the space to store the flags struct.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.c |  9 ++++-
 security/landlock/ruleset.h | 27 ++++++++++++-
 4 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c04f8879ad03..e7eaf55093e9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -756,10 +756,12 @@ static bool is_access_to_paths_allowed(
 	const struct path *const path,
 	const access_mask_t access_request_parent1,
 	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags_parent1,
 	struct landlock_request *const log_request_parent1,
 	struct dentry *const dentry_child1,
 	const access_mask_t access_request_parent2,
 	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags_parent2,
 	struct landlock_request *const log_request_parent2,
 	struct dentry *const dentry_child2)
 {
@@ -810,22 +812,30 @@ static bool is_access_to_paths_allowed(
 	}
 
 	if (unlikely(dentry_child1)) {
+		/*
+		 * The rule_flags for child1 should have been included in
+		 * rule_flags_masks_parent1 already.  We do not bother about it
+		 * for domain check.
+		 */
 		landlock_unmask_layers(
 			find_rule(domain, dentry_child1),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child1, LANDLOCK_KEY_INODE),
-			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1));
+			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1),
+			NULL);
 		layer_masks_child1 = &_layer_masks_child1;
 		child1_is_directory = d_is_dir(dentry_child1);
 	}
 	if (unlikely(dentry_child2)) {
+		/* See above comment for why NULL is passed as rule_flags_masks */
 		landlock_unmask_layers(
 			find_rule(domain, dentry_child2),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child2, LANDLOCK_KEY_INODE),
-			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2));
+			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2),
+			NULL);
 		layer_masks_child2 = &_layer_masks_child2;
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
@@ -881,16 +891,18 @@ static bool is_access_to_paths_allowed(
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
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
+		allowed_parent1 =
+			allowed_parent1 ||
+			landlock_unmask_layers(rule, access_masked_parent1,
+					       layer_masks_parent1,
+					       ARRAY_SIZE(*layer_masks_parent1),
+					       rule_flags_parent1);
+		allowed_parent2 =
+			allowed_parent2 ||
+			landlock_unmask_layers(rule, access_masked_parent2,
+					       layer_masks_parent2,
+					       ARRAY_SIZE(*layer_masks_parent2),
+					       rule_flags_parent2);
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -958,6 +970,7 @@ static int current_check_access_path(const struct path *const path,
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct collected_rule_flags rule_flags = {};
 	struct landlock_request request = {};
 
 	if (!subject)
@@ -967,8 +980,8 @@ static int current_check_access_path(const struct path *const path,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(subject->domain, path, access_request,
-				       &layer_masks, &request, NULL, 0, NULL,
-				       NULL, NULL))
+				       &layer_masks, &rule_flags, &request,
+				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request);
@@ -1032,7 +1045,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
 	const struct dentry *const mnt_root, struct dentry *dir,
-	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags)
 {
 	unsigned long access_dom;
 	bool ret = false;
@@ -1051,9 +1065,9 @@ static bool collect_domain_accesses(
 		struct dentry *parent_dentry;
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
-					   layer_masks_dom,
-					   ARRAY_SIZE(*layer_masks_dom))) {
+		if (landlock_unmask_layers(
+			    find_rule(domain, dir), access_dom, layer_masks_dom,
+			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
@@ -1140,6 +1154,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	struct dentry *old_parent;
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct collected_rule_flags rule_flags_parent1 = {},
+				    rule_flags_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
 	if (!subject)
@@ -1172,10 +1188,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			subject->domain,
 			access_request_parent1 | access_request_parent2,
 			&layer_masks_parent1, LANDLOCK_KEY_INODE);
-		if (is_access_to_paths_allowed(subject->domain, new_dir,
-					       access_request_parent1,
-					       &layer_masks_parent1, &request1,
-					       NULL, 0, NULL, NULL, NULL))
+		if (is_access_to_paths_allowed(
+			    subject->domain, new_dir, access_request_parent1,
+			    &layer_masks_parent1, &rule_flags_parent1,
+			    &request1, NULL, 0, NULL, NULL, NULL, NULL))
 			return 0;
 
 		landlock_log_denial(subject, &request1);
@@ -1201,10 +1217,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/* new_dir->dentry is equal to new_dentry->d_parent */
 	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						old_parent,
-						&layer_masks_parent1);
+						&layer_masks_parent1,
+						&rule_flags_parent1);
 	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						new_dir->dentry,
-						&layer_masks_parent2);
+						&layer_masks_parent2,
+						&rule_flags_parent2);
 
 	if (allow_parent1 && allow_parent2)
 		return 0;
@@ -1217,8 +1235,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 */
 	if (is_access_to_paths_allowed(
 		    subject->domain, &mnt_dir, access_request_parent1,
-		    &layer_masks_parent1, &request1, old_dentry,
-		    access_request_parent2, &layer_masks_parent2, &request2,
+		    &layer_masks_parent1, &rule_flags_parent1, &request1,
+		    old_dentry, access_request_parent2, &layer_masks_parent2,
+		    &rule_flags_parent2, &request2,
 		    exchange ? new_dentry : NULL))
 		return 0;
 
@@ -1616,6 +1635,7 @@ static bool is_device(const struct file *const file)
 static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct collected_rule_flags rule_flags = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_cred_security *const subject =
@@ -1647,7 +1667,8 @@ static int hook_file_open(struct file *const file)
 		    landlock_init_layer_masks(subject->domain,
 					      full_access_request, &layer_masks,
 					      LANDLOCK_KEY_INODE),
-		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
+		    &layer_masks, &rule_flags, &request, NULL, 0, NULL, NULL,
+		    NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
 		unsigned long access_bit;
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1f3915a90a80..fc6369dffa51 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -48,6 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
 {
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
+	struct collected_rule_flags rule_flags = {};
 	const struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
@@ -179,7 +180,7 @@ static int current_check_access_socket(struct socket *const sock,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
 	if (landlock_unmask_layers(rule, access_request, &layer_masks,
-				   ARRAY_SIZE(layer_masks)))
+				   ARRAY_SIZE(layer_masks), &rule_flags))
 		return 0;
 
 	audit_net.family = address->sa_family;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea51..3aa4e33ac95b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -616,7 +616,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size)
+			    const size_t masks_array_size,
+			    struct collected_rule_flags *const rule_flags)
 {
 	size_t layer_level;
 
@@ -643,6 +644,12 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		unsigned long access_bit;
 		bool is_empty;
 
+		if (rule_flags) {
+			/* Collect rule flags for each layer */
+			if (layer->flags.quiet)
+				rule_flags->quiet_masks |= layer_bit;
+		}
+
 		/*
 		 * Records in @layer_masks which layer grants access to each
 		 * requested access.
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5da9a64f5af7..d4b70b6af137 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -29,7 +29,18 @@ struct landlock_layer {
 	/**
 	 * @level: Position of this layer in the layer stack.
 	 */
-	u16 level;
+	u8 level;
+	/**
+	 * @flags: Bitfield for special flags attached to this rule.
+	 */
+	struct {
+		/**
+		 * @quiet: Suppresses denial audit logs for the object covered by
+		 * this rule in this domain.  For fs rules, this inherits down the
+		 * file hierarchy.
+		 */
+		bool quiet:1;
+	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
 	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
@@ -37,6 +48,17 @@ struct landlock_layer {
 	access_mask_t access;
 };
 
+
+/**
+ * struct collected_rule_flags - Hold accumulated flags for each layer
+ */
+struct collected_rule_flags {
+	/**
+	 * @quiet_masks: Layers for which the quiet flag is effective.
+	 */
+	layer_mask_t quiet_masks;
+};
+
 /**
  * union landlock_key - Key of a ruleset's red-black tree
  */
@@ -304,7 +326,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size);
+			    const size_t masks_array_size,
+			    struct collected_rule_flags *const rule_flags);
 
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-- 
2.51.0

