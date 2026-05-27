Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79026F2A0
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843692; cv=none; b=gOqG0lPii5Cgm5zWc6ppQTG7hiVoIPEE1AeNZWz/LdDboXWUiMf8NhGhJLOZWIN24SdG7cRYsKDolK5gIT3KJIccT5YWlTasEzZgYpXp0VHoB7bHQympewX0fWihS7DlF85sFDVvEAu2kj1Bepg4WKUtTpXEYKOWtPg5Z+lOnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843692; c=relaxed/simple;
	bh=UhBZB+ysW+a3Tb9LpA/3dWBH58UIsI30UO7oVO+dOG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTfrl1R7WkBNqNFZ35IXjqz0IaC9BFkHJGNHG865ltQjVh0bCQ/6hXCE/pCPcvAYLGhzIbCFGfFHGWi1XiC3MjpuslJFwLGT/OLoCxWQoIc/VMd2ym0wUzqnzRzzJbeqW4x+0nZXPTmKuXvCjhAJCLARF54wrGspjobwxMOWiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=9TQOhsMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHgMzZRc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="9TQOhsMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHgMzZRc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE4401400082;
	Tue, 26 May 2026 21:01:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 21:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843689; x=
	1779930089; bh=79NiDv7VeCS2EErOTS1cTkuqpUMJ6p0adsZCVoHz1vU=; b=9
	TQOhsMhNp9Hh0ECAk6uOpql00kccsyFn5itaEi3yByvDzPj1qw1ZkFWqUInTZ93B
	7kM+VDX8PvHdWnLryiXS83Cgyh6MLKuq5Icg50FMNQ03hq+nzdWzQDh4nGpF38B5
	mi1dE1pFmfMfnQk0hK+qt9ONWmZqjIyid5Q78KOJuDu8OY/ftPq7wTSsj5Q/h1Hd
	cVOiQpVIvxoSkSbii1uDBOqQhXYSwdG+0HjSLOIo1cdgwqfqXEF+05n4J2PvAsdt
	e+DAobSHLYzCcfvLFuQUftUurukDx7ZuJISuMnUsVEokGFSDEKowCRc43kAvv40C
	99et2jPy0YtjAPDz5RYOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843689; x=1779930089; bh=7
	9NiDv7VeCS2EErOTS1cTkuqpUMJ6p0adsZCVoHz1vU=; b=qHgMzZRcgOpD1wTXX
	vWIOsPRGPgvXTQMEOEz0VQGUUpZ6e/Q+Mmp7YUzqvrJX5wDEoW+Tlwv7qJwd5iXQ
	mroj9Y78RdqPfivmBimPrPjYdd2GsBpYkniakDTqY95nHD5kMMTSLbgM/zBQpHVM
	5dnyvLJm3cxlnvmLdehmA4y1HY/HzpZUMoMzR6yqFNPiCLHenoawLSJl/8ptGEcw
	oMwHNpKDocaSrFzuDBNHWKRJ5NW9nHiijYMDDChCHNBNNoqmZ+33EkakZqwtRNlx
	UB38GCDYyzbQmwKx3dG42tIRY4j13/d9Aow5UAqZQUMm7Evl6wGfc7Yn13R9zPSt
	TscJA==
X-ME-Sender: <xms:aUIWajmp5fYW7nxnYF3Lxu74-yq3fH9jUsJI6jaapW-LaHVeJ6tv3w>
    <xme:aUIWapFHLOMTPAz4xdeFEWAE7iJbG0qNdElN2aZfZcGv5VyEJ9VLoHL3knEnG0IrJ
    uumhY_GrgzdHGpHN3FHXRbqkSX0RUIaNkmmL4lHRJrPnInIhYHrHDg>
