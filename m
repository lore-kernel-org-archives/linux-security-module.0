Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857782D0C64
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091241; cv=none; b=Bw39LudoATdk/TLbIdpEZvlm+BdS+3koUOJ9nyEjZ308ein6EUQJ5tdlV5SD8Ta6Zz6mLcV2nYc156OcgMcdfP9PzbeLxdbJnt6GR5u77W0HCgEhUJJm+uLQ0GhMw4w5dR0gFEouFBMImxPeEX1J9TaKtmtm1Hf0K3eFq/2w3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091241; c=relaxed/simple;
	bh=UFewvM/W1wktCA6tzTWSxWSdEaTHjJQFYW7NeGuLNWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGvE4DGKuj+HhSZOEQGGsbpL8+rJGKZThX8Yi6ATYBAULjWeBCH4Xb2BHd7f5kXfi/osmSRrXzu8rcIsZMszJcbgGfFByXBFbI6QXrL22Z1IQU0oaeUYiUppHWN5re8W09Czhaivsx3f5WEQImEs8OUmKXO3UBgsdyDiPYOf+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTEa4DWt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTEa4DWt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso12886327a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767091236; x=1767696036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbnd7crc9OIPgHfBS3e0Kgrnzf6F3XPplBAhg8k/tmY=;
        b=bTEa4DWtnPgmchVxYBrlVVWRQZgm+t04Kp8uoMJCmbv9pZGBBadTUlzsOmIC80BC1N
         h4Gb2S8s0032bciR8CFihaACwubf6fASBXRKPj7mhh/ZRy+1uAlUd9iW2rU7rgi7YTS0
         7e3qBtIfKoQrSNQmJPNZC6esAEihW8S6rZZPK3UICL9YGL8WAyJLbSfsJ81qdty4Uj1e
         404FH+SnVz54aREDb9zjltVcX+BQWw8Eh+0Uf24aLPrlLDd7/wV9vRXSA1c7fjZ0Dnd8
         q4JjoazD4uU84yPMoubB7c7w5gEhe0eRByUkaeij8emVXvDXMTkTYx+3uub6GUaDHhiO
         jg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091236; x=1767696036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kbnd7crc9OIPgHfBS3e0Kgrnzf6F3XPplBAhg8k/tmY=;
        b=EVlKun6AVLtHwOgzWN76fSIvFngwAlVX1wVHQbp64m/2l86RAD/vQJI+JPOR+tpQeM
         pGjcajZJEX9mFW/R9/Uzou+oc7733JXqAsCCR7zehFmFvo7+2+8F2hV4bSpYQy6oHUVG
         /flhtYWjoLHJ5h//azPyiteKJS8Y35XAY3Hx0fF+ua8bp7aOXshRWQ5nQVtYEjFdcDTh
         vexjVmV5p59g3N0d2m9EMKP3/ITG9xQFqe5VMtdgUjrJ6Ha+phWEzX3Lr9VsgBr0Z0dp
         lI70ufO7lcUumKm7w6Eo/9vUQHeian8GakIbhQVTpJXKgs9BX9mqWYKc7d6QdCg7+AvS
         /ssg==
X-Gm-Message-State: AOJu0Yz7MZ4s+ewnnY3WMrCS2LTxF+N/p2nuaBNxpdut4G8sEzxgaMpb
	zP7N9urf2eoSTD5QyKZO4+GXDfo0VhYGs8+HWiHg+Ga3ClTulRPWm1Ma
X-Gm-Gg: AY/fxX5xnwDeEnB1rplvRn0s1GB6BD96TSeC4Jww7pO+Hu3iEloMz1eyk5UQ6w0Mx2O
	fV8xLgxnbhSWEOogYpSwr2NYEWdY+HtiG02g/uEFY+Hga3+UsFzxHkhN8ZqTyd3xMGloekF+HSW
	IPte2YE5yihfiIAfCIjbockexXwqOFD8gC8J78IsK4tEcNdq0UPRYCXxcLkMh1F3wRjjX6qj8Pg
	wyr9fI5Q49hrlINNKl6zqvZ/A/JkuHNkXQ98kmI6NK6ufX0gNGr5tyvdPyQ+fkJlKLqWf2T6Gkn
	dBs1Jt+4NxrcPJsOoNhjEC0vX/xDCAP7GAZFWmod4PzhVkdfqgBbRTi86L96LpDlmqyk8ovwtMn
	AMZVCO4NBmZSy0vG/U02WgKnMDlYZIGPQODf9M+zjknjzAcFxxJcEppMe44epzLRmWXwozPwEKe
	iYyEW9B6TLqb1CoMEDSpcLKiNK5IdHxdENsVId
X-Google-Smtp-Source: AGHT+IGzRUfiInrT06z+WiODEGPzzCdfQ3U3FIHwO645szzytrISpIE3D0KTKNVHUr4SAMJegqpZ0A==
X-Received: by 2002:a17:907:7fa5:b0:b76:d548:f85b with SMTP id a640c23a62f3a-b8036f2d2demr3098108166b.11.1767091235087;
        Tue, 30 Dec 2025 02:40:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599721sm34245762a12.26.2025.12.30.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:40:34 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 2/2] landlock: transpose the layer masks data structure
Date: Tue, 30 Dec 2025 11:39:21 +0100
Message-ID: <20251230103917.10549-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230103917.10549-3-gnoack3000@gmail.com>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The layer masks data structure tracks the requested but unfulfilled
access rights during an operations security check.  It stores one bit
for each combination of access right and layer index.  If the bit is
set, that access right is not granted (yet) in the given layer and we
have to traverse the path further upwards to grant it.

