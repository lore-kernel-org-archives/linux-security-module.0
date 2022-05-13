Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A2C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 11:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379904AbiEML1y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379907AbiEML1x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 07:27:53 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C753B4C
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 04:27:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L05wj138fzMqC2k;
        Fri, 13 May 2022 13:27:49 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4L05wh360LzlhMCB;
        Fri, 13 May 2022 13:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652441269;
        bh=blIYqHr32Eel+j77HwQCDY9ZnNncNKIoiGfSCtzJN3k=;
        h=From:To:Cc:Subject:Date:From;
        b=vTFEClJavy0JQhCqXjfS/363YXlUVFqpbgLEA/iuWKWfJ5HDUTSUarGbLO8uuaaA/
         P/qvSzgEVCbF+grDsFG4hup2XmsTDEJTEiXq6D+nvVOmXhwj4M2Z1Etu1dhncin/f+
         JZj8l8zobSValxEqXogaFkQR9XMUt08K4n8kRK8Q=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2] landlock: Explain how to support Landlock
Date:   Fri, 13 May 2022 13:27:43 +0200
Message-Id: <20220513112743.156414-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Let's help users by documenting how to enable and check for Landlock in
the kernel and the running system.  The userspace-api section may not be
the best place for this but it still makes sense to put all the user
documentation at the same place.

Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220513112743.156414-1-mic@digikod.net
---

Changes since v1:
* Move the checking subsection at the beginning (suggested by Paul
  Moore) and merge the two configuration subsections.
* Use both dmesg and journalctl to handle cases where journald is not
  installed or when the kernel log buffer is full.
* Add reference to the syscall check (ABI section).
* Improve explanations.
* Update copyright date.
---
 Documentation/userspace-api/landlock.rst | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 7b4fe6218132..b8ea59493964 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
 .. Copyright © 2019-2020 ANSSI
-.. Copyright © 2021 Microsoft Corporation
+.. Copyright © 2021-2022 Microsoft Corporation
 
 =====================================
 Landlock: unprivileged access control
@@ -18,6 +18,13 @@ is expected to help mitigate the security impact of bugs or
 unexpected/malicious behaviors in user space applications.  Landlock empowers
 any process, including unprivileged ones, to securely restrict themselves.
 
+We can quickly make sure that Landlock is enabled in the running system by
+looking for "landlock: Up and running" in kernel logs (as root): ``dmesg | grep
+landlock || journalctl -kg landlock`` .  Developers can also easily check for
+Landlock support with a :ref:`related system call <landlock_abi_versions>`.  If
+Landlock is not currently supported, we need to :ref:`configure the kernel
+appropriately <kernel_support>`.
+
 Landlock rules
 ==============
 
@@ -264,6 +271,8 @@ users, and because they may use different kernel versions, it is strongly
 encouraged to follow a best-effort security approach by checking the Landlock
 ABI version at runtime and only enforcing the supported features.
 
+.. _landlock_abi_versions:
+
 Landlock ABI versions
 ---------------------
 
@@ -388,6 +397,24 @@ Starting with the Landlock ABI version 2, it is now possible to securely
 control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
 access right.
 
+.. _kernel_support:
+
+Kernel support
+==============
+
+Landlock was first introduced in Linux 5.13 but it must be configured at build
+time with `CONFIG_SECURITY_LANDLOCK=y`.  Landlock must also be enabled at boot
+time as the other security modules.  The list of security modules enabled by
+default is set with `CONFIG_LSM`.  The kernel configuration should then
+contains `CONFIG_LSM=landlock,[...]` with `[...]`  as the list of other
+potentially useful security modules for the running system (see the
+`CONFIG_LSM` help).
+
+If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we can
+still enable it by adding ``lsm=landlock,[...]`` to
+Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
+configuration.
+
 Questions and answers
 =====================
 

base-commit: 67761d8181f0fb9dbd264caa5b6408dbc0d8e86a
-- 
2.36.0

