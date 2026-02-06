Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978F281368
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390745; cv=none; b=Q0IunNjf8lg+XEItUmTlPUCgJ5tTdrTO5IkJwbMll4AHVqdX3V0IY9ogPWG0mTeZWGucZOKVWak+Fvq2H1UL9m+0GWjb7FBIRVcWXf/CRhVOrvkUq+gX10X8yYK437ixxA/+rv+cVAyn6UoxOMlb2HeIZLB7jjpVvs8x1dF0798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390745; c=relaxed/simple;
	bh=yr+aKCxZiwsSKojER1jMLNXqDA0a2WWAqaK3DpPXp3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpCFAjf+q/OCqDKmsjZ5OQEOz8YNBF/rpWGbDB1W/RMlUBdiTDT4Fjn62VZAzH7kMx81Sc784LpglwMiHjQMvUam6FjUakz38Fte0AXuUx76F/VBMJ1FMQpm9zXdX5YgU1UKfK4gznGY/85Qs7JMHeHiAI+mwxNOHmdntaiGU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTCSETCm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTCSETCm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee2715254so14472005e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390743; x=1770995543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcSo6kAIOi9ddmQOSVTYvuXYWknjrsvWEfjbNuNxcuk=;
        b=XTCSETCmg4i1dOsCYe+g/F32vwSZneQ93Hv2reYQHYa3FJGwa0wzPt1gRoLk6NJKxE
         iwCASrH6ibO2SrE1YjDxZsmJd5Q+B/GG9W3PDzG7KbYFEb0LcEWNNBZmEvj73Fhx5n9x
         fTlWOSKcZkpLX3hJB7GkvfXjxV62sNF3UqAd3ZYOZYxRBQDie/4Lo+sUcu53cLq6qTMs
         WOA3DLPHdFhVBbd5tF5d+enkt5pQPGj0yTwZ9GLQ7ihwSDyIowyCurku8mddR0zi4BAB
         kVg4tnku0SvMvVBGX3PvvqdssMfuT64psgASOJTXHHtWgYx7c0hFZTmVw+OEl77QF4hy
         dOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390743; x=1770995543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcSo6kAIOi9ddmQOSVTYvuXYWknjrsvWEfjbNuNxcuk=;
        b=uWoArbl4G4WU5cJRQmfLVbN8DrTV4JoeL+Yck5zUL5jWIYwk/Sbsc0xYqg7nwCs1rs
         o9wuaMKuflB6WcNbEaI17d3r6ASSPP3hpfVNSwQFIP+drvh6XUxGL21118s6ITqNbw+i
         +DNNKhh2Du98/eEezm+SapZ3ZX8wUxsjRY4MItWzsAAwqnxtE4Gid3OHB2USlx5BSToR
         Sh8SqCbZmQXbrHxJFPbuum5kU023nble98LjQIcmNarPnCBAHMZr8L/kCpyYgpIR2H+F
         UDP5OH8k5+lGKmI+Vu+ZKZeJtWvqYzc6o09fIvCpr7Ph3yFBmGKMK9JCdwT9AmLM7yC/
         9B1A==
X-Forwarded-Encrypted: i=1; AJvYcCU21vmXUfEpehAh3hZi9RorkTNqzrvtOSxhSkwWdJo8wtI3WufEkOsuc75H+c81HoSRYhhBp5/fAw3xygugi9nw2yHL82M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAYBf9VISwrfSsWywZAMQXUguR6oEV26OZPpaEvPzErK41HQT
	tAAbAc8ZKh6yapDRv/1N3aaHLkR1mZFho6ghmjmtmaJ1ul7rnxumZR45