Previously, the layer masks were stored as arrays mapping from access
right indices to layer_mask_t.  The layer_mask_t value then indicates
all layers in which the given access right is still (tentatively)
denied.

This patch introduces struct layer_access_masks instead: This struct
contains an array with the access_mask_t of each (tentatively) denied
access right in that layer.

The hypothesis of this patch is that this simplifies the code enough
so that the resulting code will run faster:

* We can use bitwise operations in multiple places where we previously
  looped over bits individually with macros.  (Should require less
  branch speculation)

* Code is ~160 lines smaller.

Other noteworthy changes:

* Clarify deny_mask_t and the code assembling it.
  * Document what that value looks like
  * Make writing and reading functions specific to file system rules.
    (It only worked for FS rules before as well, but going all the way
    simplifies the code logic more.)
* In no_more_access(), call a new helper function may_refer(), which
  only solves the asymmetric case.  Previously, the code interleaved
  the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
  that the code is clearer when renames without RENAME_EXCHANGE are
  more obviously the normal case.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/access.h  |  10 +-
 security/landlock/audit.c   | 155 ++++++----------
 security/landlock/audit.h   |   3 +-
 security/landlock/domain.c  | 120 +++----------
 security/landlock/domain.h  |   6 +-
 security/landlock/fs.c      | 350 ++++++++++++++++--------------------
 security/landlock/net.c     |  10 +-
 security/landlock/ruleset.c |  78 +++-----
 security/landlock/ruleset.h |  18 +-
 9 files changed, 290 insertions(+), 460 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d7..aa0efa36a37db 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -61,14 +61,14 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
-typedef u16 layer_mask_t;
-
-/* Makes sure all layers can be checked. */
-static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
-
 /*
  * Tracks domains responsible of a denied access.  This is required to avoid
  * storing in each object the full layer_masks[] required by update_request().
+ *
+ * Each nibble represents the layer index of the newest layer which denied a
+ * certain access right.  For file system access rights, the upper four bits are
+ * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
+ * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
  */
 typedef u8 deny_masks_t;
 
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77b..650bd7f5cb6be 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -182,36 +182,18 @@ static void test_get_hierarchy(struct kunit *const test)
 
 static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 			       access_mask_t *const access_request,
