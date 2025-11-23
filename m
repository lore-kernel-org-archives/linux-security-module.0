Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309746BF
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931759; cv=none; b=bW+3gFoM3YBZAWoKHE6OqBVPgk7TBGXHakbXo3QAcjs8fU4tSEyjFYmsAurSbFBURmQ0cyF8sI5lC3MaYpXUrM+BxvOoKiP+wF0LShCsht7I31Cf91vRos1dn5AEBPuaYBv7iL9syb2BMTI3mjhskYbbA7w1foS+xvL7cVeKPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931759; c=relaxed/simple;
	bh=rJNWtwNmKMqSZCz2pOcztxpGfNDilgDA6TkNz4iLYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoVQwjGzqQLsI7l16SiDspMRsexxVIhQEMzfkDXcndcCo2u440XbCB1cYKU8Q/SZhhn5zSJvhitwW9CTiGmkMkpbj6uBswyDEkdMRNMixVGIB7XwTf/BEZCJ5wIJcKyLFFFOikvxVRAlNgAdKqDGCdTP2rNUap6I3RbqzMGSu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=FAhCBaZn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TeGSmGwp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="FAhCBaZn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TeGSmGwp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4220BEC01D7;
	Sun, 23 Nov 2025 16:02:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Nov 2025 16:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931756; x=
	1764018156; bh=cNEEhmtyHTKZ2oyQfnzzdyRiyg9FG56Amx5PhNPH1LU=; b=F
	AhCBaZntHSJCiVynpoE5t5yTflfAEyMaI1Ow79+9betw0IOmeaqtNxojRRlTMR5F
	YRAdQ7iEuQajA2YLkPao5V2mNXk3R0KojaK2lP/cdIviF2dT69p8GxFzbB6uV86c
	iy0ufL/OyXU7is2YOpWObxLE5rCUreXTCE3VS0ns0LpDTikFJzJxDFO4FFVr9jDe
	Hq2HwiS+Yd1Uo1yzBsDBOartTUs3fO5vohmn23tKS8zCTd5gb6cOgs4QqjfP0CEn
	lk9eUrvz/2RhKziMV9xoVNeU7Dpf6Ubiy+e63VmV2XgtDHBhIIVG7c1xqavc8B6+
	0/je51xmUbbN0tt0A1RTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931756; x=1764018156; bh=c
	NEEhmtyHTKZ2oyQfnzzdyRiyg9FG56Amx5PhNPH1LU=; b=TeGSmGwp/JUBzjzMT
	KfZNQ3dPebOWLO96ULDZioOcGnKvSGZMPSoNcFcDCUEKQVKOUsde/q8ctsptFbDv
	lDNtluq/AZ+Kx2OP2PEAY8adVlOP78wS/dHg7nQrJQ7TdLCSfT+lU7jDvD26VAZl
	6+tB6XcxXfx0B4+1y3tyYpVXE+BnWg6Z32KkPmYQ93akf9BynGiG4dnWUm6wFyY/
	bvQuQjXfznIfaXRGniiGRITdtsLmQ5fk3WVb/NqJrv+uuIByNJ7RsdWx6JW4rLGp
	T6dZNdso1tKU07TQdU3m92cbB7nMuC0AVGqZoaSC/EOnWzwJky67wcsMIOKFe4Fk
	q8r7A==
X-ME-Sender: <xms:a3YjaV0L84KrCVrj8tsw3CvBZglE1YXxUWsSecnEDkwfKqbiGN8tKw>
    <xme:a3YjaeVoOzzvKyMmkgrs_v6MFdluDyrWBcbwwcFs2nJ1i8VXUk2RIuZLZy_VzWm3N
    2q-J8NKxtqFVEp_V0OmNbSqFJNsbIMn-3_y-W8OUcmZEOPKYkI41zI>
X-ME-Received: <xmr:a3YjaYJD6TlR5X_H2qkau5TXQfZwc4KuizCjyGf5Ao2hXcTRt57BfyPSmW0qJ0yUAZW_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeihf
    dvvdfhvdfffeetveefheefgedtvdeufeegkeeiveehuddvgfffieelueekueenucffohhm
    rghinheptgholhhlvggtthgvuggprhhulhgvpghflhgrghhsrdhsvggtuhhrihhthienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrgho
    fihtmhdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofiht
    mhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a3YjaY34f8G0HPBJTJ4ZE7JufCetZC2Ml5IltFGEBsPkKe_w_zqfaw>
    <xmx:a3YjaW5WfAwDIXx9tWxCI7fu1d-0xrkY3KjFgsP7xVdvLu0c3_CS0w>
    <xmx:a3YjaZ8ATWq_GugOQPyeJsc61Wk6Legg8mzvx8YwhIjKbtMmAHCl1g>
    <xmx:a3YjaVV5xll4VZ5syxAeO17o_GIhRqMEa0ii8aLodjV2uPbd-Xs6MQ>
    <xmx:bHYjaZk6eoBv9tIPpX1RUl_0WSTkhLrj-XGl26u78_BQDcAIOdw1DJHy>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:33 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 01/10] landlock: Add a place for flags to layer rules
