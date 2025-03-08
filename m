Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04602135AB
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459493; cv=none; b=IUdURB0Z/Xs8zfGUyNo+l+IimJBjviAqI/HMXmiGMUv5UedDR6G1BHfuW2jSgQ3QvIBOJLsOgUO/LY9H9iArOyq33iY2b0B97gTxRIDpg8h/eH9NM5/5isnAOg9in4Gke6U+NWcQHMW4sAazy05TrVOLe4mBGlxm5Y1rWluavvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459493; c=relaxed/simple;
	bh=JEdzQKgr/LpUrQle/L/hutF1xQQyGDZyxiYb4Q0by38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvmqWGiQdJg63KSVb/J2SslWUKmxt0X+tJ1diZSgjmI7i9u5QTHxKKoFPn6sLWN9mW/QXL1ELUseMTwDhLlfTbKW22Ssd1pWi5un2nZIik3XM7399BqBEHB5X9HUM9RRQTvT+3PMCfGIgA7z/F4c/4XSvFlX9Qz04zYc1xDF4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fHG0V/ld; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fHG0V/ld"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsY2pTlzQwy;
	Sat,  8 Mar 2025 19:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459489;
	bh=UkXnaRvTkVKf8Qk2hG+ipdOUAkahG0b1JanDw+3kvxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHG0V/ldKZKpgZus0zf/4Rt/cPmLaODV3AWHTnbTqxzxdW2WZBhpFsvybcukzytgz
	 m1YR84KmrC4VmIqIJaMzT4TE0zIrc66My7OsKxyi2jB0ZvpjlTI9PU6t6Mw/LvohtC
	 f/JbUvuXh0NvVLLB9nlen2PcuCu3EmRy+46QSdIM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsX4vxJzsMX;
	Sat,  8 Mar 2025 19:44:48 +0100 (CET)
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
Subject: [PATCH v6 11/26] landlock: Log mount-related denials
Date: Sat,  8 Mar 2025 19:44:07 +0100
Message-ID: <20250308184422.2159360-12-mic@digikod.net>
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

Add audit support for sb_mount, move_mount, sb_umount, sb_remount, and
sb_pivot_root hooks.

The new related blocker is "fs.change_layout".

Audit event sample:

  type=LANDLOCK_DENY msg=audit(1729738800.349:44): domain=195ba459b blockers=fs.change_layout name="/" dev="tmpfs" ino=1

Remove landlock_get_applicable_domain() and get_current_fs_domain()
which are now fully replaced with landlock_get_applicable_subject().

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-12-mic@digikod.net
---

Changes since v5:
- Move request declaration in the landlock_log_denial() calls.

Changes since v4:
- Rebase on top of the landlock_log_denial() and subject type changes.
- Fix off-by-one error in landlock_match_layer_level(), now merged into
  landlock_get_applicable_domain().

Changes since v3:
- Cosmetic change to the "fs.change_layout" name.

Changes since v2:
- Log the domain that denied the action because not all layers block FS
  layout changes.
- Fix landlock_match_layer_level().

Changes since v1:
- Rebased on the TCP patch series.
- Don't log missing permissions, only domain layer, and then remove the
  permission word (suggested by Günther)