X-Gm-Gg: AZuq6aKdeAnEG1Csgl0j62yhomTbJ1K0mvFXvd1c2r0RHlHK+7xtMgP/QOrCNYHmkwF
	Nebp6WKzItiTpcnPjrG5iCu+AB1R9cI9Yfp+Jy20hROLd/B0AWD3XJSGy5EcAM33xb657GN9V0y
	5igvgYrKdj3m1+5j1OKBhpQPyKfhVlMo0sUwvezCFjbur/OTseDsbY5QnP0UqAIbmhNzuaTZ5Pa
	uSTmTasGDSA3PitT7EeBwgugN9d8ii0iYpf8IYMEUUaZ4il4oQz+kxL6q8XqWjJqmaafhHgxS9p
	srifs6LHxHmmQ3ttxjTSbfK6kpIp/NlFQMu+wwetmgP3Ru9q5H53Otcpj5vUI0yj5wWP+UF4Hjv
	KsSYHjYoyct17BcR47euO8p5aZ/HKYClzBHuZgwesQYY0rq+2DucaY6g1Dx+yK+EOjk7tfaCl4R
	hhQOe7DsfMjnamo4j2SMpx/mcyC7xGyj8v8LZa
X-Received: by 2002:a05:600c:4753:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4832021b564mr44135635e9.18.1770390743032;
        Fri, 06 Feb 2026 07:12:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ef1sm6939946f8f.7.2026.02.06.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:12:22 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 3/3] landlock: transpose the layer masks data structure
Date: Fri,  6 Feb 2026 16:11:55 +0100
Message-ID: <20260206151154.97915-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206151154.97915-2-gnoack3000@gmail.com>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The layer masks data structure tracks the requested but unfulfilled
access rights during an operation's security check.  It stores one bit
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
  branch speculation and lends itself to better loop unrolling.)

* Code is ~75 lines smaller.

Other noteworthy changes:

* In no_more_access(), call a new helper function may_refer(), which
  only solves the asymmetric case.  Previously, the code interleaved
  the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
  that the code is clearer when renames without RENAME_EXCHANGE are
  more obviously the normal case.

Tradeoffs:

This change improves performance, at a slight size increase to the
layer masks data structure.

This fixes the size of the data structure at 32 bytes for all types of
access rights. (64, once we introduce a 17th filesystem access right).

For filesystem access rights, at the moment, the data structure has
the same size as before, but once we introduce the 17th filesystem
access right, it will double in size (from 32 to 64 bytes), as
access_mask_t grows from 16 to 32 bit. [1]

Link: https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/ [1]
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/access.h  |  15 +-
 security/landlock/audit.c   |  81 +++------
 security/landlock/audit.h   |   3 +-
 security/landlock/domain.c  |  45 ++---
 security/landlock/domain.h  |   4 +-
 security/landlock/fs.c      | 348 ++++++++++++++++--------------------
 security/landlock/net.c     |   9 +-
 security/landlock/ruleset.c |  89 ++++-----
 security/landlock/ruleset.h |  21 ++-
 9 files changed, 274 insertions(+), 341 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index bab403470a6c..f0a9afeb4a2a 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -61,14 +61,15 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
-typedef u16 layer_mask_t;
-
-/* Makes sure all layers can be checked. */
-static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
-
 /*
- * Tracks domains responsible of a denied access.  This is required to avoid
- * storing in each object the full layer_masks[] required by update_request().
+ * Tracks domains responsible of a denied access.  This avoids storing in each
+ * object the full matrix of per-layer unfulfilled access rights, which is
+ * required by update_request().
+ *
+ * Each nibble represents the layer index of the newest layer which denied a
+ * certain access right.  For file system access rights, the upper four bits are
+ * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
+ * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
  */
 typedef u8 deny_masks_t;
 
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e899995f1fd5..60ff217ab95b 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -180,38 +180,21 @@ static void test_get_hierarchy(struct kunit *const test)
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
+/* Get the youngest layer that denied the access_request. */
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
-		const layer_mask_t mask = (*layer_masks)[access_bit];
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
+	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
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
@@ -221,50 +204,39 @@ static void test_get_denied_layer(struct kunit *const test)
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
 
@@ -370,9 +342,6 @@ static bool is_valid_request(const struct landlock_request *const request)
 			return false;
 	}
 
