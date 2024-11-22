Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C491B0F0C
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286062; cv=none; b=YPATH8tR8r9mrLAO7JjntcGT9AwjYJjMLxGXDiSprLPCoSrraFMlFJCBMomLH0iERcX3s+VyDDFPnEWZL4g3C6l+gOqrWesw9jsKqjrTX7za2zq9HlWFEhkWHOJ9mWG+UVADm94ecT/0ajqXVT5v5paLOK6e7lazsxD/RXqGkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286062; c=relaxed/simple;
	bh=6kd3USl/v5quMElIHNSewxBHZwwNtlMc/QPwm7gFPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+mxC4GZVJ1j1VDEgJT7svklQeO1DfJB1BEAWc4bDOpyqVtf3cYAXuXtF/8dtm/s4eEMUPO5mCzRDZqjOxHN/M5h8jewize25izyYzi1hhcACId+SqR3HMUqHFe3xysfOf788ZWPqKxsaPoF8BVx7KM5EJ3jX3B/030PzMvY3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BIc+0LYp; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BIc+0LYp"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKP6cq8zlSd;
	Fri, 22 Nov 2024 15:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286057;
	bh=kk+ZrO9KuElri+1LTWSQtEzwM18pB5uBoFHaUi66ZKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIc+0LYp4Mg9RSnjDBBFqErOczP0XtRa5aiELSN41ta+AimREo3E7GYhJXW3VGAK3
	 5bfaBH64hFbfaRrzOHD4yg7EXgXOgSggsKxqvuGPyRf9uZF3Gnqv0kiGXQriZkw1Lx
	 Kdm0DH1FbvfOn74Y18TQ3QzzQMRYRQOqp2GgCucw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKN6gbTzmHf;
	Fri, 22 Nov 2024 15:34:16 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 11/23] landlock: Log mount-related denials
Date: Fri, 22 Nov 2024 15:33:41 +0100
Message-ID: <20241122143353.59367-12-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
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

Audit event sample:

  type=LL_DENY [...]: domain=195ba459b blockers=fs_change_layout name="/" dev="tmpfs" ino=1

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-12-mic@digikod.net
---

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
 security/landlock/fs.c      | 64 ++++++++++++++++++++++++++++++++++---
 security/landlock/ruleset.h | 31 ++++++++++++++++++
 4 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 2d0a96797dd4..a07b210ca524 100644
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
index 9779170d9199..171012efb559 100644
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
@@ -1301,6 +1303,38 @@ static void hook_sb_delete(struct super_block *const sb)
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
@@ -1323,16 +1357,24 @@ static int hook_sb_mount(const char *const dev_name,
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
 
@@ -1342,15 +1384,23 @@ static int hook_move_mount(const struct path *const from_path,
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
 
@@ -1365,8 +1415,12 @@ static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
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
index 73636f214aac..944126a92aec 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -268,6 +268,37 @@ landlock_get_applicable_domain(const struct landlock_ruleset *const domain,
 	return NULL;
 }
 
+/**
+ * landlock_match_layer_level - Return the layer level restricting @masks
+ *
+ * @domain: Landlock ruleset (used as a domain)
+ * @masks: access masks
+ *
+ * Returns: the number of the layer restricting/handling any right of @access,
+ * or return 0 (i.e. first layer) otherwise.
+ */
+static inline size_t
+landlock_match_layer_level(const struct landlock_ruleset *const domain,
+			   const struct access_masks masks)
+{
+	const union access_masks_all masks_all = {
+		.masks = masks,
+	};
+	ssize_t layer_level;
+
+	for (layer_level = domain->num_layers; layer_level >= 0;
+	     layer_level--) {
+		union access_masks_all layer = {
+			.masks = domain->access_masks[layer_level],
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

