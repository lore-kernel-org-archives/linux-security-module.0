Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D7C352A3
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF20848
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgBKQ7k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:59:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbgBKQ7k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 11:59:40 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1YsZ-00014T-03; Tue, 11 Feb 2020 16:59:19 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 13/24] attr: notify_change(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:42 +0100
Message-Id: <20200211165753.356508-14-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Switch notify_change() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/attr.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index df28035aa23e..3aa65165fb06 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,6 +17,8 @@
 #include <linux/security.h>
 #include <linux/evm.h>
 #include <linux/ima.h>
+#include <linux/fsuidgid.h>
+#include <linux/fs.h>
 
 static bool chown_ok(const struct inode *inode, kuid_t uid)
 {
@@ -311,12 +313,21 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	 * Verify that uid/gid changes are valid in the target
 	 * namespace of the superblock.
 	 */
-	if (ia_valid & ATTR_UID &&
-	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
-		return -EOVERFLOW;
-	if (ia_valid & ATTR_GID &&
-	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
-		return -EOVERFLOW;
+	if (is_userns_visible(inode->i_sb->s_iflags)) {
+		if (ia_valid & ATTR_UID &&
+		    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+			return -EOVERFLOW;
+		if (ia_valid & ATTR_GID &&
+		    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+			return -EOVERFLOW;
+	} else {
+		if (ia_valid & ATTR_UID &&
+		    !kfsuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+			return -EOVERFLOW;
+		if (ia_valid & ATTR_GID &&
+		    !kfsgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+			return -EOVERFLOW;
+	}
 
 	/* Don't allow modifications of files with invalid uids or
 	 * gids unless those uids & gids are being made valid.
-- 
2.25.0

