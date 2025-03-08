Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644B214804
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459497; cv=none; b=M2SXG4xIqgnCTVdLqmlR8qehT3sZbiGuivJ9IoA7k+Z8wJv3saAKYMRebyIwRhzaxSyTE46YvfxahXFlsrpncwUSJ2bqEL56lStTydE0JCXJX4rCmRtkZg4DDfpPKcvyvOx/6UrZFnLu+nOYvuMssqKwj50hAJHLDKzHpT/QDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459497; c=relaxed/simple;
	bh=oFxMeXnqX2G1gOHOziBdMSA/w6a02qM1v9C8NYzWddk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thayfbTUne9n/VPuGfIBCpl6FqYM8zdhYZ9iTnq3YQ/n1vKct2i7u4DRorpQpUVj1Iu1qNodhS78v4FGMM4DiqKrTGVTIrpRTsXpWP2tVrhIxiRh0rBSmLIs4Ep/yQTdsB4ulqkQXGcY2isfv29mvTn5GtYKLDJwrIFebwokwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BLheSZPn; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BLheSZPn"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsc43cwzMDG;
	Sat,  8 Mar 2025 19:44:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459492;
	bh=kr7M1k4+/TJxg3zCviSq2t1LZ/ISoxZbqckczhfqc08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLheSZPnKxfNp0/D2D4Z0C5plBIiRz85MPGRLSVLWLRX6sINXO4OjZQ1HK+Ca3flJ
	 SoctsboQGi9Z4abe9v90+NuNaECFCvSnFAL0xe4OKNS5LPLhUSu8mPNlh8iQXsRZaj
	 /WJP7YeJLwsjCxURwJpUWQLkVAoktUtVNHNHGLH8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsb5jKfzW8;
	Sat,  8 Mar 2025 19:44:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 13/26] landlock: Log truncate and IOCTL denials
Date: Sat,  8 Mar 2025 19:44:09 +0100
Message-ID: <20250308184422.2159360-14-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit support to the file_truncate and file_ioctl hooks.

Add a deny_masks_t type and related helpers to store the domain's layer
level per optional access rights (i.e. LANDLOCK_ACCESS_FS_TRUNCATE and
LANDLOCK_ACCESS_FS_IOCTL_DEV) when opening a file, which cannot be
inferred later.  In practice, the landlock_file_security aligned blob size is
still 16 bytes because this new one-byte deny_masks field follows the
existing two-bytes allowed_access field and precede the packed
fown_subject.

Implementing deny_masks_t with a bitfield instead of a struct enables a
generic implementation to store and extract layer levels.

Add KUnit tests to check the identification of a layer level from a
deny_masks_t, and the computation of a deny_masks_t from an access right
with its layer level or a layer_mask_t array.

Audit event sample:

  type=LANDLOCK_DENY msg=audit(1729738800.349:44): domain=195ba459b blockers=fs.ioctl_dev path="/dev/tty" dev="devtmpfs" ino=9 ioctlcmd=0x5401

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-14-mic@digikod.net
---

Changes since v5:
- Switch to LSM_AUDIT_DATA_IOCTL_OP for IOCTL hooks, and update sample
  accordingly.
- Move request declarations in the landlock_log_denial() calls to
  not impact allowed requests with audit, and remove update_request()
  which is now useless.

Changes since v4:
- Rebase on top of the landlock_log_denial() and subject type changes.

Changes since v3:
- Rename get_layer_from_deny_masks().

Changes since v2:
- Fix !CONFIG_AUDIT build warning.
- Rename ACCESS_FS_OPTIONAL to _LANDLOCK_ACCESS_FS_OPTIONAL.
---
 security/landlock/access.h |  23 +++++++
 security/landlock/audit.c  | 102 ++++++++++++++++++++++++++--
 security/landlock/audit.h  |   4 ++
 security/landlock/domain.c | 133 +++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h |   8 +++
 security/landlock/fs.c     |  48 +++++++++++++
 security/landlock/fs.h     |   9 +++
 7 files changed, 322 insertions(+), 5 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 74fd8f399fbd..1eaaafa63178 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -28,6 +28,12 @@
 	LANDLOCK_ACCESS_FS_REFER)
 /* clang-format on */
 
