Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50879C6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 15:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIWPoL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiIWPn3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 11:43:29 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E1A8CD9
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 08:43:21 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYxJ80vBrzMpvPk;
        Fri, 23 Sep 2022 17:43:20 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYxJ62GfVzMpnPl;
        Fri, 23 Sep 2022 17:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663947800;
        bh=vgTFd6RmcHZN3gkiBl5jeXhvjaHKiux37bt405Bk/WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L64FAqPGzQi/yRwVMQArHFJZdmztaqOfn8qt1ePU2GNG99AZCiOE5011CldC0mh1b
         9Yt3tNtlXuyKokMVYUShFlBIv8dWEul6InmdYITfXfjyk2Xf6ALPpNH9FGrtVLbFuF
         8cQYFAnV9CEQ+DZ7r+0iE+7DmEPfC7XHa7Kt2khs=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 3/3] landlock: Fix documentation style
Date:   Fri, 23 Sep 2022 17:42:07 +0200
Message-Id: <20220923154207.3311629-4-mic@digikod.net>
In-Reply-To: <20220923154207.3311629-1-mic@digikod.net>
References: <20220923154207.3311629-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It seems that all code should use double backquotes, which is also used
to convert "%" defines.  Let's use an homogeneous style and remove all
use of simple backquotes (which should only be used for emphasis).

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220923154207.3311629-4-mic@digikod.net
---
 Documentation/security/landlock.rst      |  4 +--
 Documentation/userspace-api/landlock.rst | 25 ++++++++-------
 include/uapi/linux/landlock.h            | 10 +++---
 security/landlock/syscalls.c             | 40 ++++++++++++------------
 4 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index cc9617f3175b..c0029d5d02eb 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -54,8 +54,8 @@ content of a listed inode.  Indeed, a file name is local to its parent
 directory, and an inode can be referenced by multiple file names thanks to
 (hard) links.  Being able to unlink a file only has a direct impact on the
 directory, not the unlinked inode.  This is the reason why
-`LANDLOCK_ACCESS_FS_REMOVE_FILE` or `LANDLOCK_ACCESS_FS_REFER` are not allowed
-to be tied to files but only to directories.
+``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
+allowed to be tied to files but only to directories.
 
 Tests
 =====
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 83bae71bf042..cec780c2f497 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -69,7 +69,7 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
+remove the ``LANDLOCK_ACCESS_FS_REFER`` access right which is only supported
 starting with the second version of the ABI.
 
 .. code-block:: c
@@ -128,7 +128,7 @@ descriptor.
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
 ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+``LANDLOCK_ACCESS_FS_REFER`` is not allowed by any rule.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -154,8 +154,8 @@ The current thread is now ready to sandbox itself with the ruleset.
     }
     close(ruleset_fd);
 
-If the `landlock_restrict_self` system call succeeds, the current thread is now
-restricted and this policy will be enforced on all its subsequently created
+If the ``landlock_restrict_self`` system call succeeds, the current thread is
+now restricted and this policy will be enforced on all its subsequently created
 children as well.  Once a thread is landlocked, there is no way to remove its
 security policy; only adding more restrictions is allowed.  These threads are
 now in a new Landlock domain, merge of their parent one (if any) with the new
@@ -175,7 +175,8 @@ depend on their location (i.e. parent directories).  This is particularly
 relevant when we want to allow linking or renaming.  Indeed, having consistent
 access rights per directory enables to change the location of such directory
 without relying on the destination directory access rights (except those that
-are required for this operation, see `LANDLOCK_ACCESS_FS_REFER` documentation).
+are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
+documentation).
 Having self-sufficient hierarchies also helps to tighten the required access
 rights to the minimal set of data.  This also helps avoid sinkhole directories,
 i.e.  directories where data can be linked to but not linked from.  However,
@@ -259,7 +260,7 @@ Backward and forward compatibility
 
 Landlock is designed to be compatible with past and future versions of the
 kernel.  This is achieved thanks to the system call attributes and the
-associated bitflags, particularly the ruleset's `handled_access_fs`.  Making
+associated bitflags, particularly the ruleset's ``handled_access_fs``.  Making
 handled access right explicit enables the kernel and user space to have a clear
 contract with each other.  This is required to make sure sandboxing will not
 get stricter with a system update, which could break applications.
@@ -394,7 +395,7 @@ according to the potentially lost constraints.  To protect against privilege
 escalations through renaming or linking, and for the sake of simplicity,
 Landlock previously limited linking and renaming to the same directory.
 Starting with the Landlock ABI version 2, it is now possible to securely
-control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
+control renaming and linking thanks to the new ``LANDLOCK_ACCESS_FS_REFER``
 access right.
 
 .. _kernel_support:
