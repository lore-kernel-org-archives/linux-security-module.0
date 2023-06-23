Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08989EB64D7
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjFWOpE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFWOod (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34022D68
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56ff7b4feefso9581157b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531435; x=1690123435;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdm54Rz+m33IoLUpgO0/e3RXUFPHZ/9x2zIzUzsArVc=;
        b=Kr3FDs0egiiiEEbnbbgw5lSNj+XGC+p9j3WLq8sOjyGZFkHbO55x3dyQF+46jtJChl
         TUlaNKL1WzrisX/prUZwLqPvayhtV4oV3vpduFD5zYkfyWAbH0urMGQ4T2gJVwyOkYb3
         bC5GP3eaYsjB9XbKGGlUOygrN8N3juknr8os2HkBr5zBI9hx7Vd2QSWdv3ewgNO48BEC
         hsVIxKFdSSKbgnDSKf5K4SO5B0MIIbuN2yXnRLQLnOsg3T79uWlChPbzoh7N9ALf7Vgx
         YpGTIW0C/xuwv+N53YPuEmdX9BPZIwFW+zOKbGS83JJWOkOzlO5nAjCmSQNktF/Fy+py
         +ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531435; x=1690123435;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kdm54Rz+m33IoLUpgO0/e3RXUFPHZ/9x2zIzUzsArVc=;
        b=PUpsEYj23PsAUUJq495C+OxItzLLlpyk3+NEfGTz2Z1h+vV/WA0FUbuu2cn2OfVZN8
         BIKQCCyVW54R9uMr01PIzJUoa+fqVwQGkA4JkWdKJ3JQlybRcEcc5wOtcOdGvC7NDYMD
         CFXO3aYZJHpg0s5xOscZ8C7YVEADgUrUVcTtlU0rpITQWAfAn4ESYr4hn3RlrKBS5cFm
         eHxySiKTchHG7q7N1qT/Ji9qI0D51AQsf/mVpfTNsKlNgSm2jL/pAy5gdnPnWmhPabRt
         my+WFv77zdpVnChlqaVgyhcNeNKYzQgEQvWs1VHnj8tM+r5Q3oGKqIrCecUOe0ozRVq+
         PIbA==
X-Gm-Message-State: AC+VfDzEESmSluanxV+0YJcPCsnPJkmXGnE6MgjhWXkfKAT7KMqhpCEN
        aAKN+7oxxJwiQ9L1TLThxwPDpWM2kRAvbkF4pYnivot8qDgokPm7KnIFXOy39I4cbKL19sfCGHH
        BLu9w22UH3k+CiKnzxeoxlX5TswPeF239+yMgMKATIVK1Dy0hgkr8k/mmvD0Zigy6UF7oH1pTQb
        prwaVHYA==
X-Google-Smtp-Source: ACHHUZ4wlB7BEjXlcYwmQHZSRL6PB3Q3JUhNMlPeWL9i6Xz1QRVALBzXJTcQBYnS7rXYAzhngYDhtxkzZHs=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a81:bd11:0:b0:54f:b56a:cd0f with SMTP id
 b17-20020a81bd11000000b0054fb56acd0fmr9747144ywi.3.1687531434911; Fri, 23 Jun
 2023 07:43:54 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:29 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-7-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 6/6] landlock: Document ioctl support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In the paragraph above the fallback logic, use the shorter phrasing
from the landlock(7) man page.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 52 ++++++++++++++++--------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index d8cd8cd9ce25..bff3b4a9df3d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -61,18 +61,17 @@ the need to be explicit about the denied-by-default acc=
ess rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_IOCTL,
     };
=20
 Because we may not know on which kernel version an application will be
 executed, it is safer to follow a best-effort security approach.  Indeed, =
we
 should try to protect users as much as possible whatever the kernel they a=
re
-using.  To avoid binary enforcement (i.e. either all security features or
-none), we can leverage a dedicated Landlock command to get the current ver=
sion
-of the Landlock ABI and adapt the handled accesses.  Let's check if we sho=
uld
-remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
-access rights, which are only supported starting with the second and third
-version of the ABI.
+using.
+
+To be compatible with older Linux versions, we detect the available Landlo=
ck ABI
+version, and only use the available subset of access rights:
=20
 .. code-block:: c
=20
@@ -92,6 +91,9 @@ version of the ABI.
     case 2:
         /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
         ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_TRUNCATE;
+    case 3:
+        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
+        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
     }
=20
 This enables to create an inclusive ruleset that will contain our rules.
@@ -190,6 +192,7 @@ access rights per directory enables to change the locat=
ion of such directory
 without relying on the destination directory access rights (except those t=
hat
 are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
 documentation).
+
 Having self-sufficient hierarchies also helps to tighten the required acce=
ss
 rights to the minimal set of data.  This also helps avoid sinkhole directo=
ries,
 i.e.  directories where data can be linked to but not linked from.  Howeve=
r,
@@ -283,18 +286,24 @@ It should also be noted that truncating files does no=
t require the
 system call, this can also be done through :manpage:`open(2)` with the fla=
gs
 ``O_RDONLY | O_TRUNC``.
=20
-When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
``
-right is associated with the newly created file descriptor and will be use=
d for
-subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavio=
r is
-similar to opening a file for reading or writing, where permissions are ch=
ecked
-during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)=
` and
+The truncate right is associated with the opened file (see below).
+
+Rights associated with file descriptors
+---------------------------------------
+
+When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
`` and
+``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly created f=
ile
+descriptor and will be used for subsequent truncation and ioctl attempts u=
sing
+:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is similar =
to
+opening a file for reading or writing, where permissions are checked durin=
g
+:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
 :manpage:`write(2)` calls.
=20
-As a consequence, it is possible to have multiple open file descriptors fo=
r the
-same file, where one grants the right to truncate the file and the other d=
oes
-not.  It is also possible to pass such file descriptors between processes,
-keeping their Landlock properties, even when these processes do not have a=
n
-enforced Landlock ruleset.
+As a consequence, it is possible to have multiple open file descriptors
+referring to the same file, where one grants the truncate or ioctl right a=
nd the
+other does not.  It is also possible to pass such file descriptors between
+processes, keeping their Landlock properties, even when these processes do=
 not
+have an enforced Landlock ruleset.
=20
 Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -451,6 +460,15 @@ always allowed when using a kernel that only supports =
the first or second ABI.
 Starting with the Landlock ABI version 3, it is now possible to securely c=
ontrol
 truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
=20
+Ioctl (ABI < 4)
+---------------
+
+Ioctl operations could not be denied before the fourth Landlock ABI, so io=
ctl is
+always allowed when using a kernel that only supports an earlier ABI.
+
+Starting with the Landlock ABI version 4, it is possible to restrict the u=
se of
+ioctl using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access right.
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.41.0.162.gfafddb0af9-goog