-			       const layer_mask_t (*const layer_masks)[],
-			       const size_t layer_masks_size)
+			       const struct layer_access_masks *masks)
 {
-	const unsigned long access_req = *access_request;
-	unsigned long access_bit;
-	access_mask_t missing = 0;
-	long youngest_layer = -1;
-
-	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
-		const access_mask_t mask = (*layer_masks)[access_bit];
-		long layer;
-
-		if (!mask)
-			continue;
-
-		/* __fls(1) == 0 */
-		layer = __fls(mask);
-		if (layer > youngest_layer) {
-			youngest_layer = layer;
-			missing = BIT(access_bit);
-		} else if (layer == youngest_layer) {
-			missing |= BIT(access_bit);
+	for (int i = LANDLOCK_MAX_NUM_LAYERS - 1; i >= 0; i--) {
+		if (masks->access[i] & *access_request) {
+			*access_request &= masks->access[i];
+			return i;
 		}
 	}
 
-	*access_request = missing;
-	if (youngest_layer == -1)
-		return domain->num_layers - 1;
-
-	return youngest_layer;
+	/* Not found - fall back to default values */
+	*access_request = 0;
+	return domain->num_layers - 1;
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
@@ -221,94 +203,82 @@ static void test_get_denied_layer(struct kunit *const test)
 	const struct landlock_ruleset dom = {
 		.num_layers = 5,
 	};
-	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT(1),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = BIT(1) | BIT(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = BIT(2),
+	const struct layer_access_masks masks = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
+			     LANDLOCK_ACCESS_FS_READ_DIR,
+		.access[1] = LANDLOCK_ACCESS_FS_READ_FILE |
+			     LANDLOCK_ACCESS_FS_READ_DIR,
+		.access[2] = LANDLOCK_ACCESS_FS_REMOVE_DIR,
 	};
 	access_mask_t access;
 
 	access = LANDLOCK_ACCESS_FS_EXECUTE;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 0, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
 
 	access = LANDLOCK_ACCESS_FS_READ_FILE;
-	KUNIT_EXPECT_EQ(test, 1,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
 
 	access = LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
 
 	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access,
 			LANDLOCK_ACCESS_FS_READ_FILE |
 				LANDLOCK_ACCESS_FS_READ_DIR);
 
 	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
 
 	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
-	KUNIT_EXPECT_EQ(test, 4,
-			get_denied_layer(&dom, &access, &layer_masks,
-					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, 4, get_denied_layer(&dom, &access, &masks));
 	KUNIT_EXPECT_EQ(test, access, 0);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
-static size_t
-get_layer_from_deny_masks(access_mask_t *const access_request,
-			  const access_mask_t all_existing_optional_access,
-			  const deny_masks_t deny_masks)
+/*
+ * get_layer_from_fs_deny_masks - get the layer which denied the access request
+ *
+ * As a side effect, stores the denied access rights from that layer(!) in
+ * *access_request.
+ */
+static size_t get_layer_from_fs_deny_masks(access_mask_t *const access_request,
+					   const deny_masks_t deny_masks)
 {
-	const unsigned long access_opt = all_existing_optional_access;
-	const unsigned long access_req = *access_request;
-	access_mask_t missing = 0;
+	const access_mask_t access_req = *access_request;
 	size_t youngest_layer = 0;
-	size_t access_index = 0;
-	unsigned long access_bit;
+	access_mask_t missing = 0;
 
-	/* This will require change with new object types. */
-	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
+	WARN_ON_ONCE((access_req | _LANDLOCK_ACCESS_FS_OPTIONAL) !=
+		     _LANDLOCK_ACCESS_FS_OPTIONAL);
 
-	for_each_set_bit(access_bit, &access_opt,
-			 BITS_PER_TYPE(access_mask_t)) {
-		if (access_req & BIT(access_bit)) {
-			const size_t layer =
-				(deny_masks >> (access_index * 4)) &
-				(LANDLOCK_MAX_NUM_LAYERS - 1);
+	if (access_req & LANDLOCK_ACCESS_FS_TRUNCATE) {
+		size_t layer = deny_masks & 0x0f;
 
-			if (layer > youngest_layer) {
-				youngest_layer = layer;
-				missing = BIT(access_bit);
-			} else if (layer == youngest_layer) {
-				missing |= BIT(access_bit);
-			}
-		}
-		access_index++;
+		missing |= LANDLOCK_ACCESS_FS_TRUNCATE;
+		youngest_layer = max(youngest_layer, layer);
 	}
+	if (access_req & LANDLOCK_ACCESS_FS_IOCTL_DEV) {
+		size_t layer = (deny_masks & 0xf0) >> 4;
 
+		if (layer > youngest_layer)
+			missing = 0;
+
+		missing |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
+		youngest_layer = max(youngest_layer, layer);
+	}
 	*access_request = missing;
 	return youngest_layer;
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
-static void test_get_layer_from_deny_masks(struct kunit *const test)
+static void test_get_layer_from_fs_deny_masks(struct kunit *const test)
 {
 	deny_masks_t deny_mask;
 	access_mask_t access;
@@ -318,16 +288,12 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_fs_deny_masks(&access, deny_mask));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
 	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_fs_deny_masks(&access, deny_mask));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
 
 	/* truncate:15 ioctl_dev:15 */
@@ -335,16 +301,12 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_fs_deny_masks(&access, deny_mask));
 	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
 
 	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
 	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(&access,
-						  _LANDLOCK_ACCESS_FS_OPTIONAL,
-						  deny_mask));
+			get_layer_from_fs_deny_masks(&access, deny_mask));
 	KUNIT_EXPECT_EQ(test, access,
 			LANDLOCK_ACCESS_FS_TRUNCATE |
 				LANDLOCK_ACCESS_FS_IOCTL_DEV);
@@ -361,18 +323,15 @@ static bool is_valid_request(const struct landlock_request *const request)
 		return false;
 
 	if (request->access) {
-		if (WARN_ON_ONCE(!(!!request->layer_masks ^
+		if (WARN_ON_ONCE(!(!!request->masks ^
 				   !!request->all_existing_optional_access)))
 			return false;
 	} else {
-		if (WARN_ON_ONCE(request->layer_masks ||
+		if (WARN_ON_ONCE(request->masks ||
 				 request->all_existing_optional_access))
 			return false;
 	}
 
-	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request->layer_masks_size))
-		return false;
-
 	if (request->deny_masks) {
 		if (WARN_ON_ONCE(!request->all_existing_optional_access))
 			return false;
@@ -405,14 +364,12 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	missing = request->access;
 	if (missing) {
 		/* Gets the nearest domain that denies the request. */
-		if (request->layer_masks) {
+		if (request->masks) {
 			youngest_layer = get_denied_layer(
-				subject->domain, &missing, request->layer_masks,
-				request->layer_masks_size);
+				subject->domain, &missing, request->masks);
 		} else {
-			youngest_layer = get_layer_from_deny_masks(
-				&missing, request->all_existing_optional_access,
-				request->deny_masks);
+			youngest_layer = get_layer_from_fs_deny_masks(
+				&missing, request->deny_masks);
 		}
 		youngest_denied =
 			get_hierarchy(subject->domain, youngest_layer);
@@ -507,7 +464,7 @@ static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_hierarchy),
 	KUNIT_CASE(test_get_denied_layer),
-	KUNIT_CASE(test_get_layer_from_deny_masks),
+	KUNIT_CASE(test_get_layer_from_fs_deny_masks),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d80..104472060ef5e 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -43,8 +43,7 @@ struct landlock_request {
 	access_mask_t access;
 
 	/* Required fields for requests with layer masks. */
-	const layer_mask_t (*layer_masks)[];
-	size_t layer_masks_size;
+	const struct layer_access_masks *masks;
 
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d060..e8e4ae5d075fe 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -23,6 +23,7 @@
 #include "common.h"
 #include "domain.h"
 #include "id.h"
+#include "limits.h"
 
 #ifdef CONFIG_AUDIT
 
@@ -133,111 +134,47 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	return 0;
 }
 
-static deny_masks_t
-get_layer_deny_mask(const access_mask_t all_existing_optional_access,
-		    const unsigned long access_bit, const size_t layer)
-{
-	unsigned long access_weight;
-
-	/* This may require change with new object types. */
-	WARN_ON_ONCE(all_existing_optional_access !=
-		     _LANDLOCK_ACCESS_FS_OPTIONAL);
-
-	if (WARN_ON_ONCE(layer >= LANDLOCK_MAX_NUM_LAYERS))
-		return 0;
-
-	access_weight = hweight_long(all_existing_optional_access &
-				     GENMASK(access_bit, 0));
-	if (WARN_ON_ONCE(access_weight < 1))
-		return 0;
-
-	return layer
-	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
-}
-
-#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
-
-static void test_get_layer_deny_mask(struct kunit *const test)
-{
-	const unsigned long truncate = BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE);
-	const unsigned long ioctl_dev = BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV);
-
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
-					    truncate, 0));
-	KUNIT_EXPECT_EQ(test, 0x3,
-			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
-					    truncate, 3));
-
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
-					    ioctl_dev, 0));
-	KUNIT_EXPECT_EQ(test, 0xf0,
-			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
-					    ioctl_dev, 15));
-}
-
-#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-
 deny_masks_t
-landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
-			const access_mask_t optional_access,
-			const layer_mask_t (*const layer_masks)[],
-			const size_t layer_masks_size)
+landlock_get_fs_deny_masks(const access_mask_t optional_access,
+			   const struct layer_access_masks *layer_masks)
 {
-	const unsigned long access_opt = optional_access;
-	unsigned long access_bit;
-	deny_masks_t deny_masks = 0;
+	u8 truncate_layer = 0;
+	u8 ioctl_dev_layer = 0;
 
-	/* This may require change with new object types. */
-	WARN_ON_ONCE(access_opt !=
-		     (optional_access & all_existing_optional_access));
-
-	if (WARN_ON_ONCE(!layer_masks))
-		return 0;
-
-	if (WARN_ON_ONCE(!access_opt))
-		return 0;
-
-	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
-		const layer_mask_t mask = (*layer_masks)[access_bit];
-
-		if (!mask)
-			continue;
-
-		/* __fls(1) == 0 */
-		deny_masks |= get_layer_deny_mask(all_existing_optional_access,
-						  access_bit, __fls(mask));
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
+		if (layer_masks->access[i] & optional_access &
+		    LANDLOCK_ACCESS_FS_TRUNCATE)
+			truncate_layer = i;
+		if (layer_masks->access[i] & optional_access &
+		    LANDLOCK_ACCESS_FS_IOCTL_DEV)
+			ioctl_dev_layer = i;
 	}
-	return deny_masks;
+	return ((ioctl_dev_layer << 4) & 0xf0) | (truncate_layer & 0x0f);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
-static void test_landlock_get_deny_masks(struct kunit *const test)
+static void test_landlock_get_fs_deny_masks(struct kunit *const test)
 {
-	const layer_mask_t layers1[BITS_PER_TYPE(access_mask_t)] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
-							  BIT_ULL(9),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = BIT_ULL(1),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = BIT_ULL(2) |
-							    BIT_ULL(0),
+	const struct layer_access_masks layers1 = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
+			     LANDLOCK_ACCESS_FS_IOCTL_DEV,
+		.access[1] = LANDLOCK_ACCESS_FS_TRUNCATE,
+		.access[2] = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+		.access[9] = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
 
 	KUNIT_EXPECT_EQ(test, 0x1,
-			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
-						LANDLOCK_ACCESS_FS_TRUNCATE,
-						&layers1, ARRAY_SIZE(layers1)));
+			landlock_get_fs_deny_masks(LANDLOCK_ACCESS_FS_TRUNCATE,
+						   &layers1));
 	KUNIT_EXPECT_EQ(test, 0x20,
-			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
-						LANDLOCK_ACCESS_FS_IOCTL_DEV,
-						&layers1, ARRAY_SIZE(layers1)));
+			landlock_get_fs_deny_masks(LANDLOCK_ACCESS_FS_IOCTL_DEV,
+						   &layers1));
 	KUNIT_EXPECT_EQ(
 		test, 0x21,
-		landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
-					LANDLOCK_ACCESS_FS_TRUNCATE |
-						LANDLOCK_ACCESS_FS_IOCTL_DEV,
-					&layers1, ARRAY_SIZE(layers1)));
+		landlock_get_fs_deny_masks(LANDLOCK_ACCESS_FS_TRUNCATE |
+						   LANDLOCK_ACCESS_FS_IOCTL_DEV,
+					   &layers1));
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
@@ -246,8 +183,7 @@ static void test_landlock_get_deny_masks(struct kunit *const test)
 
 static struct kunit_case test_cases[] = {
 	/* clang-format off */
-	KUNIT_CASE(test_get_layer_deny_mask),
-	KUNIT_CASE(test_landlock_get_deny_masks),
+	KUNIT_CASE(test_landlock_get_fs_deny_masks),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a1..39600acb63897 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -120,10 +120,8 @@ struct landlock_hierarchy {
 #ifdef CONFIG_AUDIT
 
 deny_masks_t
-landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
-			const access_mask_t optional_access,
-			const layer_mask_t (*const layer_masks)[],
-			size_t layer_masks_size);
+landlock_get_fs_deny_masks(const access_mask_t optional_access,
+			   const struct layer_access_masks *layer_masks);
 
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b4ce03bef4b8e..1e765d22d8d49 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -407,57 +407,55 @@ static bool access_mask_subset(access_mask_t a, access_mask_t b)
 	return (a | b) == b;
 }
 
+/*
+ * Returns true iff the child file with the given src_child access rights under
+ * src_parent would result in having the same or fewer access rights if it were
+ * moved under new_parent.
+ */
+static bool may_refer(const struct layer_access_masks *const src_parent,
+		      const struct layer_access_masks *const src_child,
+		      const struct layer_access_masks *const new_parent,
+		      const bool child_is_dir)
+{
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
+		access_mask_t child_access = src_parent->access[i] &
+					     src_child->access[i];
+		access_mask_t parent_access = new_parent->access[i];
+
+		if (!child_is_dir) {
+			child_access &= ACCESS_FILE;
+			parent_access &= ACCESS_FILE;
+		}
+
+		if (!access_mask_subset(child_access, parent_access))
+			return false;
+	}
+	return true;
+}
+
 /*
  * Check that a destination file hierarchy has more restrictions than a source
  * file hierarchy.  This is only used for link and rename actions.
  *
- * @layer_masks_child2: Optional child masks.
+ * Returns: true if child1 may be moved from parent1 to parent2 without
+ * increasing its access rights.  If child2 is set, an additional condition is
+ * that child2 may be used from parent2 to parent1 without increasing its access
+ * rights.
  */
