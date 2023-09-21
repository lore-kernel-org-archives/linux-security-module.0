Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200D5E7D0A2
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIURYm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjIURYX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 13:24:23 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D94B10906
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:07:30 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlYD10SYzMpp2X;
        Thu, 21 Sep 2023 06:17:04 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlYC4BjrzMppKR;
        Thu, 21 Sep 2023 08:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277024;
        bh=aXxAzAZrVv/AQrM1hbU5eAstfAxS1hqSXWRkrvqIPdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIkVnGqhXST4ff8AXuEDBtYbO577M5gPCcl8ioUJLhFVZ/9MT+b5xSJWdc/Ejx95W
         34dNrLXehRDfDf4p/H+ylzPrcZHOg03FmLJcrXkmVut5vV/xcwyn7vnt78ptkUEXtC
         2pLnKDwNZSOXw6R9CHZ5lP7yTTxoAm0ndKQvkLGI=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 6/7] landlock: Log mount-related requests
Date:   Thu, 21 Sep 2023 08:16:40 +0200
Message-ID: <20230921061641.273654-7-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add audit support for mount, move_mount, umount, remount, and pivot_root
requests.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c | 26 ++++++++++++-
 security/landlock/audit.h | 13 ++++++-
 security/landlock/fs.c    | 82 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 148fc0fafef4..89bd701d124f 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -18,6 +18,11 @@ static const char *op_to_string(enum landlock_operation operation)
 {
 	const char *const desc[] = {
 		[0] = "",
+		[LANDLOCK_OP_MOUNT] = "mount",
+		[LANDLOCK_OP_MOVE_MOUNT] = "move_mount",
+		[LANDLOCK_OP_UMOUNT] = "umount",
+		[LANDLOCK_OP_REMOUNT] = "remount",
+		[LANDLOCK_OP_PIVOT_ROOT] = "pivot_root",
 		[LANDLOCK_OP_MKDIR] = "mkdir",
 		[LANDLOCK_OP_MKNOD] = "mknod",
 		[LANDLOCK_OP_SYMLINK] = "symlink",
@@ -33,6 +38,20 @@ static const char *op_to_string(enum landlock_operation operation)
 	return desc[operation];
 }
 
+static const char *perm_to_string(enum landlock_permission permission)
+{
+	const char *const desc[] = {
+		[0] = "",
+		[LANDLOCK_PERM_PTRACE] = "ptrace",
+		[LANDLOCK_PERM_FS_LAYOUT] = "fs_layout",
+	};
+
+	if (WARN_ON_ONCE(permission < 0 || permission > ARRAY_SIZE(desc)))
+		return "unknown";
+
+	return desc[permission];
+}
+
 #define BIT_INDEX(bit) HWEIGHT(bit - 1)
 
 static void log_accesses(struct audit_buffer *const ab,
@@ -177,8 +196,11 @@ update_request(struct landlock_request *const request,
 	WARN_ON_ONCE(request->youngest_domain);
 	WARN_ON_ONCE(request->missing_access);
 
-	if (WARN_ON_ONCE(!access_request))
+	if (!access_request) {
+		/* No missing accesses. */
+		request->youngest_domain = node->id;
 		return;
+	}
 
 	if (WARN_ON_ONCE(!layer_masks))
 		return;
@@ -240,6 +262,8 @@ log_request(const int error, struct landlock_request *const request,
 			 request->youngest_domain,
 			 op_to_string(request->operation), -error);
 	log_accesses(ab, request->missing_access);
+	audit_log_format(ab, " missing-permission=%s",
+			 perm_to_string(request->missing_permission));
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
 }
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 8edc68b98fca..e559fb6a89dd 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -14,7 +14,12 @@
 #include "ruleset.h"
 
 enum landlock_operation {
-	LANDLOCK_OP_MKDIR = 1,
+	LANDLOCK_OP_MOUNT = 1,
+	LANDLOCK_OP_MOVE_MOUNT,
+	LANDLOCK_OP_UMOUNT,
+	LANDLOCK_OP_REMOUNT,
+	LANDLOCK_OP_PIVOT_ROOT,
+	LANDLOCK_OP_MKDIR,
 	LANDLOCK_OP_MKNOD,
 	LANDLOCK_OP_SYMLINK,
 	LANDLOCK_OP_UNLINK,
@@ -23,8 +28,14 @@ enum landlock_operation {
 	LANDLOCK_OP_OPEN,
 };
 
+enum landlock_permission {
+	LANDLOCK_PERM_PTRACE = 1,
+	LANDLOCK_PERM_FS_LAYOUT,
+};
+
 struct landlock_request {
 	const enum landlock_operation operation;
+	const enum landlock_permission missing_permission;
 	access_mask_t missing_access;
 	u64 youngest_domain;
 	struct common_audit_data audit;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 104dfb2abc32..8600530e304c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1050,17 +1050,41 @@ static int hook_sb_mount(const char *const dev_name,
 			 const struct path *const path, const char *const type,
 			 const unsigned long flags, void *const data)
 {
-	if (!landlock_get_current_domain())
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_MOUNT,
+		.missing_permission = LANDLOCK_PERM_FS_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = *path,
+		},
+	};
+
+	if (!dom)
 		return 0;
-	return -EPERM;
+
+	return landlock_log_request(-EPERM, &request, dom, 0, NULL);
 }
 
 static int hook_move_mount(const struct path *const from_path,
 			   const struct path *const to_path)
 {
-	if (!landlock_get_current_domain())
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_MOVE_MOUNT,
+		.missing_permission = LANDLOCK_PERM_FS_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = *to_path,
+		},
+	};
+
+	if (!dom)
 		return 0;
-	return -EPERM;
+
+	return landlock_log_request(-EPERM, &request, dom, 0, NULL);
 }
 
 /*
@@ -1069,16 +1093,42 @@ static int hook_move_mount(const struct path *const from_path,
  */
 static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
 {
-	if (!landlock_get_current_domain())
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_UMOUNT,
+		.missing_permission = LANDLOCK_PERM_FS_LAYOUT,
+		.audit = {
+			// TODO: try to print the mounted path
+			// cf. dentry_path()
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = mnt->mnt_root,
+		},
+	};
+
+	if (!dom)
 		return 0;
-	return -EPERM;
+
+	return landlock_log_request(-EPERM, &request, dom, 0, NULL);
 }
 
 static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 {
-	if (!landlock_get_current_domain())
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_REMOUNT,
+		.missing_permission = LANDLOCK_PERM_FS_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = sb->s_root,
+		},
+	};
+
+	if (!dom)
 		return 0;
-	return -EPERM;
+
+	return landlock_log_request(-EPERM, &request, dom, 0, NULL);
 }
 
 /*
@@ -1092,9 +1142,21 @@ static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
 static int hook_sb_pivotroot(const struct path *const old_path,
 			     const struct path *const new_path)
 {
-	if (!landlock_get_current_domain())
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_PIVOT_ROOT,
+		.missing_permission = LANDLOCK_PERM_FS_LAYOUT,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = *new_path,
+		},
+	};
+
+	if (!dom)
 		return 0;
-	return -EPERM;
+
+	return landlock_log_request(-EPERM, &request, dom, 0, NULL);
 }
 
 /* Path hooks */
-- 
2.42.0

