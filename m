Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7DC6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 15:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIWPn7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiIWPnW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 11:43:22 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C2915D3
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 08:43:06 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYxHs1dM0zMpvVd;
        Fri, 23 Sep 2022 17:43:05 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYxHr28NbzxG;
        Fri, 23 Sep 2022 17:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663947785;
        bh=+N+3TBW2VBo+nM3Z+jOPY8kIESll0SxnXdbU8y4iAnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKp9DluC/yIAlX8CyyjUauSiMlVc8olOGDZZGcAaimqVxg8PdV0nJArrHZtzNwxBO
         zpn0+2sVOSW6OEJlxmwh+wu16p/g9S7jAWk4u0TUaDrR0ZY+wUvxqs5h9n7Ba+Lbhr
         ipXEHfeDlXjCAMDxhnG5aUsa0PlaLUs/XmnuNuxE=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/3] landlock: Slightly improve documentation and fix spelling
Date:   Fri, 23 Sep 2022 17:42:06 +0200
Message-Id: <20220923154207.3311629-3-mic@digikod.net>
In-Reply-To: <20220923154207.3311629-1-mic@digikod.net>
References: <20220923154207.3311629-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Now that we have more than one ABI version, make limitation explanation
more consistent by replacing "ABI 1" with "ABI < 2".  This also
indicates which ABIs support such past limitation.

Improve documentation consistency by not using contractions.

Fix spelling in fs.c .

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220923154207.3311629-3-mic@digikod.net
---
 Documentation/security/landlock.rst      |  4 ++--
 Documentation/userspace-api/landlock.rst | 10 +++++-----
 security/landlock/fs.c                   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 5c77730b4479..cc9617f3175b 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: May 2022
+:Date: September 2022
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -49,7 +49,7 @@ Filesystem access rights
 ------------------------
 
 All access rights are tied to an inode and what can be accessed through it.
-Reading the content of a directory doesn't imply to be allowed to read the
+Reading the content of a directory does not imply to be allowed to read the
 content of a listed inode.  Indeed, a file name is local to its parent
 directory, and an inode can be referenced by multiple file names thanks to
 (hard) links.  Being able to unlink a file only has a direct impact on the
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8ea59493964..83bae71bf042 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: May 2022
+:Date: September 2022
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem access) for a set of processes.  Because Landlock is a stackable
@@ -170,7 +170,7 @@ It is recommended setting access rights to file hierarchy leaves as much as
 possible.  For instance, it is better to be able to have ``~/doc/`` as a
 read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
 ``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
-Following this good practice leads to self-sufficient hierarchies that don't
+Following this good practice leads to self-sufficient hierarchies that do not
 depend on their location (i.e. parent directories).  This is particularly
 relevant when we want to allow linking or renaming.  Indeed, having consistent
 access rights per directory enables to change the location of such directory
@@ -380,8 +380,8 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
 Previous limitations
 ====================
 
-File renaming and linking (ABI 1)
----------------------------------
+File renaming and linking (ABI < 2)
+-----------------------------------
 
 Because Landlock targets unprivileged access controls, it needs to properly
 handle composition of rules.  Such property also implies rules nesting.
@@ -410,7 +410,7 @@ contains `CONFIG_LSM=landlock,[...]` with `[...]`  as the list of other
 potentially useful security modules for the running system (see the
 `CONFIG_LSM` help).
 
-If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we can
+If the running kernel does not have `landlock` in `CONFIG_LSM`, then we can
 still enable it by adding ``lsm=landlock,[...]`` to
 Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
 configuration.
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a9dbd99d9ee7..64ed7665455f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -712,7 +712,7 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
  * allowed accesses in @layer_masks_dom.
  *
  * This is similar to check_access_path_dual() but much simpler because it only
- * handles walking on the same mount point and only check one set of accesses.
+ * handles walking on the same mount point and only checks one set of accesses.
  *
  * Returns:
  * - true if all the domain access rights are allowed for @dir;
-- 
2.37.2