-static bool no_more_access(
-	const layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
-	const layer_mask_t (*const layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS],
-	const bool child1_is_directory,
-	const layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
-	const layer_mask_t (*const layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS],
-	const bool child2_is_directory)
+static bool no_more_access(const struct layer_access_masks *const parent1,
+			   const struct layer_access_masks *const child1,
+			   const bool child1_is_dir,
+			   const struct layer_access_masks *const parent2,
+			   const struct layer_access_masks *const child2,
+			   const bool child2_is_dir)
 {
-	unsigned long access_bit;
+	if (!may_refer(parent1, child1, parent2, child1_is_dir))
+		return false;
 
-	for (access_bit = 0; access_bit < ARRAY_SIZE(*layer_masks_parent2);
-	     access_bit++) {
-		/* Ignores accesses that only make sense for directories. */
-		const bool is_file_access =
-			!!(BIT_ULL(access_bit) & ACCESS_FILE);
+	if (!child2)
+		return true;
 
-		if (child1_is_directory || is_file_access) {
-			/*
-			 * Checks if the destination restrictions are a
-			 * superset of the source ones (i.e. inherited access
-			 * rights without child exceptions):
-			 * restrictions(parent2) >= restrictions(child1)
-			 */
-			if ((((*layer_masks_parent1)[access_bit] &
-			      (*layer_masks_child1)[access_bit]) |
-			     (*layer_masks_parent2)[access_bit]) !=
-			    (*layer_masks_parent2)[access_bit])
-				return false;
-		}
-
-		if (!layer_masks_child2)
-			continue;
-		if (child2_is_directory || is_file_access) {
-			/*
-			 * Checks inverted restrictions for RENAME_EXCHANGE:
-			 * restrictions(parent1) >= restrictions(child2)
-			 */
-			if ((((*layer_masks_parent2)[access_bit] &
-			      (*layer_masks_child2)[access_bit]) |
-			     (*layer_masks_parent1)[access_bit]) !=
-			    (*layer_masks_parent1)[access_bit])
-				return false;
-		}
-	}
-	return true;
+	return may_refer(parent2, child2, parent1, child2_is_dir);
 }
 
 #define NMA_TRUE(...) KUNIT_EXPECT_TRUE(test, no_more_access(__VA_ARGS__))
