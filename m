Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54426CE2D
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490812; cv=none; b=GIW2WAz5Nq0evU7HIB2yH6kq0XoNLH1swogJGmtwRhenHIpfX/PuCNeSeyrnQE75ovObvrJrGoX5SVs6mbsZky8AifcV/4vw2QG1vi3iQ5yeGaZbutb1vuXTy46ZozxYCcrVbQY1Lop9tQNtMBWlPJEGOjQV/+j4XUSKZogJk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490812; c=relaxed/simple;
	bh=Uz00Kijm6tmMcVt9JCuEgcSFnNEMZvFJS/xj098rbgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbtNBtFDWZ+eGr95UGxEroZ6GQx7zcWNxdIJcOmWG1j0Jlp+vF2Kn3fi0YFKvcaGhgiObdPh7RuLVY7wafRroi2eBwZ4KBTyjbK1o67nASzzU1TgRqG1Dt/pNvhlX1V3Hw9VRxhxnRMIdl78Xw3K6qbTgOnWGMmm2N2pEsYCyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Np6uzFPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQlfmPQS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Np6uzFPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQlfmPQS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E21BD7A0038;
	Mon,  6 Apr 2026 11:53:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490809; x=
	1775577209; bh=HCLky6kKIwAdLVfdEleTB/O6uQ1hVLL2dQb/UwDSg4g=; b=N
	p6uzFPBY3j48dREGNmGDNQDSO63+8cEL1HZqLPZe4IwCGmJLIDTyFtPqBxvA0rCW
	k45s/XGmgw3O+h0gXPIQINSWz0RPXEphAXY3N3NdnFOHZequz/peZw0Az2iJTsMU
	faR/erKXzQoBHXxk9GTN3lB8FgBm5mFzDq2OX9ilEFpQ/qDCUTj6Q2FAt0waSuRH
	pZ3yuXVJoJS55hiCd68MA1p0WL1f51Do99FaSK6LNkFUQwlPY9iW7asSPHKixh3h
	gcEr+EUTEltWERehDCULNpsIKM5Umj1aQyhjAWvLymbFKgXJBzShZHXt79BVnW/l
	kcbYgmYsmuES+cYEjv5pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490809; x=1775577209; bh=H
	CLky6kKIwAdLVfdEleTB/O6uQ1hVLL2dQb/UwDSg4g=; b=dQlfmPQS/DQlJ2aWC
	omcwxVIDmV5RR98dB0N3S75/Jzyl/cKGwi8GsMyLZ4bv/Kx7+ctcR4VoUaZTAgE5
	lYd/5M958v/PwzDM2qcGe1QL7zcszPDno8MXpR3qBlKMKYaDoDpBalEyKm4Mi4kN
	VSTh/3sFcEk0M8MMnWQrCQTvmZSJTDezQUKtu72HLxUalYSFZY6O75CFZcRVP/8E
	XqsZR0w6r9/HLI7Q3gvdUZ4sH3m0InLw9yNUwvBcj0UoQp6XJqyv+mqEhyeAfJYl
	3QSw+AOgXYo9/K+j2SiMeBX+9XZ3fRy3mVjyn1xZtK7Nr1fLf8TJVOcumFpfihAV
	hNfSA==
X-ME-Sender: <xms:-dbTaWpdQvhQuGPZyXgFMmwSZwlUxFvr9Wxdf-ZeawIQ-65vaZWtxw>
    <xme:-dbTaW4GtVyXr8M9u_Lg4U6go0w_YkdjtZwqcTOc1YJzPjJblX1gtes3JOGyTRTC_
    dhn4Z8reLfd5oFfST-npoVNKB5vjiG2-c-fadRCB4zEsR75BCePhbw>
X-ME-Received: <xmr:-dbTaddshllQ7bSv8V13LrGwdOqWuTrpPggPBBzMC7D0KvH3xBzYrfTEt6eRUl-r9uSRfYNgfM8KvZgCeWVKVrOXxsgRNu-Ki4gup58xu9NNV5Xmb19k7wyJ2grpsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhephfekhe
    eugedvtdehkefgtdelfffhveeuvdfgvdfhteehhedtjefhveejleffffdtnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvth
    dprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehgnhhorggtkhef
    tddttdesghhmrghilhdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthht
    ohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsh
    gvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-dbTab7v6Dp9VSkKVvfK9Fd4G7tG59DeQ4YwUoNEQA4aNRyJVXH8cg>
    <xmx:-dbTaUucb2vF57K0XRCWaxvZB3LIa3JKK3DWsGtT5GHmePayq54SUQ>
    <xmx:-dbTabhNYnYOrXN2CsTu0l8xOKgXDwlk95sO5TFAaVg-plavDtz6eg>
    <xmx:-dbTafrCKGNLWjbv2CBT8IJBoHFv2XHhU7MCcjQuZbIbZKbL_j_4MQ>
    <xmx:-dbTaakhVekPYw5wDUX_FAuw5NZaEikrILEmVJM0AxdLJsxBKBkG7DsX>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:28 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Date: Mon,  6 Apr 2026 16:52:14 +0100
