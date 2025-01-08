Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B6200BA2
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351053; cv=none; b=ZbN2YwPHPVAkNiG+Am9KBwGiMxBXZCve2R7DVdwNVRblpyAhVUhtpvldr4kWAK8+KvMgZHOJF/M1g01SwnrYarKjFD05kXf/D8i6LKUEmt4+4YzN0m9uQuxH4WSrqbp26oWlZcRqz3qTKN9RoraU3odmmhK6Gm0yGDmN/tAded8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351053; c=relaxed/simple;
	bh=RZwxHrJMgDj5SndDqsvGMaghHawEXk0XcX8ARzfPR5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cS0q8ka6M0dac0mLebVfYo+yjt9DfXdX9g0Kj1hU995l5QYXhbI0/qTP0rTj7s91XzX3cI+FIymoMA40Vll6YarcpWPxcs82W7V8D4cpAxASHrQnvkrOy5rQMlsr3TQRmS5guhqxFeL9hx39JpXbt16PEKtAvWVWPnA/GIBj7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=c30pmZVb; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="c30pmZVb"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfH5WH4zC77;
	Wed,  8 Jan 2025 16:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351047;
	bh=SfrAfYYSHBImPzCn8yz6R+GIVRtqTvtKhbY/pZ1i7Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c30pmZVbtiqYQiBJkQ29PpB7pAOV4xZ9WUlmwrvFrJlzvmhuc0XoqNhTOVoGiJjaq
	 prCMzr61SsSErF7JpQ1CLbOeRIJ0jRUCcU1hHbhP6BMjZ6S7iIbdKXX8ixGUKHA7ih
	 Yk8KUPLnEFXzxD1pofdb+QMqyoRBvuvCyVn+5zQU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfG5kk8zswB;
	Wed,  8 Jan 2025 16:44:06 +0100 (CET)
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 14/30] landlock: Log file-related denials
Date: Wed,  8 Jan 2025 16:43:22 +0100
Message-ID: <20250108154338.1129069-15-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit support for path_mkdir, path_mknod, path_symlink, path_unlink,
path_rmdir, path_truncate, path_link, path_rename, and file_open hooks.

The dedicated blockers are:
- fs.execute
- fs.write_file
- fs.read_file
- fs.read_dir
- fs.remove_dir
- fs.remove_file
- fs.make_char
- fs.make_dir
- fs.make_reg
- fs.make_sock
- fs.make_fifo
- fs.make_block
- fs.make_sym
- fs.refer
- fs.truncate
- fs.ioctl_dev

Audit event sample for a denied link action:

  type=LANDLOCK_DENY msg=audit(1729738800.349:44): domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
  type=LANDLOCK_DENY msg=audit(1729738800.349:44): domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365

We could pack blocker names (e.g. "fs:make_reg,refer") but that would
increase complexity for the kernel and log parsers.  Moreover, this
could not handle blockers of different classes (e.g. fs and net).  Make
it simple and flexible instead.

Add KUnit tests to check the identification from a layer_mask_t array of
the first layer level denying such request.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-15-mic@digikod.net
---

Changes since v3:
- Rename blockers from fs_* to fs.*
- Extend commit message.

Changes since v2:
- Replace integer with bool in log_blockers().
- Always initialize youngest_layer, spotted by Francis Laniel.
- Fix incorrect log reason by using access_masked_parent1 instead of
  access_request_parent1 (thanks to the previous fix patches).
- Clean up formatting.

Changes since v1:
- Move audit code to the ptrace patch.
- Revamp logging and support the path_link and path_rename hooks.
- Add KUnit tests.
---
 security/landlock/audit.c | 177 ++++++++++++++++++++++++++++++++++++--
 security/landlock/audit.h |   9 ++
 security/landlock/fs.c    |  65 +++++++++++---
 3 files changed, 234 insertions(+), 17 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index aae93b2c994b..987b4b15e0d7 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -7,22 +7,55 @@
 
 #include <kunit/test.h>
 #include <linux/audit.h>
+#include <linux/bitops.h>
 #include <linux/lsm_audit.h>
 #include <linux/pid.h>
 #include <linux/uidgid.h>
