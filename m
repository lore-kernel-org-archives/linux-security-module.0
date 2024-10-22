Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC841BC08C
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613438; cv=none; b=OhpKNt7L30n9a1pv04yZYsNCycd17avhCV4OsVz0LM28wyOXX4ql0CpWgK+4uYdZx+mJKzQMqBD4360BDVcSYfK3et4gdK1l3KCFDDp3Ffx4BLl09/n+fIaJhERpuV4FA1M23wyerY41RhagR3H2RScxScSejNR5OgOt4BK9Sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613438; c=relaxed/simple;
	bh=evqKCI7XLqjqg1ZetdfGSXOFu87CpDBLB/lbz10tL08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX5syjjgJzDaO3U1ReIc7nQtEYC4PUAaHwJ8P4Qr/aqLaEuTqXoRewR7i/p6TOcc8KHoQ9TRflQ+ug38COwsCHU7doC9+cns7TndRg2NnJEQRKwylWLaVDJo4Bj0chNQ+2xOuCNF9inGbLVU2ZGooAEFNR+QwdUt3v6HtcnDuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uBcqCdy5; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uBcqCdy5"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwn3xpWzMZY;
	Tue, 22 Oct 2024 18:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613433;
	bh=8jgIrNHhjmhClA1AewvlMzMfw/fFKOQvBW2YCRdj/JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBcqCdy59muhPQMlwf1a85Fqss49SpuhpYIXMYNKUcyDXGp0xLIsjLMl1gjPp6mjN
	 hq5ttPomxokI5v/0bByHuNDTXBNvhtwZL2j6HxakhOjDxj6ObTwfHPc2UT8idFSPPK
	 yDfNechLYrZnrbhdgE+jwyM5fVUFstKLz5bHNy/4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwm5Rn5znfX;
	Tue, 22 Oct 2024 18:10:32 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 10/14] landlock: Log file-related denials
Date: Tue, 22 Oct 2024 18:10:05 +0200
Message-ID: <20241022161009.982584-11-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
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

Audit record sample for a link action:

  DENY:     domain=4533720568 blockers=fs_refer path="/usr/bin" dev="vda2" ino=351
  DOM_INFO: domain=4533720568 parent=0 pid=325 uid=0 exe="/root/sandboxer" comm="sandboxer"
  DENY:     domain=4533720568 blockers=fs_make_reg,fs_refer path="/usr/local" dev="vda2" ino=365
  SYSCALL:  arch=c000003e syscall=265 success=no exit=-13 ...

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-11-mic@digikod.net
---

Changes since v2:
* Revamp logging and support the path_link and path_rename hooks.
* Add KUnit tests.

Changes since v1:
* Move audit code to the ptrace patch.
---
 security/landlock/audit.c | 173 ++++++++++++++++++++++++++++++++++++--
 security/landlock/audit.h |   9 ++
 security/landlock/fs.c    |  64 +++++++++++---
 3 files changed, 229 insertions(+), 17 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 4cd9407459d2..9c8b6c246884 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -7,23 +7,55 @@
 
 #include <kunit/test.h>
 #include <linux/audit.h>
+#include <linux/bitops.h>
 #include <linux/lsm_audit.h>
 #include <linux/pid.h>
 #include <linux/uidgid.h>
+#include <uapi/linux/landlock.h>
 
 #include "audit.h"
+#include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "ruleset.h"
 
-static const char *get_blocker(const enum landlock_request_type type)
+static const char *const fs_access_strings[] = {
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "fs_execute",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = "fs_write_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = "fs_read_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = "fs_read_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = "fs_remove_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] = "fs_remove_file",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] = "fs_make_char",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] = "fs_make_dir",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = "fs_make_reg",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] = "fs_make_sock",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] = "fs_make_fifo",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] = "fs_make_block",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] = "fs_make_sym",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs_refer",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs_truncate",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs_ioctl_dev",
+};
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
 		return "fs_change_layout";
+
+	case LANDLOCK_REQUEST_FS_ACCESS:
+		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(fs_access_strings)))
+			return "unknown";
+		return fs_access_strings[access_bit];
 	}
 
 	WARN_ON_ONCE(1);
