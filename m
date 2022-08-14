Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B6C25B06
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 19:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiHNT0z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiHNT0t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 15:26:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654091AF0B
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i14so10374171ejg.6
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D30SETT0tSv61NCSBcqdH/3/FViIS9vtRY0gOp9asbY=;
        b=amnGmmKUvtClA6U1tC8lC3wce6Su/U/em4PqSamF6mKKOh5SrUF1WdoDeVB624RKqy
         nvEdG8wl8OC8Cxzb5/u6BoRU78knZJ2y3cNWrZ7DEaWANyHLe6xFhj/ZKofhdUGUTek4
         CENpfNJDwAOynMg5zbiyHGxGbzHxmgD8eDGyTCDMcIfDi/1F2QvdSyeDX2etxUB5LIcj
         Mq8RT9Bz3q2mm43Nt3UeN7cqIFhMeZJff8eeaYw/UQpwIf5GVz7mMJxcCLGvW0ZSCKKe
         t2FUhSF0LawR4daxduyihWGY4LKft3vLd1950ygfdlVRHP31kqJtj//+3OwpBwQpL3ub
         wcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D30SETT0tSv61NCSBcqdH/3/FViIS9vtRY0gOp9asbY=;
        b=Vmue3b1WZZ4Us2qG1XZHRXLUjZUbNjYfUoFIdp4hcqrReRAbT0bbyupdfUIMUtCO41
         bUrqLzcXRihxIWRx6kxqxX/JHrsmwyJUPUrwkVHS4aZniUiFxx+f+BOddO+59oopnQhP
         F8g6J6YjpE6Cvx/JJG95daaQ16okyVKDUbbUcBBzSe5ckm3wAWPUZDQ3FsxV5Jbw8fPB
         vCKxQD8OhhFzUY96RusHWOhhBEwfVIEZnaCyfcBf6IHKZbm+oslB9eWf+OQK+UvjON2Y
         EGiumUSyPZeaZMVBYL6gxHXovkRF1HASlOhOonzQ0AQCsBv9lEUoBHkxziRtVwcnTbmz
         9VBQ==
X-Gm-Message-State: ACgBeo2UkLQigsW77/0s7aM8EpYPqLMGx5vHY4/xlTulcQg325nTXQCX
        Zobrc1HyFWGb3562fR+bqxJqHu974/g=
X-Google-Smtp-Source: AA6agR56+z/yI4tYbn7j0B92Qdrvyt+dZmsf4wCaqNOHdbZAxMaLHJFjVMidM0khBrViUxdqrQcs1Q==
X-Received: by 2002:a17:907:3f85:b0:733:3f0e:2f28 with SMTP id hr5-20020a1709073f8500b007333f0e2f28mr8284701ejc.376.1660505206687;
        Sun, 14 Aug 2022 12:26:46 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bq24-20020a170906d0d800b0072b2ef2757csm3209066ejb.180.2022.08.14.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 12:26:46 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v4 4/4] landlock: Document Landlock's file truncation support
Date:   Sun, 14 Aug 2022 21:26:03 +0200
Message-Id: <20220814192603.7387-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814192603.7387-1-gnoack3000@gmail.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.

Adapt the backwards compatibility example and discussion to remove the
truncation flag where needed.

Point out potential surprising behaviour related to truncate.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 48 +++++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 6648e59fabe7..3ceb97cbe9d1 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_FIFO |
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
-            LANDLOCK_ACCESS_FS_REFER,
+            LANDLOCK_ACCESS_FS_REFER |
+            LANDLOCK_ACCESS_FS_TRUNCATE,
     };
 
 Because we may not know on which kernel version an application will be
@@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
-starting with the second version of the ABI.
+remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access
+rights, which are only supported starting with the second and third version of
+the ABI.
 
 .. code-block:: c
 
     int abi;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
-    if (abi < 2) {
-        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+    switch (abi) {
+    case -1:
+            perror("The running kernel does not enable to use Landlock");
+            return 1;
+    case 1:
+            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+            __attribute__((fallthrough));
+    case 2:
+            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -127,8 +138,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -251,6 +262,24 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+Truncating files
+----------------
+
+The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
+`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and sometimes
+overlap in non-intuitive ways.  It is recommended to always specify both of
+these together.
+
+A particularly surprising example is :manpage:`creat(2)`.  The name suggests
+that this system call requires the rights to create and write files.  However,
+it also requires the truncate right if an existing file under the same name is
+already present.
+
+It should also be noted that truncating files does not necessarily require the
+`LANDLOCK_ACCESS_FS_WRITE_FILE` right.  Apart from the obvious
+:manpage:`truncate(2)` system call, this can also be done through
+:manpage:`open(2)` with the flags `O_RDONLY` and `O_TRUNC`.
+
 Compatibility
 =============
 
@@ -386,9 +415,8 @@ File truncation (ABI < 3)
 File truncation could not be denied before the third Landlock ABI, so it is
 always allowed when using a kernel that only supports the first or second ABI.
 
-Starting with the Landlock ABI version 3, it is now possible to securely
-control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access
-right.
+Starting with the Landlock ABI version 3, it is now possible to securely control
+truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access right.
 
 File renaming and linking (ABI 1)
 ---------------------------------
-- 
2.37.2