+#include <uapi/linux/landlock.h>
 
 #include "audit.h"
+#include "common.h"
 #include "domain.h"
 #include "ruleset.h"
 
-static const char *get_blocker(const enum landlock_request_type type)
+static const char *const fs_access_strings[] = {
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "fs.execute",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = "fs.write_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = "fs.read_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = "fs.read_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = "fs.remove_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] = "fs.remove_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] = "fs.make_char",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] = "fs.make_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = "fs.make_reg",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] = "fs.make_sock",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] = "fs.make_fifo",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] = "fs.make_block",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] = "fs.make_sym",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+};
+
+static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
+
+static __attribute_const__ const char *
+get_blocker(const enum landlock_request_type type,
+	    const unsigned long access_bit)
 {
 	switch (type) {
 	case LANDLOCK_REQUEST_PTRACE:
+		WARN_ON_ONCE(access_bit != -1);
 		return "ptrace";
 
 	case LANDLOCK_REQUEST_FS_CHANGE_LAYOUT:
+		WARN_ON_ONCE(access_bit != -1);
 		return "fs.change_layout";
+
+	case LANDLOCK_REQUEST_FS_ACCESS:
+		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(fs_access_strings)))
+			return "unknown";
+		return fs_access_strings[access_bit];
 	}
 
 	WARN_ON_ONCE(1);
@@ -30,9 +63,20 @@ static const char *get_blocker(const enum landlock_request_type type)
 }
 
 static void log_blockers(struct audit_buffer *const ab,
-			 const enum landlock_request_type type)
+			 const enum landlock_request_type type,
+			 const access_mask_t access)
 {
-	audit_log_format(ab, "%s", get_blocker(type));
+	const unsigned long access_mask = access;
+	unsigned long access_bit;
+	bool is_first = true;
+
+	for_each_set_bit(access_bit, &access_mask, BITS_PER_TYPE(access)) {
+		audit_log_format(ab, "%s%s", is_first ? "" : ",",
+				 get_blocker(type, access_bit));
+		is_first = false;
+	}
+	if (is_first)
+		audit_log_format(ab, "%s", get_blocker(type, -1));
 }
 
 static void log_node(struct landlock_hierarchy *const node)