@@ -31,9 +63,20 @@ static const char *get_blocker(const enum landlock_request_type type)
 }
 
 static void log_blockers(struct audit_buffer *const ab,
-			 const enum landlock_request_type type)
+			 const enum landlock_request_type type,
+			 const access_mask_t access)
 {
-	audit_log_format(ab, "%s", get_blocker(type));
+	const unsigned long access_mask = access;
+	unsigned long access_bit;
+	size_t i = 0;
+
+	for_each_set_bit(access_bit, &access_mask, BITS_PER_TYPE(access)) {
+		audit_log_format(ab, "%s%s", (i == 0) ? "" : ",",
+				 get_blocker(type, access_bit));
+		i++;
+	}
+	if (i == 0)
+		audit_log_format(ab, "%s", get_blocker(type, -1));
 }
 
 static void log_node(struct landlock_hierarchy *const node)
@@ -121,9 +164,110 @@ static void test_get_hierarchy(struct kunit *const test)
 
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
@@ -140,6 +284,7 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 {
 	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
+	access_mask_t missing;
 
 	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
 		return;
@@ -155,9 +300,24 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!ab)
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
+		}
+		youngest_denied = get_hierarchy(domain, youngest_layer);
+	} else {
+		youngest_denied =
+			get_hierarchy(domain, request->layer_plus_one - 1);
+	}
+
 	audit_log_format(ab, "domain=%llu blockers=", youngest_denied->id);
-	log_blockers(ab, request->type);
+	log_blockers(ab, request->type, missing);
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
 
@@ -204,6 +364,7 @@ void landlock_log_drop_domain(const struct landlock_ruleset *const domain)
 static struct kunit_case test_cases[] = {
 	/* clang-format off */
 	KUNIT_CASE(test_get_hierarchy),
+	KUNIT_CASE(test_get_denied_layer),
 	{}
 	/* clang-format on */
 };
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 6f5ad04b83c2..25fc8333cddc 100644
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
index a099167d2347..7f69bed9e095 100644
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
@@ -907,6 +911,24 @@ static bool is_access_to_paths_allowed(
 	}
 	path_put(&walker_path);
 
+	if (!allowed_parent1 && log_request_parent1) {
+		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS,
+		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH,
+		log_request_parent1->audit.u.path = *path;
+		log_request_parent1->access = access_request_parent1;
+		log_request_parent1->layer_masks = layer_masks_parent1;
+		log_request_parent1->layer_masks_size =
+			ARRAY_SIZE(*layer_masks_parent1);
+	}
+	if (!allowed_parent2 && log_request_parent2) {
+		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS,
+		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH,
+		log_request_parent2->audit.u.path = *path;
+		log_request_parent2->access = access_request_parent2;
+		log_request_parent2->layer_masks = layer_masks_parent2;
+		log_request_parent2->layer_masks_size =
+			ARRAY_SIZE(*layer_masks_parent2);
+	}
 	return allowed_parent1 && allowed_parent2;
 }
 
@@ -915,6 +937,7 @@ static int current_check_access_path(const struct path *const path,
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct landlock_request request = {};
 
 	if (!dom)
 		return 0;
@@ -922,9 +945,10 @@ static int current_check_access_path(const struct path *const path,
 	access_request = landlock_init_layer_masks(
 		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
 	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
-				       NULL, 0, NULL, NULL))
+				       &request, NULL, 0, NULL, NULL, NULL))
 		return 0;
 
+	landlock_log_denial(dom, &request);
 	return -EACCES;
 }
 
@@ -1093,6 +1117,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	struct dentry *old_parent;
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
+	struct landlock_request request1 = {}, request2 = {};
 
 	if (!dom)
 		return 0;
@@ -1124,10 +1149,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
 
@@ -1162,12 +1190,22 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1546,6 +1584,7 @@ static int hook_file_open(struct file *const file)
 		optional_access;
 	const struct landlock_ruleset *const dom = landlock_match_ruleset(
 		landlock_cred(file->f_cred)->domain, any_fs);
+	struct landlock_request request = {};
 
 	if (!dom)
 		return 0;
@@ -1571,7 +1610,7 @@ static int hook_file_open(struct file *const file)
 		    dom, &file->f_path,
 		    landlock_init_layer_masks(dom, full_access_request,
 					      &layer_masks, LANDLOCK_KEY_INODE),
-		    &layer_masks, NULL, 0, NULL, NULL)) {
+		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
 		unsigned long access_bit;
@@ -1601,6 +1640,9 @@ static int hook_file_open(struct file *const file)
 	if ((open_access_request & allowed_access) == open_access_request)
 		return 0;
 
+	/* Sets access to reflect the actual request. */
+	request.access = open_access_request;
+	landlock_log_denial(dom, &request);
 	return -EACCES;
 }
 
-- 
2.47.0

