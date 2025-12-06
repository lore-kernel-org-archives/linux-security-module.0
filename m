Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926F24679C
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041106; cv=none; b=N+c2j5OSCXmN2Hdk9cDjUKsQu5f51J0bD50X9+teE8MUKXQZ3netlDpQSougWzXqiIrWnitW0KiHEzz1oRJyH8ms5MghLXDcNztaRe0VutVzRfmghJGCP8cQ6uoOYyhtAZ+PHzT0HVGYlxUn7FxeXq8McprmKtz7ujRk7g/k68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041106; c=relaxed/simple;
	bh=5qLf95ZpJokrxM0y2Mgk25iXGXfUPRwNt2TvqW00HFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stxBeQBi6/7M+quQw0RO6JLsTszV6GoZ+A3P4nmgk+RO+gRVO8dPRz8X4W//brGmd91Y7m9EwF4RTG8gDzZ1fMJXr8m6Z/9qE4XG2axyTMlvIVSk3tZ+OazQxi8QUe/tZqcWV+yzMFBBO+TSI46xGZyhLGITgnvkuGddipSkBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KV1i6aJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDmGJ4R1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KV1i6aJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDmGJ4R1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECDA67A00EC;
	Sat,  6 Dec 2025 12:11:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 12:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765041102; x=
	1765127502; bh=MXtmdLnRNe5Fxcc2LzS62eBbj7ky/Xb34aZIhW4HQXM=; b=K
	V1i6aJ/cstAVj33kaRCrhL7hLwkjhYEAR7el8iwOv2cOQjLb8og8i1S1yu1uNqa/
	yFkPFnLkLuMArngRIwwQvufkn38tXpkN9zwzouL2PKO06/YoJKsUrBm65mUfJBQM
	qdewdPn8/mEGSntq3iWSmMrst9PT6deZ8Ct9CABIMetelTvIXn/CufP1Dsre3SEh
	KZPeGJVWN8zEx5zA2nSvUCu2dI616F30XTNUfowIqZb2pob/oqPI28bMlXM444g/
	psenCykvlp0STUMQ5RMoXVV0cVXeYRD1qG1JJZUmjROaOM9z79MswhIMtrXurObu
	ARXBMJqvcT0mo66LmJecg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765041102; x=1765127502; bh=M
	XtmdLnRNe5Fxcc2LzS62eBbj7ky/Xb34aZIhW4HQXM=; b=mDmGJ4R1nHLuHCkWC
	SYG9/nn5E56BTsFCaLk4lRsVQdJRwT30K0IGI33pq3qATsbxYJX0Dlf1hewr1G9+
	PsU8eNljUhe0soEt7cSldUTftsUgz930InE+K45C6wsbIRrcsQWfcWU9wZGaxKXR
	bERskiyWpozZ3dRV4iye/xDAAnvxhz0dcC4EDcNEHRDsE5lUDV7Il8olvJveoJq9
	Kh2H9kSHbEnQe5h4ey/d3o6F0a5pwWIOmEm9JJgdJwbeeDTsVfw5xHLVuu1aWtUy
	buNTWUQOTncCPJYvJzxrnwf7XlOFIW6B8DqujCxvywclTYEDun9iQ5fa13AQpuEM
	qFo2Q==
X-ME-Sender: <xms:zmM0aUavoSlZYJXeAYFWlPtaG9tE-2G5k6X60Mk2WghuXtm1soBNww>
    <xme:zmM0aRqJpkS6rwRezjrsmsMSb9FPl1pnfX7bvij_rjsXkBC-lFG2nfQH0NACR0nRE
    Lx8o2_C1JZSD5YjFFiEhmcRk2x_fGeFsEyg3xqJCruLp6YEcuoqc0M>
X-ME-Received: <xmr:zmM0aROYUbWV3mhkZs8YAGlXPnOqMoXiy-a_SzYLQ3qACnbIIqSs-bQ6rRnLdk2Jcmy69PIoXzNKX5St4cal_i5002bQvVEnrfHlBiSL8KVonUUt_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepiefhvd
    dvhfdvffefteevfeehfeegtddvueefgeekieevheduvdfgffeileeukeeunecuffhomhgr
    ihhnpegtohhllhgvtghtvggupghruhhlvggpfhhlrghgshdrshgvtghurhhithihnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohif
    thhmrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhm
    rdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgr
    tghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zmM0aUpAkrzsW4SaD2ucpMtek_-qQUrRaFVCwHDdZJfRGGyzC26htg>
    <xmx:zmM0aeev9GcJ-jbSsxy6ZrTfd5W-6WSdFQkMwh6a2HsAZw_eusrc6A>
    <xmx:zmM0aSTPeeYKsUiPcU6aU_OK_7_XMjT6qcHz5qWYb63Jy3Z5ZMPvag>
    <xmx:zmM0afblATOo2I-mopMj9k6_2C5l2v1lTBDI9HpBFPVr5opepyoiCw>
    <xmx:zmM0aT4Y0f00dQPC74TpR7u_t7xF5BhkdLYHOOznn2iKtUFsmxJW1QEB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:11:41 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 01/10] landlock: Add a place for flags to layer rules
