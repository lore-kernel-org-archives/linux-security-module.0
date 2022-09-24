Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D318C32771
	for <linux-security-module@archiver.kernel.org>; Sat, 24 Sep 2022 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiIXN3h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Sep 2022 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiIXN3e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Sep 2022 09:29:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7DBB8;
        Sat, 24 Sep 2022 06:29:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d11so2466443pll.8;
        Sat, 24 Sep 2022 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nZi+2omkvJoFFkUAbE/N0IadhmCrsHT7fq+It+ClhBM=;
        b=lnTHbmEH4TVdY1CGOo3J+xSe/N2G/Q3LzM+P03KmbA0MX2POPTzO083nu2Wv1MXTx6
         /SXy54U3zQ4ZXaYDBlPOHyHR8E/r/eWWSRAkGFmj+cjDQUut5jcJouzvAIneYSwRHKjV
         c/g+QHldUVshcAsKsknQ5cyfqtCqtnvOQkChg5VD4glRKOcdmEx09S08cWW7YDYnnUoK
         neV1rh62OWc7GwvrZrIpzz0JVZZ74PfeaW0fNnou262xSCidFHqJrrj9fKxq3gZcMt86
         U/Z+h9qOwfjUTm4OMDnBHI3SXMK1J9FjCz2mwH7tt4vkwjEMrMo2QJHWCzyct52/A+4y
         SICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nZi+2omkvJoFFkUAbE/N0IadhmCrsHT7fq+It+ClhBM=;
        b=Nh8oUFlNtzL7MM4qHYibrIDAJPVOeAh5xfSqYvxwpD97BBEUUNFpUpk1hD93a85F2f
         VZYvUmVZ8KkXIuUs16AmdL7i/EnpRWLQ91VbhlqLu4TsZ/u6Gos/mHKPpbCGgJf6LuOt
         UfJGn0k5vRyVkKHhz7HRajrGP25JwSTsr24D9r8rI/AHAim5ahBdB4uT3Bd1JRxgvB/w
         GjnHwAI0TQ2bIdiSflwg9/39lqJ29hJnBIV521DitiC4ZnAAX7/ca/shTqkPfvIDvifg
         MQjaCCQimUqdGM8rx0fVA4/NDBvOAdPQhTvFEVFeXJ7JS+N4DnK4b1vQe+V05ZYch29S
         4GGQ==
X-Gm-Message-State: ACrzQf1tg/zkg4UP7aRWV/Ye+bBAWeHTIQKG7+Lul272SDoY3kuJeQhi
        AW9QzG+JIyCRFVfIACAUeBA=
X-Google-Smtp-Source: AMsMyM4bBmpxB9HK6zw90hxhV1RHDrnq66WhBQIZeO6+kMR1tYrnG87U5GdBdWnWWQZILSTWVJpnXg==
X-Received: by 2002:a17:903:204d:b0:176:ca4e:37d4 with SMTP id q13-20020a170903204d00b00176ca4e37d4mr13810750pla.106.1664026169435;
        Sat, 24 Sep 2022 06:29:29 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-92.three.co.id. [180.214.232.92])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f71200b00176b0dec886sm7725035plo.58.2022.09.24.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 06:29:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A5AC5103763; Sat, 24 Sep 2022 20:29:24 +0700 (WIB)
Date:   Sat, 24 Sep 2022 20:29:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Message-ID: <Yy8GNAAmq6t6Kt66@debian.me>
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9P4bw43uMF1hAmPJ"
Content-Disposition: inline
In-Reply-To: <20220923154207.3311629-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--9P4bw43uMF1hAmPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 05:42:06PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Now that we have more than one ABI version, make limitation explanation
> more consistent by replacing "ABI 1" with "ABI < 2".  This also
> indicates which ABIs support such past limitation.
>=20

Hi,

I think grammar and reference link on userspace documentation can be
improved, like:

