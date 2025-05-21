Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6822F15E
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856096; cv=none; b=Nph7SAJ4Ak6zEhc+GeI58CcZXC02DDjSZcPSlYCFVJklsrxxj3sWQiYEbDRFDGQnE7zR/geQSamnm6yUxuqwfapY7cNTNMjl2KRGN7/7vpzcAfzyuDbxH624t6Gg/ePi0WwYQOQXtgyAbZLVrd6WIPJUaUoD9Lapk6fxXyoT0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856096; c=relaxed/simple;
	bh=PrSuryG/LpJg5x0gdauL190YsVu8t1/JfWkyy5nAdHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfGitxUwIo/xCHg+bCYMYIVECxjKRP60hFF6hvNJ9ue9CcH6Eagg8PUvTKaNGXXU/ol33Rwx/QKFE66oZXWywUVcyb+Q1nUpsq7R5L3Ln0LML5fDDm6XZfcT49x6+oywMg5QevOkovEfUpJNUa+KCuTXaKc87mXFM0U8YRKMDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=rL82VmsU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJuDGj9k; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="rL82VmsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJuDGj9k"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D36221140117;
	Wed, 21 May 2025 15:34:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 15:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747856093;
	 x=1747942493; bh=0l4zdGjvxhCj8Z37Ky2mRIGe+ozb0kh457fbhLDHznM=; b=
	rL82VmsUrtS6F96JVxNmZB7mZjXaR2aN8uqjqThXqiIZa5QABJwFWQyCttIudJPr
	UZeJuBz+ZHn9JZ3/vl3aNnUXY/GtcVs5ZOmgiX9V3e0JMToyXb2T+p5/ZQQA1yEi
	mkL2yXb/mvmmAB4sLA9QkQmoY1F2TjEn8WtM7M4Zz0DAn1zS+eoyrQPST7XYWXM0
	DCbEScjXaTOMfwYjfx5HYL1xOWNUYEbv48zrMZ+QReN2hJbU7nS26iF349Ef9ywc
	MUCBbp/+D39rFzIkBz3mi50A8Cdm9+sn2dP10T5l94y57U1ERnjvefo8WOZ+Obxw
	qX8eNUvYFyF9IM0CCMusCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747856093; x=
	1747942493; bh=0l4zdGjvxhCj8Z37Ky2mRIGe+ozb0kh457fbhLDHznM=; b=C
	JuDGj9ktu6kkvpOo2kra0S0dRFk7xpfeKPjiWI2g/99JmIT2SmlpdIKTqi+G5I8c
	tmxXDHWAJEHnO2h/8oF2lidX+9ZNzV2Q0mRGalnVzOMw89/OGEDbnKrw/Ndkk3U+
	H2y2R7MiKpUNL6v62226BYXBh7fzAVZkwMyxQrr9koAPrAk9YF4AIJiAFl1QvDzI
	57McrKzeOE0t563qcxHBxlglu7tfFEpPlFCdUY0Nm+b9gqVLdzVlEsC8t9ey2Sw9
	8fOiaNb0u0Z3fQQRCA4Anm7dSsHDZOAVbBWNayAQ5jjZO+L3ESk2lVjoGfmw7LLo
	V8svtg7ppazqJgKxKzKwA==
X-ME-Sender: <xms:3SouaLPlgQjkYjLZJmw6qb0_a2cFVzGESPm2qSp_HpN43d8yTmbqcQ>
    <xme:3SouaF-7p5bTX5SVhIpckEqrfypJFMSTBAEfHK2PeYLtbVVjF0hIQLxKqdt5dlv-o
    EsOF8ia3C-Eo_WJ4pY>
X-ME-Received: <xmr:3SouaKR5tuzGt3AoDw_N9kcW0IzXBGUyqeI5CcCMNFiZ7ypDFD3KSUN_Z-zrIzpbyibB1cGs_W-9L0G1cx26F1hO3hlhPxjdqmTIVmBGA1i_7H0h0a0Uog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmse
    hmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeu
    ffehhfevuefgvdekjeekhedvtedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3SouaPuODlscmnfEt9jIFvdgbo2ryaYNxUbduG566HBBzNzbYmTuVw>
    <xmx:3SouaDcnUI_gtJmwUo_vg2KminCD7pHb8NHg578_efg4Gnw5nca25w>
    <xmx:3SouaL249mEd1HhbchSKVz9zyAonoZlSFJc09OgaVNx6NoHONf0N7A>
    <xmx:3SouaP8H4AZR9gYR-LlndkwnS1EdZ2pXq8AtEyCIZpEtK5pL1UKS9g>
    <xmx:3SouaFdiQUGk8OHbbF_9wka3oekwCjKcM3koXNTUiOeyV19UYqQgQZs0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:52 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 09/10] landlock/fs: Use the new hashtable-based domain to find inode rules
Date: Wed, 21 May 2025 20:32:05 +0100
Message-ID: <b5abc3c8271aae97aea411461a9da4276977df17.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747836146.git.m@maowtm.org>
References: <cover.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c | 55 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c4f442093c6e..0846362caaf9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -7,6 +7,7 @@
  * Copyright © 2021-2025 Microsoft Corporation
  * Copyright © 2022 Günther Noack <gnoack3000@gmail.com>
  * Copyright © 2023-2024 Google LLC
+ * Copyright © 2025 Tingmao Wang <m@maowtm.org>
  */
 
 #include <asm/ioctls.h>
