Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B62C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 12:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbiELMJA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351652AbiELMJA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 08:09:00 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DD36314
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 05:08:57 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KzVtc25HczMq0p4;
        Thu, 12 May 2022 14:08:56 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KzVtb4x74zlhRVf;
        Thu, 12 May 2022 14:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652357336;
        bh=VAzyzqBsb5khQ9HXF8UiahInvKHtn618TZOLyFUBrQI=;
        h=From:To:Cc:Subject:Date:From;
        b=bXqdqZSSqxEbbGwkmo7SIN1ptW+6/alRxTzCM5DSKNzdFLcl0L4pzPIDUkBJeBkUj
         EE5bwIGbY6pQj/PTbpYMF7UeNUWUbfeipx8c59HBRM6uuj4VRKNPtIlCVXvgQqqFDH
         3LaKEeot34rmTjE+d7WWKib5qqq1TapXNdXOZR1Y=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Explain how to support Landlock
Date:   Thu, 12 May 2022 14:08:47 +0200
Message-Id: <20220512120847.124822-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20220512120847.124822-1-mic@digikod.net
---
 Documentation/userspace-api/landlock.rst | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 7b4fe6218132..e69dbddcc191 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -388,6 +388,32 @@ Starting with the Landlock ABI version 2, it is now possible to securely
 control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
 access right.
 
+Landlock support
+================
+
+Kernel configuration
+--------------------
+
+Landlock can be supported since Linux 5.13 but it must be configured in the
+kernel with `CONFIG_SECURITY_LANDLOCK=y`, and it should be enabled at boot time
+with `CONFIG_LSM=landlock,[...]`.  The `[...]` must be replaced with the list
+of LSMs that may be useful for the running system (see the `CONFIG_LSM` help).
+
+Running system configuration
+----------------------------
+
+If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we can
+still enable it by adding `lsm=landlock,[...]` to
+Documentation/admin-guide/kernel-parameters.rst. The `[...]` must be replaced
+with the list of LSMs that may be useful for the running system (see the
+`CONFIG_LSM` help).
+
+Running system check
+--------------------
+
+We can check that Landlock is enabled by looking for "landlock: Up and running"
+in kernel logs: `dmesg | grep landlock`
+
 Questions and answers
 =====================
 

base-commit: 67761d8181f0fb9dbd264caa5b6408dbc0d8e86a
-- 
2.36.0