@@ -467,25 +465,25 @@ static bool no_more_access(
 
 static void test_no_more_access(struct kunit *const test)
 {
-	const layer_mask_t rx0[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT_ULL(0),
+	const struct layer_access_masks rx0 = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
+			     LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	const layer_mask_t mx0[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = BIT_ULL(0),
+	const struct layer_access_masks mx0 = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE |
+			     LANDLOCK_ACCESS_FS_MAKE_REG,
 	};
-	const layer_mask_t x0[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
+	const struct layer_access_masks x0 = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const layer_mask_t x1[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(1),
+	const struct layer_access_masks x1 = {
+		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const layer_mask_t x01[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
-							  BIT_ULL(1),
+	const struct layer_access_masks x01 = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
+		.access[1] = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	const layer_mask_t allows_all[LANDLOCK_NUM_ACCESS_FS] = {};
+	const struct layer_access_masks allows_all = {};
 
 	/* Checks without restriction. */
 	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
@@ -573,31 +571,30 @@ static void test_no_more_access(struct kunit *const test)
 #undef NMA_TRUE
 #undef NMA_FALSE
 
-static bool is_layer_masks_allowed(
-	layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
 {
-	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
+	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
 }
 
 /*
- * Removes @layer_masks accesses that are not requested.
+ * Removes @masks accesses that are not requested.
  *
  * Returns true if the request is allowed, false otherwise.
  */
-static bool
-scope_to_request(const access_mask_t access_request,
-		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+static bool scope_to_request(const access_mask_t access_request,
+			     struct layer_access_masks *masks)
 {
-	const unsigned long access_req = access_request;
-	unsigned long access_bit;
+	bool saw_unfulfilled_access = false;
 
-	if (WARN_ON_ONCE(!layer_masks))
+	if (WARN_ON_ONCE(!masks))
 		return true;
 
-	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
-		(*layer_masks)[access_bit] = 0;
-
-	return is_layer_masks_allowed(layer_masks);
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
+		masks->access[i] &= access_request;
+		if (masks->access[i])
+			saw_unfulfilled_access = true;
+	}
+	return !saw_unfulfilled_access;
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
@@ -605,48 +602,41 @@ scope_to_request(const access_mask_t access_request,
 static void test_scope_to_request_with_exec_none(struct kunit *const test)
 {
 	/* Allows everything. */
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks masks = {};
 
 	/* Checks and scopes with execute. */
-	KUNIT_EXPECT_TRUE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
-						 &layer_masks));
-	KUNIT_EXPECT_EQ(test, 0,
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
-	KUNIT_EXPECT_EQ(test, 0,
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+	KUNIT_EXPECT_TRUE(test,
+			  scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE, &masks));
+	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
 }
 
 static void test_scope_to_request_with_exec_some(struct kunit *const test)
 {
 	/* Denies execute and write. */
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(1),
+	struct layer_access_masks masks = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
+		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
 	/* Checks and scopes with execute. */
 	KUNIT_EXPECT_FALSE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
-						  &layer_masks));
-	KUNIT_EXPECT_EQ(test, BIT_ULL(0),
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
-	KUNIT_EXPECT_EQ(test, 0,
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+						  &masks));
+	KUNIT_EXPECT_EQ(test, LANDLOCK_ACCESS_FS_EXECUTE, masks.access[0]);
+	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
 }
 
 static void test_scope_to_request_without_access(struct kunit *const test)
 {
 	/* Denies execute and write. */
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0),
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(1),
+	struct layer_access_masks masks = {
+		.access[0] = LANDLOCK_ACCESS_FS_EXECUTE,
+		.access[1] = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
 	/* Checks and scopes without access request. */
-	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &layer_masks));
-	KUNIT_EXPECT_EQ(test, 0,
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
-	KUNIT_EXPECT_EQ(test, 0,
-			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
+	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &masks));
+	KUNIT_EXPECT_EQ(test, 0, masks.access[0]);
+	KUNIT_EXPECT_EQ(test, 0, masks.access[1]);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
@@ -655,20 +645,16 @@ static void test_scope_to_request_without_access(struct kunit *const test)
  * Returns true if there is at least one access right different than
  * LANDLOCK_ACCESS_FS_REFER.
  */
-static bool
-is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
-	  const access_mask_t access_request)
+static bool is_eacces(const struct layer_access_masks *masks,
+		      const access_mask_t access_request)
 {
-	unsigned long access_bit;
-	/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
-	const unsigned long access_check = access_request &
-					   ~LANDLOCK_ACCESS_FS_REFER;
-
-	if (!layer_masks)
+	if (!masks)
 		return false;
 
-	for_each_set_bit(access_bit, &access_check, ARRAY_SIZE(*layer_masks)) {
-		if ((*layer_masks)[access_bit])
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
+		/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
+		if (masks->access[i] & access_request &
+		    ~LANDLOCK_ACCESS_FS_REFER)
 			return true;
 	}
 	return false;
@@ -681,37 +667,37 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 
 static void test_is_eacces_with_none(struct kunit *const test)
 {
-	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	const struct layer_access_masks masks = {};
 
-	IE_FALSE(&layer_masks, 0);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+	IE_FALSE(&masks, 0);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_EXECUTE);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
 }
 
 static void test_is_eacces_with_refer(struct kunit *const test)
 {
-	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = BIT_ULL(0),
+	const struct layer_access_masks masks = {
+		.access[0] = LANDLOCK_ACCESS_FS_REFER,
 	};
 
-	IE_FALSE(&layer_masks, 0);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+	IE_FALSE(&masks, 0);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_EXECUTE);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
 }
 
 static void test_is_eacces_with_write(struct kunit *const test)
 {
-	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
-		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = BIT_ULL(0),
+	const struct layer_access_masks masks = {
+		.access[0] = LANDLOCK_ACCESS_FS_WRITE_FILE,
 	};
 
-	IE_FALSE(&layer_masks, 0);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
-	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
+	IE_FALSE(&masks, 0);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_REFER);
+	IE_FALSE(&masks, LANDLOCK_ACCESS_FS_EXECUTE);
 
-	IE_TRUE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
+	IE_TRUE(&masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
@@ -761,26 +747,25 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * - true if the access request is granted;
  * - false otherwise.
  */
-static bool is_access_to_paths_allowed(
-	const struct landlock_ruleset *const domain,
-	const struct path *const path,
-	const access_mask_t access_request_parent1,
-	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
-	struct landlock_request *const log_request_parent1,
-	struct dentry *const dentry_child1,
-	const access_mask_t access_request_parent2,
-	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
-	struct landlock_request *const log_request_parent2,
-	struct dentry *const dentry_child2)
+static bool
+is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
+			   const struct path *const path,
+			   const access_mask_t access_request_parent1,
+			   struct layer_access_masks *layer_masks_parent1,
+			   struct landlock_request *const log_request_parent1,
+			   struct dentry *const dentry_child1,
+			   const access_mask_t access_request_parent2,
+			   struct layer_access_masks *layer_masks_parent2,
+			   struct landlock_request *const log_request_parent2,
+			   struct dentry *const dentry_child2)
 {
 	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
 	     child1_is_directory = true, child2_is_directory = true;
 	struct path walker_path;
 	access_mask_t access_masked_parent1, access_masked_parent2;
-	layer_mask_t _layer_masks_child1[LANDLOCK_NUM_ACCESS_FS],
-		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
-	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
-	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
+	struct layer_access_masks _layer_masks_child1, _layer_masks_child2;
+	struct layer_access_masks *layer_masks_child1 = NULL,
+				  *layer_masks_child2 = NULL;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -820,22 +805,20 @@ static bool is_access_to_paths_allowed(
 	}
 
 	if (unlikely(dentry_child1)) {
-		landlock_unmask_layers(
-			find_rule(domain, dentry_child1),
-			landlock_init_layer_masks(
-				domain, LANDLOCK_MASK_ACCESS_FS,
-				&_layer_masks_child1, LANDLOCK_KEY_INODE),
-			&_layer_masks_child1, ARRAY_SIZE(_layer_masks_child1));
+		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+					      &_layer_masks_child1,
+					      LANDLOCK_KEY_INODE))
+			landlock_unmask_layers(find_rule(domain, dentry_child1),
+					       &_layer_masks_child1);
 		layer_masks_child1 = &_layer_masks_child1;
 		child1_is_directory = d_is_dir(dentry_child1);
 	}
 	if (unlikely(dentry_child2)) {
-		landlock_unmask_layers(
-			find_rule(domain, dentry_child2),
-			landlock_init_layer_masks(
-				domain, LANDLOCK_MASK_ACCESS_FS,
-				&_layer_masks_child2, LANDLOCK_KEY_INODE),
-			&_layer_masks_child2, ARRAY_SIZE(_layer_masks_child2));
+		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+					      &_layer_masks_child2,
+					      LANDLOCK_KEY_INODE))
+			landlock_unmask_layers(find_rule(domain, dentry_child2),
+					       &_layer_masks_child2);
 		layer_masks_child2 = &_layer_masks_child2;
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
@@ -890,16 +873,12 @@ static bool is_access_to_paths_allowed(
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
+			landlock_unmask_layers(rule, layer_masks_parent1);
+		allowed_parent2 =
+			allowed_parent2 ||
+			landlock_unmask_layers(rule, layer_masks_parent2);
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -953,9 +932,7 @@ static bool is_access_to_paths_allowed(
 		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent1->audit.u.path = *path;
 		log_request_parent1->access = access_masked_parent1;
-		log_request_parent1->layer_masks = layer_masks_parent1;
-		log_request_parent1->layer_masks_size =
-			ARRAY_SIZE(*layer_masks_parent1);
+		log_request_parent1->masks = layer_masks_parent1;
 	}
 
 	if (!allowed_parent2) {
@@ -963,9 +940,7 @@ static bool is_access_to_paths_allowed(
 		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent2->audit.u.path = *path;
 		log_request_parent2->access = access_masked_parent2;
-		log_request_parent2->layer_masks = layer_masks_parent2;
-		log_request_parent2->layer_masks_size =
-			ARRAY_SIZE(*layer_masks_parent2);
+		log_request_parent2->masks = layer_masks_parent2;
 	}
 	return allowed_parent1 && allowed_parent2;
 }
@@ -978,7 +953,7 @@ static int current_check_access_path(const struct path *const path,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks;
 	struct landlock_request request = {};
 
 	if (!subject)
@@ -1053,10 +1028,10 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * - true if all the domain access rights are allowed for @dir;
  * - false if the walk reached @mnt_root.
  */
-static bool collect_domain_accesses(
-	const struct landlock_ruleset *const domain,
-	const struct dentry *const mnt_root, struct dentry *dir,
-	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
+				    const struct dentry *const mnt_root,
+				    struct dentry *dir,
+				    struct layer_access_masks *layer_masks_dom)
 {
 	unsigned long access_dom;
 	bool ret = false;
@@ -1075,9 +1050,8 @@ static bool collect_domain_accesses(
 		struct dentry *parent_dentry;
 
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
-					   layer_masks_dom,
-					   ARRAY_SIZE(*layer_masks_dom))) {
+		if (landlock_unmask_layers(find_rule(domain, dir),
+					   layer_masks_dom)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
@@ -1165,8 +1139,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
 	struct dentry *old_parent;
-	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
-		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks_parent1 = {},
+				  layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
 	if (!subject)
@@ -1323,7 +1297,8 @@ static void hook_sb_delete(struct super_block *const sb)
 		 * second call to iput() for the same Landlock object.  Also
 		 * checks I_NEW because such inode cannot be tied to an object.
 		 */
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode_state_read(inode) &
+		    (I_FREEING | I_WILL_FREE | I_NEW)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1641,7 +1616,7 @@ static bool is_device(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_cred_security *const subject =
@@ -1676,20 +1651,14 @@ static int hook_file_open(struct file *const file)
 		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
-		unsigned long access_bit;
-		const unsigned long access_req = full_access_request;
-
 		/*
 		 * Calculate the actual allowed access rights from layer_masks.
-		 * Add each access right to allowed_access which has not been
-		 * vetoed by any layer.
+		 * Remove the access rights from the full access request which
+		 * are still unfulfilled in any of the layers.
 		 */
-		allowed_access = 0;
-		for_each_set_bit(access_bit, &access_req,
-				 ARRAY_SIZE(layer_masks)) {
-			if (!layer_masks[access_bit])
-				allowed_access |= BIT_ULL(access_bit);
-		}
+		allowed_access = full_access_request;
+		for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
+			allowed_access &= ~layer_masks.access[i];
 	}
 
 	/*
@@ -1700,9 +1669,8 @@ static int hook_file_open(struct file *const file)
 	 */
 	landlock_file(file)->allowed_access = allowed_access;
 #ifdef CONFIG_AUDIT
-	landlock_file(file)->deny_masks = landlock_get_deny_masks(
-		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks,
-		ARRAY_SIZE(layer_masks));
+	landlock_file(file)->deny_masks =
+		landlock_get_fs_deny_masks(optional_access, &layer_masks);
 #endif /* CONFIG_AUDIT */
 
 	if (access_mask_subset(open_access_request, allowed_access))
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1f3915a90a808..2a5456f4f017e 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -47,7 +47,7 @@ static int current_check_access_socket(struct socket *const sock,
 				       access_mask_t access_request)
 {
 	__be16 port;
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
+	struct layer_access_masks layer_masks = {};
 	const struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
@@ -178,8 +178,9 @@ static int current_check_access_socket(struct socket *const sock,
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
-	if (landlock_unmask_layers(rule, access_request, &layer_masks,
-				   ARRAY_SIZE(layer_masks)))
+	if (!access_request)
+		return 0;
+	if (landlock_unmask_layers(rule, &layer_masks))
 		return 0;
 
 	audit_net.family = address->sa_family;
@@ -189,8 +190,7 @@ static int current_check_access_socket(struct socket *const sock,
 				    .audit.type = LSM_AUDIT_DATA_NET,
 				    .audit.u.net = &audit_net,
 				    .access = access_request,
-				    .layer_masks = &layer_masks,
-				    .layer_masks_size = ARRAY_SIZE(layer_masks),
+				    .masks = &layer_masks,
 			    });
 	return -EACCES;
 }
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index dfcdc19ea2683..d20e28d38e9c9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -622,49 +622,24 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
  * request are empty).
  */
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    const access_mask_t access_request,
-			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size)
+			    struct layer_access_masks *masks)
 {
-	size_t layer_level;
-
-	if (!access_request || !layer_masks)
+	if (!masks)
 		return true;
 	if (!rule)
 		return false;
 
-	/*
-	 * An access is granted if, for each policy layer, at least one rule
-	 * encountered on the pathwalk grants the requested access,
-	 * regardless of its position in the layer stack.  We must then check
-	 * the remaining layers for each inode, from the first added layer to
-	 * the last one.  When there is multiple requested accesses, for each
-	 * policy layer, the full set of requested accesses may not be granted
-	 * by only one rule, but by the union (binary OR) of multiple rules.
-	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
-	 */
-	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
-		const struct landlock_layer *const layer =
-			&rule->layers[layer_level];
-		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
-		const unsigned long access_req = access_request;
-		unsigned long access_bit;
-		bool is_empty;
+	for (int i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *l = &rule->layers[i];
 
-		/*
-		 * Records in @layer_masks which layer grants access to each requested
-		 * access: bit cleared if the related layer grants access.
-		 */
-		is_empty = true;
-		for_each_set_bit(access_bit, &access_req, masks_array_size) {
-			if (layer->access & BIT_ULL(access_bit))
-				(*layer_masks)[access_bit] &= ~layer_bit;
-			is_empty = is_empty && !(*layer_masks)[access_bit];
-		}
-		if (is_empty)
-			return true;
+		masks->access[l->level - 1] &= ~l->access;
 	}
-	return false;
+
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
+		if (masks->access[i])
+			return false;
+	}
+	return true;
 }
 
 typedef access_mask_t
@@ -679,8 +654,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
  *
  * @domain: The domain that defines the current restrictions.
  * @access_request: The requested access rights to check.
- * @layer_masks: It must contain %LANDLOCK_NUM_ACCESS_FS or
- * %LANDLOCK_NUM_ACCESS_NET elements according to @key_type.
+ * @masks: Layer access masks to populate.
  * @key_type: The key type to switch between access masks of different types.
  *
  * Returns: An access mask where each access right bit is set which is handled
@@ -689,23 +663,20 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  const access_mask_t access_request,
-			  layer_mask_t (*const layer_masks)[],
+			  struct layer_access_masks *masks,
 			  const enum landlock_key_type key_type)
 {
 	access_mask_t handled_accesses = 0;
-	size_t layer_level, num_access;
 	get_access_mask_t *get_access_mask;
 
 	switch (key_type) {
 	case LANDLOCK_KEY_INODE:
 		get_access_mask = landlock_get_fs_access_mask;
-		num_access = LANDLOCK_NUM_ACCESS_FS;
 		break;
 
 #if IS_ENABLED(CONFIG_INET)
 	case LANDLOCK_KEY_NET_PORT:
 		get_access_mask = landlock_get_net_access_mask;
-		num_access = LANDLOCK_NUM_ACCESS_NET;
 		break;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
@@ -714,27 +685,18 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 		return 0;
 	}
 
-	memset(layer_masks, 0,
-	       array_size(sizeof((*layer_masks)[0]), num_access));
-
 	/* An empty access request can happen because of O_WRONLY | O_RDWR. */
 	if (!access_request)
 		return 0;
 
-	/* Saves all handled accesses per layer. */
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
-		const unsigned long access_req = access_request;
-		const access_mask_t access_mask =
-			get_access_mask(domain, layer_level);
-		unsigned long access_bit;
+	for (int i = 0; i < domain->num_layers; i++) {
+		const access_mask_t handled = get_access_mask(domain, i);
 
-		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) & access_mask) {
-				(*layer_masks)[access_bit] |=
-					BIT_ULL(layer_level);
-				handled_accesses |= BIT_ULL(access_bit);
-			}
-		}
+		masks->access[i] = access_request & handled;
+		handled_accesses |= masks->access[i];
 	}
+	for (int i = domain->num_layers; i < LANDLOCK_MAX_NUM_LAYERS; i++)
+		masks->access[i] = 0;
+
 	return handled_accesses;
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1a78cba662b24..f7b80b18c2a70 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -301,15 +301,25 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
+/**
+ * struct layer_accesses - A boolean matrix of layers and access rights
+ *
+ * This has a bit for each combination of layer numbers and access rights.
+ * During access checks, it is used to represent the access rights for each
+ * layer which still need to be fulfilled.  When all bits are 0, the access
+ * request is considered to be fulfilled.
+ */
+struct layer_access_masks {
+	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
+};
+
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    const access_mask_t access_request,
-			    layer_mask_t (*const layer_masks)[],
-			    const size_t masks_array_size);
+			    struct layer_access_masks *masks);
 
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  const access_mask_t access_request,
-			  layer_mask_t (*const layer_masks)[],
+			  struct layer_access_masks *masks,
 			  const enum landlock_key_type key_type);
 
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.52.0

