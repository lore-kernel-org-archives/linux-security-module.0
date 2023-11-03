Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35226C4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 15:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjKCP6A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbjKCP54 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 11:57:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE903D5B
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 08:57:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso2644926276.1
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027072; x=1699631872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VOiCN8o/DjtYXboLphKkKFmrLlTPpPKQqRg+hd9A94=;
        b=LgLw/V/Wpi1268LB78IzmbPKykgAJUWCtQri41hqjerWJpDQH5e+h56sXIBVRnYJ6K
         cHxl+3s5srCAoQ2ZrpqML85U6g3ar5nHi+B2X2Hrk2JfbRSrIUIH3gLIwBEts2nV8dmn
         ZYYP6i+Zxf81DPYyYchDRv+k3caoL0mBtPYgVtpZ5arpoHDMRPsL6emAOlft9i2x4Tjv
         7oKVGu57VCY3xEpf81/pPxiJgABeQN7jUYWJqtrp0DT16h1EK1029Tbh3sCdLBvesmtj
         y57IpV8Us8Rr3MC0WHp6hS2Nz1V2bqtwI3a+iDBFQBESmpRb5cuOeO1dY6AnRxPtnMTh
         TVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027072; x=1699631872;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4VOiCN8o/DjtYXboLphKkKFmrLlTPpPKQqRg+hd9A94=;
        b=V8KJzrDB8mP8Yfug/CQXGg6qzxvBrP8HeiqGH+fdbKsNmrH5mRF5NfLlyfZ+R6aKns
         f6CeuWNbKWYrNKVLXuiD/7dMDO+umfXFQS098ZFl7hg4xLD5lG6SsX6bnBRqrSSH1Mb2
         CJnUfWAvJLrmIYmbCHEpWlOZ3LkdLoLsye67wUiMQatSxWK7F35JEJ1Jck27xSO+7i3d
         W3uHk5YzXGDKS9C8fvjQ1h79Ta8ilNcoL92IKKyO7g88SGRSiKxrJ4fjgTLYgPodgy3b
         4CDeF2FWf2AmxVddikoi05AvGKU6OHZ6vlAte9CeFmLrN1HPZKPdNWVXSUrFAlv+czzb
         Uf+w==
X-Gm-Message-State: AOJu0YySe859APw+XEn4U+iiUEpUm5CVrpLAcINCRAB4BW0P632FddKN
        4o3IcvY6PxrZcKbz/lwS/0us5ss82Amp2QGCmIR0QFxPOMVCXZyrTLLbuIJO6s/OE4qq7IsB717
        zR0BmDHy57gevUVQOglssUlYfHm7q+NS0YFXdg4Yo1vqmCx9t9XBN6WKQpbtB73TKHXjYxqTEeG
        eWv3bTRg==
X-Google-Smtp-Source: AGHT+IFafpyzF7d3cKv64Oaba1Jzq343m+7zJQytbaFGf4dNJ0KJO1thYwDC/DTpnsIZR6dNC02aPGCv2FY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:a25:bc90:0:b0:d9c:c9a8:8c27 with SMTP id
 e16-20020a25bc90000000b00d9cc9a88c27mr427171ybk.13.1699027071630; Fri, 03 Nov
 2023 08:57:51 -0700 (PDT)
Date:   Fri,  3 Nov 2023 16:57:17 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-8-gnoack@google.com>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 7/7] landlock: Document IOCTL support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
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
 Documentation/userspace-api/landlock.rst | 74 +++++++++++++++++++-----
 include/uapi/linux/landlock.h            | 28 +++++++--
 2 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 2e3822677061..c64f315d5a2e 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -75,7 +75,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_IOCTL,
         .handled_access_net =3D
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -84,10 +85,10 @@ to be explicit about the denied-by-default access right=
s.
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
-remove access rights which are only supported in higher versions of the AB=
I.
+using.
+
+To be compatible with older Linux versions, we detect the available Landlo=
ck ABI
+version, and only use the available subset of access rights:
=20
 .. code-block:: c
=20
@@ -113,6 +114,10 @@ remove access rights which are only supported in highe=
r versions of the ABI.
         ruleset_attr.handled_access_net &=3D
             ~(LANDLOCK_ACCESS_NET_BIND_TCP |
               LANDLOCK_ACCESS_NET_CONNECT_TCP);
