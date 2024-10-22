Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436751B5808;
	Tue, 22 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613437; cv=none; b=HFMU7gBzWIEcmezIXD9PwSVrIitzAe+fxDqrFinibbYwZIpzIdY6vboJZSQdUFm8qIuqhm8B/uO7o5y3KXV96yy9lvVBJ5kHYq/vkpJK3HbhWZrFl9ulfRnG3e8fVqKA+ogMJRzthpy1GXcav30c3Z0Llc3M9eutCzX8ixpEC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613437; c=relaxed/simple;
	bh=CbChgtXckXk3u1m3Yox0x6RBMdZITj8ROOX7Y3B0368=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWmkxH97UcyRNN6VcqvtkZIdw51mJTRefKRJgNfsZzPm9KVloNXaD/z5o+5lbBRNL7+663ZBjp8SwRi+UoxmZl9MsbXCUhIEiGlEDOdUU+K+a1rWqRdyoPBi7CbNQ3XtAXpOdGFqVqOb1sv1T0O93X+C6qApntwQmcPrCZkmZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WQstIalo; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WQstIalo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwm1dmRzvm;
	Tue, 22 Oct 2024 18:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613432;
	bh=JIkFdcA2MSd0H2lV7JeqWVnBj8kE454w4i9hCEh/p08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQstIalo/8jZU1OYFvp0FdW++30j1fOyZZJqdKc1yLUnd0wsDTdEx+HI74LnYwu4m
	 nhF4YH5RCw0nXACPx5pSi93ZxouwgFu/Rqcu+Qn97SA4HTLI82Fb8DwAYoLfo438Wp
	 bRTC/Z4QnTcL2uJzcEZ8sJ6RG4gHCKdOSFXYRkJo=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwl2w77z1D4;
	Tue, 22 Oct 2024 18:10:31 +0200 (CEST)
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
Subject: [RFC PATCH v2 09/14] landlock: Log mount-related denials
Date: Tue, 22 Oct 2024 18:10:04 +0200
Message-ID: <20241022161009.982584-10-mic@digikod.net>
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

Add audit support for sb_mount, move_mount, sb_umount, sb_remount, and
sb_pivot_root hooks.

Add and use a new landlock_match_layer_level() helper.

Audit record sample:

  DENY:    blockers=fs_change_layout name="/" dev="tmpfs" ino=1
  SYSCALL: arch=c000003e syscall=166 success=no exit=-1 ...

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-10-mic@digikod.net
---

Changes since v2:
* Log the domain that denied the action because not all layers block FS
  layout changes.

Changes since v1:
* Rebased on the TCP patch series.
* Don't log missing permissions, only domain layer, and then remove the
  permission word (suggested by Günther)
---
 security/landlock/audit.c   |  3 ++
 security/landlock/audit.h   |  1 +
 security/landlock/fs.c      | 64 ++++++++++++++++++++++++++++++++++---
 security/landlock/ruleset.h | 31 ++++++++++++++++++
 4 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index f5860f396044..4cd9407459d2 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -21,6 +21,9 @@ static const char *get_blocker(const enum landlock_request_type type)
 	switch (type) {
 	case LANDLOCK_REQUEST_PTRACE:
 		return "ptrace";
+
+	case LANDLOCK_REQUEST_FS_CHANGE_LAYOUT:
+		return "fs_change_layout";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 7a1b1652f21b..6f5ad04b83c2 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -15,6 +15,7 @@
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
+	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e0e5775b75ae..a099167d2347 100644
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
@@ -1308,6 +1310,38 @@ static void hook_sb_delete(struct super_block *const sb)
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
 }
 
+static void
+log_fs_change_layout_path(const struct landlock_ruleset *const domain,
+			  const struct path *const path)
+{
+	const struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = *path,
+		},
+		.layer_plus_one = landlock_match_layer_level(domain, any_fs) + 1,
+	};
+
+	landlock_log_denial(domain, &request);
+}
+
+static void
+log_fs_change_layout_dentry(const struct landlock_ruleset *const domain,
+			    struct dentry *const dentry)
+{
+	const struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = landlock_match_layer_level(domain, any_fs) + 1,
+	};
+
+	landlock_log_denial(domain, &request);
+}
+
 /*
  * Because a Landlock security policy is defined according to the filesystem
  * topology (i.e. the mount namespace), changing it may grant access to files
@@ -1330,16 +1364,24 @@ static int hook_sb_mount(const char *const dev_name,
 			 const struct path *const path, const char *const type,
 			 const unsigned long flags, void *const data)
 {
-	if (!get_current_fs_domain())
+	const struct landlock_ruleset *const dom = get_current_fs_domain();
+
+	if (!dom)
 		return 0;
+
+	log_fs_change_layout_path(dom, path);
 	return -EPERM;
 }
 
 static int hook_move_mount(const struct path *const from_path,
 			   const struct path *const to_path)
 {
-	if (!get_current_fs_domain())
+	const struct landlock_ruleset *const dom = get_current_fs_domain();
+
+	if (!dom)
 		return 0;
+
+	log_fs_change_layout_path(dom, to_path);
 	return -EPERM;
 }
 
@@ -1349,15 +1391,23 @@ static int hook_move_mount(const struct path *const from_path,
  */
 static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
 {
-	if (!get_current_fs_domain())
+	const struct landlock_ruleset *const dom = get_current_fs_domain();
+
+	if (!dom)
 		return 0;
+
+	log_fs_change_layout_dentry(dom, mnt->mnt_root);
 	return -EPERM;
 }
 
 static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 {
-	if (!get_current_fs_domain())
+	const struct landlock_ruleset *const dom = get_current_fs_domain();
+
+	if (!dom)
 		return 0;
+
+	log_fs_change_layout_dentry(dom, sb->s_root);
 	return -EPERM;
 }
 
@@ -1372,8 +1422,12 @@ static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 static int hook_sb_pivotroot(const struct path *const old_path,
 			     const struct path *const new_path)
 {
-	if (!get_current_fs_domain())
+	const struct landlock_ruleset *const dom = get_current_fs_domain();
+
+	if (!dom)
 		return 0;
+
+	log_fs_change_layout_path(dom, new_path);
 	return -EPERM;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 1fe88027404b..c463ff9a6615 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -278,6 +278,37 @@ landlock_match_ruleset(const struct landlock_ruleset *const ruleset,
 	return NULL;
 }
 
+/**
+ * landlock_match_layer_level - Return the layer level restricting @masks
+ *
+ * @ruleset: Landlock ruleset (used as a domain)
+ * @masks: access masks
+ *
+ * Returns: the number of the layer restricting/handling any right of @access,
+ * or return 0 (i.e. first layer) otherwise.
+ */
+static inline size_t
+landlock_match_layer_level(const struct landlock_ruleset *const ruleset,
+			   const struct access_masks masks)
+{
+	const union access_masks_all masks_all = {
+		.masks = masks,
+	};
+	size_t layer_level;
+
+	for (layer_level = ruleset->num_layers; layer_level >= 0;
+	     layer_level--) {
+		union access_masks_all layer = {
+			.masks = ruleset->access_masks[layer_level],
+		};
+
+		if (masks_all.all & layer.all)
+			return layer_level;
+	}
+
+	return 0;
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
-- 
2.47.0