---
 security/landlock/audit.c   |  3 ++
 security/landlock/audit.h   |  1 +
 security/landlock/fs.c      | 81 ++++++++++++++++++++++++++++++++-----
 security/landlock/ruleset.h | 30 --------------
 4 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 507771a6710d..f754e4e719fa 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -21,6 +21,9 @@ static const char *get_blocker(const enum landlock_request_type type)
 	switch (type) {
 	case LANDLOCK_REQUEST_PTRACE:
 		return "ptrace";
+
+	case LANDLOCK_REQUEST_FS_CHANGE_LAYOUT:
+		return "fs.change_layout";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 0608241eb7e1..258b7e3cd9a5 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -16,6 +16,7 @@
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
+	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7dbfc6420e1b..29f964ae4195 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
+#include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -37,6 +38,7 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
+#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "fs.h"
@@ -393,12 +395,6 @@ static const struct access_masks any_fs = {
 	.fs = ~0,
 };
 
-static const struct landlock_ruleset *get_current_fs_domain(void)
-{
-	return landlock_get_applicable_domain(landlock_get_current_domain(),
-					      any_fs);
-}
-
 /*
  * Check that a destination file hierarchy has more restrictions than a source
  * file hierarchy.  This is only used for link and rename actions.
@@ -1333,6 +1329,34 @@ static void hook_sb_delete(struct super_block *const sb)
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
 }
 
+static void
+log_fs_change_layout_path(const struct landlock_cred_security *const subject,
+			  size_t handle_layer, const struct path *const path)
+{
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = *path,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+}
+
+static void
+log_fs_change_layout_dentry(const struct landlock_cred_security *const subject,
+			    size_t handle_layer, struct dentry *const dentry)
+{
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+}
+
 /*
  * Because a Landlock security policy is defined according to the filesystem
  * topology (i.e. the mount namespace), changing it may grant access to files
@@ -1355,16 +1379,30 @@ static int hook_sb_mount(const char *const dev_name,
 			 const struct path *const path, const char *const type,
 			 const unsigned long flags, void *const data)
 {
-	if (!get_current_fs_domain())
+	size_t handle_layer;
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs,
+						&handle_layer);
+
+	if (!subject)
 		return 0;
+
+	log_fs_change_layout_path(subject, handle_layer, path);
 	return -EPERM;
 }
 
 static int hook_move_mount(const struct path *const from_path,
 			   const struct path *const to_path)
 {
-	if (!get_current_fs_domain())
+	size_t handle_layer;
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs,
+						&handle_layer);
+
+	if (!subject)
 		return 0;
+
+	log_fs_change_layout_path(subject, handle_layer, to_path);
 	return -EPERM;
 }
 
@@ -1374,15 +1412,29 @@ static int hook_move_mount(const struct path *const from_path,
  */
 static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
 {
-	if (!get_current_fs_domain())
+	size_t handle_layer;
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs,
+						&handle_layer);
+
+	if (!subject)
 		return 0;
+
+	log_fs_change_layout_dentry(subject, handle_layer, mnt->mnt_root);
 	return -EPERM;
 }
 
 static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 {
-	if (!get_current_fs_domain())
+	size_t handle_layer;
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs,
+						&handle_layer);
+
+	if (!subject)
 		return 0;
+
+	log_fs_change_layout_dentry(subject, handle_layer, sb->s_root);
 	return -EPERM;
 }
 
@@ -1397,8 +1449,15 @@ static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 static int hook_sb_pivotroot(const struct path *const old_path,
 			     const struct path *const new_path)
 {
-	if (!get_current_fs_domain())
+	size_t handle_layer;
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs,
+						&handle_layer);
+
+	if (!subject)
 		return 0;
+
+	log_fs_change_layout_path(subject, handle_layer, new_path);
 	return -EPERM;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index bbb5996545d2..27a4f92ae82c 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -242,36 +242,6 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
 	return matches.masks;
 }
 
-/**
- * landlock_get_applicable_domain - Return @domain if it applies to (handles)
- *				    at least one of the access rights specified
- *				    in @masks
- *
- * @domain: Landlock ruleset (used as a domain)
- * @masks: access masks
- *
- * Returns: @domain if any access rights specified in @masks is handled, or
- * NULL otherwise.
- */
-static inline const struct landlock_ruleset *
-landlock_get_applicable_domain(const struct landlock_ruleset *const domain,
-			       const struct access_masks masks)
-{
-	const union access_masks_all masks_all = {
-		.masks = masks,
-	};
-	union access_masks_all merge = {};
-
-	if (!domain)
-		return NULL;
-
-	merge.masks = landlock_union_access_masks(domain);
-	if (merge.all & masks_all.all)
-		return domain;
-
-	return NULL;
-}
-
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
-- 
2.48.1