+        __attribute__((fallthrough));
+    case 4:
+        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
     }
=20
 This enables to create an inclusive ruleset that will contain our rules.
@@ -224,6 +229,7 @@ access rights per directory enables to change the locat=
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
@@ -317,18 +323,24 @@ It should also be noted that truncating files does no=
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
@@ -457,6 +469,28 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restric=
ted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
=20
+IOCTL support
+-------------
+
+The ``LANDLOCK_ACCESS_FS_IOCTL`` access right restricts the use of
+:manpage:`ioctl(2)`, but it only applies to newly opened files.  This mean=
s
+specifically that pre-existing file descriptors like stdin, stdout and std=
err
+are unaffected.
+
+Users should be aware that TTY devices have traditionally permitted to con=
trol
+other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` =
IOCTL
+commands.  It is therefore recommended to close inherited TTY file descrip=
tors,
+or to reopen them from ``/proc/self/fd/*`` without the
+``LANDLOCK_ACCESS_FS_IOCTL`` right, if possible.  The :manpage:`isatty(3)`
+function checks whether a given file descriptor is a TTY.
+
+Landlock's IOCTL support is coarse-grained at the moment, but may become m=
ore
+fine-grained in the future.  Until then, users are advised to establish th=
e
+guarantees that they need through the file hierarchy, by only permitting t=
he
+``LANDLOCK_ACCESS_FS_IOCTL`` right on files where it is really harmless.  =
In
+cases where you can control the mounts, the ``nodev`` mount option can hel=
p to
+rule out that device files can be accessed.
+
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -494,6 +528,16 @@ bind and connect actions to only a set of allowed port=
s thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
 access rights.
=20
+Ioctl (ABI < 5)
+---------------
+
+IOCTL operations could not be denied before the fourth Landlock ABI, so
+:manpage:`ioctl(2)` is always allowed when using a kernel that only suppor=
ts an
+earlier ABI.
+
+Starting with the Landlock ABI version 4, it is possible to restrict the u=
se of
+:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access righ=
t.
+
 .. _kernel_support:
=20
 Kernel support
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 6d41c059e910..3af0b1590f1b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -205,11 +205,31 @@ struct landlock_net_port_attr {
  *   file or directory.
  *
  *   This access right applies to all :manpage:`ioctl(2)` commands, except=
 of
- *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC`` and ``FIONREAD``=
.
- *   These commands continue to be invokable independent of the
- *   %LANDLOCK_ACCESS_FS_IOCTL access right.
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO`` and ``FIOASYNC``.  These comma=
nds
+ *   continue to be invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL
+ *   access right.
  *
- *   This access right is available since the fourth version of the Landlo=
ck
+ *   When certain other access rights are handled in the ruleset, in addit=
ion to
+ *   %LANDLOCK_ACCESS_FS_IOCTL, granting these access rights will unlock a=
ccess
+ *   to additional groups of IOCTL commands, on the affected files:
+ *
+ *   * %LANDLOCK_ACCESS_FS_READ_FILE unlocks access to ``FIOQSIZE``,
+ *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FIONREAD``,
+ *     ``FIDEDUPRANGE``.
+ *
+ *   * %LANDLOCK_ACCESS_FS_WRITE_FILE unlocks access to ``FIOQSIZE``,
+ *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FICLONE``,
+ *     ``FICLONERANGE``, ``FS_IOC_RESVSP``, ``FS_IOC_RESVSP64``,
+ *     ``FS_IOC_UNRESVSP``, ``FS_IOC_UNRESVSP64``, ``FS_IOC_ZERO_RANGE``.
+ *
+ *   * %LANDLOCK_ACCESS_FS_READ_DIR unlocks access to ``FIOQSIZE``,
+ *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``.
+ *
+ *   When these access rights are handled in the ruleset, the availability=
 of
+ *   the affected IOCTL commands is not governed by %LANDLOCK_ACCESS_FS_IO=
CTL
+ *   any more, but by the respective access right.
+ *
+ *   This access right is available since the fifth version of the Landloc=
k
  *   ABI.
  *
  * .. warning::
--=20
2.42.0.869.gea05f2083d-goog

