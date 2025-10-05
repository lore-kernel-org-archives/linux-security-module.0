Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE433985
	for <linux-security-module@vger.kernel.org>; Sun,  5 Oct 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686995; cv=none; b=uuE1wue8gskA+Az9WpoA2qd4ed6LTUljj0SUhyCglE3Kh5E6ekPMt7jdJtjypuIsWZpmMM6Mqk5+xA/6CFSiHB7xLNvv5pLCtWS80OIe0UBleHxmvmRwT0vCxc5IFFsQjg7ScEAXR63rB/6OekJ5QEwKpH+xugstag3agwcU7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686995; c=relaxed/simple;
	bh=CcSOZD3FT8VRSVJCHJDbFVQiripbLP4vlxziLMXYo84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StESBJhFrdboGghTYoP3ZKd7VMnueKTXHWIq9lE1pf1g/B10/9L31XrJe4yAzSam4cpVHPQq3ZEEMPGQ1Fk4g5GrsJO0jGYbij91ReNuNaKbDS6AdkvY3NMetfjr0IXyi39OWthsQuW6Idcy4f5Cuol71P/AwYdwHmVS0mZwlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PaOdS53R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGrol9zJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PaOdS53R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGrol9zJ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 74DAC1D0001B;
	Sun,  5 Oct 2025 13:56:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 05 Oct 2025 13:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1759686991; x=
	1759773391; bh=gzlhBzZk548Y+An/VjJGOXevwBU0OjwZwpN9LsMbGoc=; b=P
	aOdS53RVzcnvg3TG1FgouxPt9U8R+XjQ0LT9NGmeJfaNRStJAsgnoggUmPsoFFoX
	q6aXeeS9sqfpEw/4MFgb00j9zgCW9HNMukTJUpKfq5kltagqEOiEpauNykwe5Sk8
	nVVpXMiF2P3praM64/1rwXZCXRfboSVJmEAfifdL8yUMN8hPGO2Il2vxrQNVgQQd
	LdVvoSUlR/WMTSph5A9PhjE7KvX2aBtWwVgjGC2++J6aJa6jkO7maeHMxaytJZcS
	TOBFQIH55x3I6mmth9uN+EFddljAFv3fpO2mXjL1d6xWLA4YootHjRNuF3ABueiZ
	vZGqkSTnpNSkZEk9En2Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759686991; x=1759773391; bh=g
	zlhBzZk548Y+An/VjJGOXevwBU0OjwZwpN9LsMbGoc=; b=TGrol9zJoh5rHZTyh
	dUr+U6L3Llv8sFjpxOaOEmmKlNXp7kp2oavcOSGtKIXOYP2p4kqANdLqKfbWGmdF
	gKSOmy5BX96nmnlY0tPg/5EwdoWi+sHzaEhyblcvXZ/jsVUBdelQ29v+taJSP7z3
	qaMr7sMHTQU/mDauaJ4A+2K688nTuauFINvqyuEuHo/espnTBJCjW3J1va0aRqVR
	8yg15pD4N7aGXC+sAo06ANhjdMfrgUnGfQzuN09ygjqEJN5L1n+f2/mTwD0QF23T
	ngXkg+hqgbJSJfFc8oSARJToK6V/BxHdVSsKEBLE8FkD+wYveSfNez5AVGwSZ9Ji
	RnQfQ==
X-ME-Sender: <xms:TrHiaDvI8tkYDe6yNc7ci6215DFRnZPgr3LPILBpx930uphvtVEXzQ>
    <xme:TrHiaLUp1ceTAgUBvPWuqA8rk5qKpz1GpcxmAnw7d9jNNAz5Pb7NwRqeLaLZcnaWN
    kYZAKkhD1kWcmWriQ9WVmgPly25V87iVq-5sf3GWiDklhvcm3xxwA>
X-ME-Received: <xmr:TrHiaPHyKaUlH3X-PY-lydCvh5KaaH_PKYk55RxwD8mSzHJdS9JpqW_LxKiPWaQP3gj6b-Qc5i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheefudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:TrHiaN0g7nwLW5uKB746EqlwGz43t1oJfXqV_EJMvqfj2Hv-00FoTA>
    <xmx:TrHiaBNJvElSu_NfjUOBBrPPRdok-cIpXnrMdxRNfq3DWJfT07H1Pg>
    <xmx:TrHiaM6IUmqzNHskwKcwPP1v2NiodIM2gmEY9EglBIkeCGgIVXuVSg>
    <xmx:TrHiaL2bLoRca5v8HGdDV4F1KJL5nOT9rzRh_FY6fWF2JlNue604kw>
    <xmx:T7HiaP_92oEIx3r08Yt-55i9keiqptXsb-XRHZuwcLtpH-tbaI07Wak9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 13:56:29 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/6] landlock: Add a place for flags to layer rules
Date: Sun,  5 Oct 2025 18:55:24 +0100
Message-ID: <feccc42da1c32b81e07ccd7387564d4bba8a06c1.1759686613.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759686613.git.m@maowtm.org>
References: <cover.1759686613.git.m@maowtm.org>
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

Note: conflict with 9a868cdbe6 ("landlock: Fix handling of disconnected
directories") on mic/next but is not hard to fix - need to backup the
collected rule flags too.

Changes since v1:
- Comment changes

 security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.c |  9 ++++-
 security/landlock/ruleset.h | 26 ++++++++++++-
 4 files changed, 82 insertions(+), 31 deletions(-)

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
index 5da9a64f5af7..eeee287a9508 100644
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
+		 * this rule in this domain.  For filesystem rules, this inherits
+		 * down the file hierarchy.
+		 */
+		bool quiet:1;
+	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
 	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
@@ -37,6 +48,16 @@ struct landlock_layer {
 	access_mask_t access;
 };
 
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
@@ -304,7 +325,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
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
