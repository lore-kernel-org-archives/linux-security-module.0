Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C335B13C
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511535; cv=none; b=KRHhqpd5BrHljVJ5U6YYPCKU9Rdg/tMIHi9udFz2x0Z4AVxbYoWWFFOhqiC5cYdOnZuYGT15/39wBcYbtCR82auHUpTM/itbQYmtpSRGaunuwXlq6QkmtXnZm1pZMhv7Qx4wDiYY1Ok+SgdBX6NnWKaSQruxJcdqA3tpyViVhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511535; c=relaxed/simple;
	bh=2sNykHOyEg3gFqjxVS6Uo3cBnUrOAeV5GWlnoBDbeeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWgxvWENwatBweLJM/lreyv19eq6jZ4JvuMP9XOS6yT1VNo9CLybhXYSh2aqNj2ap/DUo0XNQ0nFnHRbv4/Vbt1jABqCVu7VyUpJitKBUDcNbepUZSm5+2ZnGNoEwzMYaxpNpqb5sxaEwEwpFMG/pFOk2wSwjQzwierzW8xZlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hU0+Ay5Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZu3bRny; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hU0+Ay5Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZu3bRny"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAA721400242;
	Sun, 26 Oct 2025 16:45:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 26 Oct 2025 16:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761511531; x=
	1761597931; bh=qg9wGHpkqM/wdh4GHL63fIevR5igCpqdDubF4u13ftE=; b=h
	U0+Ay5ZHRgEB3pklC7S44sVulwuMiPRb9HV42V00ngg3N4yMn1Z1ZkW/iTLjpgcM
	zVG6GaP38oS0w/kkgWvxIlobGrc82DXnsJ2rdEI7LVvVDmlJUREkD7E1fInxBzWK
	iOCtEACzjpHBpiCZgKODDjlh0F2mv/eHTEBSI3hWsX30STn/nerQ0LV71vyr7jlY
	Sl9LwIcGRU1SwP62GrzJAef6chGXR6Td+MsTSJD4g5QlPpzquT3L91hPUJxSSTbI
	Whj6dhFBsX73rhKElknqv+91cvtn5RR8dBtdV9p+8OYuqAZl+5wWT2NAKU5Zm/x7
	YHXA4cIA/aVTD5QnYo1fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761511531; x=1761597931; bh=q
	g9wGHpkqM/wdh4GHL63fIevR5igCpqdDubF4u13ftE=; b=eZu3bRnyZDz+OiFhW
	EGBJ8ZJe4ZuzF7X0KWptI0EOygOWYAXIIuXMDb/kPV3BL5Xk8WwRXcerOV9+IWe/
	ezxWB2Es0FgqcGsHL+M8ZXbepBX5qDYD+Kylw6gZ9+CNYuQC/7CQk6uoAp7gNkoa
	5bcWujloqlUkO81Jwo2YKeGRDa1VSegcpg8AzJcxC8u0aZFetEGVWyVSSJB7EvdQ
	vP8vaEajD4BbJuiSgJO7DhPsG+Ip2YwXCj1Y3LXh40J5WJEfEcQKCi6K5NDiwIsy
	MmdYiHsXH2RjhH32B/3WMjE7SqeKbSJX+dRS38puVK3Yg8sW4F0xuKOFks0oQQTs
	ZWjkw==
X-ME-Sender: <xms:a4j-aM8ppJMIWqmCVZ2xkFstetDnJH0VGISXRaYWEQLnvKxPHLPMdQ>
    <xme:a4j-aIYIu17NoajjYhjA7sFr9s6S30OPxhKxnFy4jCv5HRzlOl6CxzokOUxbyuSWA
    i2waeECeanXxmApEcWGVUPVxVldprD-qHQ70v3iG2lyItvV7fz4QeM>
