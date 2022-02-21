Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED4C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Feb 2022 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiBUVQb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Feb 2022 16:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiBUVPs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Feb 2022 16:15:48 -0500
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF423BFA
        for <linux-security-module@vger.kernel.org>; Mon, 21 Feb 2022 13:15:18 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znx4FH4zMqHRq;
        Mon, 21 Feb 2022 22:15:17 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znx2S0HzljTgH;
        Mon, 21 Feb 2022 22:15:17 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 11/11] landlock: Add design choices documentation for filesystem access rights
Date:   Mon, 21 Feb 2022 22:25:22 +0100
Message-Id: <20220221212522.320243-12-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-12-mic@digikod.net
---
 Documentation/security/landlock.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3df68cb1d10f..621b2c1ac514 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: March 2021
+:Date: February 2022
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -42,6 +42,21 @@ Guiding principles for safe access controls
 * Computation related to Landlock operations (e.g. enforcing a ruleset) shall
   only impact the processes requesting them.
 
+Design choices
+==============
+
+Filesystem access rights
+------------------------
+
+All access rights are tied to an inode and what can be accessed through it.
+Reading the content of a directory doesn't imply to be allowed to read the
+content of a listed inode.  Indeed, a file name is local to its parent
+directory, and an inode can be referenced by multiple file names thanks to
+(hard) links.  Being able to unlink a file only has a direct impact on the
+directory, not the unlinked inode.  This is the reason why
+`LANDLOCK_ACCESS_FS_REMOVE_FILE` or `LANDLOCK_ACCESS_FS_REFER` are not allowed
+to be tied to files but only to directories.
+
 Tests
 =====
 
-- 
2.35.1

