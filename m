Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2BC4321E
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Dec 2022 11:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLEL0u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Dec 2022 06:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLEL0t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Dec 2022 06:26:49 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0B18370
        for <linux-security-module@vger.kernel.org>; Mon,  5 Dec 2022 03:26:47 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NQh8P0n5nzMpnwB;
        Mon,  5 Dec 2022 12:26:45 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NQh8M4RT6zMppfs;
        Mon,  5 Dec 2022 12:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1670239605;
        bh=tmMFBVbFRIZZNZ44CMRrOzryQYouUTzTotI0v6azOe8=;
        h=From:To:Cc:Subject:Date:From;
        b=Tt9yFLmbnCXoz66bJXsVRc56+RdMXxsOkQV5pSo+YWYm8KD/sr02nNdGXWWBicZVo
         IRQdZ0LnHaOT+fCZyMA9GLlQkCXggjo1Ji+BXNPcSSqX0sW1a7Hke8uPxV7FjLkcvO
         JManiApnJPTcd8InUREDma1AlgHhIIgDHQ2K7isQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Explain file descriptor access rights
Date:   Mon,  5 Dec 2022 12:26:21 +0100
Message-Id: <20221205112621.3530557-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Starting with LANDLOCK_ACCESS_FS_TRUNCATE, it is worth explaining why we
choose to restrict access checks at open time.  This new "File
descriptor access rights" section is complementary to the existing
"Inode access rights" section.

Cc: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20221205112621.3530557-1-mic@digikod.net
---
 Documentation/security/landlock.rst | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index c0029d5d02eb..bd0af6031ebb 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: September 2022
+:Date: November 2022
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -45,8 +45,8 @@ Guiding principles for safe access controls
 Design choices
 ==============
 
-Filesystem access rights
-------------------------
+Inode access rights
+-------------------
 
 All access rights are tied to an inode and what can be accessed through it.
 Reading the content of a directory does not imply to be allowed to read the
@@ -57,6 +57,25 @@ directory, not the unlinked inode.  This is the reason why
 ``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
 allowed to be tied to files but only to directories.
 
+File descriptor access rights
+-----------------------------
+
+Access rights are checked and tied to file descriptors at open time.  As a
+consequence, it may be allowed to create a file without being allowed to
+truncate it if the file hierarchy doesn't grant such access right.  The
+rationale is that this approach is simple and consistent with all access
+rights, however file requests are based on path or based on file descriptor
+(obtained with the same path, by a thread restricted with the same Landlock
+domain).  For instance, updating an application from using :manpage:`mknod` and
+:manpage:`truncate` to initialize a file (i.e. path-based), to using
+:manpage:`open` and :manpage:`ftruncate` to initialize the same file (i.e. file
+descriptor-based) should work the same way with the same Landlock restrictions.
+
+Processes not sandboxed by Landlock may still be restricted for operations on
+file descriptors coming from a sandboxed process.  Indeed, this is required to
+keep a consistent access control over the whole system, and avoid unattended
+bypasses through file descriptor passing (i.e. confused deputy attack).
+
 Tests
 =====
 

base-commit: 0b4ab8cd635e8b21e42c14b9e4810ca701babd11
-- 
2.38.1