+/* clang-format off */
+#define _LANDLOCK_ACCESS_FS_OPTIONAL ( \
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+/* clang-format on */
+
 typedef u16 access_mask_t;
 
 /* Makes sure all filesystem access rights can be stored. */
@@ -60,6 +66,23 @@ typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
 
+/*
+ * Tracks domains responsible of a denied access.  This is required to avoid
+ * storing in each object the full layer_masks[] required by update_request().
+ */
+typedef u8 deny_masks_t;
+
+/*
+ * Makes sure all optional access rights can be tied to a layer index (cf.
+ * get_deny_mask).
+ */
+static_assert(BITS_PER_TYPE(deny_masks_t) >=
+	      (HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1) *
+	       HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL)));
+
+/* LANDLOCK_MAX_NUM_LAYERS must be a power of two (cf. deny_masks_t assert). */
+static_assert(HWEIGHT(LANDLOCK_MAX_NUM_LAYERS) == 1);
+
 /* Upgrades with all initially denied by default access rights. */
 static inline struct access_masks
 landlock_upgrade_handled_access_masks(struct access_masks access_masks)
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index bda095822aa2..edb9fbafbcad 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -13,10 +13,12 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
+#include "fs.h"
 #include "ruleset.h"
 
 static const char *const fs_access_strings[] = {
@@ -251,22 +253,111 @@ static void test_get_denied_layer(struct kunit *const test)
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
+static size_t
+get_layer_from_deny_masks(access_mask_t *const access_request,
+			  const access_mask_t all_existing_optional_access,
+			  const deny_masks_t deny_masks)
+{
+	const unsigned long access_opt = all_existing_optional_access;
+	const unsigned long access_req = *access_request;
+	access_mask_t missing = 0;
+	size_t youngest_layer = 0;
+	size_t access_index = 0;
+	unsigned long access_bit;
+
+	/* This will require change with new object types. */
+	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
+
+	for_each_set_bit(access_bit, &access_opt,
+			 BITS_PER_TYPE(access_mask_t)) {
+		if (access_req & BIT(access_bit)) {
+			const size_t layer =
+				(deny_masks >> (access_index * 4)) &
+				(LANDLOCK_MAX_NUM_LAYERS - 1);
+
+			if (layer > youngest_layer) {
+				youngest_layer = layer;
+				missing = BIT(access_bit);
+			} else if (layer == youngest_layer) {
+				missing |= BIT(access_bit);
+			}
+		}
+		access_index++;
+	}
+
+	*access_request = missing;
+	return youngest_layer;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_layer_from_deny_masks(struct kunit *const test)
+{
+	deny_masks_t deny_mask;
+	access_mask_t access;
+
+	/* truncate:0 ioctl_dev:2 */
+	deny_mask = 0x20;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(&access,
+						  _LANDLOCK_ACCESS_FS_OPTIONAL,
+						  deny_mask));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(&access,
+						  _LANDLOCK_ACCESS_FS_OPTIONAL,
+						  deny_mask));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+
+	/* truncate:15 ioctl_dev:15 */
+	deny_mask = 0xff;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(&access,
+						  _LANDLOCK_ACCESS_FS_OPTIONAL,
+						  deny_mask));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(&access,
+						  _LANDLOCK_ACCESS_FS_OPTIONAL,
+						  deny_mask));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_TRUNCATE |
+				LANDLOCK_ACCESS_FS_IOCTL_DEV);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
 static bool is_valid_request(const struct landlock_request *const request)
 {
 	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
 		return false;
 
 	if (request->access) {
-		if (WARN_ON_ONCE(!request->layer_masks))
+		if (WARN_ON_ONCE(!(!!request->layer_masks ^
+				   !!request->all_existing_optional_access)))
 			return false;
 	} else {
-		if (WARN_ON_ONCE(request->layer_masks))
+		if (WARN_ON_ONCE(request->layer_masks ||
+				 request->all_existing_optional_access))
 			return false;
 	}
 
 	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request->layer_masks_size))
 		return false;
 
+	if (request->deny_masks) {
+		if (WARN_ON_ONCE(!request->all_existing_optional_access))
+			return false;
+	}
+
 	return true;
 }
 