---- >8 ----

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation=
/admin-guide/cgroup-v1/memory.rst
index 2cc502a75ef640..c49454900edb12 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -1,3 +1,5 @@
+.. _cgroup-v1-memory:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 Memory Resource Controller
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesy=
stems/overlayfs.rst
index 4c76fda076454c..dbeddb6851e6c9 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -3,6 +3,8 @@
 Written by: Neil Brown
 Please see MAINTAINERS file for where to send questions.
=20
+.. _overlayfs:
+
 Overlay Filesystem
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/fi=
lesystems/sharedsubtree.rst
index d83395354250d9..cbc20658bd0c07 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
+.. _shared-subtrees:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Shared Subtrees
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 5dbd577b5f58b7..13a8db59b0c0e5 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -14,16 +14,18 @@ The goal of Landlock is to enable to restrict ambient r=
ights (e.g. global
 filesystem access) for a set of processes.  Because Landlock is a stackable
 LSM, it makes possible to create safe security sandboxes as new security l=
ayers
 in addition to the existing system-wide access-controls. This kind of sand=
box
-is expected to help mitigate the security impact of bugs or
-unexpected/malicious behaviors in user space applications.  Landlock empow=
ers
-any process, including unprivileged ones, to securely restrict themselves.
+can help mitigating the security impact of bugs or unexpected/malicious
+behaviors in user space applications.  Landlock empowers any process, incl=
uding
+unprivileged ones, to securely restrict themselves.
=20
-We can quickly make sure that Landlock is enabled in the running system by
-looking for ``landlock: Up and running`` in kernel logs (as root): ``dmesg=
 |=20
-grep landlock || journalctl -kg landlock`` .  Developers can also easily c=
heck
-for Landlock support with a :ref:`related system call <landlock_abi_versio=
ns>`.
-If Landlock is not currently supported, we need to :ref:`configure the ker=
nel
-appropriately <kernel_support>`.
+To check whether Landlock has been successfully enabled, look for
+``landlock: Up and running`` in kernel logs, which can be seen with (as ro=
ot)::
+
+  dmesg | grep landlock || journalctl -kg landlock
+ =20
+Developers can also easily check for Landlock support with a
+:ref:`related system call <landlock_abi_versions>`. If Landlock is not
+currently supported, :ref:`the kernel needs to be configured <kernel_suppo=
rt>`.
=20
 Landlock rules
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -36,12 +38,12 @@ the thread enforcing it, and its future children.
 Defining and enforcing a security policy
 ----------------------------------------
=20
-We first need to define the ruleset that will contain our rules.  For this
-example, the ruleset will contain rules that only allow read actions, but =
write
-actions will be denied.  The ruleset then needs to handle both of these ki=
nd of
+First, the ruleset that will contain rules needs to be defined. For this
+example, the ruleset will contain rules that only allow read actions (write
+actions will be denied). The ruleset then needs to handle both of these ki=
nd of
 actions.  This is required for backward and forward compatibility (i.e. the
 kernel and user space may not know each other's supported restrictions), h=
ence
-the need to be explicit about the denied-by-default access rights.
+it is required to be explicit about the denied-by-default access rights.
=20
 .. code-block:: c
=20
@@ -63,14 +65,14 @@ the need to be explicit about the denied-by-default acc=
ess rights.
             LANDLOCK_ACCESS_FS_REFER,
     };
=20
-Because we may not know on which kernel version an application will be
-executed, it is safer to follow a best-effort security approach.  Indeed, =
we
-should try to protect users as much as possible whatever the kernel they a=
re
-using.  To avoid binary enforcement (i.e. either all security features or
-none), we can leverage a dedicated Landlock command to get the current ver=
sion
-of the Landlock ABI and adapt the handled accesses.  Let's check if we sho=
uld
-remove the ``LANDLOCK_ACCESS_FS_REFER`` access right which is only support=
ed
-starting with the second version of the ABI.
+Because it is unknown which kernel version an application will be executed,
+it is safer to follow a best-effort security approach. Indeed, users need =
to
+be protected as much as possible whatever the kernel they are
+using.  To avoid atomic enforcement situations (i.e. either all security
+features or none), a dedicated Landlock command to get the current version
+of the Landlock ABI can be used and adapt the handled accesses. Let's chec=
k if
+``LANDLOCK_ACCESS_FS_REFER`` access right (which is available since second
+ABI version) can be removed:
=20
 .. code-block:: c
