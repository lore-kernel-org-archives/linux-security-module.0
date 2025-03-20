Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F222A7F4
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497671; cv=none; b=FtDuShM3oArG1mFkzMBy845vtt1dcdfja7Jd9LNAAKfDCRl2HXbu6hCHHC4nD5t0qxa0U915y+EnNE2kq1gi9YbDqDyV3lA/96PPwNk2eZLPWCcj9dgLtKgqEKq+XNWfKYWxzwmoNOFJjJFMeBXl1+Fs3in/ahNZr0DItSUg06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497671; c=relaxed/simple;
	bh=A9+YR6hyVdpAJYOLu0wRgK3Vs3gojgUoKGJQnoR7pu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXADYSdhIwXTkdjHU2kuBaxdxuA3/M9kZqkxrGhzyxFnQeXr65jh79GVb0vnuxufvgck38d9KsxnUpUWPcEhH6EETOV0tRQQaKWC2LI6DABIT0+5kY0aA+mAqPprNl/4TC80UN7lDGs9VQOmRw/gLBjhBYqwnEMSOJxK/Vfhtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qwlw94cN; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qwlw94cN"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpV64z6zJR2;
	Thu, 20 Mar 2025 20:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497666;
	bh=L9zWhwt2UGUtQOt7Wco5Ty1KjQubVlyoaCirgi63198=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwlw94cNLWDYiJq6IAlDar0XA/08gJBN/yBVDiojO5PkQ3QZUHeQ715/DlCaUw1nz
	 /7UWMd1fOPM6Ynrq206phkS32ncHRHSftM0jYyQldoIzBLVXJz83Vq4MMfDRr/DDqt
	 eENL2gfbdf4XChGlfZOKUX4UQc65kuDr0mkDkoAA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpT6MKJz6M9;
	Thu, 20 Mar 2025 20:07:45 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 14/28] landlock: Log truncate and IOCTL denials
Date: Thu, 20 Mar 2025 20:07:03 +0100
Message-ID: <20250320190717.2287696-15-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
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
---

Changes since v6:
- Remove useless include.

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
 security/landlock/audit.c  | 101 ++++++++++++++++++++++++++--
 security/landlock/audit.h  |   4 ++
 security/landlock/domain.c | 133 +++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h |   7 ++
 security/landlock/fs.c     |  34 ++++++++++
 security/landlock/fs.h     |   9 +++
 7 files changed, 306 insertions(+), 5 deletions(-)

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
index d0c5f9ce1d43..f50ce677e3a0 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -12,6 +12,7 @@
 #include <linux/pid.h>
 #include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "audit.h"
 #include "common.h"
 #include "cred.h"
@@ -249,6 +250,88 @@ static void test_get_denied_layer(struct kunit *const test)
 
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
 	if (WARN_ON_ONCE(request->layer_plus_one > LANDLOCK_MAX_NUM_LAYERS))
@@ -258,16 +341,23 @@ static bool is_valid_request(const struct landlock_request *const request)
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
 
@@ -300,9 +390,9 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
@@ -388,6 +478,7 @@ static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_hierarchy),
 	KUNIT_CASE(test_get_denied_layer),
+	KUNIT_CASE(test_get_layer_from_deny_masks),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 2a154116134e..8130a6fcad07 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -42,6 +42,10 @@ struct landlock_request {
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
index 3c1715e4b1c9..f61fa5ae8e56 100644
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
@@ -15,6 +18,8 @@
 #include <linux/sched.h>
 #include <linux/uidgid.h>
 
+#include "access.h"
+#include "common.h"
 #include "domain.h"
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
index 2c6f04da3628..96642dd87b33 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#include "access.h"
 #include "audit.h"
 
 enum landlock_log_status {
@@ -107,6 +108,12 @@ struct landlock_hierarchy {
 
 #ifdef CONFIG_AUDIT
 
+deny_masks_t
+landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
+			const access_mask_t optional_access,
+			const layer_mask_t (*const layer_masks)[],
+			size_t layer_masks_size);
+
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
 static inline void
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c67ef35248e3..9d7443ff67c7 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -43,6 +43,7 @@
 #include "audit.h"
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "fs.h"
 #include "limits.h"
 #include "object.h"
@@ -1671,6 +1672,11 @@ static int hook_file_open(struct file *const file)
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
@@ -1695,6 +1701,19 @@ static int hook_file_truncate(struct file *const file)
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
 
@@ -1719,6 +1738,21 @@ static int hook_file_ioctl_common(const struct file *const file,
 				  is_masked_device_ioctl(cmd))
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
2.49.0