@@ -299,9 +390,9 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 				subject->domain, &missing, request->layer_masks,
 				request->layer_masks_size);
 		} else {
-			/* This will change with the next commit. */
-			WARN_ON_ONCE(1);
-			youngest_layer = subject->domain->num_layers;
+			youngest_layer = get_layer_from_deny_masks(
+				&missing, request->all_existing_optional_access,
+				request->deny_masks);
 		}
 		youngest_denied =
 			get_hierarchy(subject->domain, youngest_layer);
@@ -383,6 +474,7 @@ static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_hierarchy),
 	KUNIT_CASE(test_get_denied_layer),
+	KUNIT_CASE(test_get_layer_from_deny_masks),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index d14b779a2b00..6765a419001d 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -43,6 +43,10 @@ struct landlock_request {
 	/* Required fields for requests with layer masks. */
 	const layer_mask_t (*layer_masks)[];
 	size_t layer_masks_size;
+
+	/* Required fields for requests with deny masks. */
+	const access_mask_t all_existing_optional_access;
+	deny_masks_t deny_masks;
 };
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 6a731efca7be..6704e9283206 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -7,6 +7,9 @@
  * Copyright © 2024-2025 Microsoft Corporation
  */
 
+#include <kunit/test.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/cred.h>
 #include <linux/file.h>
 #include <linux/mm.h>
@@ -14,6 +17,8 @@
 #include <linux/pid.h>
 #include <linux/sched.h>
 
+#include "access.h"
+#include "common.h"
 #include "domain.h"
 #include "fs.h"
 #include "id.h"
@@ -126,4 +131,132 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	return 0;
 }
 
+static deny_masks_t
+get_layer_deny_mask(const access_mask_t all_existing_optional_access,
+		    const unsigned long access_bit, const size_t layer)
+{
+	unsigned long access_weight;
+
+	/* This may require change with new object types. */
+	WARN_ON_ONCE(all_existing_optional_access !=
+		     _LANDLOCK_ACCESS_FS_OPTIONAL);
+
+	if (WARN_ON_ONCE(layer >= LANDLOCK_MAX_NUM_LAYERS))
+		return 0;
+
+	access_weight = hweight_long(all_existing_optional_access &
+				     GENMASK(access_bit, 0));
+	if (WARN_ON_ONCE(access_weight < 1))
+		return 0;
+
+	return layer
+	       << ((access_weight - 1) * HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1));
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_layer_deny_mask(struct kunit *const test)
+{
+	const unsigned long truncate = BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE);
+	const unsigned long ioctl_dev = BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV);
+
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
+					    truncate, 0));
+	KUNIT_EXPECT_EQ(test, 0x3,
+			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
+					    truncate, 3));
+
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
+					    ioctl_dev, 0));
+	KUNIT_EXPECT_EQ(test, 0xf0,
+			get_layer_deny_mask(_LANDLOCK_ACCESS_FS_OPTIONAL,
+					    ioctl_dev, 15));
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+deny_masks_t
+landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
+			const access_mask_t optional_access,
+			const layer_mask_t (*const layer_masks)[],
+			const size_t layer_masks_size)
+{
+	const unsigned long access_opt = optional_access;
+	unsigned long access_bit;
+	deny_masks_t deny_masks = 0;
+
+	/* This may require change with new object types. */
+	WARN_ON_ONCE(access_opt !=
+		     (optional_access & all_existing_optional_access));
+
+	if (WARN_ON_ONCE(!layer_masks))
+		return 0;
+
+	if (WARN_ON_ONCE(!access_opt))
+		return 0;
+
+	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
+		const layer_mask_t mask = (*layer_masks)[access_bit];
+
+		if (!mask)
+			continue;
+
+		/* __fls(1) == 0 */
+		deny_masks |= get_layer_deny_mask(all_existing_optional_access,
+						  access_bit, __fls(mask));
+	}
+	return deny_masks;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_landlock_get_deny_masks(struct kunit *const test)
+{
+	const layer_mask_t layers1[BITS_PER_TYPE(access_mask_t)] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT_ULL(0) |
+							  BIT_ULL(9),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = BIT_ULL(1),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = BIT_ULL(2) |
+							    BIT_ULL(0),
+	};
+
+	KUNIT_EXPECT_EQ(test, 0x1,
+			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
+						LANDLOCK_ACCESS_FS_TRUNCATE,
+						&layers1, ARRAY_SIZE(layers1)));
+	KUNIT_EXPECT_EQ(test, 0x20,
+			landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
+						LANDLOCK_ACCESS_FS_IOCTL_DEV,
+						&layers1, ARRAY_SIZE(layers1)));
+	KUNIT_EXPECT_EQ(
+		test, 0x21,
+		landlock_get_deny_masks(_LANDLOCK_ACCESS_FS_OPTIONAL,
+					LANDLOCK_ACCESS_FS_TRUNCATE |
+						LANDLOCK_ACCESS_FS_IOCTL_DEV,
+					&layers1, ARRAY_SIZE(layers1)));
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_get_layer_deny_mask),
+	KUNIT_CASE(test_landlock_get_deny_masks),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_domain",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
 #endif /* CONFIG_AUDIT */
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 008ea7a26cb2..c1ab2fe1d441 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -19,6 +19,8 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#include "access.h"
+
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
@@ -125,6 +127,12 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
+deny_masks_t
+landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
+			const access_mask_t optional_access,
+			const layer_mask_t (*const layer_masks)[],
+			size_t layer_masks_size);
+
 #else /* CONFIG_AUDIT */
 
 static inline int
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ee233128759d..14f9c6d9903f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1669,6 +1669,11 @@ static int hook_file_open(struct file *const file)
 	 * file access rights in the opened struct file.
 	 */
 	landlock_file(file)->allowed_access = allowed_access;