-	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request->layer_masks_size))
-		return false;
-
 	if (request->deny_masks) {
 		if (WARN_ON_ONCE(!request->all_existing_optional_access))
 			return false;
@@ -406,12 +375,12 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (missing) {
 		/* Gets the nearest domain that denies the request. */
 		if (request->layer_masks) {
-			youngest_layer = get_denied_layer(
-				subject->domain, &missing, request->layer_masks,
-				request->layer_masks_size);
+			youngest_layer = get_denied_layer(subject->domain,
+							  &missing,
+							  request->layer_masks);
 		} else {
 			youngest_layer = get_layer_from_deny_masks(
-				&missing, request->all_existing_optional_access,
+				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
 				request->deny_masks);
 		}
 		youngest_denied =
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d8..56778331b58c 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -43,8 +43,7 @@ struct landlock_request {
 	access_mask_t access;
 
 	/* Required fields for requests with layer masks. */
-	const layer_mask_t (*layer_masks)[];
-	size_t layer_masks_size;
+	const struct layer_access_masks *layer_masks;
 
 	/* Required fields for requests with deny masks. */
 	const access_mask_t all_existing_optional_access;
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..d2a4354feeb4 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -7,6 +7,7 @@
  * Copyright © 2024-2025 Microsoft Corporation
  */
 
+#include "ruleset.h"
 #include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
@@ -182,32 +183,36 @@ static void test_get_layer_deny_mask(struct kunit *const test)
 deny_masks_t
 landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
-			const layer_mask_t (*const layer_masks)[],
-			const size_t layer_masks_size)
+			const struct layer_access_masks *const masks)
 {
 	const unsigned long access_opt = optional_access;
 	unsigned long access_bit;
+	access_mask_t all_denied = 0;
 	deny_masks_t deny_masks = 0;
 
 	/* This may require change with new object types. */
-	WARN_ON_ONCE(access_opt !=
-		     (optional_access & all_existing_optional_access));
+	WARN_ON_ONCE(!access_mask_subset(optional_access,
+					 all_existing_optional_access));
 
-	if (WARN_ON_ONCE(!layer_masks))
+	if (WARN_ON_ONCE(!masks))
 		return 0;
 
 	if (WARN_ON_ONCE(!access_opt))
 		return 0;
 
-	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
-		const layer_mask_t mask = (*layer_masks)[access_bit];
+	for (ssize_t i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
+		const access_mask_t denied = masks->access[i] & optional_access;
+		const unsigned long newly_denied = denied & ~all_denied;
 
-		if (!mask)
+		if (!newly_denied)
 			continue;
 
-		/* __fls(1) == 0 */
-		deny_masks |= get_layer_deny_mask(all_existing_optional_access,
-						  access_bit, __fls(mask));
+		for_each_set_bit(access_bit, &newly_denied,
+				 8 * sizeof(access_mask_t)) {
+			deny_masks |= get_layer_deny_mask(
+				all_existing_optional_access, access_bit, i);
+		}
+		all_denied |= denied;
 	}
 	return deny_masks;
 }
@@ -216,28 +221,28 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 
 static void test_landlock_get_deny_masks(struct kunit *const test)
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
 			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
 						LANDLOCK_ACCESS_FS_TRUNCATE,
-						&layers1, ARRAY_SIZE(layers1)));
+						&layers1));
 	KUNIT_EXPECT_EQ(test, 0x20,
 			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
 						LANDLOCK_ACCESS_FS_IOCTL_DEV,
-						&layers1, ARRAY_SIZE(layers1)));
+						&layers1));
 	KUNIT_EXPECT_EQ(
 		test, 0x21,
 		landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
 					LANDLOCK_ACCESS_FS_TRUNCATE |
 						LANDLOCK_ACCESS_FS_IOCTL_DEV,
-					&layers1, ARRAY_SIZE(layers1)));
+					&layers1));
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 621f054c9a2b..227066d667f7 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,6 +10,7 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include "ruleset.h"
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/path.h>
@@ -122,8 +123,7 @@ struct landlock_hierarchy {
 deny_masks_t
 landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
-			const layer_mask_t (*const layer_masks)[],
-			size_t layer_masks_size);
+			const struct layer_access_masks *const masks);
 
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index aa8e7cddb929..e764470f588c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -398,57 +398,55 @@ static const struct access_masks any_fs = {
 	.fs = ~0,
 };
 
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
+	for (size_t i = 0; i < ARRAY_SIZE(new_parent->access); i++) {
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
@@ -458,25 +456,25 @@ static bool no_more_access(
 
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
@@ -564,31 +562,30 @@ static void test_no_more_access(struct kunit *const test)
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
+	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
+		masks->access[i] &= access_request;
+		if (masks->access[i])
+			saw_unfulfilled_access = true;
+	}
+	return !saw_unfulfilled_access;
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
@@ -596,48 +593,41 @@ scope_to_request(const access_mask_t access_request,
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
@@ -646,20 +636,16 @@ static void test_scope_to_request_without_access(struct kunit *const test)
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
+	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
+		/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
+		if (masks->access[i] & access_request &
+		    ~LANDLOCK_ACCESS_FS_REFER)
 			return true;
 	}
 	return false;
@@ -672,37 +658,37 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 
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
@@ -752,26 +738,25 @@ static void test_is_eacces_with_write(struct kunit *const test)
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
@@ -811,22 +796,20 @@ static bool is_access_to_paths_allowed(
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
@@ -881,16 +864,12 @@ static bool is_access_to_paths_allowed(
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
@@ -950,8 +929,6 @@ static bool is_access_to_paths_allowed(
 		log_request_parent1->audit.u.path = *path;
 		log_request_parent1->access = access_masked_parent1;
 		log_request_parent1->layer_masks = layer_masks_parent1;
-		log_request_parent1->layer_masks_size =
-			ARRAY_SIZE(*layer_masks_parent1);
 	}
 
 	if (!allowed_parent2 && log_request_parent2) {
@@ -960,8 +937,6 @@ static bool is_access_to_paths_allowed(
 		log_request_parent2->audit.u.path = *path;
 		log_request_parent2->access = access_masked_parent2;
 		log_request_parent2->layer_masks = layer_masks_parent2;
-		log_request_parent2->layer_masks_size =
-			ARRAY_SIZE(*layer_masks_parent2);
 	}
 #endif /* CONFIG_AUDIT */
 
@@ -976,7 +951,7 @@ static int current_check_access_path(const struct path *const path,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks;
 	struct landlock_request request = {};
 
 	if (!subject)
@@ -1051,12 +1026,11 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
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
-	unsigned long access_dom;
 	bool ret = false;
 
 	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
@@ -1064,18 +1038,17 @@ static bool collect_domain_accesses(
 	if (is_nouser_or_private(dir))
 		return true;
 
-	access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-					       layer_masks_dom,
-					       LANDLOCK_KEY_INODE);
+	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+				       layer_masks_dom, LANDLOCK_KEY_INODE))
+		return true;
 
 	dget(dir);
 	while (true) {
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
@@ -1163,8 +1136,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
 	struct dentry *old_parent;
-	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
-		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks_parent1 = {},
+				  layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
 	if (!subject)
@@ -1640,7 +1613,7 @@ static bool is_device(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct layer_access_masks layer_masks = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_cred_security *const subject =
@@ -1675,20 +1648,14 @@ static int hook_file_open(struct file *const file)
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
+		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
+			allowed_access &= ~layer_masks.access[i];
 	}
 
 	/*
@@ -1700,8 +1667,7 @@ static int hook_file_open(struct file *const file)
 	landlock_file(file)->allowed_access = allowed_access;
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
-		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks,
-		ARRAY_SIZE(layer_masks));
+		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
 #endif /* CONFIG_AUDIT */
 
 	if (access_mask_subset(open_access_request, allowed_access))
diff --git a/security/landlock/net.c b/security/landlock/net.c
index e6367e30e5b0..55684d79aac9 100644
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
@@ -194,8 +194,10 @@ static int current_check_access_socket(struct socket *const sock,
 	access_request = landlock_init_layer_masks(subject->domain,
 						   access_request, &layer_masks,
 						   LANDLOCK_KEY_NET_PORT);
-	if (landlock_unmask_layers(rule, access_request, &layer_masks,
-				   ARRAY_SIZE(layer_masks)))
+	if (!access_request)
+		return 0;
+
+	if (landlock_unmask_layers(rule, &layer_masks))
 		return 0;
 
 	audit_net.family = address->sa_family;
@@ -206,7 +208,6 @@ static int current_check_access_socket(struct socket *const sock,
 				    .audit.u.net = &audit_net,
 				    .access = access_request,
 				    .layer_masks = &layer_masks,
-				    .layer_masks_size = ARRAY_SIZE(layer_masks),
 			    });
 	return -EACCES;
 }
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 0a5b0c76b3f7..419b237de635 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -612,22 +612,24 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
 	return NULL;
 }
 
-/*
- * @layer_masks is read and may be updated according to the access request and
- * the matching rule.
- * @masks_array_size must be equal to ARRAY_SIZE(*layer_masks).
+/**
+ * landlock_unmask_layers - Remove the access rights in @masks
+ *                          which are granted in @rule
  *
- * Returns true if the request is allowed (i.e. relevant layer masks for the
- * request are empty).
+ * Updates the set of (per-layer) unfulfilled access rights @masks
+ * so that all the access rights granted in @rule are removed from it
+ * (because they are now fulfilled).
+ *
+ * @rule: A rule that grants a set of access rights for each layer
+ * @masks: A matrix of unfulfilled access rights for each layer
+ *
+ * Returns true if the request is allowed (i.e. the access rights granted all
+ * remaining unfulfilled access rights and masks has no leftover set bits).
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
@@ -642,28 +644,18 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 	 * by only one rule, but by the union (binary OR) of multiple rules.
 	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
 	 */
-	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
-		const struct landlock_layer *const layer =
-			&rule->layers[layer_level];
-		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
-		const unsigned long access_req = access_request;
-		unsigned long access_bit;
-		bool is_empty;
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
 
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
+		/* Clear the bits where the layer in the rule grants access. */
+		masks->access[layer->level - 1] &= ~layer->access;
 	}
-	return false;
+
+	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
+		if (masks->access[i])
+			return false;
+	}
+	return true;
 }
 
 typedef access_mask_t
