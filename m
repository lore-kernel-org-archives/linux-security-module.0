From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:45 -0700
Subject: [PATCH 09/17] doc: ReSTify apparmor.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-10-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Cc: John Johansen <john.johansen@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../apparmor.txt => admin-guide/LSM/apparmor.rst}  | 36 ++++++++++++++--------
 Documentation/admin-guide/LSM/index.rst            |  1 +
 Documentation/security/00-INDEX                    |  2 --
 MAINTAINERS                                        |  1 +
 security/apparmor/match.c                          |  2 +-
 security/apparmor/policy_unpack.c                  |  2 +-
 6 files changed, 28 insertions(+), 16 deletions(-)
 rename Documentation/{security/apparmor.txt => admin-guide/LSM/apparmor.rst} (65%)

diff --git a/Documentation/security/apparmor.txt b/Documentation/admin-guide/LSM/apparmor.rst
similarity index 65%
rename from Documentation/security/apparmor.txt
rename to Documentation/admin-guide/LSM/apparmor.rst
index 93c1fd7d0635..3e9734bd0e05 100644
--- a/Documentation/security/apparmor.txt
+++ b/Documentation/admin-guide/LSM/apparmor.rst
@@ -1,4 +1,9 @@
---- What is AppArmor? ---
+========
+AppArmor
+========
+
+What is AppArmor?
+=================
 
 AppArmor is MAC style security extension for the Linux kernel.  It implements
 a task centered policy, with task "profiles" being created and loaded
@@ -6,34 +11,41 @@ from user space.  Tasks on the system that do not have a profile defined for
 them run in an unconfined state which is equivalent to standard Linux DAC
 permissions.
 
---- How to enable/disable ---
+How to enable/disable
+=====================
+
+set ``CONFIG_SECURITY_APPARMOR=y``
 
-set CONFIG_SECURITY_APPARMOR=y
+If AppArmor should be selected as the default security module then set::
 
-If AppArmor should be selected as the default security module then
-   set CONFIG_DEFAULT_SECURITY="apparmor"
-   and CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
+   CONFIG_DEFAULT_SECURITY="apparmor"
+   CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
 
 Build the kernel
 
 If AppArmor is not the default security module it can be enabled by passing
-security=apparmor on the kernel's command line.
+``security=apparmor`` on the kernel's command line.
 
 If AppArmor is the default security module it can be disabled by passing
-apparmor=0, security=XXXX (where XXX is valid security module), on the
-kernel's command line
+``apparmor=0, security=XXXX`` (where ``XXXX`` is valid security module), on the
+kernel's command line.
 
 For AppArmor to enforce any restrictions beyond standard Linux DAC permissions
 policy must be loaded into the kernel from user space (see the Documentation
 and tools links).
 
---- Documentation ---
+Documentation
+=============
 
-Documentation can be found on the wiki.
+Documentation can be found on the wiki, linked below.
 
---- Links ---
+Links
+=====
 
 Mailing List - apparmor at lists.ubuntu.com
+
 Wiki - http://apparmor.wiki.kernel.org/
+
 User space tools - https://launchpad.net/apparmor
+
 Kernel module - git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev.git
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index cc0e04d63bf9..a4db29410ea0 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -33,4 +33,5 @@ the one "major" module (e.g. SELinux) if there is one configured.
 .. toctree::
    :maxdepth: 1
 
+   apparmor
    SELinux
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index aaa0195418b3..22ebdc02f0dc 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -4,8 +4,6 @@ Smack.txt
 	- documentation on the Smack Linux Security Module.
 Yama.txt
 	- documentation on the Yama Linux Security Module.
-apparmor.txt
-	- documentation on the AppArmor security extension.
 keys-ecryptfs.txt
 	- description of the encryption keys for the ecryptfs filesystem.
 keys-request-key.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index c85108b4f6c7..184cdd32a67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11560,6 +11560,7 @@ W:	apparmor.wiki.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev.git
 S:	Supported
 F:	security/apparmor/
+F:	Documentation/admin-guide/LSM/apparmor.rst
 
 LOADPIN SECURITY MODULE
 M:	Kees Cook <keescook@chromium.org>
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 960c913381e2..72c604350e80 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -226,7 +226,7 @@ void aa_dfa_free_kref(struct kref *kref)
  * @flags: flags controlling what type of accept tables are acceptable
  *
  * Unpack a dfa that has been serialized.  To find information on the dfa
- * format look in Documentation/security/apparmor.txt
+ * format look in Documentation/admin-guide/LSM/apparmor.rst
  * Assumes the dfa @blob stream has been aligned on a 8 byte boundary
  *
  * Returns: an unpacked dfa ready for matching or ERR_PTR on failure
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f3422a91353c..981d570eebba 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -13,7 +13,7 @@
  * License.
  *
  * AppArmor uses a serialized binary format for loading policy. To find
- * policy format documentation look in Documentation/security/apparmor.txt
+ * policy format documentation see Documentation/admin-guide/LSM/apparmor.rst
  * All policy is validated before it is used.
  */
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