=20
@@ -81,7 +83,7 @@ starting with the second version of the ABI.
         ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_REFER;
     }
=20
-This enables to create an inclusive ruleset that will contain our rules.
+This enables to create an inclusive ruleset that will contain the rules.
=20
 .. code-block:: c
=20
@@ -93,12 +95,11 @@ This enables to create an inclusive ruleset that will c=
ontain our rules.
         return 1;
     }
=20
-We can now add a new rule to this ruleset thanks to the returned file
+Now a new rule to this ruleset can be added using the returned file
 descriptor referring to this ruleset.  The rule will only allow reading the
-file hierarchy ``/usr``.  Without another rule, write actions would then be
-denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
-``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this =
file
-descriptor.
+file hierarchy ``/usr``. To add ``/usr`` to the ruleset, open the ruleset
+with the ``O_PATH`` flag and fill the struct landlock_path_beneath_attr wi=
th
+the descriptor:
=20
 .. code-block:: c
=20
@@ -125,15 +126,15 @@ descriptor.
         return 1;
     }
=20
-It may also be required to create rules following the same logic as explai=
ned
-for the ruleset creation, by filtering access rights according to the Land=
lock
-ABI version.  In this example, this is not required because
-``LANDLOCK_ACCESS_FS_REFER`` is not allowed by any rule.
+It may also be required to add rules following the same logic as explained
+above, to filter access rights according to the Landlock ABI version.
+In this example, this is not required because ``LANDLOCK_ACCESS_FS_REFER``
+is not allowed by any rule.
=20
-We now have a ruleset with one rule allowing read access to ``/usr`` while
+Now there is a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
-restrict the current thread from gaining more privileges (e.g. thanks to a=
 SUID
-binary).
+restrict the current thread from gaining more privileges (for example due
+to be run by setuid binary):
=20
 .. code-block:: c
=20
@@ -158,7 +159,7 @@ If the ``landlock_restrict_self`` system call succeeds,=
 the current thread is
 now restricted and this policy will be enforced on all its subsequently cr=
eated
 children as well.  Once a thread is landlocked, there is no way to remove =
its
 security policy; only adding more restrictions is allowed.  These threads =
are
-now in a new Landlock domain, merge of their parent one (if any) with the =
new
+now in a new Landlock domain, merging their parent one (if any) with the n=
ew
 ruleset.
=20
 Full working code can be found in `samples/landlock/sandboxer.c`_.
@@ -166,24 +167,24 @@ Full working code can be found in `samples/landlock/s=
andboxer.c`_.
 Good practices
 --------------
=20
-It is recommended setting access rights to file hierarchy leaves as much as
-possible.  For instance, it is better to be able to have ``~/doc/`` as a
-read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
-``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
-Following this good practice leads to self-sufficient hierarchies that do =
not
-depend on their location (i.e. parent directories).  This is particularly
-relevant when we want to allow linking or renaming.  Indeed, having consis=
tent
-access rights per directory enables to change the location of such directo=
ry
-without relying on the destination directory access rights (except those t=
hat
-are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
-documentation).
+It is recommended to set access rights to file hierarchy leaves as much as
+possible.  For instance, it is better to have a read-only ``~/doc/`` and
+read-write ``~/tmp/`` hierarchies, compared to read-only ``~/`` and
+read-write ``~/tmp/`` hierarchies. Following it leads to self-sufficient
+hierarchies that do not depend on their location (i.e. parent directories).
+This is particularly relevant when allowing linking or renaming is needed.
+Indeed, having consistent access rights per directory enables to change the
+location of such directory without relying on the destination directory ac=
cess
+rights (except those that are required for this operation, see
+``LANDLOCK_ACCESS_FS_REFER``=C2=A0documentation for example).
+
 Having self-sufficient hierarchies also helps to tighten the required acce=
ss
 rights to the minimal set of data.  This also helps avoid sinkhole directo=