@@ -119,9 +163,110 @@ static void test_get_hierarchy(struct kunit *const test)
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
+static size_t get_denied_layer(const struct landlock_ruleset *const domain,
+			       access_mask_t *const access_request,
+			       const layer_mask_t (*const layer_masks)[],
+			       const size_t layer_masks_size)
+{
+	const unsigned long access_req = *access_request;
+	unsigned long access_bit;
+	access_mask_t missing = 0;
+	long youngest_layer = -1;
+
+	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
+		const access_mask_t mask = (*layer_masks)[access_bit];
+		long layer;
+
+		if (!mask)
+			continue;
+
+		/* __fls(1) == 0 */
+		layer = __fls(mask);
+		if (layer > youngest_layer) {
+			youngest_layer = layer;
+			missing = BIT(access_bit);
+		} else if (layer == youngest_layer) {
+			missing |= BIT(access_bit);
+		}
+	}
+
+	*access_request = missing;
+	if (youngest_layer == -1)
+		return domain->num_layers - 1;
+
+	return youngest_layer;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_denied_layer(struct kunit *const test)
+{
+	const struct landlock_ruleset dom = {
+		.num_layers = 5,
+	};
+	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = BIT(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = BIT(1),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = BIT(1) | BIT(0),
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = BIT(2),
+	};
+	access_mask_t access;
+
+	access = LANDLOCK_ACCESS_FS_EXECUTE;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
+
+	access = LANDLOCK_ACCESS_FS_READ_FILE;
+	KUNIT_EXPECT_EQ(test, 1,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
+
+	access = LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
+	KUNIT_EXPECT_EQ(test, 4,
+			get_denied_layer(&dom, &access, &layer_masks,
+					 sizeof(layer_masks)));
+	KUNIT_EXPECT_EQ(test, access, 0);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
 static bool is_valid_request(const struct landlock_request *const request)
 {
-	if (WARN_ON_ONCE(!request->layer_plus_one))
+	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
+		return false;
+
+	if (request->access) {
+		if (WARN_ON_ONCE(!request->layer_masks))
+			return false;
+	} else {
+		if (WARN_ON_ONCE(request->layer_masks))
+			return false;
+	}
+
+	if (WARN_ON_ONCE(!!request->layer_masks ^ !!request->layer_masks_size))
 		return false;
 
 	return true;
@@ -138,6 +283,7 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 {
 	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
+	access_mask_t missing;
 
 	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
 		return;
@@ -145,7 +291,25 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!is_valid_request(request))
 		return;
 
-	youngest_denied = get_hierarchy(domain, request->layer_plus_one - 1);
+	missing = request->access;
+	if (missing) {
+		size_t youngest_layer;
+
+		/* Gets the nearest domain that denies the request. */
+		if (request->layer_masks) {
+			youngest_layer = get_denied_layer(
+				domain, &missing, request->layer_masks,
+				request->layer_masks_size);
+		} else {
+			/* This will change with the next commit. */
+			WARN_ON_ONCE(1);
+			youngest_layer = domain->num_layers;
+		}
+		youngest_denied = get_hierarchy(domain, youngest_layer);
+	} else {
+		youngest_denied =
+			get_hierarchy(domain, request->layer_plus_one - 1);
+	}
 
 	/*
 	 * Consistently keeps track of the number of denied access requests
@@ -163,7 +327,7 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 		return;
 
 	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
-	log_blockers(ab, request->type);
+	log_blockers(ab, request->type, missing);
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
 
@@ -212,6 +376,7 @@ void landlock_log_drop_domain(const struct landlock_ruleset *const domain)
 static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_hierarchy),
+	KUNIT_CASE(test_get_denied_layer),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 745dcf7b1b6d..093791929580 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -11,11 +11,13 @@
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
 
+#include "access.h"
 #include "ruleset.h"
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
 	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
+	LANDLOCK_REQUEST_FS_ACCESS,
 };
 
 /*
@@ -33,6 +35,13 @@ struct landlock_request {
 	 * extra one is useful to detect uninitialized field.
 	 */
 	size_t layer_plus_one;
+
+	/* Required field for configurable access control. */
+	access_mask_t access;
+
+	/* Required fields for requests with layer masks. */
+	const layer_mask_t (*layer_masks)[];
+	size_t layer_masks_size;
 };
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 01f9d5e78218..f38c7a60b9bf 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -730,6 +730,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  *     those identified by @access_request_parent1).  This matrix can
  *     initially refer to domain layer masks and, when the accesses for the
  *     destination and source are the same, to requested layer masks.
+ * @log_request_parent1: Audit request to fill if the related access is denied.
  * @dentry_child1: Dentry to the initial child of the parent1 path.  This
  *     pointer must be NULL for non-refer actions (i.e. not link nor rename).
  * @access_request_parent2: Similar to @access_request_parent1 but for a
@@ -738,6 +739,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  *     the source.  Must be set to 0 when using a simple path request.
  * @layer_masks_parent2: Similar to @layer_masks_parent1 but for a refer
  *     action.  This must be NULL otherwise.
+ * @log_request_parent2: Audit request to fill if the related access is denied.
  * @dentry_child2: Dentry to the initial child of the parent2 path.  This
  *     pointer is only set for RENAME_EXCHANGE actions and must be NULL
  *     otherwise.
@@ -757,10 +759,12 @@ static bool is_access_to_paths_allowed(
 	const struct path *const path,
 	const access_mask_t access_request_parent1,
 	layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
-	const struct dentry *const dentry_child1,
+	struct landlock_request *const log_request_parent1,
+	struct dentry *const dentry_child1,
 	const access_mask_t access_request_parent2,
 	layer_mask_t (*const layer_masks_parent2)[LANDLOCK_NUM_ACCESS_FS],
-	const struct dentry *const dentry_child2)
+	struct landlock_request *const log_request_parent2,
+	struct dentry *const dentry_child2)
 {
 	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
 	     child1_is_directory = true, child2_is_directory = true;
@@ -922,6 +926,25 @@ static bool is_access_to_paths_allowed(
 	}
 	path_put(&walker_path);
 
+	if (!allowed_parent1) {
+		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS,
+		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH,
+		log_request_parent1->audit.u.path = *path;
+		log_request_parent1->access = access_masked_parent1;
+		log_request_parent1->layer_masks = layer_masks_parent1;
+		log_request_parent1->layer_masks_size =
+			ARRAY_SIZE(*layer_masks_parent1);
+	}
+
+	if (!allowed_parent2) {
+		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS,
+		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH,
+		log_request_parent2->audit.u.path = *path;
+		log_request_parent2->access = access_masked_parent2;
+		log_request_parent2->layer_masks = layer_masks_parent2;
+		log_request_parent2->layer_masks_size =
+			ARRAY_SIZE(*layer_masks_parent2);
+	}
 	return allowed_parent1 && allowed_parent2;
 }
 