@@ -403,14 +404,14 @@ Kernel support
 ==============
 
 Landlock was first introduced in Linux 5.13 but it must be configured at build
-time with `CONFIG_SECURITY_LANDLOCK=y`.  Landlock must also be enabled at boot
+time with ``CONFIG_SECURITY_LANDLOCK=y``.  Landlock must also be enabled at boot
 time as the other security modules.  The list of security modules enabled by
-default is set with `CONFIG_LSM`.  The kernel configuration should then
-contains `CONFIG_LSM=landlock,[...]` with `[...]`  as the list of other
+default is set with ``CONFIG_LSM``.  The kernel configuration should then
+contains ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
 potentially useful security modules for the running system (see the
-`CONFIG_LSM` help).
+``CONFIG_LSM`` help).
 
-If the running kernel does not have `landlock` in `CONFIG_LSM`, then we can
+If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then we can
 still enable it by adding ``lsm=landlock,[...]`` to
 Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
 configuration.
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..9c4bcc37a455 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -26,7 +26,7 @@ struct landlock_ruleset_attr {
 	 * Landlock filesystem access rights that are not part of
 	 * handled_access_fs are allowed.  This is needed for backward
 	 * compatibility reasons.  One exception is the
-	 * LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
+	 * %LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
 	 * handled, but must still be explicitly handled to add new rules with
 	 * this access right.
 	 */
@@ -128,11 +128,11 @@ struct landlock_path_beneath_attr {
  *   hierarchy must also always have the same or a superset of restrictions of
  *   the source hierarchy.  If it is not the case, or if the domain doesn't
  *   handle this access right, such actions are denied by default with errno
- *   set to EXDEV.  Linking also requires a LANDLOCK_ACCESS_FS_MAKE_* access
- *   right on the destination directory, and renaming also requires a
- *   LANDLOCK_ACCESS_FS_REMOVE_* access right on the source's (file or
+ *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
+ *   access right on the destination directory, and renaming also requires a
+ *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
  *   directory) parent.  Otherwise, such actions are denied with errno set to
- *   EACCES.  The EACCES errno prevails over EXDEV to let user space
+ *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
  *   efficiently deal with an unrecoverable error.
  *
  * .. warning::
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 735a0865ea11..2ca0ccbd905a 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -149,10 +149,10 @@ static const struct file_operations ruleset_fops = {
  *
  * Possible returned errors are:
  *
- * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - EINVAL: unknown @flags, or unknown access, or too small @size;
- * - E2BIG or EFAULT: @attr or @size inconsistencies;
- * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
+ * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - %EINVAL: unknown @flags, or unknown access, or too small @size;
+ * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
+ * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
  */
 SYSCALL_DEFINE3(landlock_create_ruleset,
 		const struct landlock_ruleset_attr __user *const, attr,
@@ -280,7 +280,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  * @ruleset_fd: File descriptor tied to the ruleset that should be extended
  *		with the new rule.
  * @rule_type: Identify the structure type pointed to by @rule_attr (only
- *             LANDLOCK_RULE_PATH_BENEATH for now).
+ *             %LANDLOCK_RULE_PATH_BENEATH for now).
  * @rule_attr: Pointer to a rule (only of type &struct
  *             landlock_path_beneath_attr for now).
  * @flags: Must be 0.
@@ -290,17 +290,17 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  *
  * Possible returned errors are:
  *
- * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
+ * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - %EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
  *   &landlock_path_beneath_attr.allowed_access is not a subset of the
  *   ruleset handled accesses);
- * - ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
- * - EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
+ * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
+ * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
- * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
+ * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
  *   @rule_attr is not the expected file descriptor type;
- * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
- * - EFAULT: @rule_attr inconsistency.
+ * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
+ * - %EFAULT: @rule_attr inconsistency.
  */
 SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
@@ -378,20 +378,20 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * @flags: Must be 0.
  *
  * This system call enables to enforce a Landlock ruleset on the current
- * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN in its
+ * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
  * Possible returned errors are:
  *
- * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - EINVAL: @flags is not 0.
- * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
- * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
- * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
+ * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
+ * - %EINVAL: @flags is not 0.
+ * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
+ * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
+ * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
  *   current thread is not running with no_new_privs, or it doesn't have
- *   CAP_SYS_ADMIN in its namespace.
- * - E2BIG: The maximum number of stacked rulesets is reached for the current
+ *   %CAP_SYS_ADMIN in its namespace.
+ * - %E2BIG: The maximum number of stacked rulesets is reached for the current
  *   thread.
  */
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
-- 
2.37.2

