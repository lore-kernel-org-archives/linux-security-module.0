Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2FB640
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272060; cv=none; b=BOGGEJV9SRSyOpHKCVDJ9ZNbrYIpWlw0vxMmQTOWcIQNKrqAG3+jwlYq1p+4R/VNztUHeD428Y3z1Ni4Cuf69cy6s03EuFMJR0/Y4UzrB69lNZWoyalL6oLYpLIrqkrhJV0zdDFh+AUyTN5D15J/THfmhoT9PQrsybCod8SCnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272060; c=relaxed/simple;
	bh=84oO3nHBAE3zzvo/x0TobO/OAO7i0tLEtwfVpJIiOqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dArNWkpf31lMO7Vjv4LeIu5YgmWTPKjbmVS8cSJvqfz9V2dSfIJ7Hva1DrOn2WFBIcKUBd8ucV+Md+QrylYWCaqph1JYKPr7UJxIUekaXUKOL62pCCVT43GeXxO/BkR2X1HQgWQECXoF90xckMtP9FoI4OwEV9oB94M+Wg31F74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=xbMYDjJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/UJ2O+c; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="xbMYDjJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/UJ2O+c"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B0AA7A00A2;
	Sun, 31 May 2026 20:00:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 31 May 2026 20:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272057; x=
	1780358457; bh=fUUv6xyTFFj87PbvXZGbPYoUpwUVedvusBF2YFTDePg=; b=x
	bMYDjJI8tMGCv1Sn3lVv+k4yez7UpeqmbIH21qLwEA8DhQ3GfXaIZC7kX/NfjJ1t
	Ax/mGe5Q/RR3wl0AuzUdWFkj7urwudb6RsFgbfSeM16GTy2soGUlBqmO2pw0kzjT
	jek87ck/5tGQa4RAAe+2+6tohsQ8iwv1BaGTnUlhOiiVgA8/qJ1HDvCZ7IAiWoL0
	H+ZTOYoAZLhVGbAo8Gpft+wZfoJbram+fyQG8sIXG1IqQQVLbU6CBCnnbID/vi5d
	aoY+W5AcSbcKJpyJy6Bl2aXxhujZFT90zrdowBtYa2vMT+SJg/ecqZvF9ukQcqLT
	K0HqpC9lVTRwX6SAtiJfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272057; x=1780358457; bh=f
	UUv6xyTFFj87PbvXZGbPYoUpwUVedvusBF2YFTDePg=; b=A/UJ2O+cVoYxLLvre
	6RHPQQZR56iD7zfLSFiJ6d/ljAODsC341MI4LL7cUeAktD1omikkGJ2U4NSpupnk
	BeqT3IixjBp03hb7JJOea3BES9qrIUTkS6GvQqdACAeIixkmNAH8U7Aeg1hBDvVZ
	7pT2JghqG9EgarN7ZHHjRUPWlUEMYPiwDkeD2sDLMz5LOixhyf+FAIMTEQ2tAfyq
	7xwRi/GcrnOUkI6NUGfimdoyQmn4Sy8QJE52n6QDFu7UiiDLSzSioAmV3SBzbgN2
	+SQkW43Z+ZpQv3xxiWwmOUtEVD/V5GzoksfC4tBe6Cswae77QsGLC/9ZltGqEHqp
	Gj5rQ==
X-ME-Sender: <xms:uMscamIX_wC8rmvlicH05pJCY39eebIM2AIjuhGueKzewXiz9rCtsg>
    <xme:uMscagYFxSRp_1BuQExZpdD98Qp7xW4waTxzTqgI2pES3fwOJrWcOPYqbTn_pK8Pr
    U71Z9P384bhm4QAltv9NwgYocMzTBVDRcNYZ1fjPbyEWh9y8OlsQkc>