X-ME-Received: <xmr:a4j-aL1flrd0Ed61S0vlmMZXCdUDqaV22cjI-c9QMjePLliJFxCSI9vZxPM0qqkbJN1aIFeCs4IniLUv_C5zp0EhFWP2mc_TeQryVBFgIobT8MXoiKZF8PkaeaAWWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeihf
    dvvdfhvdfffeetveefheefgedtvdeufeegkeeiveehuddvgfffieelueekueenucffohhm
    rghinheptgholhhlvggtthgvuggprhhulhgvpghflhgrghhsrdhsvggtuhhrihhthienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrgho
    fihtmhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofiht
    mhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a4j-aDYBNFEE4noyEyr5wMWHDQ9HprZaHvXZS8t2tnCaGboy50i4wQ>
    <xmx:a4j-aDLXeKS0ZEcry8hjhxt8tQpvHpXZtmivH6r5iBa5IPLgd7fJJA>
    <xmx:a4j-aCGrEubBXOYr3e2DFfkuLStxt4G8Kp-MNfUY_xp5y4cDT8f3nA>
    <xmx:a4j-aKv5Jio4Y5kEPottfqIlC1itFrMrFu62RlkiCA3N8EpeKgYELw>
    <xmx:a4j-aKEc5uigPf6xz_rrtf83vn-3ZMkE7u5wTYgChCg-E1yNsjqxFmLI>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:30 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 1/8] landlock: Add a place for flags to layer rules
Date: Sun, 26 Oct 2025 20:44:16 +0000
Message-ID: <9fb677cab1feefb69b9ae6dd51702348ec8920b4.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
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

Changes since v2:
- Comment changes, move local variables, simplify if branch

Changes since v1:
- Comment changes
- Rebased to include disconnected directory handling changes on mic/next
  and add backing up of collected_rule_flags.

 security/landlock/fs.c      | 95 ++++++++++++++++++++++++++-----------
 security/landlock/net.c     |  3 +-
 security/landlock/ruleset.c |  7 ++-
 security/landlock/ruleset.h | 26 +++++++++-
 4 files changed, 99 insertions(+), 32 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4ed997f4a663..721cd63a4de8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -757,10 +757,12 @@ static bool is_access_to_paths_allowed(
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
@@ -775,6 +777,7 @@ static bool is_access_to_paths_allowed(
 		_layer_masks_parent2_bkp[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
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
 
@@ -1063,6 +1092,7 @@ static int current_check_access_path(const struct path *const path,
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 	struct landlock_request request = {};
+	struct collected_rule_flags rule_flags = {};
 
 	if (!subject)
 		return 0;
@@ -1071,8 +1101,8 @@ static int current_check_access_path(const struct path *const path,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(subject->domain, path, access_request,
-				       &layer_masks, &request, NULL, 0, NULL,
-				       NULL, NULL))
+				       &layer_masks, &rule_flags, &request,
+				       NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request);
@@ -1139,7 +1169,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
 	const struct path *const mnt_dir, struct dentry *dir,
-	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
+	struct collected_rule_flags *const rule_flags)
 {
 	access_mask_t access_dom;
 	bool ret = false;
@@ -1158,9 +1189,9 @@ static bool collect_domain_accesses(
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
@@ -1269,6 +1300,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 	struct landlock_request request1 = {}, request2 = {};
+	struct collected_rule_flags rule_flags_parent1 = {},
+				    rule_flags_parent2 = {};
 
 	if (!subject)
 		return 0;
@@ -1300,10 +1333,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1327,11 +1360,14 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(
-		subject->domain, &mnt_dir, old_parent, &layer_masks_parent1);
+	allow_parent1 = collect_domain_accesses(subject->domain, &mnt_dir,
+						old_parent,
+						&layer_masks_parent1,
+						&rule_flags_parent1);
 	allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
 						new_dir->dentry,
-						&layer_masks_parent2);
+						&layer_masks_parent2,
+						&rule_flags_parent2);
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
@@ -1343,8 +1379,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
 
@@ -1747,6 +1784,7 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 	struct landlock_request request = {};
+	struct collected_rule_flags rule_flags = {};
 
 	if (!subject)
 		return 0;
@@ -1773,7 +1811,8 @@ static int hook_file_open(struct file *const file)
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
2.51.1