Message-ID: <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
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
Co-developed-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Because the no inherit patchset [2] from Justin Suess will depend on
this rule flags mechanism, I and Justin discussed a bit whether this
patch should in fact be a standalone thing separate from quiet flags
(i.e. add the infrastructure for rule flags, but don't actually add any
rule flags in this commit), so that the two series can be developed and
merged independently.  However in the end I decided to not do this and
send this patch as-is.

Changes in v8:
- Rebase on top of mic/next
- Add Co-developed-by: Justin Suess for handling this rebase initially
- layer_mask_t was removed in [1] but we still need it for the
  collected_rule_flags.  Rather than using raw u16, I've chosen to
  re-define it back in ruleset.h (it was in access.h).

Changes in v7:
- Take rule_flags separately from landlock_request in
  is_access_to_paths_allowed to avoid writing to the landlock_request
  variable if CONFIG_AUDIT is disabled (to enable compiler elision).
- Due to the above change, we don't need rule_flags in landlock_request in
  this commit anymore (will be added later).

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

[1]: https://lore.kernel.org/all/20260125195853.109967-1-gnoack3000@gmail.com/
[2]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/

 security/landlock/fs.c      | 96 +++++++++++++++++++++++--------------
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.c |  8 +++-
 security/landlock/ruleset.h | 32 ++++++++++++-
 4 files changed, 99 insertions(+), 40 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..6f63e0182ef0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -717,6 +717,9 @@ static void test_is_eacces_with_write(struct kunit *const test)
  *     those identified by @access_request_parent1).  This matrix can
  *     initially refer to domain layer masks and, when the accesses for the
  *     destination and source are the same, to requested layer masks.
+ * @rule_flags_parent1: Pointer to a collected_rule_flags struct
+ *     corresponding to the accumulated rule flags for parent1 to be read from
+ *     and filled as we traverse the path.
  * @log_request_parent1: Audit request to fill if the related access is denied.
  * @dentry_child1: Dentry to the initial child of the parent1 path.  This
  *     pointer must be NULL for non-refer actions (i.e. not link nor rename).
@@ -726,6 +729,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  *     the source.  Must be set to 0 when using a simple path request.
  * @layer_masks_parent2: Similar to @layer_masks_parent1 but for a refer
  *     action.  This must be NULL otherwise.
+ * @rule_flags_parent2: Similar to @rule_flags_parent1 but for parent2.
  * @log_request_parent2: Audit request to fill if the related access is denied.
  * @dentry_child2: Dentry to the initial child of the parent2 path.  This
  *     pointer is only set for RENAME_EXCHANGE actions and must be NULL
@@ -739,17 +743,19 @@ static void test_is_eacces_with_write(struct kunit *const test)
  *
  * Return: True if the access request is granted, false otherwise.
  */
-static bool
-is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
-			   const struct path *const path,
-			   const access_mask_t access_request_parent1,
-			   struct layer_access_masks *layer_masks_parent1,
-			   struct landlock_request *const log_request_parent1,
-			   struct dentry *const dentry_child1,
-			   const access_mask_t access_request_parent2,
-			   struct layer_access_masks *layer_masks_parent2,
-			   struct landlock_request *const log_request_parent2,
-			   struct dentry *const dentry_child2)
+static bool is_access_to_paths_allowed(
+	const struct landlock_ruleset *const domain,
+	const struct path *const path,
+	const access_mask_t access_request_parent1,
+	struct layer_access_masks *layer_masks_parent1,
+	struct collected_rule_flags *const rule_flags_parent1,
+	struct landlock_request *const log_request_parent1,
+	struct dentry *const dentry_child1,
+	const access_mask_t access_request_parent2,
+	struct layer_access_masks *layer_masks_parent2,
+	struct collected_rule_flags *const rule_flags_parent2,
+	struct landlock_request *const log_request_parent2,
+	struct dentry *const dentry_child2)
 {
 	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
 	     child1_is_directory = true, child2_is_directory = true;
@@ -797,20 +803,28 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 	}
 
 	if (unlikely(dentry_child1)) {
+		/*
+		 * Get the layer masks for the child dentries for use by domain
+		 * check later.  The rule_flags for child1 should have been
+		 * included in rule_flags_parent1 already (cf.
+		 * collect_domain_accesses), and is not relevant for domain check,
+		 * so we don't have to pass it to landlock_unmask_layers.
+		 */
 		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 					      &_layer_masks_child1,
 					      LANDLOCK_KEY_INODE))
 			landlock_unmask_layers(find_rule(domain, dentry_child1),
-					       &_layer_masks_child1);
+					       &_layer_masks_child1, NULL);
 		layer_masks_child1 = &_layer_masks_child1;
 		child1_is_directory = d_is_dir(dentry_child1);
 	}
 	if (unlikely(dentry_child2)) {
+		/* See above comment for why NULL is passed as rule_flags_masks. */
 		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 					      &_layer_masks_child2,
 					      LANDLOCK_KEY_INODE))
 			landlock_unmask_layers(find_rule(domain, dentry_child2),
-					       &_layer_masks_child2);
+					       &_layer_masks_child2, NULL);
 		layer_masks_child2 = &_layer_masks_child2;
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
@@ -865,12 +879,14 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 =
-			allowed_parent1 ||
-			landlock_unmask_layers(rule, layer_masks_parent1);
-		allowed_parent2 =
-			allowed_parent2 ||
-			landlock_unmask_layers(rule, layer_masks_parent2);
+		allowed_parent1 = allowed_parent1 ||
+				  landlock_unmask_layers(rule,
+							 layer_masks_parent1,
+							 rule_flags_parent1);
+		allowed_parent2 = allowed_parent2 ||
+				  landlock_unmask_layers(rule,
+							 layer_masks_parent2,
+							 rule_flags_parent2);
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -954,6 +970,7 @@ static int current_check_access_path(const struct path *const path,
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
 	struct layer_access_masks layer_masks;
 	struct landlock_request request = {};
+	struct collected_rule_flags rule_flags = {};
 
 	if (!subject)
 		return 0;
@@ -962,8 +979,8 @@ static int current_check_access_path(const struct path *const path,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(subject->domain, path, access_request,
-				       &layer_masks, &request, NULL, 0, NULL,
-				       NULL, NULL))
+				       &layer_masks, &rule_flags, &request,
+				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request);
@@ -1026,10 +1043,11 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * Return: True if all the domain access rights are allowed for @dir, false if
  * the walk reached @mnt_root.
  */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