X-ME-Received: <xmr:aUIWar6aFiXhtt6qVrYYaRu_ei3sTSHu5X2xtM_QnXA2FzzKhRkrbjuak9AZJKPHW6M>
X-ME-Proxy-Cause: dmFkZTEMZCGoO8qMHAAZDAcnHwYYuZI6SfBZ4N0UdIXrhM9SMKk6teYLwZxXaucumsVIZ9
    KP874NW6w8ArqPcU+thmRoQGVd259+7rPy8e1ZXR8rCjxbh4wNlycv7gKbf2iS6clruXPf
    Om8c4CM4FLLjXCq6znzHR0J+jeM0/KHGoZnsMmcJ6udPRsJZDVWRPLC+78UcAqR0p/9aOl
    v/AqPPI977KuR9JLOGFm9zjnl2rPpEKl1I+ojFkAy4NK2Y6Y3JEhM1gZ9jEcF3sPv529PF
    r5g+cjMkejUXhXm1P1muyOUwi1vfTNuhO1NX/SjafEu83XyN7ORxSE9Fxj686UjGE8mpdD
    aUCO5W7rUJvzs8NKg1OfrbmP5iKInsc5b9gOqFHIY+nNa/8+1H7scfWs0SRfuPEbkRva3g
    mMf9b1EPleQkoBTLINkbSbei0rshhNYZkyxOJktsH4XTtOOxB6/AwKFPYyPf8gUCLRuhYF
    O+PknY5IuK26bLaZ0fHSM8w3VyMIAwJjYTDtzEvwBLQex195L+UGwBD4fKUMRkT1NsPbA9
    RkDK1SCKJX74UtKo3KIdDy28O9PQK1McAL/kk6zrWIEWp9606vePCeJizU8GVCqyo5s833
    oDDktmzFO4zp3iAblDyihLIX2vjGIWcqz8xX6Sux/guLh+9q5n4wVZefdKFA
X-ME-Proxy: <xmx:aUIWahkFfhPxPtNvM_SK8dkuI9nbZ0QreOM0Qjwb7H9D14pXm8vd0g>
    <xmx:aUIWagp2_S2KPUtTmz5FIKNekIN0g7O7c5xLa-7fRAa3FD_1TlvM0Q>
    <xmx:aUIWaguefRwx0FIo_vCMnJxvIBiPlTw9DjCrCkcdWu_B5hTon7lufw>
    <xmx:aUIWalGIeK3p--wr1wZcBm5n48Ci-kNAL6zkcI6jLIHO6tyF0npF-Q>
    <xmx:aUIWajQ28A4d3PiQN4tX8pyggs4Aa1FJe4R917UPiojkApGZR5hjF4TU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:28 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 1/9] landlock: Add a place for flags to layer rules
Date: Wed, 27 May 2026 02:01:11 +0100
Message-ID: <725de048a1756253dd2164c8f39b038e4e0ebdb5.1779843375.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779843375.git.m@maowtm.org>
References: <cover.1779843375.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid unnecessarily increasing the size of struct landlock_layer, we
make the layer level a u8 and use the space to store the flags struct.

struct layer_access_masks is renamed to struct layer_masks, and a new
field is added to track whether a quiet flag rule is seen for each
layer.  Through use of bitfields, this does not increase the size of the
struct.

Cc: Justin Suess <utilityemal77@gmail.com>
Assisted-by: GitHub Copilot:claude-opus-4.7 copilot-review
Signed-off-by: Tingmao Wang <m@maowtm.org>
Co-developed-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Changes in v9:
- Move a hunk from patch 2 to here
- Fix comment and format
- Renamed struct layer_access_masks to struct layer_masks, and moved the
  content of struct collected_rule_flags into this struct, getting rid
  of the extra struct collected_rule_flags and function parameters.
  This is following a discussion in [3].  The flag is now initialized in
  landlock_init_layer_masks as false.