ries,
-i.e.  directories where data can be linked to but not linked from.  Howeve=
r,
-this depends on data organization, which might not be controlled by develo=
pers.
-In this case, granting read-write access to ``~/tmp/``, instead of write-o=
nly
-access, would potentially allow to move ``~/tmp/`` to a non-readable direc=
tory
-and still keep the ability to list the content of ``~/tmp/``.
+i.e.  directories where data can be linked to but not from.  However,
+this depends on data organization and layout, which may be outside develop=
er
+control. In this case, granting read-write access instead of write-only to
+``~/tmp/`` would potentially allow to move ``~/tmp/`` to a non-readable
+directory and still keep the ability to list the content of ``~/tmp/``.
=20
 Layers of file path access rights
 ---------------------------------
@@ -194,7 +195,7 @@ the potentially other rulesets already restricting this=
 thread.  A sandboxed
 thread can then safely add more constraints to itself with a new enforced
 ruleset.
=20
-One policy layer grants access to a file path if at least one of its rules
+A policy layer grants access to a file path if at least one of its rules
 encountered on the path grants the access.  A sandboxed thread can only ac=
cess
 a file path if all its enforced policy layers grant the access as well as =
all
 the other system access controls (e.g. filesystem DAC, other LSM policies,
@@ -203,42 +204,40 @@ etc.).
 Bind mounts and OverlayFS
 -------------------------
=20
-Landlock enables to restrict access to file hierarchies, which means that =
these
-access rights can be propagated with bind mounts (cf.
-Documentation/filesystems/sharedsubtree.rst) but not with
-Documentation/filesystems/overlayfs.rst.
+Landlock can restrict access to file hierarchies, which means that these
+access rights can be propagated with bind mounts (see
+:ref:`shared-subtrees`) but not with :ref:`OverlayFS <overlayfs>`.
=20
 A bind mount mirrors a source file hierarchy to a destination.  The destin=
ation
 hierarchy is then composed of the exact same files, on which Landlock rule=
s can
-be tied, either via the source or the destination path.  These rules restr=
ict
-access when they are encountered on a path, which means that they can rest=
rict
-access to multiple file hierarchies at the same time, whether these hierar=
chies
+be applied, either via the source or the destination path.  These rules
+restrict access when they are encountered on a path, which means that acce=
ss
+to multiple file hierarchies can be restricted, whether these hierarchies
 are the result of bind mounts or not.
=20
-An OverlayFS mount point consists of upper and lower layers.  These layers=
 are
-combined in a merge directory, result of the mount point.  This merge hier=
archy
-may include files from the upper and lower layers, but modifications perfo=
rmed
-on the merge hierarchy only reflects on the upper layer.  From a Landlock
-policy point of view, each OverlayFS layers and merge hierarchies are
-standalone and contains their own set of files and directories, which is
-different from bind mounts.  A policy restricting an OverlayFS layer will =
not
-restrict the resulted merged hierarchy, and vice versa.  Landlock users sh=
ould
-then only think about file hierarchies they want to allow access to, regar=
dless
-of the underlying filesystem.
+On the other hand, an OverlayFS mount point consists of upper and lower la=
yers.
+These layers are combined in a merge directory; result of the mount point.
+This merge hierarchy may include files from the upper and lower layers, but
+modifications performed on the merge hierarchy only reflects on the upper
+layer. From a Landlock policy point of view, each OverlayFS layers and mer=
ge
+hierarchies are standalone and contains their own set of files and directo=
ries,
+which are different from bind mounts.  A policy restricting an OverlayFS l=
ayer
+will not restrict the resulted merged hierarchy, and vice versa. Landlock =
users
+should then only think about file hierarchies they want to allow access to,
+regardless of the underlying filesystem.
=20
 Inheritance
 -----------
=20
 Every new thread resulting from a :manpage:`clone(2)` inherits Landlock do=
