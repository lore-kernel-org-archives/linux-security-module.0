From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:38 -0700
Subject: [PATCH 02/17] doc: ReSTify no_new_privs.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-3-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This updates no_new_privs documentation to ReST markup and adds it to
the user-space API documentation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/userspace-api/index.rst              |  1 +
 .../no_new_privs.rst}                              | 44 ++++++++++++----------
 2 files changed, 26 insertions(+), 19 deletions(-)
 rename Documentation/{prctl/no_new_privs.txt => userspace-api/no_new_privs.rst} (54%)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 15ff12342db8..7b2eb1b7d4ca 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -16,6 +16,7 @@ place where this information is gathered.
 .. toctree::
    :maxdepth: 2
 
+   no_new_privs
    seccomp_filter
    unshare
 
diff --git a/Documentation/prctl/no_new_privs.txt b/Documentation/userspace-api/no_new_privs.rst
similarity index 54%
rename from Documentation/prctl/no_new_privs.txt
rename to Documentation/userspace-api/no_new_privs.rst
index f7be84fba910..d060ea217ea1 100644
--- a/Documentation/prctl/no_new_privs.txt
+++ b/Documentation/userspace-api/no_new_privs.rst
@@ -1,3 +1,7 @@
+======================
+No New Privileges Flag
+======================
+
 The execve system call can grant a newly-started program privileges that
 its parent did not have.  The most obvious examples are setuid/setgid
 programs and file capabilities.  To prevent the parent program from
@@ -5,53 +9,55 @@ gaining these privileges as well, the kernel and user code must be
 careful to prevent the parent from doing anything that could subvert the
 child.  For example:
 
- - The dynamic loader handles LD_* environment variables differently if
+ - The dynamic loader handles ``LD_*`` environment variables differently if
    a program is setuid.
 
  - chroot is disallowed to unprivileged processes, since it would allow
-   /etc/passwd to be replaced from the point of view of a process that
+   ``/etc/passwd`` to be replaced from the point of view of a process that
    inherited chroot.
 
  - The exec code has special handling for ptrace.
 
-These are all ad-hoc fixes.  The no_new_privs bit (since Linux 3.5) is a
+These are all ad-hoc fixes.  The ``no_new_privs`` bit (since Linux 3.5) is a
 new, generic mechanism to make it safe for a process to modify its
 execution environment in a manner that persists across execve.  Any task
-can set no_new_privs.  Once the bit is set, it is inherited across fork,
-clone, and execve and cannot be unset.  With no_new_privs set, execve
+can set ``no_new_privs``.  Once the bit is set, it is inherited across fork,
+clone, and execve and cannot be unset.  With ``no_new_privs`` set, ``execve()``
 promises not to grant the privilege to do anything that could not have
 been done without the execve call.  For example, the setuid and setgid
 bits will no longer change the uid or gid; file capabilities will not
 add to the permitted set, and LSMs will not relax constraints after
 execve.
 
-To set no_new_privs, use prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0).
+To set ``no_new_privs``, use::
+
+    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 
 Be careful, though: LSMs might also not tighten constraints on exec
-in no_new_privs mode.  (This means that setting up a general-purpose
-service launcher to set no_new_privs before execing daemons may
+in ``no_new_privs`` mode.  (This means that setting up a general-purpose
+service launcher to set ``no_new_privs`` before execing daemons may
 interfere with LSM-based sandboxing.)
 
-Note that no_new_privs does not prevent privilege changes that do not
-involve execve.  An appropriately privileged task can still call
-setuid(2) and receive SCM_RIGHTS datagrams.
+Note that ``no_new_privs`` does not prevent privilege changes that do not
+involve ``execve()``.  An appropriately privileged task can still call
+``setuid(2)`` and receive SCM_RIGHTS datagrams.
 
-There are two main use cases for no_new_privs so far:
+There are two main use cases for ``no_new_privs`` so far:
 
  - Filters installed for the seccomp mode 2 sandbox persist across
    execve and can change the behavior of newly-executed programs.
    Unprivileged users are therefore only allowed to install such filters
-   if no_new_privs is set.
+   if ``no_new_privs`` is set.
 
- - By itself, no_new_privs can be used to reduce the attack surface
+ - By itself, ``no_new_privs`` can be used to reduce the attack surface
    available to an unprivileged user.  If everything running with a
-   given uid has no_new_privs set, then that uid will be unable to
+   given uid has ``no_new_privs`` set, then that uid will be unable to
    escalate its privileges by directly attacking setuid, setgid, and
    fcap-using binaries; it will need to compromise something without the
-   no_new_privs bit set first.
+   ``no_new_privs`` bit set first.
 
 In the future, other potentially dangerous kernel features could become
-available to unprivileged tasks if no_new_privs is set.  In principle,
-several options to unshare(2) and clone(2) would be safe when
-no_new_privs is set, and no_new_privs + chroot is considerable less
+available to unprivileged tasks if ``no_new_privs`` is set.  In principle,
+several options to ``unshare(2)`` and ``clone(2)`` would be safe when
+``no_new_privs`` is set, and ``no_new_privs`` + ``chroot`` is considerable less
 dangerous than chroot by itself.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