@@ -361,14 +362,12 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
  * Returns NULL if no rule is found or if @dentry is negative.
  */
 static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
+find_rule(const struct landlock_domain *const domain,
 	  const struct dentry *const dentry)
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
-	struct landlock_id id = {
-		.type = LANDLOCK_KEY_INODE,
-	};
+	union landlock_key key;
 
 	/* Ignores nonexistent leafs. */
 	if (d_is_negative(dentry))
@@ -376,8 +375,8 @@ find_rule(const struct landlock_ruleset *const domain,
 
 	inode = d_backing_inode(dentry);
 	rcu_read_lock();
-	id.key.object = rcu_dereference(landlock_inode(inode)->object);
-	rule = landlock_find_rule(domain, id);
+	key.object = rcu_dereference(landlock_inode(inode)->object);
+	rule = landlock_hash_find(&domain->inode_table, key);
 	rcu_read_unlock();
 	return rule;
 }
@@ -753,6 +752,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  */
 static bool is_access_to_paths_allowed(
 	const struct landlock_ruleset *const domain,
+	const struct landlock_domain *const domain2,
 	const struct path *const path,
 	const access_mask_t access_request_parent1,
 	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
@@ -831,7 +831,7 @@ static bool is_access_to_paths_allowed(
 
 	if (unlikely(dentry_child1)) {
 		landlock_unmask_layers(
-			find_rule(domain, dentry_child1),
+			find_rule(domain2, dentry_child1),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child1, LANDLOCK_KEY_INODE),
@@ -841,7 +841,7 @@ static bool is_access_to_paths_allowed(
 	}
 	if (unlikely(dentry_child2)) {
 		landlock_unmask_layers(
-			find_rule(domain, dentry_child2),
+			find_rule(domain2, dentry_child2),
 			landlock_init_layer_masks(
 				domain, LANDLOCK_MASK_ACCESS_FS,
 				&_layer_masks_child2, LANDLOCK_KEY_INODE),
@@ -900,7 +900,7 @@ static bool is_access_to_paths_allowed(
 				break;
 		}
 
-		rule = find_rule(domain, walker_path.dentry);
+		rule = find_rule(domain2, walker_path.dentry);
 		allowed_parent1 = allowed_parent1 ||
 				  landlock_unmask_layers(
 					  rule, access_masked_parent1,
@@ -1012,9 +1012,9 @@ static int current_check_access_path(const struct path *const path,
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_INODE);
-	if (is_access_to_paths_allowed(subject->domain, path, access_request,
-				       &layer_masks, &request, NULL, 0, NULL,
-				       NULL, NULL))
+	if (is_access_to_paths_allowed(subject->domain, subject->domain2, path,
+				       access_request, &layer_masks, &request,
+				       NULL, 0, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request);
@@ -1077,6 +1077,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  */
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
+	const struct landlock_domain *const domain2,
 	const struct dentry *const mnt_root, struct dentry *dir,
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
 {
@@ -1097,7 +1098,7 @@ static bool collect_domain_accesses(
 		struct dentry *parent_dentry;
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
+		if (landlock_unmask_layers(find_rule(domain2, dir), access_dom,
 					   layer_masks_dom,
 					   ARRAY_SIZE(*layer_masks_dom))) {
 			/*
@@ -1218,10 +1219,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 			subject->domain,
 			access_request_parent1 | access_request_parent2,
 			&layer_masks_parent1, LANDLOCK_KEY_INODE);
-		if (is_access_to_paths_allowed(subject->domain, new_dir,
-					       access_request_parent1,
-					       &layer_masks_parent1, &request1,
-					       NULL, 0, NULL, NULL, NULL))
+		if (is_access_to_paths_allowed(
+			    subject->domain, subject->domain2, new_dir,
+			    access_request_parent1, &layer_masks_parent1,
+			    &request1, NULL, 0, NULL, NULL, NULL))
 			return 0;
 
 		landlock_log_denial(subject, &request1);
@@ -1245,11 +1246,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
+	allow_parent1 = collect_domain_accesses(subject->domain,
+						subject->domain2,
+						mnt_dir.dentry, old_parent,
 						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent2 = collect_domain_accesses(subject->domain,
+						subject->domain2,
+						mnt_dir.dentry, new_dir->dentry,
 						&layer_masks_parent2);
 
 	if (allow_parent1 && allow_parent2)
@@ -1262,10 +1265,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * destination parent access rights.
 	 */
 	if (is_access_to_paths_allowed(
-		    subject->domain, &mnt_dir, access_request_parent1,
-		    &layer_masks_parent1, &request1, old_dentry,
-		    access_request_parent2, &layer_masks_parent2, &request2,
-		    exchange ? new_dentry : NULL))
+		    subject->domain, subject->domain2, &mnt_dir,
+		    access_request_parent1, &layer_masks_parent1, &request1,
+		    old_dentry, access_request_parent2, &layer_masks_parent2,
+		    &request2, exchange ? new_dentry : NULL))
 		return 0;
 
 	if (request1.access) {
@@ -1689,7 +1692,7 @@ static int hook_file_open(struct file *const file)
 	full_access_request = open_access_request | optional_access;
 
 	if (is_access_to_paths_allowed(
-		    subject->domain, &file->f_path,
+		    subject->domain, subject->domain2, &file->f_path,
 		    landlock_init_layer_masks(subject->domain,
 					      full_access_request, &layer_masks,
 					      LANDLOCK_KEY_INODE),
-- 
2.49.0