- Thus also removed now unnecessary layer_mask_t

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
[3]: https://lore.kernel.org/all/20260524.eFiz4hahrami@digikod.net/

 security/landlock/access.h  |  35 +++++++--
 security/landlock/audit.c   |  20 ++---
 security/landlock/audit.h   |   2 +-
 security/landlock/domain.c  |  19 ++---
 security/landlock/domain.h  |   2 +-
 security/landlock/fs.c      | 147 +++++++++++++++++++-----------------
 security/landlock/limits.h  |   3 +
 security/landlock/net.c     |   2 +-
 security/landlock/ruleset.c |  33 +++++---
 security/landlock/ruleset.h |  17 ++++-
 10 files changed, 170 insertions(+), 110 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index c19d5bc13944..3b8ba6c1300d 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -62,18 +62,37 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
 /**
- * struct layer_access_masks - A boolean matrix of layers and access rights
+ * struct layer_mask - The unfulfilled access rights and rule flags for
+ * a layer.
  *
- * This has a bit for each combination of layer numbers and access rights.
- * During access checks, it is used to represent the access rights for each
- * layer which still need to be fulfilled.  When all bits are 0, the access
- * request is considered to be fulfilled.
+ * During access checks, @access is used to represent the access rights
+ * for each layer which still need to be fulfilled.  When all bits in
+ * @access is 0, the access request is allowed by this layer.
+ *
+ * @quiet is used to store whether we have encountered a rule with the
+ * quiet flag for this layer, which will be used to control audit logging.
+ */
+struct layer_mask {
+	access_mask_t access:LANDLOCK_NUM_ACCESS_MAX;
+#ifdef CONFIG_AUDIT
+	bool quiet:1;
+#endif /* CONFIG_AUDIT */
+};
+
+/*
+ * Make sure that we don't increase the size of struct layer_mask when
+ * storing rule flags.
+ */
+static_assert(sizeof(struct layer_mask) == sizeof(access_mask_t));
+
+/**
+ * struct layer_masks - An array of struct layer_mask, one per layer.
  */