Date: Sun, 23 Nov 2025 20:57:37 +0000
Message-ID: <cebbc90d5a6bbfa38c6c6e4e770cb2eae399466e.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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
 security/landlock/fs.c      | 71 +++++++++++++++++++++++++++----------
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.c |  7 +++-
 security/landlock/ruleset.h | 26 ++++++++++++--
 5 files changed, 86 insertions(+), 23 deletions(-)

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
index b33d8ac239c1..58dba2f7c6cd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -775,6 +775,9 @@ static bool is_access_to_paths_allowed(
 		_layer_masks_parent2_bkp[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
+	struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
+	struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
+	struct collected_rule_flags _rule_flag_parent1_bkp, _rule_flag_parent2_bkp;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -800,6 +803,8 @@ static bool is_access_to_paths_allowed(
 		 */
 		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
 		       sizeof(_layer_masks_parent2_bkp));
+		memcpy(&_rule_flag_parent2_bkp, rule_flags_parent2,
+		       sizeof(_rule_flag_parent2_bkp));
 		allowed_parent2 = is_layer_masks_allowed(layer_masks_parent2);
 
 		/*
@@ -826,26 +831,38 @@ static bool is_access_to_paths_allowed(
 	 */
 	memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
 	       sizeof(_layer_masks_parent1_bkp));
+	memcpy(&_rule_flag_parent1_bkp, rule_flags_parent1,
+	       sizeof(_rule_flag_parent1_bkp));
 	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
 	is_dom_check_bkp = is_dom_check;
 
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
@@ -901,16 +918,18 @@ static bool is_access_to_paths_allowed(
 			       NULL :
 			       find_rule(domain, walker_path.dentry);
 
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
 		if (allowed_parent1 && allowed_parent2) {
@@ -947,10 +966,16 @@ static bool is_access_to_paths_allowed(
 				memcpy(&_layer_masks_parent1_bkp,
 				       layer_masks_parent1,
 				       sizeof(_layer_masks_parent1_bkp));
+				memcpy(&_rule_flag_parent1_bkp,
+				       rule_flags_parent1,
+				       sizeof(_rule_flag_parent1_bkp));
 				if (layer_masks_parent2) {
 					memcpy(&_layer_masks_parent2_bkp,
 					       layer_masks_parent2,
 					       sizeof(_layer_masks_parent2_bkp));
+					memcpy(&_rule_flag_parent2_bkp,
+					       rule_flags_parent2,
+					       sizeof(_rule_flag_parent2_bkp));
 					is_dom_check_bkp = is_dom_check;
 				}
 
@@ -999,11 +1024,15 @@ static bool is_access_to_paths_allowed(
 		 */
 		memcpy(layer_masks_parent1, &_layer_masks_parent1_bkp,
 		       sizeof(_layer_masks_parent1_bkp));
+		memcpy(rule_flags_parent1, &_rule_flag_parent1_bkp,
+		       sizeof(_rule_flag_parent1_bkp));
 		allowed_parent1 =
 			is_layer_masks_allowed(&_layer_masks_parent1_bkp);
 		if (layer_masks_parent2) {
 			memcpy(layer_masks_parent2, &_layer_masks_parent2_bkp,
 			       sizeof(_layer_masks_parent2_bkp));
+			memcpy(rule_flags_parent2, &_rule_flag_parent2_bkp,
+			       sizeof(_rule_flag_parent2_bkp));
 			allowed_parent2 = is_layer_masks_allowed(
 				&_layer_masks_parent2_bkp);
 
@@ -1139,7 +1168,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
 	const struct path *const mnt_dir, struct dentry *dir,
-	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags)
 {
 	access_mask_t access_dom;
 	bool ret = false;
@@ -1158,9 +1188,9 @@ static bool collect_domain_accesses(
 		struct dentry *parent_dentry;
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
-					   layer_masks_dom,
-					   ARRAY_SIZE(*layer_masks_dom))) {
+		if (landlock_unmask_layers(
+			    find_rule(domain, dir), access_dom, layer_masks_dom,
+			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
 			/*
 			 * Before allowing this side of the access request, checks that the
 			 * walk was not in a disconnected directory.
@@ -1327,11 +1357,14 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(
-		subject->domain, &mnt_dir, old_parent, &layer_masks_parent1);
+	allow_parent1 = collect_domain_accesses(subject->domain, &mnt_dir,
+						old_parent,
+						&layer_masks_parent1,
+						&request1.rule_flags);
 	allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
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