Date: Sat,  6 Dec 2025 17:11:03 +0000
Message-ID: <2f76a3952d214e87cc7096ae5336ced5d72f9e04.1765040503.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765040503.git.m@maowtm.org>
References: <cover.1765040503.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid unnecessarily increasing the size of struct landlock_layer, we
make the layer level a u8 and use the space to store the flags struct.

Cc: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v6:
- Rebased to include the revised disconnected directory handling changes
  (without the "reverting" behaviour)

Changes in v5:
- Move rule_flags into landlock_request.  This lets us get rid of the
  extra parameters to is_access_to_paths_allowed (and later on,
  landlock_log_denial), and thus less code changes.

Changes in v3:
- Comment changes, move local variables, simplify if branch

Changes in v2:
- Comment changes
- Rebased to include disconnected directory handling changes on mic/next
  and add backing up of collected_rule_flags.

 security/landlock/audit.h   |  2 ++
 security/landlock/fs.c      | 53 ++++++++++++++++++++++++-------------
 security/landlock/net.c     |  3 ++-
 security/landlock/ruleset.c |  7 ++++-
 security/landlock/ruleset.h | 26 ++++++++++++++++--
 5 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d8..d66c6d936438 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -49,6 +49,8 @@ struct landlock_request {
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
 	deny_masks_t deny_masks;
+
+	struct collected_rule_flags rule_flags;
 };
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fadb54496a0..ce5fceb87657 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -772,6 +772,8 @@ static bool is_access_to_paths_allowed(
 		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
+	struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
+	struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -811,22 +813,32 @@ static bool is_access_to_paths_allowed(
 	}
 
 	if (unlikely(dentry_child1)) {
+		/*
+		 * Get the layer masks for the child dentries for use by domain
+		 * check later.  The rule_flags for child1 should have been
+		 * included in rule_flags_parent1 already (cf.
+		 * collect_domain_accesses), and is not relevant for domain check,
+		 * so we don't have to pass it to landlock_unmask_layers.
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
+		/* See above comment for why NULL is passed as rule_flags_masks. */
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
@@ -881,16 +893,18 @@ static bool is_access_to_paths_allowed(
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
@@ -1047,7 +1061,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
 	const struct dentry *const mnt_root, struct dentry *dir,
-	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags)
 {
 	unsigned long access_dom;
 	bool ret = false;
@@ -1066,9 +1081,9 @@ static bool collect_domain_accesses(
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
@@ -1219,10 +1234,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/* new_dir->dentry is equal to new_dentry->d_parent */
 	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						old_parent,
-						&layer_masks_parent1);
+						&layer_masks_parent1,
+						&request1.rule_flags);
 	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						new_dir->dentry,
-						&layer_masks_parent2);
+						&layer_masks_parent2,
+						&request2.rule_flags);
 
 	if (allow_parent1 && allow_parent2)
 		return 0;
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
index dfcdc19ea268..81cdf87d1c79 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -624,7 +624,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size)
+			    const size_t masks_array_size,
+			    struct collected_rule_flags *const rule_flags)
 {
 	size_t layer_level;
 
@@ -651,6 +652,10 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		unsigned long access_bit;
 		bool is_empty;
 
+		/* Collect rule flags for each layer. */
+		if (rule_flags && layer->flags.quiet)
+			rule_flags->quiet_masks |= layer_bit;
+
 		/*
 		 * Records in @layer_masks which layer grants access to each requested
 		 * access: bit cleared if the related layer grants access.
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1a78cba662b2..9790c60c0c00 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -29,7 +29,18 @@ struct landlock_layer {
 	/**
 	 * @level: Position of this layer in the layer stack.  Starts from 1.
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
+ * struct collected_rule_flags - Hold accumulated flags for each layer.
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
2.52.0
