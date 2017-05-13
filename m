From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:43 -0700
Subject: [PATCH 07/17] doc: ReSTify and split LSM.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-8-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing LSM.txt file covered both usage and development, so split
this into two files, one under admin-guide and one under kernel
development.

Cc: James Morris <james.l.morris@oracle.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../LSM.txt => admin-guide/LSM/index.rst}          | 22 ++++++----------------
 Documentation/admin-guide/index.rst                |  1 +
 Documentation/security/00-INDEX                    |  2 --
 Documentation/security/LSM.rst                     | 14 ++++++++++++++
 Documentation/security/index.rst                   |  1 +
 5 files changed, 22 insertions(+), 18 deletions(-)
 rename Documentation/{security/LSM.txt => admin-guide/LSM/index.rst} (62%)
 create mode 100644 Documentation/security/LSM.rst

diff --git a/Documentation/security/LSM.txt b/Documentation/admin-guide/LSM/index.rst
similarity index 62%
rename from Documentation/security/LSM.txt
rename to Documentation/admin-guide/LSM/index.rst
index c2683f28ed36..7e892b9b58aa 100644
--- a/Documentation/security/LSM.txt
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -1,12 +1,13 @@
-Linux Security Module framework
--------------------------------
+===========================
+Linux Security Module Usage
+===========================
 
 The Linux Security Module (LSM) framework provides a mechanism for
 various security checks to be hooked by new kernel extensions. The name
 "module" is a bit of a misnomer since these extensions are not actually
 loadable kernel modules. Instead, they are selectable at build-time via
 CONFIG_DEFAULT_SECURITY and can be overridden at boot-time via the
-"security=..." kernel command line argument, in the case where multiple
+``"security=..."`` kernel command line argument, in the case where multiple
 LSMs were built into a given kernel.
 
 The primary users of the LSM interface are Mandatory Access Control
@@ -19,23 +20,12 @@ in the core functionality of Linux itself.
 Without a specific LSM built into the kernel, the default LSM will be the
 Linux capabilities system. Most LSMs choose to extend the capabilities
 system, building their checks on top of the defined capability hooks.
-For more details on capabilities, see capabilities(7) in the Linux
+For more details on capabilities, see ``capabilities(7)`` in the Linux
 man-pages project.
 
 A list of the active security modules can be found by reading
-/sys/kernel/security/lsm. This is a comma separated list, and
+``/sys/kernel/security/lsm``. This is a comma separated list, and
 will always include the capability module. The list reflects the
 order in which checks are made. The capability module will always
 be first, followed by any "minor" modules (e.g. Yama) and then
 the one "major" module (e.g. SELinux) if there is one configured.
-
-Based on https://lkml.org/lkml/2007/10/26/215,
-a new LSM is accepted into the kernel when its intent (a description of
-what it tries to protect against and in what cases one would expect to
-use it) has been appropriately documented in Documentation/security/.
-This allows an LSM's code to be easily compared to its goals, and so
-that end users and distros can make a more informed decision about which
-LSMs suit their requirements.
-
-For extensive documentation on the available LSM hook interfaces, please
-see include/linux/security.h.
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 8c60a8a32a1a..e14c374aaf60 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -61,6 +61,7 @@ configure specific aspects of kernel behavior to your liking.
    java
    ras
    pm/index
+   LSM/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index c4df62a9ae5b..190a023a7e72 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file.
-LSM.txt
-	- description of the Linux Security Module framework.
 SELinux.txt
 	- how to get started with the SELinux security enhancement.
 Smack.txt
diff --git a/Documentation/security/LSM.rst b/Documentation/security/LSM.rst
new file mode 100644
index 000000000000..d75778b0fa10
--- /dev/null
+++ b/Documentation/security/LSM.rst
@@ -0,0 +1,14 @@
+=================================
+Linux Security Module Development
+=================================
+
+Based on https://lkml.org/lkml/2007/10/26/215,
+a new LSM is accepted into the kernel when its intent (a description of
+what it tries to protect against and in what cases one would expect to
+use it) has been appropriately documented in ``Documentation/security/LSM``.
+This allows an LSM's code to be easily compared to its goals, and so
+that end users and distros can make a more informed decision about which
+LSMs suit their requirements.
+
+For extensive documentation on the available LSM hook interfaces, please
+see ``include/linux/lsm_hooks.h``.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 4212d7ac58b6..94ba1cfc01c5 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -7,5 +7,6 @@ Security Documentation
 
    credentials
    IMA-templates
+   LSM
    self-protection
    tpm/index
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