main
-restrictions from its parent.  This is similar to the seccomp inheritance =
(cf.
-Documentation/userspace-api/seccomp_filter.rst) or any other LSM dealing w=
ith
-task's :manpage:`credentials(7)`.  For instance, one process's thread may =
apply
-Landlock rules to itself, but they will not be automatically applied to ot=
her
-sibling threads (unlike POSIX thread credential changes, cf.
-:manpage:`nptl(7)`).
+restrictions from its parent.  This is similar to the :ref:`seccomp-bpf`) =
or
+any other LSM dealing with task :manpage:`credentials(7)`. For instance, a
+process thread may apply Landlock rules to itself, but they will not be
+automatically applied to other sibling threads (unlike POSIX thread creden=
tial
+changes, see :manpage:`nptl(7)`).
=20
-When a thread sandboxes itself, we have the guarantee that the related sec=
urity
-policy will stay enforced on all this thread's descendants.  This allows
+When a thread sandboxes itself, there is a guarantee that the related secu=
rity
+policy will stay enforced on all the thread descendants.  This allows
 creating standalone and modular security policies per application, which w=
ill
 automatically be composed between themselves according to their runtime pa=
rent
 policies.
@@ -259,18 +258,19 @@ Backward and forward compatibility
 ----------------------------------
=20
 Landlock is designed to be compatible with past and future versions of the
-kernel.  This is achieved thanks to the system call attributes and the
-associated bitflags, particularly the ruleset's ``handled_access_fs``.  Ma=
king
-handled access right explicit enables the kernel and user space to have a =
clear
-contract with each other.  This is required to make sure sandboxing will n=
ot
-get stricter with a system update, which could break applications.
+kernel.  This is achieved bysystem call attributes and the associated bitf=
lags,
+particularly the ``handled_access_fs`` of ruleset. Making access rights
+handling explicit enables the kernel and user space to have a clear contra=
ct
+with each other.  This is required to make sure sandboxing will not get
+stricter with a system update, which could break applications.
=20
 Developers can subscribe to the `Landlock mailing list
-<https://subspace.kernel.org/lists.linux.dev.html>`_ to knowingly update a=
nd
-test their applications with the latest available features.  In the intere=
st of
-users, and because they may use different kernel versions, it is strongly
-encouraged to follow a best-effort security approach by checking the Landl=
ock
-ABI version at runtime and only enforcing the supported features.
+<https://subspace.kernel.org/lists.linux.dev.html>`_ to get to know with
+Landlock updates and test their applications with bleeding-edge features.
+In the interest of users, and because they may use different kernel versio=
ns,
+it is strongly encouraged to follow a best-effort security approach by
+checking the Landlock ABI version at runtime and only enforcing the suppor=
ted
+features.
=20
 .. _landlock_abi_versions:
=20
@@ -345,7 +345,7 @@ Filesystem topology modification
=20
 As for file renaming and linking, a sandboxed thread cannot modify its
 filesystem topology, whether via :manpage:`mount(2)` or
-:manpage:`pivot_root(2)`.  However, :manpage:`chroot(2)` calls are not den=
ied.
+:manpage:`pivot_root(2)`.  However, :manpage:`chroot(2)` calls are allowed.
=20
 Special filesystems
 -------------------
@@ -353,13 +353,11 @@ Special filesystems
 Access to regular files and directories can be restricted by Landlock,
 according to the handled accesses of a ruleset.  However, files that do not
 come from a user-visible filesystem (e.g. pipe, socket), but can still be
