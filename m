Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC6C6FA83
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiI0Qnk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI0Qnb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 12:43:31 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD9AFF3D4
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 09:43:28 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4McQRf3M5qzMqlmB;
        Tue, 27 Sep 2022 18:43:26 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4McQRd3xvfzMpphG;
        Tue, 27 Sep 2022 18:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664297006;
        bh=IVZRSXqUunwK74/efbzv36tMuKLfuIujD4Xjgp65/SE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WW64+KLRPlO/XRNV7kcqjKtigoVrWx177di8nRpwWt+yr44MCupJAQQMUL4GLmJ1R
         8A3ZBVcogoIzCFbJoZ1RKYfhL+Oru5+ZfuJWAoc7UcHJp1SZFXv0kOzEe3+7kK4pu7
         eXbAPXa+mqDTZZ2nXdaDgXZSvXOFLmn5ycxBa0BA=
Message-ID: <bfbf58ea-5272-6668-2359-a49966ce3b9e@digikod.net>
Date:   Tue, 27 Sep 2022 18:43:24 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-3-mic@digikod.net> <Yy8GNAAmq6t6Kt66@debian.me>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yy8GNAAmq6t6Kt66@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for your patch, but this is not a review of my patch.

On 24/09/2022 15:29, Bagas Sanjaya wrote:
> On Fri, Sep 23, 2022 at 05:42:06PM +0200, Mickaël Salaün wrote:
>> Now that we have more than one ABI version, make limitation explanation
>> more consistent by replacing "ABI 1" with "ABI < 2".  This also
>> indicates which ABIs support such past limitation.
>>
> 
> Hi,
> 
> I think grammar and reference link on userspace documentation can be
> improved, like:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 2cc502a75ef640..c49454900edb12 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -1,3 +1,5 @@
> +.. _cgroup-v1-memory:
> +
>   ==========================
>   Memory Resource Controller
>   ==========================
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 4c76fda076454c..dbeddb6851e6c9 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -3,6 +3,8 @@
>   Written by: Neil Brown
>   Please see MAINTAINERS file for where to send questions.
>   
> +.. _overlayfs:
> +
>   Overlay Filesystem
>   ==================
>   
> diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
> index d83395354250d9..cbc20658bd0c07 100644
> --- a/Documentation/filesystems/sharedsubtree.rst
> +++ b/Documentation/filesystems/sharedsubtree.rst
> @@ -1,5 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> +.. _shared-subtrees:
> +

These modifications are unrelated to Landlock.


>   ===============
>   Shared Subtrees
>   ===============
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 5dbd577b5f58b7..13a8db59b0c0e5 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -14,16 +14,18 @@ The goal of Landlock is to enable to restrict ambient rights (e.g. global
>   filesystem access) for a set of processes.  Because Landlock is a stackable
>   LSM, it makes possible to create safe security sandboxes as new security layers
>   in addition to the existing system-wide access-controls. This kind of sandbox
> -is expected to help mitigate the security impact of bugs or
> -unexpected/malicious behaviors in user space applications.  Landlock empowers
> -any process, including unprivileged ones, to securely restrict themselves.
> +can help mitigating the security impact of bugs or unexpected/malicious
> +behaviors in user space applications.  Landlock empowers any process, including
> +unprivileged ones, to securely restrict themselves.
>   
> -We can quickly make sure that Landlock is enabled in the running system by
> -looking for ``landlock: Up and running`` in kernel logs (as root): ``dmesg |
> -grep landlock || journalctl -kg landlock`` .  Developers can also easily check
> -for Landlock support with a :ref:`related system call <landlock_abi_versions>`.
> -If Landlock is not currently supported, we need to :ref:`configure the kernel
> -appropriately <kernel_support>`.
> +To check whether Landlock has been successfully enabled, look for
> +``landlock: Up and running`` in kernel logs, which can be seen with (as root)::
> +
> +  dmesg | grep landlock || journalctl -kg landlock
> +
> +Developers can also easily check for Landlock support with a
> +:ref:`related system call <landlock_abi_versions>`. If Landlock is not
> +currently supported, :ref:`the kernel needs to be configured <kernel_support>`.

This looks good, but it is difficult to see your changes because you 
re-wrapped the lines.