X-ME-Received: <xmr:uMscao9jMmvUkM52viZj8hJyKOI23Z4tP4E4BA8_4wZx7DswRYg1UeJD8Qq-K1FhhVI>
X-ME-Proxy-Cause: dmFkZTGYowkHlS32lfH2LV02/WXhZdT0oTEeax97LhCpEElFCJDjgJK4UeAkkEFhB3L5FE
    uUflDKBRtzeOf1kGwVbv6ghsn63fsliATnoWyVwwuvbLV9BKM6TpRONUDdTfpqih7QN3HB
    7QxXLUiKuKg9k+2rxDt8ip8lpxCjHa+U8gJ7Z1m06J5dEfSbA3M2S5xb4yd+KygUhRBtRO
    MDQi5TOvWBdLR4NYz/RE6QkRfj1hJQfSwtgVvn6+dcoJ0Mwi5RsJDpxRwE6imlzHYNHGex
    r+N9CmWgjNTHK1ldTGLleJk8gbFH22PU59ZRRh8fv6isTVPALn7sC7hNKD8oGhiLRRgqBm
    n2ztdeqCx6Luz97N5R2y6sOgl8FR7NEzdVLdsY4ij/ER6T3pbd7CFXGePFUNUp67dc/K+c
    AXCPUPCJnWMrV9AeR9KsaIIVVerwyjOAESwCOI7HZgaAddQK3ki/aZg0u1aY9fa1a1NSvx
    1TMHANCUWOfyt+RscgiXhMRN/zCRu1lYSnlLGiNjmPlhAU9/TLFpbgmUbZSY+jx/ZPiO/l
    MuAJCs2kzUWFweoab810azL2ErwgPPDKAwNEnNE+n/07Emn4NpUlFipBlxxwf5nvqR3VPq
    0VQFCoOGVpAG5Ogmw6KhoLm3s6NmPDJ+8l/cfpF5kHe0d0GhHBIhvtAemXGQ
X-ME-Proxy: <xmx:uMscahZMakIXFacJqYPngQQZmLy7x45ZfPB5wd6rcM7qRVVHPvz9Fg>
    <xmx:uMscasP9mkdZ9dR2MswmmkEHkrwaCov7KIyoEaacX16kJI6EU6XMAg>
    <xmx:uMscatCdDBk0L1dOZfoh_RTaUB_jDZA1nQGf_3TsdvVHiLqBo3qIxA>
    <xmx:uMscajJtwk-oGUyrZ9qrw_tDq5TYpEWtXqB0xDP94Mf50nAvtCXXVg>
    <xmx:ucscaoFPuKomnYDi-OUai_WVdyZdtZG9wC1v1eaFoaGygraOEnlJbWHG>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:00:55 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 1/9] landlock: Add a place for flags to layer rules
Date: Mon,  1 Jun 2026 01:00:35 +0100
Message-ID: <676e38f1c2d3f6445bdcd45be043e514f6509a3a.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
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
Tested-by: Justin Suess <utilityemal77@gmail.com>
---

Changes in v10:
- Doc for struct layer_mask members
- clang-format header file changes
- Add Tested-by for Justin Suess

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

 security/landlock/access.h  |  39 +++++++---
 security/landlock/audit.c   |  20 ++---
 security/landlock/audit.h   |   2 +-
 security/landlock/domain.c  |  19 ++---
 security/landlock/domain.h  |   2 +-
 security/landlock/fs.c      | 147 +++++++++++++++++++-----------------
 security/landlock/limits.h  |   3 +
 security/landlock/net.c     |   2 +-
 security/landlock/ruleset.c |  33 +++++---
 security/landlock/ruleset.h |  17 ++++-
 10 files changed, 173 insertions(+), 111 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index c19d5bc13944..42d8b5134358 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -62,18 +62,39 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
 /**
- * struct layer_access_masks - A boolean matrix of layers and access rights
- *
- * This has a bit for each combination of layer numbers and access rights.
- * During access checks, it is used to represent the access rights for each
- * layer which still need to be fulfilled.  When all bits are 0, the access
- * request is considered to be fulfilled.
+ * struct layer_mask - The unfulfilled access rights and rule flags for
+ * a layer.
+ */
+struct layer_mask {
+	/**
+	 * @access: During access checks, this is used to represent the access
+	 * rights for each layer which still need to be fulfilled.  When all
+	 * bits are 0, the access request is allowed by this layer.
+	 */
+	access_mask_t access : LANDLOCK_NUM_ACCESS_MAX;
+#ifdef CONFIG_AUDIT
+	/**
+	 * @quiet: Whether we have encountered a rule with the quiet flag for
+	 * this layer.  Used to control audit logging.
+	 */
+	bool quiet : 1;
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
index edaa52572cbd..f7c1bc64de20 100644
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
index 889f4b30301a..f80ca487d125 100644
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
+		bool quiet : 1;
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