-struct layer_access_masks {
+struct layer_masks {
 	/**
-	 * @access: The unfulfilled access rights for each layer.
+	 * @layers: The unfulfilled access rights for each layer.
 	 */
-	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
+	struct layer_mask layers[LANDLOCK_MAX_NUM_LAYERS];
 };
 
 /*
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 851647197a01..8c56f7f6467a 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -187,11 +187,11 @@ static void test_get_hierarchy(struct kunit *const test)
 /* Get the youngest layer that denied the access_request. */
 static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 			       access_mask_t *const access_request,
-			       const struct layer_access_masks *masks)
+			       const struct layer_masks *masks)
 {
-	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
-		if (masks->access[i] & *access_request) {
-			*access_request &= masks->access[i];
+	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
+		if (masks->layers[i].access & *access_request) {
+			*access_request &= masks->layers[i].access;
 			return i;
 		}
 	}
@@ -208,12 +208,12 @@ static void test_get_denied_layer(struct kunit *const test)
 	const struct landlock_ruleset dom = {
 		.num_layers = 5,
 	};
-	const struct layer_access_masks masks = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
-			     LANDLOCK_ACCESS_FS_READ_DIR,
-		.access[1] = LANDLOCK_ACCESS_FS_READ_FILE |
-			     LANDLOCK_ACCESS_FS_READ_DIR,
-		.access[2] = LANDLOCK_ACCESS_FS_REMOVE_DIR,
+	const struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
+				    LANDLOCK_ACCESS_FS_READ_DIR,
+		.layers[1].access = LANDLOCK_ACCESS_FS_READ_FILE |
+				    LANDLOCK_ACCESS_FS_READ_DIR,
+		.layers[2].access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
 	};
 	access_mask_t access;
 
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 56778331b58c..b85d752273ac 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -43,7 +43,7 @@ struct landlock_request {
 	access_mask_t access;
 
 	/* Required fields for requests with layer masks. */
-	const struct layer_access_masks *layer_masks;
+	const struct layer_masks *layer_masks;
 
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 5dd06f7c2312..d1a4d8b33ee1 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -184,7 +184,7 @@ static void test_get_layer_deny_mask(struct kunit *const test)
 deny_masks_t
 landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
-			const struct layer_access_masks *const masks)
+			const struct layer_masks *const masks)
 {
 	const unsigned long access_opt = optional_access;
 	unsigned long access_bit;
@@ -201,8 +201,9 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 	if (WARN_ON_ONCE(!access_opt))
 		return 0;
 
-	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
-		const access_mask_t denied = masks->access[i] & optional_access;
+	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
+		const access_mask_t denied = masks->layers[i].access &
+					     optional_access;
 		const unsigned long newly_denied = denied & ~all_denied;
 
 		if (!newly_denied)
@@ -222,12 +223,12 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 
 static void test_landlock_get_deny_masks(struct kunit *const test)
 {
-	const struct layer_access_masks layers1 = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
-			     LANDLOCK_ACCESS_FS_IOCTL_DEV,
-		.access[1] = LANDLOCK_ACCESS_FS_TRUNCATE,
-		.access[2] = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-		.access[9] = LANDLOCK_ACCESS_FS_EXECUTE,
+	const struct layer_masks layers1 = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
+				    LANDLOCK_ACCESS_FS_IOCTL_DEV,
+		.layers[1].access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		.layers[2].access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+		.layers[9].access = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
 
 	KUNIT_EXPECT_EQ(test, 0x1,
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 35cac8f6daee..af100a8cd939 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -119,7 +119,7 @@ struct landlock_hierarchy {
 deny_masks_t
 landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
-			const struct layer_access_masks *const masks);
+			const struct layer_masks *const masks);
 
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..b7357643b8c7 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -406,15 +406,15 @@ static const struct access_masks any_fs = {
  * src_parent would result in having the same or fewer access rights if it were
  * moved under new_parent.
  */
-static bool may_refer(const struct layer_access_masks *const src_parent,
-		      const struct layer_access_masks *const src_child,
-		      const struct layer_access_masks *const new_parent,
+static bool may_refer(const struct layer_masks *const src_parent,
+		      const struct layer_masks *const src_child,
+		      const struct layer_masks *const new_parent,
 		      const bool child_is_dir)
 {
-	for (size_t i = 0; i < ARRAY_SIZE(new_parent->access); i++) {
-		access_mask_t child_access = src_parent->access[i] &
-					     src_child->access[i];
-		access_mask_t parent_access = new_parent->access[i];
+	for (size_t i = 0; i < ARRAY_SIZE(new_parent->layers); i++) {
+		access_mask_t child_access = src_parent->layers[i].access &
+					     src_child->layers[i].access;
+		access_mask_t parent_access = new_parent->layers[i].access;
 
 		if (!child_is_dir) {
 			child_access &= ACCESS_FILE;
@@ -436,11 +436,11 @@ static bool may_refer(const struct layer_access_masks *const src_parent,
  * that child2 may be used from parent2 to parent1 without increasing its access
  * rights), false otherwise.
  */
-static bool no_more_access(const struct layer_access_masks *const parent1,
-			   const struct layer_access_masks *const child1,
+static bool no_more_access(const struct layer_masks *const parent1,
+			   const struct layer_masks *const child1,
 			   const bool child1_is_dir,
-			   const struct layer_access_masks *const parent2,
-			   const struct layer_access_masks *const child2,
+			   const struct layer_masks *const parent2,
+			   const struct layer_masks *const child2,
 			   const bool child2_is_dir)
 {
 	if (!may_refer(parent1, child1, parent2, child1_is_dir))
@@ -459,25 +459,25 @@ static bool no_more_access(const struct layer_access_masks *const parent1,
 
 static void test_no_more_access(struct kunit *const test)
 {
-	const struct layer_access_masks rx0 = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
-			     LANDLOCK_ACCESS_FS_READ_FILE,
+	const struct layer_masks rx0 = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
+				    LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	const struct layer_access_masks mx0 = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
-			     LANDLOCK_ACCESS_FS_MAKE_REG,
+	const struct layer_masks mx0 = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
+				    LANDLOCK_ACCESS_FS_MAKE_REG,
 	};
-	const struct layer_access_masks x0 = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
+	const struct layer_masks x0 = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const struct layer_access_masks x1 = {
-		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
+	const struct layer_masks x1 = {
+		.layers[1].access = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const struct layer_access_masks x01 = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
-		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
+	const struct layer_masks x01 = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.layers[1].access = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const struct layer_access_masks allows_all = {};
+	const struct layer_masks allows_all = {};
 
 	/* Checks without restriction. */
 	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
@@ -565,9 +565,13 @@ static void test_no_more_access(struct kunit *const test)
 #undef NMA_TRUE
 #undef NMA_FALSE
 
-static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
+static bool is_layer_masks_allowed(const struct layer_masks *masks)
 {
-	return mem_is_zero(&masks->access, sizeof(masks->access));
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		if (masks->layers[i].access)
+			return false;
+	}
+	return true;
 }
 
 /*
@@ -576,16 +580,16 @@ static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
  * Returns true if the request is allowed, false otherwise.
  */
 static bool scope_to_request(const access_mask_t access_request,
-			     struct layer_access_masks *masks)
+			     struct layer_masks *masks)
 {
 	bool saw_unfulfilled_access = false;
 
 	if (WARN_ON_ONCE(!masks))
 		return true;
 
-	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
-		masks->access[i] &= access_request;
-		if (masks->access[i])
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		masks->layers[i].access &= access_request;
+		if (masks->layers[i].access)
 			saw_unfulfilled_access = true;
 	}
 	return !saw_unfulfilled_access;
@@ -596,41 +600,46 @@ static bool scope_to_request(const access_mask_t access_request,
 static void test_scope_to_request_with_exec_none(struct kunit *const test)
 {
 	/* Allows everything. */
-	struct layer_access_masks masks = {};
+	struct layer_masks masks = {};
 
 	/* Checks and scopes with execute. */
 	KUNIT_EXPECT_TRUE(test,
 			  scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE, &masks));
-	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
+	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[0].access);
 }
 
 static void test_scope_to_request_with_exec_some(struct kunit *const test)
 {
 	/* Denies execute and write. */
-	struct layer_access_masks masks = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
-		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.layers[1].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
 	/* Checks and scopes with execute. */
 	KUNIT_EXPECT_FALSE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
 						  &masks));
-	KUNIT_EXPECT_EQ(test, LANDLOCK_ACCESS_FS_EXECUTE, masks.access[0]);
-	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
+	/*
+	 * These casts to access_mask_t are needed because typeof(), used in
+	 * KUNIT_EXPECT_EQ(), does not work on bitfields.
+	 */
+	KUNIT_EXPECT_EQ(test, LANDLOCK_ACCESS_FS_EXECUTE,
+			(access_mask_t)masks.layers[0].access);
+	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[1].access);
 }
 
 static void test_scope_to_request_without_access(struct kunit *const test)
 {
 	/* Denies execute and write. */
-	struct layer_access_masks masks = {
-		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
-		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.layers[1].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
 	/* Checks and scopes without access request. */
 	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &masks));
-	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
-	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
+	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[0].access);
+	KUNIT_EXPECT_EQ(test, 0, (access_mask_t)masks.layers[1].access);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
@@ -639,15 +648,15 @@ static void test_scope_to_request_without_access(struct kunit *const test)
  * Returns true if there is at least one access right different than
  * LANDLOCK_ACCESS_FS_REFER.
  */
-static bool is_eacces(const struct layer_access_masks *masks,
+static bool is_eacces(const struct layer_masks *masks,
 		      const access_mask_t access_request)
 {
 	if (!masks)
 		return false;
 
-	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
 		/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
-		if (masks->access[i] & access_request &
+		if (masks->layers[i].access & access_request &
 		    ~LANDLOCK_ACCESS_FS_REFER)
 			return true;
 	}
@@ -661,7 +670,7 @@ static bool is_eacces(const struct layer_access_masks *masks,
 
 static void test_is_eacces_with_none(struct kunit *const test)
 {
-	const struct layer_access_masks masks = {};
+	const struct layer_masks masks = {};
 
 	IE_FALSE(&masks, 0);
 	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_REFER);
@@ -671,8 +680,8 @@ static void test_is_eacces_with_none(struct kunit *const test)
 
 static void test_is_eacces_with_refer(struct kunit *const test)
 {
-	const struct layer_access_masks masks = {
-		.access[0] = LANDLOCK_ACCESS_FS_REFER,
+	const struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_REFER,
 	};
 
 	IE_FALSE(&masks, 0);
@@ -683,8 +692,8 @@ static void test_is_eacces_with_refer(struct kunit *const test)
 
 static void test_is_eacces_with_write(struct kunit *const test)
 {
-	const struct layer_access_masks masks = {
-		.access[0] = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	const struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
 	IE_FALSE(&masks, 0);
@@ -743,11 +752,11 @@ static bool
 is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 			   const struct path *const path,
 			   const access_mask_t access_request_parent1,
-			   struct layer_access_masks *layer_masks_parent1,
+			   struct layer_masks *layer_masks_parent1,
 			   struct landlock_request *const log_request_parent1,
 			   struct dentry *const dentry_child1,
 			   const access_mask_t access_request_parent2,
-			   struct layer_access_masks *layer_masks_parent2,
+			   struct layer_masks *layer_masks_parent2,
 			   struct landlock_request *const log_request_parent2,
 			   struct dentry *const dentry_child2)
 {
@@ -755,9 +764,9 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 	     child1_is_directory = true, child2_is_directory = true;
 	struct path walker_path;
 	access_mask_t access_masked_parent1, access_masked_parent2;
-	struct layer_access_masks _layer_masks_child1, _layer_masks_child2;
-	struct layer_access_masks *layer_masks_child1 = NULL,
-				  *layer_masks_child2 = NULL;
+	struct layer_masks _layer_masks_child1, _layer_masks_child2;
+	struct layer_masks *layer_masks_child1 = NULL,
+			   *layer_masks_child2 = NULL;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -797,6 +806,10 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 	}
 
 	if (unlikely(dentry_child1)) {
+		/*
+		 * Get the layer masks for the child dentries for use by domain
+		 * check later.
+		 */
 		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 					      &_layer_masks_child1,
 					      LANDLOCK_KEY_INODE))
@@ -952,7 +965,7 @@ static int current_check_access_path(const struct path *const path,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
-	struct layer_access_masks layer_masks;
+	struct layer_masks layer_masks;
 	struct landlock_request request = {};
 
 	if (!subject)
@@ -1029,7 +1042,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
 				    const struct dentry *const mnt_root,
 				    struct dentry *dir,
-				    struct layer_access_masks *layer_masks_dom)
+				    struct layer_masks *layer_masks_dom)
 {
 	bool ret = false;
 
@@ -1135,8 +1148,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
 	struct dentry *old_parent;
-	struct layer_access_masks layer_masks_parent1 = {},
-				  layer_masks_parent2 = {};
+	struct layer_masks layer_masks_parent1 = {}, layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
 	if (!subject)
@@ -1202,7 +1214,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						new_dir->dentry,
 						&layer_masks_parent2);
-
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
@@ -1580,7 +1591,7 @@ static int hook_path_truncate(const struct path *const path)
  */
 static void unmask_scoped_access(const struct landlock_ruleset *const client,
 				 const struct landlock_ruleset *const server,
-				 struct layer_access_masks *const masks,
+				 struct layer_masks *const masks,
 				 const access_mask_t access)
 {
 	int client_layer, server_layer;
@@ -1621,9 +1632,9 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 		server_walker = server_walker->parent;
 
 	for (; client_layer >= 0; client_layer--) {
-		if (masks->access[client_layer] & access &&
+		if (masks->layers[client_layer].access & access &&
 		    client_walker == server_walker)
-			masks->access[client_layer] &= ~access;
+			masks->layers[client_layer].access &= ~access;
 
 		client_walker = client_walker->parent;
 		server_walker = server_walker->parent;
@@ -1635,7 +1646,7 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
 {
 	const struct landlock_ruleset *dom_other;
 	const struct landlock_cred_security *subject;
-	struct layer_access_masks layer_masks;
+	struct layer_masks layer_masks;
 	struct landlock_request request = {};
 	static const struct access_masks fs_resolve_unix = {
 		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
@@ -1739,7 +1750,7 @@ static bool is_device(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
-	struct layer_access_masks layer_masks = {};
+	struct layer_masks layer_masks = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_cred_security *const subject =
@@ -1780,8 +1791,8 @@ static int hook_file_open(struct file *const file)
 		 * are still unfulfilled in any of the layers.
 		 */
 		allowed_access = full_access_request;
-		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
-			allowed_access &= ~layer_masks.access[i];
+		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.layers); i++)
+			allowed_access &= ~layer_masks.layers[i].access;
 	}
 
 	/*
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index a4d908b240a2..08d5f2f6d321 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -31,6 +31,9 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
+#define LANDLOCK_NUM_ACCESS_MAX \
+	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
+
 #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index db2046a89a9a..981a362c24db 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -48,7 +48,7 @@ static int current_check_access_socket(struct socket *const sock,
 				       bool connecting)
 {
 	__be16 port;
-	struct layer_access_masks layer_masks = {};
+	struct layer_masks layer_masks = {};
 	const struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 181df7736bb9..91948e406e69 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -628,7 +628,7 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
  * remaining unfulfilled access rights and masks has no leftover set bits).
  */
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks)
+			    struct layer_masks *masks)
 {
 	if (!masks)
 		return true;
@@ -649,11 +649,17 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		const struct landlock_layer *const layer = &rule->layers[i];
 
 		/* Clear the bits where the layer in the rule grants access. */
-		masks->access[layer->level - 1] &= ~layer->access;
+		masks->layers[layer->level - 1].access &= ~layer->access;
+
+#ifdef CONFIG_AUDIT
+		/* Collect rule flags for each layer. */
+		if (layer->flags.quiet)
+			masks->layers[layer->level - 1].quiet = true;
+#endif /* CONFIG_AUDIT */
 	}
 
-	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
-		if (masks->access[i])
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		if (masks->layers[i].access)
 			return false;
 	}
 	return true;
@@ -668,6 +674,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
  *
  * Populates @masks such that for each access right in @access_request,
  * the bits for all the layers are set where this access right is handled.
+ * Rule flags are also zeroed.
  *
  * @domain: The domain that defines the current restrictions.
  * @access_request: The requested access rights to check.
@@ -680,7 +687,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  const access_mask_t access_request,
-			  struct layer_access_masks *const masks,
+			  struct layer_masks *const masks,
 			  const enum landlock_key_type key_type)
 {
 	access_mask_t handled_accesses = 0;
@@ -709,11 +716,19 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	for (size_t i = 0; i < domain->num_layers; i++) {
 		const access_mask_t handled = get_access_mask(domain, i);
 
-		masks->access[i] = access_request & handled;
-		handled_accesses |= masks->access[i];
+		masks->layers[i].access = access_request & handled;
+		handled_accesses |= masks->layers[i].access;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
+	}
+	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
+	     i++) {
+		masks->layers[i].access = 0;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
 	}
-	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->access); i++)
-		masks->access[i] = 0;
 
 	return handled_accesses;
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 889f4b30301a..8eec5dbf28a3 100644
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
@@ -302,12 +313,12 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 }
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_access_masks *masks);
+			    struct layer_masks *masks);
 
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  const access_mask_t access_request,
-			  struct layer_access_masks *masks,
+			  struct layer_masks *masks,
 			  const enum landlock_key_type key_type);
 
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.54.0