@@ -930,6 +953,7 @@ static int current_check_access_path(const struct path *const path,
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct landlock_request request = {};
 
 	if (!dom)
 		return 0;
@@ -937,9 +961,10 @@ static int current_check_access_path(const struct path *const path,
 	access_request = landlock_init_layer_masks(
 		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
-				       NULL, 0, NULL, NULL))
+				       &request, NULL, 0, NULL, NULL, NULL))
 		return 0;
 
+	landlock_log_denial(dom, &request);
 	return -EACCES;
 }
 
@@ -1108,6 +1133,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	struct dentry *old_parent;
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct landlock_request request1 = {}, request2 = {};
 
 	if (!dom)
 		return 0;
@@ -1139,10 +1165,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		access_request_parent1 = landlock_init_layer_masks(
 			dom, access_request_parent1 | access_request_parent2,
 			&layer_masks_parent1, LANDLOCK_KEY_INODE);
-		if (is_access_to_paths_allowed(
-			    dom, new_dir, access_request_parent1,
-			    &layer_masks_parent1, NULL, 0, NULL, NULL))
+		if (is_access_to_paths_allowed(dom, new_dir,
+					       access_request_parent1,
+					       &layer_masks_parent1, &request1,
+					       NULL, 0, NULL, NULL, NULL))
 			return 0;
+
+		landlock_log_denial(dom, &request1);
 		return -EACCES;
 	}
 
@@ -1177,12 +1206,22 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * parent access rights.  This will be useful to compare with the
 	 * destination parent access rights.
 	 */
-	if (is_access_to_paths_allowed(
-		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
-		    old_dentry, access_request_parent2, &layer_masks_parent2,
-		    exchange ? new_dentry : NULL))
+	if (is_access_to_paths_allowed(dom, &mnt_dir, access_request_parent1,
+				       &layer_masks_parent1, &request1,
+				       old_dentry, access_request_parent2,
+				       &layer_masks_parent2, &request2,
+				       exchange ? new_dentry : NULL))
 		return 0;
 
+	if (request1.access) {
+		request1.audit.u.path.dentry = old_parent;
+		landlock_log_denial(dom, &request1);
+	}
+	if (request2.access) {
+		request2.audit.u.path.dentry = new_dir->dentry;
+		landlock_log_denial(dom, &request2);
+	}
+
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including
 	 * renames with RENAME_EXCHANGE.
@@ -1562,6 +1601,7 @@ static int hook_file_open(struct file *const file)
 	const struct landlock_ruleset *const dom =
 		landlock_get_applicable_domain(
 			landlock_cred(file->f_cred)->domain, any_fs);
+	struct landlock_request request = {};
 
 	if (!dom)
 		return 0;
@@ -1587,7 +1627,7 @@ static int hook_file_open(struct file *const file)
 		    dom, &file->f_path,
 		    landlock_init_layer_masks(dom, full_access_request,
 					      &layer_masks, LANDLOCK_KEY_INODE),
-		    &layer_masks, NULL, 0, NULL, NULL)) {
+		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
 		unsigned long access_bit;
@@ -1617,6 +1657,9 @@ static int hook_file_open(struct file *const file)
 	if ((open_access_request & allowed_access) == open_access_request)
 		return 0;
 
+	/* Sets access to reflect the actual request. */
+	request.access = open_access_request;
+	landlock_log_denial(dom, &request);
 	return -EACCES;
 }
 
-- 
2.47.1

