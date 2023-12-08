Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hClVuVGf"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC841724
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:51:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so27631847b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050713; x=1702655513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mju3ViF0d/Jk5ieUylmRq+FCfb/T1IaKWcGes5aRqrg=;
        b=hClVuVGfdMr5wkmZn0X4IU5Ym4fDxgEo5MgxpHddwJ9K5yfmeS61BJ7jHgSQG4NF+v
         f5wMVulB9R0CFIchJGPrYdBlI9jPjDr5CnV5cn4BQEOujA7xHKfAOhecsMT7Z+y/oYJl
         j1MH+oKSsG47B2yJJGnwwxklOuTDzHuCf8qDcjEmmunPVjzhr6eHmFPTka1JM2Uy83mq
         oq/S1iA9f3czBRBump4De8+EowfOFhiakt6Nu1i+O0n0jvCBPkH5V3jC1cq3Q7jSFLlx
         uQ6udW9iohe2bf0o4v9r5BU/v0qUpZrK7KaWLfpXuLBNZbj54s+H+z/XCU50+zCXSUhC
         xm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050713; x=1702655513;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mju3ViF0d/Jk5ieUylmRq+FCfb/T1IaKWcGes5aRqrg=;
        b=Pw0NabDMS9HRLeRTCh/nS69PBtj4YbtHyP//a+jnpZ/+HZ3QON9Snf1iF3y8r7/fVj
         l+wgX8eZvntR3fenxyptnETYlutYql0Bt8Uv7FmiXzua49dLaEQpmtt9RvWv4CPWIIng
         +6jgixTBImqyN0tDDmX7YNcXfqyRZwJpb0Lq+hk5n5iSzDgIdALAZYamKcjCVlth4LtV
         NAUDdi7NZcHYH+TasquxOcm11G3THI+qmxHF+x2TrWgh9i1dGcjxiQGWGQfsC/FnO5Sw
         Qn5VglONy1NRWgJuGwGtU4qMKn5wVkhjGQD9AhLkUvjLBe5wpN9S0yyosBli/gZ98jMV
         Ff/g==
X-Gm-Message-State: AOJu0YxN+YfbE5BUU3PF1zE3o9epV5zomFRgV9XJkyo2apB4BHLGOMTI
	rsWIN37gFYviE4TEeNnjqp7WXFmgVXbOwLkvt1g0UkTcB0IHns81M/oQHIIYLDfoY665ELsSvMH
	wS3cPj0AFkse+2+xUNYvtkrVvbZABOhXSe/N7s2o1PGVhcv+v2B+R0pNXU8QC5xTZvMXt/WjUbj
	XiX4I8YA==
X-Google-Smtp-Source: AGHT+IF08Rhtqy3Dy8W8OMYKeuBaF2V/tUXkUmZOLclD76Htb9sZGykZKBCDCf47NU7fqO4KDAlQIZtzMwE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a05:690c:b9d:b0:5a8:33ab:d545 with SMTP id
 ck29-20020a05690c0b9d00b005a833abd545mr2810ywb.2.1702050712043; Fri, 08 Dec
 2023 07:51:52 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:21 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-10-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 9/9] landlock: Document IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the paragraph above the fallback logic, use the shorter phrasing
from the landlock(7) man page.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 119 ++++++++++++++++++++---
 1 file changed, 104 insertions(+), 15 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 2e3822677061..8398851964e6 100644
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
@@ -317,18 +323,69 @@ It should also be noted that truncating files does no=
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
+As a consequence, it is possible that a process has multiple open file
+descriptors referring to the same file, but Landlock enforces different th=
ings
+when operating with these file descriptors.  This can happen when a Landlo=
ck
+ruleset gets enforced and the process keeps file descriptors which were op=
ened
+both before and after the enforcement.  It is also possible to pass such f=
ile
+descriptors between processes, keeping their Landlock properties, even whe=
n some
+of the involved processes do not have an enforced Landlock ruleset.
+
+Restricting IOCTL commands
+--------------------------
+
+When the ``LANDLOCK_ACCESS_FS_IOCTL`` access right is handled, Landlock wi=
ll
+restrict the invocation of IOCTL commands.  However, to *permit* these IOC=
TL
+commands again, some of these IOCTL commands are then granted through othe=
r,
+preexisting access rights.
+
+For example, consider a program which handles ``LANDLOCK_ACCESS_FS_IOCTL``=
 and
+``LANDLOCK_ACCESS_FS_READ_FILE``.  The program *permits*
+``LANDLOCK_ACCESS_FS_READ_FILE`` on a file ``foo.log``.
+
+By virtue of granting this access on the ``foo.log`` file, it is now possi=
ble to
+use common and harmless IOCTL commands which are useful when reading files=
, such
+as ``FIONREAD``.
+
+On the other hand, if the program permits ``LANDLOCK_ACCESS_FS_IOCTL`` on
+another file, ``FIONREAD`` will not work on that file when it is opened.  =
As
+soon as ``LANDLOCK_ACCESS_FS_READ_FILE`` is *handled* in the ruleset, the =
IOCTL
+commands affected by it can not be reenabled though ``LANDLOCK_ACCESS_FS_I=
OCTL``
+any more, but are then governed by ``LANDLOCK_ACCESS_FS_READ_FILE``.
+
+The following table illustrates how IOCTL attempts for ``FIONREAD`` are
+filtered, depending on how a Landlock ruleset handles and permits the
+``LANDLOCK_ACCESS_FS_IOCTL`` and ``LANDLOCK_ACCESS_FS_READ_FILE`` access r=
ights:
+
++------------------------+-------------+-------------------+--------------=
-----+
+|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL`` han=
dled |
+|                        | not handled | and permitted     | and not permi=
tted |
++------------------------+-------------+-------------------+--------------=
-----+
+| ``READ_FILE`` not      | allow       | allow             | deny         =
     |
+| handled                |             |                   |              =
     |
++------------------------+             +-------------------+--------------=
-----+
+| ``READ_FILE`` handled  |             | allow                            =
     |
+| and permitted          |             |                                  =
     |
++------------------------+             +-------------------+--------------=
-----+
+| ``READ_FILE`` handled  |             | deny                             =
     |
+| and not permitted      |             |                                  =
     |
++------------------------+-------------+-------------------+--------------=
-----+
+
+The full list of IOCTL commands and the access rights which affect them is
+documented below.
=20
 Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -457,6 +514,28 @@ Memory usage
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
@@ -494,6 +573,16 @@ bind and connect actions to only a set of allowed port=
s thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
 access rights.
=20
+IOCTL (ABI < 5)
+---------------
+
+IOCTL operations could not be denied before the fifth Landlock ABI, so
+:manpage:`ioctl(2)` is always allowed when using a kernel that only suppor=
ts an
+earlier ABI.
+
+Starting with the Landlock ABI version 5, it is possible to restrict the u=
se of
+:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access righ=
t.
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.43.0.472.g3155946c3a-goog

