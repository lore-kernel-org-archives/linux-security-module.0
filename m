Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E9C19F21
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 19:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiHDTiU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiHDTiJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696AB6E2C9
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 12:38:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b96so1016152edf.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kjoSV2O7dr/1ghBAP2+33C9U6pxl/HAlANzNjIYzCsw=;
        b=oFoku01v5ZEw1P6dTV3/onjfr130C03HJbF4Xj4MDVmDWLwJ+33taFoTvivReBNcVI
         +DxM6teNs8Dn8rb5rzu48drEpWIXjZbULO6LXghONemkN0xzr63lgRxZ8+mT/ZnwVClb
         0QIpLFpaKlERLegT7Tx8HUn5Il/o0BPH7LiAQMtxSK2nyZi2srMQ4DS+yRul5SsD8nYy
         m2FvvobHgPezlP74mISTUTPmNJGw4CNfJipkH/ZnwVa5RYCt6vPvKMqODWFJxWWNN3pz
         HZlZQsbYwYrFMsh4yEZS6rqH1ZxWQLYYJxhLk8bbRYmlrED296IOV/j4cMR6TyXXLi98
         VmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kjoSV2O7dr/1ghBAP2+33C9U6pxl/HAlANzNjIYzCsw=;
        b=6XH7vnHL/t+xV++41ZMOUY7TRMN4iJe1h03g5P0Ehdc0kQdAuy+ZBhFujUAWVyPZXI
         YQD1KmdJPjN4LQCv58ZFaLWkAr59HFTdJ3uMWGV+JRRXnb3xQHbw7YIlPmVp3E6r0caU
         GQHCqnPBLPSIdiGKwscnuxlBXj9uBhW7IBcyz0pBxjmSWBtWmQP02MgNrM8wIB5gsPIa
         CAezzcnuDGay465SPsqPPM+lrkBLrV1EaiIJdgbQ6d4x2c9awJ3FrNH/48/VKB425Jai
         DweYMwlkkYms01sjI4Tev6ZACDfQ30vPQu4SNasC9OhQhj4Ajs/cuINfvtUgjFM0ZGw6
         yNYA==
X-Gm-Message-State: ACgBeo2p5lYVsqJGdSHEfK5HKbuGktDDNq4TQ0KLXPXn7WVswJ9GTK2M
        zetQpOZfh02WOanrb08X7NfP3LnaBaI=
X-Google-Smtp-Source: AA6agR4S4QroVh2atJ71wKBy/QDB3smpubijoRKNPUooZW3Xws3qiQZpkuNuQfOEQDAuI8UaUiCM0Q==
X-Received: by 2002:a05:6402:43c5:b0:43d:f9ca:4061 with SMTP id p5-20020a05640243c500b0043df9ca4061mr3547979edc.352.1659641886974;
        Thu, 04 Aug 2022 12:38:06 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072abb95c9f4sm631851ejh.193.2022.08.04.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:38:06 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 4/4] landlock: Document Landlock's file truncation support
Date:   Thu,  4 Aug 2022 21:37:46 +0200
Message-Id: <20220804193746.9161-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804193746.9161-1-gnoack3000@gmail.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
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
 Documentation/userspace-api/landlock.rst | 41 ++++++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index d92e335380d4..9c3c9fa65958 100644
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
@@ -69,16 +70,24 @@ should try to protect users as much as possible whatever the kernel they are
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
+            perror("Landlock is not supported with the running kernel");
+            return 1;
+    case 1:
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+            __attribute__((fallthrough));
+    case 2:
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -127,8 +136,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -251,6 +260,24 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+Truncating files
+----------------
+
+The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
+`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and
+sometimes overlap in non-intuitive ways. It is recommended to always
+specify both of these together.
+
+A particularly surprising example is :manpage:`creat(2)`. The name
+suggests that this system call requires the rights to create and write
+files. However, it also requires the truncate right if an existing
+file under the same name is already present.
+
+It should also be noted that truncating files does not necessarily
+require the `LANDLOCK_ACCESS_FS_WRITE_FILE` right. Apart from the
+obvious :manpage:`truncate(2)` system call, this can also be done
+through :manpage:`open(2)` with the flags `O_RDONLY` and `O_TRUNC`.
+
 Compatibility
 =============
 
-- 
2.37.1