@@ -673,13 +665,12 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
 /**
  * landlock_init_layer_masks - Initialize layer masks from an access request
  *
- * Populates @layer_masks such that for each access right in @access_request,
+ * Populates @masks such that for each access right in @access_request,
  * the bits for all the layers are set where this access right is handled.
  *
  * @domain: The domain that defines the current restrictions.
  * @access_request: The requested access rights to check.
- * @layer_masks: It must contain %LANDLOCK_NUM_ACCESS_FS or
- * %LANDLOCK_NUM_ACCESS_NET elements according to @key_type.
+ * @masks: Layer access masks to populate.
  * @key_type: The key type to switch between access masks of different types.
  *
  * Returns: An access mask where each access right bit is set which is handled
@@ -688,23 +679,20 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
 access_mask_t
 landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 			  const access_mask_t access_request,
-			  layer_mask_t (*const layer_masks)[],
+			  struct layer_access_masks *const masks,
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
 
@@ -713,27 +701,18 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
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
+	for (size_t i = 0; i < domain->num_layers; i++) {
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
+	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->access); i++)
+		masks->access[i] = 0;
+
 	return handled_accesses;
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1a78cba662b2..1ceb5fd674c9 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -301,15 +301,28 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
+/**
+ * struct layer_access_masks - A boolean matrix of layers and access rights
+ *
+ * This has a bit for each combination of layer numbers and access rights.
+ * During access checks, it is used to represent the access rights for each
+ * layer which still need to be fulfilled.  When all bits are 0, the access
+ * request is considered to be fulfilled.
+ */
+struct layer_access_masks {
+	/**
+	 * @access: The unfulfilled access rights for each layer.
+	 */
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