>   
>   Landlock rules
>   ==============
> @@ -36,12 +38,12 @@ the thread enforcing it, and its future children.
>   Defining and enforcing a security policy
>   ----------------------------------------
>   
> -We first need to define the ruleset that will contain our rules.  For this
> -example, the ruleset will contain rules that only allow read actions, but write
> -actions will be denied.  The ruleset then needs to handle both of these kind of
> +First, the ruleset that will contain rules needs to be defined. For this
> +example, the ruleset will contain rules that only allow read actions (write
> +actions will be denied). The ruleset then needs to handle both of these kind of

Why such changes?


>   actions.  This is required for backward and forward compatibility (i.e. the
>   kernel and user space may not know each other's supported restrictions), hence
> -the need to be explicit about the denied-by-default access rights.
> +it is required to be explicit about the denied-by-default access rights.
>   
>   .. code-block:: c
>   
> @@ -63,14 +65,14 @@ the need to be explicit about the denied-by-default access rights.
>               LANDLOCK_ACCESS_FS_REFER,
>       };
>   
> -Because we may not know on which kernel version an application will be
> -executed, it is safer to follow a best-effort security approach.  Indeed, we
> -should try to protect users as much as possible whatever the kernel they are
> -using.  To avoid binary enforcement (i.e. either all security features or
> -none), we can leverage a dedicated Landlock command to get the current version
> -of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the ``LANDLOCK_ACCESS_FS_REFER`` access right which is only supported
> -starting with the second version of the ABI.
> +Because it is unknown which kernel version an application will be executed,
> +it is safer to follow a best-effort security approach. Indeed, users need to
> +be protected as much as possible whatever the kernel they are
> +using.  To avoid atomic enforcement situations (i.e. either all security
> +features or none), a dedicated Landlock command to get the current version
> +of the Landlock ABI can be used and adapt the handled accesses. Let's check if
> +``LANDLOCK_ACCESS_FS_REFER`` access right (which is available since second
> +ABI version) can be removed:

Again, difficult to review with all this line changes.


>   
>   .. code-block:: c
>   
> @@ -81,7 +83,7 @@ starting with the second version of the ABI.
>           ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>       }
>   
> -This enables to create an inclusive ruleset that will contain our rules.
> +This enables to create an inclusive ruleset that will contain the rules.

Can you explain your motivation?


>   
>   .. code-block:: c
>   
> @@ -93,12 +95,11 @@ This enables to create an inclusive ruleset that will contain our rules.
>           return 1;
>       }
>   
> -We can now add a new rule to this ruleset thanks to the returned file
> +Now a new rule to this ruleset can be added using the returned file
>   descriptor referring to this ruleset.  The rule will only allow reading the
> -file hierarchy ``/usr``.  Without another rule, write actions would then be
> -denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
> -``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
> -descriptor.
> +file hierarchy ``/usr``. To add ``/usr`` to the ruleset, open the ruleset
> +with the ``O_PATH`` flag and fill the struct landlock_path_beneath_attr with
> +the descriptor:
>   
>   .. code-block:: c
>   
> @@ -125,15 +126,15 @@ descriptor.
>           return 1;
>       }
>   
> -It may also be required to create rules following the same logic as explained
> -for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because
> -``LANDLOCK_ACCESS_FS_REFER`` is not allowed by any rule.
> +It may also be required to add rules following the same logic as explained
> +above, to filter access rights according to the Landlock ABI version.
> +In this example, this is not required because ``LANDLOCK_ACCESS_FS_REFER``
> +is not allowed by any rule.
>   
> -We now have a ruleset with one rule allowing read access to ``/usr`` while
> +Now there is a ruleset with one rule allowing read access to ``/usr`` while
>   denying all other handled accesses for the filesystem.  The next step is to
> -restrict the current thread from gaining more privileges (e.g. thanks to a SUID
> -binary).
> +restrict the current thread from gaining more privileges (for example due
> +to be run by setuid binary):
>   
>   .. code-block:: c
>   
> @@ -158,7 +159,7 @@ If the ``landlock_restrict_self`` system call succeeds, the current thread is
>   now restricted and this policy will be enforced on all its subsequently created
>   children as well.  Once a thread is landlocked, there is no way to remove its
>   security policy; only adding more restrictions is allowed.  These threads are
> -now in a new Landlock domain, merge of their parent one (if any) with the new
> +now in a new Landlock domain, merging their parent one (if any) with the new

"merging their parent one"?


