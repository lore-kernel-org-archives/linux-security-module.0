From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:44 -0700
Subject: [PATCH 08/17] doc: ReSTify SELinux.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-9-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../SELinux.txt => admin-guide/LSM/SELinux.rst}        | 18 ++++++++++++------
 Documentation/admin-guide/LSM/index.rst                |  5 +++++
 Documentation/security/00-INDEX                        |  2 --
 MAINTAINERS                                            |  1 +
 scripts/selinux/README                                 |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)
 rename Documentation/{security/SELinux.txt => admin-guide/LSM/SELinux.rst} (71%)

diff --git a/Documentation/security/SELinux.txt b/Documentation/admin-guide/LSM/SELinux.rst
similarity index 71%
rename from Documentation/security/SELinux.txt
rename to Documentation/admin-guide/LSM/SELinux.rst
index 07eae00f3314..f722c9b4173a 100644
--- a/Documentation/security/SELinux.txt
+++ b/Documentation/admin-guide/LSM/SELinux.rst
@@ -1,27 +1,33 @@
+=======
+SELinux
+=======
+
 If you want to use SELinux, chances are you will want
 to use the distro-provided policies, or install the
 latest reference policy release from
+
 	http://oss.tresys.com/projects/refpolicy
 
 However, if you want to install a dummy policy for
-testing, you can do using 'mdp' provided under
+testing, you can do using ``mdp`` provided under
 scripts/selinux.  Note that this requires the selinux
 userspace to be installed - in particular you will
 need checkpolicy to compile a kernel, and setfiles and
 fixfiles to label the filesystem.
 
 	1. Compile the kernel with selinux enabled.
-	2. Type 'make' to compile mdp.
+	2. Type ``make`` to compile ``mdp``.
 	3. Make sure that you are not running with
 	   SELinux enabled and a real policy.  If
 	   you are, reboot with selinux disabled
 	   before continuing.
-	4. Run install_policy.sh:
+	4. Run install_policy.sh::
+
 		cd scripts/selinux
 		sh install_policy.sh
 
 Step 4 will create a new dummy policy valid for your
 kernel, with a single selinux user, role, and type.
-It will compile the policy, will set your SELINUXTYPE to
-dummy in /etc/selinux/config, install the compiled policy
-as 'dummy', and relabel your filesystem.
+It will compile the policy, will set your ``SELINUXTYPE`` to
+``dummy`` in ``/etc/selinux/config``, install the compiled policy
+as ``dummy``, and relabel your filesystem.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index 7e892b9b58aa..cc0e04d63bf9 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -29,3 +29,8 @@ will always include the capability module. The list reflects the
 order in which checks are made. The capability module will always
 be first, followed by any "minor" modules (e.g. Yama) and then
 the one "major" module (e.g. SELinux) if there is one configured.
+
+.. toctree::
+   :maxdepth: 1
+
+   SELinux
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index 190a023a7e72..aaa0195418b3 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file.
-SELinux.txt
-	- how to get started with the SELinux security enhancement.
 Smack.txt
 	- documentation on the Smack Linux Security Module.
 Yama.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index f2261713043c..c85108b4f6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11551,6 +11551,7 @@ S:	Supported
 F:	include/linux/selinux*
 F:	security/selinux/
 F:	scripts/selinux/
+F:	Documentation/admin-guide/LSM/SELinux.rst
 
 APPARMOR SECURITY MODULE
 M:	John Johansen <john.johansen@canonical.com>
diff --git a/scripts/selinux/README b/scripts/selinux/README
index 4d020ecb7524..5ba679c5be18 100644
--- a/scripts/selinux/README
+++ b/scripts/selinux/README
@@ -1,2 +1,2 @@
-Please see Documentation/security/SELinux.txt for information on
+Please see Documentation/admin-guide/LSM/SELinux.rst for information on
 installing a dummy SELinux policy.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