+#ifdef CONFIG_AUDIT
+	landlock_file(file)->deny_masks = landlock_get_deny_masks(
+		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks,
+		ARRAY_SIZE(layer_masks));
+#endif /* CONFIG_AUDIT */
 
 	if ((open_access_request & allowed_access) == open_access_request)
 		return 0;
@@ -1693,6 +1698,19 @@ static int hook_file_truncate(struct file *const file)
 	 */
 	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_TRUNCATE)
 		return 0;
+
+	landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_ACCESS,
+		.audit = {
+			.type = LSM_AUDIT_DATA_FILE,
+			.u.file = file,
+		},
+		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
+		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+#ifdef CONFIG_AUDIT
+		.deny_masks = landlock_file(file)->deny_masks,
+#endif /* CONFIG_AUDIT */
+	});
 	return -EACCES;
 }
 
@@ -1716,6 +1734,21 @@ static int hook_file_ioctl(struct file *file, unsigned int cmd,
 	if (is_masked_device_ioctl(cmd))
 		return 0;
 
+	landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_ACCESS,
+		.audit = {
+			.type = LSM_AUDIT_DATA_IOCTL_OP,
+			.u.op = &(struct lsm_ioctlop_audit) {
+				.path = file->f_path,
+				.cmd = cmd,
+			},
+		},
+		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
+		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+#ifdef CONFIG_AUDIT
+		.deny_masks = landlock_file(file)->deny_masks,
+#endif /* CONFIG_AUDIT */
+	});
 	return -EACCES;
 }
 
@@ -1739,6 +1772,21 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 	if (is_masked_device_ioctl_compat(cmd))
 		return 0;
 
+	landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_ACCESS,
+		.audit = {
+			.type = LSM_AUDIT_DATA_IOCTL_OP,
+			.u.op = &(struct lsm_ioctlop_audit) {
+				.path = file->f_path,
+				.cmd = cmd,
+			},
+		},
+		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
+		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+#ifdef CONFIG_AUDIT
+		.deny_masks = landlock_file(file)->deny_masks,
+#endif /* CONFIG_AUDIT */
+	});
 	return -EACCES;
 }
 
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 1449a90e92c7..3a09ba985b74 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -54,6 +54,15 @@ struct landlock_file_security {
 	 * needed to authorize later operations on the open file.
 	 */
 	access_mask_t allowed_access;
+
+#ifdef CONFIG_AUDIT
+	/**
+	 * @deny_masks: Domain layer levels that deny an optional access (see
+	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
+	 */
+	deny_masks_t deny_masks;
+#endif /* CONFIG_AUDIT */
+
 	/**
 	 * @fown_subject: Landlock credential of the task that set the PID that
 	 * may receive a signal e.g., SIGURG when writing MSG_OOB to the
-- 
2.48.1