>   ruleset.
>   
>   Full working code can be found in `samples/landlock/sandboxer.c`_.
> @@ -166,24 +167,24 @@ Full working code can be found in `samples/landlock/sandboxer.c`_.
>   Good practices
>   --------------
>   
> -It is recommended setting access rights to file hierarchy leaves as much as
> -possible.  For instance, it is better to be able to have ``~/doc/`` as a
> -read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
> -``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
> -Following this good practice leads to self-sufficient hierarchies that do not
> -depend on their location (i.e. parent directories).  This is particularly
> -relevant when we want to allow linking or renaming.  Indeed, having consistent
> -access rights per directory enables to change the location of such directory
> -without relying on the destination directory access rights (except those that
> -are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
> -documentation).
> +It is recommended to set access rights to file hierarchy leaves as much as
> +possible.  For instance, it is better to have a read-only ``~/doc/`` and
> +read-write ``~/tmp/`` hierarchies, compared to read-only ``~/`` and
> +read-write ``~/tmp/`` hierarchies. Following it leads to self-sufficient
> +hierarchies that do not depend on their location (i.e. parent directories).
> +This is particularly relevant when allowing linking or renaming is needed.
> +Indeed, having consistent access rights per directory enables to change the
> +location of such directory without relying on the destination directory access
> +rights (except those that are required for this operation, see
> +``LANDLOCK_ACCESS_FS_REFER`` documentation for example).
> +
>   Having self-sufficient hierarchies also helps to tighten the required access
>   rights to the minimal set of data.  This also helps avoid sinkhole directories,
> -i.e.  directories where data can be linked to but not linked from.  However,
> -this depends on data organization, which might not be controlled by developers.
> -In this case, granting read-write access to ``~/tmp/``, instead of write-only
> -access, would potentially allow to move ``~/tmp/`` to a non-readable directory
> -and still keep the ability to list the content of ``~/tmp/``.
> +i.e.  directories where data can be linked to but not from.  However,
> +this depends on data organization and layout, which may be outside developer
> +control. In this case, granting read-write access instead of write-only to
> +``~/tmp/`` would potentially allow to move ``~/tmp/`` to a non-readable
> +directory and still keep the ability to list the content of ``~/tmp/``.
>   
>   Layers of file path access rights
>   ---------------------------------
> @@ -194,7 +195,7 @@ the potentially other rulesets already restricting this thread.  A sandboxed
>   thread can then safely add more constraints to itself with a new enforced
>   ruleset.
>   
> -One policy layer grants access to a file path if at least one of its rules
> +A policy layer grants access to a file path if at least one of its rules
>   encountered on the path grants the access.  A sandboxed thread can only access
>   a file path if all its enforced policy layers grant the access as well as all
>   the other system access controls (e.g. filesystem DAC, other LSM policies,
> @@ -203,42 +204,40 @@ etc.).
>   Bind mounts and OverlayFS
>   -------------------------
>   
> -Landlock enables to restrict access to file hierarchies, which means that these
> -access rights can be propagated with bind mounts (cf.
> -Documentation/filesystems/sharedsubtree.rst) but not with
> -Documentation/filesystems/overlayfs.rst.
> +Landlock can restrict access to file hierarchies, which means that these
> +access rights can be propagated with bind mounts (see
> +:ref:`shared-subtrees`) but not with :ref:`OverlayFS <overlayfs>`.
>   
>   A bind mount mirrors a source file hierarchy to a destination.  The destination
>   hierarchy is then composed of the exact same files, on which Landlock rules can
> -be tied, either via the source or the destination path.  These rules restrict
> -access when they are encountered on a path, which means that they can restrict
> -access to multiple file hierarchies at the same time, whether these hierarchies
> +be applied, either via the source or the destination path.  These rules
> +restrict access when they are encountered on a path, which means that access
> +to multiple file hierarchies can be restricted, whether these hierarchies
>   are the result of bind mounts or not.
>   
> -An OverlayFS mount point consists of upper and lower layers.  These layers are
> -combined in a merge directory, result of the mount point.  This merge hierarchy
> -may include files from the upper and lower layers, but modifications performed
> -on the merge hierarchy only reflects on the upper layer.  From a Landlock
> -policy point of view, each OverlayFS layers and merge hierarchies are
> -standalone and contains their own set of files and directories, which is
> -different from bind mounts.  A policy restricting an OverlayFS layer will not
> -restrict the resulted merged hierarchy, and vice versa.  Landlock users should
> -then only think about file hierarchies they want to allow access to, regardless
> -of the underlying filesystem.
> +On the other hand, an OverlayFS mount point consists of upper and lower layers.
> +These layers are combined in a merge directory; result of the mount point.
> +This merge hierarchy may include files from the upper and lower layers, but
> +modifications performed on the merge hierarchy only reflects on the upper
> +layer. From a Landlock policy point of view, each OverlayFS layers and merge
> +hierarchies are standalone and contains their own set of files and directories,
> +which are different from bind mounts.  A policy restricting an OverlayFS layer
> +will not restrict the resulted merged hierarchy, and vice versa. Landlock users
> +should then only think about file hierarchies they want to allow access to,
> +regardless of the underlying filesystem.
>   
>   Inheritance
>   -----------
>   
>   Every new thread resulting from a :manpage:`clone(2)` inherits Landlock domain
> -restrictions from its parent.  This is similar to the seccomp inheritance (cf.
> -Documentation/userspace-api/seccomp_filter.rst) or any other LSM dealing with
> -task's :manpage:`credentials(7)`.  For instance, one process's thread may apply
> -Landlock rules to itself, but they will not be automatically applied to other
> -sibling threads (unlike POSIX thread credential changes, cf.
> -:manpage:`nptl(7)`).
> +restrictions from its parent.  This is similar to the :ref:`seccomp-bpf`) or
> +any other LSM dealing with task :manpage:`credentials(7)`. For instance, a
> +process thread may apply Landlock rules to itself, but they will not be
> +automatically applied to other sibling threads (unlike POSIX thread credential
> +changes, see :manpage:`nptl(7)`).
>   
> -When a thread sandboxes itself, we have the guarantee that the related security
> -policy will stay enforced on all this thread's descendants.  This allows
> +When a thread sandboxes itself, there is a guarantee that the related security
> +policy will stay enforced on all the thread descendants.  This allows
>   creating standalone and modular security policies per application, which will
>   automatically be composed between themselves according to their runtime parent
>   policies.
> @@ -259,18 +258,19 @@ Backward and forward compatibility
>   ----------------------------------
>   
>   Landlock is designed to be compatible with past and future versions of the
> -kernel.  This is achieved thanks to the system call attributes and the
> -associated bitflags, particularly the ruleset's ``handled_access_fs``.  Making
> -handled access right explicit enables the kernel and user space to have a clear
> -contract with each other.  This is required to make sure sandboxing will not
> -get stricter with a system update, which could break applications.
> +kernel.  This is achieved bysystem call attributes and the associated bitflags,
> +particularly the ``handled_access_fs`` of ruleset. Making access rights
> +handling explicit enables the kernel and user space to have a clear contract
> +with each other.  This is required to make sure sandboxing will not get
> +stricter with a system update, which could break applications.
>   
>   Developers can subscribe to the `Landlock mailing list
> -<https://subspace.kernel.org/lists.linux.dev.html>`_ to knowingly update and
> -test their applications with the latest available features.  In the interest of
> -users, and because they may use different kernel versions, it is strongly
> -encouraged to follow a best-effort security approach by checking the Landlock
> -ABI version at runtime and only enforcing the supported features.
> +<https://subspace.kernel.org/lists.linux.dev.html>`_ to get to know with
> +Landlock updates and test their applications with bleeding-edge features.
> +In the interest of users, and because they may use different kernel versions,
> +it is strongly encouraged to follow a best-effort security approach by
> +checking the Landlock ABI version at runtime and only enforcing the supported
> +features.
>   
>   .. _landlock_abi_versions:
>   
> @@ -345,7 +345,7 @@ Filesystem topology modification
>   
>   As for file renaming and linking, a sandboxed thread cannot modify its
>   filesystem topology, whether via :manpage:`mount(2)` or
> -:manpage:`pivot_root(2)`.  However, :manpage:`chroot(2)` calls are not denied.
> +:manpage:`pivot_root(2)`.  However, :manpage:`chroot(2)` calls are allowed.
>   
>   Special filesystems
>   -------------------
> @@ -353,13 +353,11 @@ Special filesystems
>   Access to regular files and directories can be restricted by Landlock,
>   according to the handled accesses of a ruleset.  However, files that do not
>   come from a user-visible filesystem (e.g. pipe, socket), but can still be
> -accessed through ``/proc/<pid>/fd/*``, cannot currently be explicitly
> -restricted.  Likewise, some special kernel filesystems such as nsfs, which can
> -be accessed through ``/proc/<pid>/ns/*``, cannot currently be explicitly
> -restricted.  However, thanks to the `ptrace restrictions`_, access to such
> -sensitive ``/proc`` files are automatically restricted according to domain
> -hierarchies.  Future Landlock evolutions could still enable to explicitly
> -restrict such paths with dedicated ruleset flags.
> +accessed through ``/proc/<pid>/fd/*``, cannot currently be restricted,
> +and so some special kernel filesystems such as nsfs which can
> +be accessed through ``/proc/<pid>/ns/*``. However, access to such
> +sensitive ``/proc`` files are automatically restricted due to `ptrace restrictions`_ according to domain hierarchies. Future Landlock evolutions could still
> +enable to explicitly restrict such paths with dedicated ruleset flags.
>   
>   Ruleset layers
>   --------------
> @@ -376,7 +374,7 @@ Memory usage
>   ------------
>   
>   Kernel memory allocated to create rulesets is accounted and can be restricted
> -by the Documentation/admin-guide/cgroup-v1/memory.rst.
> +(see :ref:`cgroup-v1-memory`).
>   
>   Previous limitations
>   ====================
> @@ -386,7 +384,7 @@ File renaming and linking (ABI < 2)
>   
>   Because Landlock targets unprivileged access controls, it needs to properly
>   handle composition of rules.  Such property also implies rules nesting.
> -Properly handling multiple layers of rulesets, each one of them able to
> +Properly handling multiple layers of rulesets, with each one of them able to
>   restrict access to files, also implies inheritance of the ruleset restrictions
>   from a parent to its hierarchy.  Because files are identified and restricted by
>   their hierarchy, moving or linking a file from one directory to another implies
> @@ -395,26 +393,24 @@ according to the potentially lost constraints.  To protect against privilege
>   escalations through renaming or linking, and for the sake of simplicity,
>   Landlock previously limited linking and renaming to the same directory.
>   Starting with the Landlock ABI version 2, it is now possible to securely
> -control renaming and linking thanks to the new ``LANDLOCK_ACCESS_FS_REFER``
> -access right.
> +control renaming and linking by ``LANDLOCK_ACCESS_FS_REFER``.
>   
>   .. _kernel_support:
>   
>   Kernel support
>   ==============
>   
> -Landlock was first introduced in Linux 5.13 but it must be configured at build
> -time with ``CONFIG_SECURITY_LANDLOCK=y``.  Landlock must also be enabled at boot
> -time as the other security modules.  The list of security modules enabled by
> -default is set with ``CONFIG_LSM``.  The kernel configuration should then
> -contains ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
> +Landlock was first introduced in Linux 5.13. To enable the support, the kernel
> +must be configured at build time with ``CONFIG_SECURITY_LANDLOCK=y``.
> +Landlock must also be enabled at boot time like other security modules.
> +The list of security modules enabled by default can be seen with
> +``CONFIG_LSM``. The kernel configuration should then contains
> +``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
>   potentially useful security modules for the running system (see the
>   ``CONFIG_LSM`` help).
>   
> -If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then we can
> -still enable it by adding ``lsm=landlock,[...]`` to
> -Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
> -configuration.
> +If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then it can still be enabled by adding ``lsm=landlock,[...]`` kernel parameter (see
> +:ref:`kernelparameters`)
>   
>   Questions and answers
>   =====================
> @@ -433,7 +429,7 @@ What about namespaces and containers?
>   Namespaces can help create sandboxes but they are not designed for
>   access-control and then miss useful features for such use case (e.g. no
>   fine-grained restrictions).  Moreover, their complexity can lead to security
> -issues, especially when untrusted processes can manipulate them (cf.
> +issues, especially when untrusted processes can manipulate them (see
>   `Controlling access to user namespaces <https://lwn.net/Articles/673597/>`_).
>   
>   Additional documentation

This is too difficult to review and there is no explanation justifying 
them. Anyway, it is unrelated to my patch. You can send a standalone 
patch on top of this series, but I need more explanation.


> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index d1e2b9193f0984..a12782a958d43c 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -1,3 +1,5 @@
> +.. _seccomp-bpf:
> +
>   ===========================================
>   Seccomp BPF (SECure COMPuting with filters)
>   ===========================================
> 
> Thanks.
> 

Not related to Landlock.