-				    const struct dentry *const mnt_root,
-				    struct dentry *dir,
-				    struct layer_access_masks *layer_masks_dom)
+static bool
+collect_domain_accesses(const struct landlock_ruleset *const domain,
+			const struct dentry *const mnt_root, struct dentry *dir,
+			struct layer_access_masks *layer_masks_dom,
+			struct collected_rule_flags *const rule_flags)
 {
 	bool ret = false;
 
@@ -1048,7 +1066,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
 
 		/* Gets all layers allowing all domain accesses. */
 		if (landlock_unmask_layers(find_rule(domain, dir),
-					   layer_masks_dom)) {
+					   layer_masks_dom, rule_flags)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
@@ -1138,6 +1156,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	struct layer_access_masks layer_masks_parent1 = {},
 				  layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
+	struct collected_rule_flags rule_flags_parent1 = {},
+				    rule_flags_parent2 = {};
 
 	if (!subject)
 		return 0;
@@ -1169,10 +1189,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1198,11 +1218,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/* new_dir->dentry is equal to new_dentry->d_parent */
 	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						old_parent,
-						&layer_masks_parent1);
+						&layer_masks_parent1,
+						&rule_flags_parent1);
 	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						new_dir->dentry,
-						&layer_masks_parent2);
-
+						&layer_masks_parent2,
+						&rule_flags_parent2);
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
@@ -1214,8 +1235,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
 
@@ -1745,6 +1767,7 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 	struct landlock_request request = {};
+	struct collected_rule_flags rule_flags = {};
 
 	if (!subject)
 		return 0;
@@ -1771,7 +1794,8 @@ static int hook_file_open(struct file *const file)
 		    landlock_init_layer_masks(subject->domain,
 					      full_access_request, &layer_masks,
 					      LANDLOCK_KEY_INODE),
-		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
+		    &layer_masks, &rule_flags, &request, NULL, 0, NULL, NULL,
+		    NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
 		/*
diff --git a/security/landlock/net.c b/security/landlock/net.c
index c368649985c5..dc82ce4a2bd4 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -48,6 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
 {
 	__be16 port;
 	struct layer_access_masks layer_masks = {};
+	struct collected_rule_flags rule_flags = {};
 	const struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
@@ -194,7 +195,7 @@ static int current_check_access_socket(struct socket *const sock,
 	if (!access_request)
 		return 0;
 
-	if (landlock_unmask_layers(rule, &layer_masks))
+	if (landlock_unmask_layers(rule, &layer_masks, &rule_flags))
 		return 0;
 
 	audit_net.family = address->sa_family;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 181df7736bb9..e4e6b730b581 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -628,7 +628,8 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
  * remaining unfulfilled access rights and masks has no leftover set bits).
  */
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks)
+			    struct layer_access_masks *masks,
+			    struct collected_rule_flags *const rule_flags)
 {
 	if (!masks)
 		return true;
@@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 	 */
 	for (size_t i = 0; i < rule->num_layers; i++) {
 		const struct landlock_layer *const layer = &rule->layers[i];
+		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
 
 		/* Clear the bits where the layer in the rule grants access. */
 		masks->access[layer->level - 1] &= ~layer->access;
+
+		/* Collect rule flags for each layer. */
+		if (rule_flags && layer->flags.quiet)
+			rule_flags->quiet_masks |= layer_bit;
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 889f4b30301a..3b31552f0c95 100644
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
@@ -37,6 +48,22 @@ struct landlock_layer {
 	access_mask_t access;
 };
 
+typedef u16 layer_mask_t;
+
+/* Makes sure this is enough to include all layers. */
+static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
+
+
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
@@ -302,7 +329,8 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 }
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks);
+			    struct layer_access_masks *masks,
+			    struct collected_rule_flags *const rule_flags);
 
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-- 
2.53.0