-accessed through ``/proc/<pid>/fd/*``, cannot currently be explicitly
-restricted.  Likewise, some special kernel filesystems such as nsfs, which=
 can
-be accessed through ``/proc/<pid>/ns/*``, cannot currently be explicitly
-restricted.  However, thanks to the `ptrace restrictions`_, access to such
-sensitive ``/proc`` files are automatically restricted according to domain
-hierarchies.  Future Landlock evolutions could still enable to explicitly
-restrict such paths with dedicated ruleset flags.
+accessed through ``/proc/<pid>/fd/*``, cannot currently be restricted,
+and so some special kernel filesystems such as nsfs which can
+be accessed through ``/proc/<pid>/ns/*``. However, access to such
+sensitive ``/proc`` files are automatically restricted due to `ptrace rest=
rictions`_ according to domain hierarchies. Future Landlock evolutions coul=
d still
+enable to explicitly restrict such paths with dedicated ruleset flags.
=20
 Ruleset layers
 --------------
@@ -376,7 +374,7 @@ Memory usage
 ------------
=20
 Kernel memory allocated to create rulesets is accounted and can be restric=
ted
-by the Documentation/admin-guide/cgroup-v1/memory.rst.
+(see :ref:`cgroup-v1-memory`).
=20
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -386,7 +384,7 @@ File renaming and linking (ABI < 2)
=20
 Because Landlock targets unprivileged access controls, it needs to properly
 handle composition of rules.  Such property also implies rules nesting.
-Properly handling multiple layers of rulesets, each one of them able to
+Properly handling multiple layers of rulesets, with each one of them able =
to
 restrict access to files, also implies inheritance of the ruleset restrict=
ions
 from a parent to its hierarchy.  Because files are identified and restrict=
ed by
 their hierarchy, moving or linking a file from one directory to another im=
plies
@@ -395,26 +393,24 @@ according to the potentially lost constraints.  To pr=
otect against privilege
 escalations through renaming or linking, and for the sake of simplicity,
 Landlock previously limited linking and renaming to the same directory.
 Starting with the Landlock ABI version 2, it is now possible to securely
-control renaming and linking thanks to the new ``LANDLOCK_ACCESS_FS_REFER``
-access right.
+control renaming and linking by ``LANDLOCK_ACCESS_FS_REFER``.
=20
 .. _kernel_support:
=20
 Kernel support
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Landlock was first introduced in Linux 5.13 but it must be configured at b=
uild
-time with ``CONFIG_SECURITY_LANDLOCK=3Dy``.  Landlock must also be enabled=
 at boot
-time as the other security modules.  The list of security modules enabled =
by
-default is set with ``CONFIG_LSM``.  The kernel configuration should then
-contains ``CONFIG_LSM=3Dlandlock,[...]`` with ``[...]``  as the list of ot=
her
+Landlock was first introduced in Linux 5.13. To enable the support, the ke=
rnel
+must be configured at build time with ``CONFIG_SECURITY_LANDLOCK=3Dy``.=20
+Landlock must also be enabled at boot time like other security modules.
+The list of security modules enabled by default can be seen with
+``CONFIG_LSM``. The kernel configuration should then contains
+``CONFIG_LSM=3Dlandlock,[...]`` with ``[...]``  as the list of other
 potentially useful security modules for the running system (see the
 ``CONFIG_LSM`` help).
=20
-If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then w=
e can
-still enable it by adding ``lsm=3Dlandlock,[...]`` to
-Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
-configuration.
+If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then i=
t can still be enabled by adding ``lsm=3Dlandlock,[...]`` kernel parameter =
(see
+:ref:`kernelparameters`)
=20
 Questions and answers
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -433,7 +429,7 @@ What about namespaces and containers?
 Namespaces can help create sandboxes but they are not designed for
 access-control and then miss useful features for such use case (e.g. no
 fine-grained restrictions).  Moreover, their complexity can lead to securi=
ty
-issues, especially when untrusted processes can manipulate them (cf.
+issues, especially when untrusted processes can manipulate them (see
 `Controlling access to user namespaces <https://lwn.net/Articles/673597/>`=
_).
=20
 Additional documentation
diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation=
/userspace-api/seccomp_filter.rst
index d1e2b9193f0984..a12782a958d43c 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -1,3 +1,5 @@
+.. _seccomp-bpf:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Seccomp BPF (SECure COMPuting with filters)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9P4bw43uMF1hAmPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy8GLwAKCRD2uYlJVVFO
ox1/AP9NSx2BFAy7/afHzh4jZu738Zbd0g0dc3mD1tgUvavsdAEAjnyMBSAlrQvu
6kfAoGGlpYnouKNiQgliSKW7s8YQywU=
=L2OD
-----END PGP SIGNATURE-----

--9P4bw43uMF1hAmPJ--
