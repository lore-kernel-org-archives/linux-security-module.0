From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:47 -0700
Subject: [PATCH 11/17] doc: ReSTify Yama.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-12-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../Yama.txt => admin-guide/LSM/Yama.rst}          | 55 ++++++++++++----------
 Documentation/admin-guide/LSM/index.rst            |  1 +
 Documentation/security/00-INDEX                    |  2 -
 MAINTAINERS                                        |  1 +
 security/yama/Kconfig                              |  3 +-
 5 files changed, 33 insertions(+), 29 deletions(-)
 rename Documentation/{security/Yama.txt => admin-guide/LSM/Yama.rst} (60%)

diff --git a/Documentation/security/Yama.txt b/Documentation/admin-guide/LSM/Yama.rst
similarity index 60%
rename from Documentation/security/Yama.txt
rename to Documentation/admin-guide/LSM/Yama.rst
index d9ee7d7a6c7f..13468ea696b7 100644
--- a/Documentation/security/Yama.txt
+++ b/Documentation/admin-guide/LSM/Yama.rst
@@ -1,13 +1,14 @@
+====
+Yama
+====
+
 Yama is a Linux Security Module that collects system-wide DAC security
 protections that are not handled by the core kernel itself. This is
-selectable at build-time with CONFIG_SECURITY_YAMA, and can be controlled
-at run-time through sysctls in /proc/sys/kernel/yama:
-
-- ptrace_scope
+selectable at build-time with ``CONFIG_SECURITY_YAMA``, and can be controlled
+at run-time through sysctls in ``/proc/sys/kernel/yama``:
 
-==============================================================
-
-ptrace_scope:
+ptrace_scope
+============
 
 As Linux grows in popularity, it will become a larger target for
 malware. One particularly troubling weakness of the Linux process
@@ -25,47 +26,49 @@ exist and remain possible if ptrace is allowed to operate as before.
 Since ptrace is not commonly used by non-developers and non-admins, system
 builders should be allowed the option to disable this debugging system.
 
-For a solution, some applications use prctl(PR_SET_DUMPABLE, ...) to
+For a solution, some applications use ``prctl(PR_SET_DUMPABLE, ...)`` to
 specifically disallow such ptrace attachment (e.g. ssh-agent), but many
 do not. A more general solution is to only allow ptrace directly from a
 parent to a child process (i.e. direct "gdb EXE" and "strace EXE" still
-work), or with CAP_SYS_PTRACE (i.e. "gdb --pid=PID", and "strace -p PID"
+work), or with ``CAP_SYS_PTRACE`` (i.e. "gdb --pid=PID", and "strace -p PID"
 still work as root).
 
 In mode 1, software that has defined application-specific relationships
 between a debugging process and its inferior (crash handlers, etc),
-prctl(PR_SET_PTRACER, pid, ...) can be used. An inferior can declare which
-other process (and its descendants) are allowed to call PTRACE_ATTACH
+``prctl(PR_SET_PTRACER, pid, ...)`` can be used. An inferior can declare which
+other process (and its descendants) are allowed to call ``PTRACE_ATTACH``
 against it. Only one such declared debugging process can exists for
 each inferior at a time. For example, this is used by KDE, Chromium, and
 Firefox's crash handlers, and by Wine for allowing only Wine processes
 to ptrace each other. If a process wishes to entirely disable these ptrace
-restrictions, it can call prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, ...)
+restrictions, it can call ``prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, ...)``
 so that any otherwise allowed process (even those in external pid namespaces)
 may attach.
 
-The sysctl settings (writable only with CAP_SYS_PTRACE) are:
+The sysctl settings (writable only with ``CAP_SYS_PTRACE``) are:
 
-0 - classic ptrace permissions: a process can PTRACE_ATTACH to any other
+0 - classic ptrace permissions:
+    a process can ``PTRACE_ATTACH`` to any other
     process running under the same uid, as long as it is dumpable (i.e.
     did not transition uids, start privileged, or have called
-    prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
+    ``prctl(PR_SET_DUMPABLE...)`` already). Similarly, ``PTRACE_TRACEME`` is
     unchanged.
 
-1 - restricted ptrace: a process must have a predefined relationship
-    with the inferior it wants to call PTRACE_ATTACH on. By default,
+1 - restricted ptrace:
+    a process must have a predefined relationship
+    with the inferior it wants to call ``PTRACE_ATTACH`` on. By default,
     this relationship is that of only its descendants when the above
     classic criteria is also met. To change the relationship, an
-    inferior can call prctl(PR_SET_PTRACER, debugger, ...) to declare
-    an allowed debugger PID to call PTRACE_ATTACH on the inferior.
-    Using PTRACE_TRACEME is unchanged.
+    inferior can call ``prctl(PR_SET_PTRACER, debugger, ...)`` to declare
+    an allowed debugger PID to call ``PTRACE_ATTACH`` on the inferior.
+    Using ``PTRACE_TRACEME`` is unchanged.
 
-2 - admin-only attach: only processes with CAP_SYS_PTRACE may use ptrace
-    with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
+2 - admin-only attach:
+    only processes with ``CAP_SYS_PTRACE`` may use ptrace
+    with ``PTRACE_ATTACH``, or through children calling ``PTRACE_TRACEME``.
 
-3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor via
-    PTRACE_TRACEME. Once set, this sysctl value cannot be changed.
+3 - no attach:
+    no processes may use ptrace with ``PTRACE_ATTACH`` nor via
+    ``PTRACE_TRACEME``. Once set, this sysctl value cannot be changed.
 
 The original children-only logic was based on the restrictions in grsecurity.
-
-==============================================================
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index 6aa4e0dc588b..e5ba2c69b8ef 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -36,3 +36,4 @@ the one "major" module (e.g. SELinux) if there is one configured.
    apparmor
    SELinux
    tomoyo
+   Yama
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index 04ef62511ea1..a55f781be0dd 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -2,8 +2,6 @@
 	- this file.
 Smack.txt
 	- documentation on the Smack Linux Security Module.
-Yama.txt
-	- documentation on the Yama Linux Security Module.
 keys-ecryptfs.txt
 	- description of the encryption keys for the ecryptfs filesystem.
 keys-request-key.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 184cdd32a67e..c72830e888f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11573,6 +11573,7 @@ M:	Kees Cook <keescook@chromium.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git yama/tip
 S:	Supported
 F:	security/yama/
+F:	Documentation/admin-guide/LSM/Yama.rst
 
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@gmail.com>
diff --git a/security/yama/Kconfig b/security/yama/Kconfig
index 90c605eea892..96b27405558a 100644
--- a/security/yama/Kconfig
+++ b/security/yama/Kconfig
@@ -7,6 +7,7 @@ config SECURITY_YAMA
 	  system-wide security settings beyond regular Linux discretionary
 	  access controls. Currently available is ptrace scope restriction.
 	  Like capabilities, this security module stacks with other LSMs.
-	  Further information can be found in Documentation/security/Yama.txt.
+	  Further information can be found in
+	  Documentation/admin-guide/LSM/Yama.rst.
 
 	  If you are unsure how to answer this question, answer N.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
