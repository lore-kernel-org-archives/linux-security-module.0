From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:48 -0700
Subject: [PATCH 12/17] doc: ReSTify LoadPin.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-13-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../{security/LoadPin.txt => admin-guide/LSM/LoadPin.rst}    | 12 ++++++++----
 Documentation/admin-guide/LSM/index.rst                      |  1 +
 MAINTAINERS                                                  |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)
 rename Documentation/{security/LoadPin.txt => admin-guide/LSM/LoadPin.rst} (73%)

diff --git a/Documentation/security/LoadPin.txt b/Documentation/admin-guide/LSM/LoadPin.rst
similarity index 73%
rename from Documentation/security/LoadPin.txt
rename to Documentation/admin-guide/LSM/LoadPin.rst
index e11877f5d3d4..32070762d24c 100644
--- a/Documentation/security/LoadPin.txt
+++ b/Documentation/admin-guide/LSM/LoadPin.rst
@@ -1,3 +1,7 @@
+=======
+LoadPin
+=======
+
 LoadPin is a Linux Security Module that ensures all kernel-loaded files
 (modules, firmware, etc) all originate from the same filesystem, with
 the expectation that such a filesystem is backed by a read-only device
@@ -5,13 +9,13 @@ such as dm-verity or CDROM. This allows systems that have a verified
 and/or unchangeable filesystem to enforce module and firmware loading
 restrictions without needing to sign the files individually.
 
-The LSM is selectable at build-time with CONFIG_SECURITY_LOADPIN, and
+The LSM is selectable at build-time with ``CONFIG_SECURITY_LOADPIN``, and
 can be controlled at boot-time with the kernel command line option
-"loadpin.enabled". By default, it is enabled, but can be disabled at
-boot ("loadpin.enabled=0").
+"``loadpin.enabled``". By default, it is enabled, but can be disabled at
+boot ("``loadpin.enabled=0``").
 
 LoadPin starts pinning when it sees the first file loaded. If the
 block device backing the filesystem is not read-only, a sysctl is
-created to toggle pinning: /proc/sys/kernel/loadpin/enabled. (Having
+created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
 a mutable filesystem means pinning is mutable too, but having the
 sysctl allows for easy testing on systems with a mutable filesystem.)
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index e5ba2c69b8ef..41f5262359f9 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -34,6 +34,7 @@ the one "major" module (e.g. SELinux) if there is one configured.
    :maxdepth: 1
 
    apparmor
+   LoadPin
    SELinux
    tomoyo
    Yama
diff --git a/MAINTAINERS b/MAINTAINERS
index c72830e888f1..3c1560c75aa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11567,6 +11567,7 @@ M:	Kees Cook <keescook@chromium.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git lsm/loadpin
 S:	Supported
 F:	security/loadpin/
+F:	Documentation/admin-guide/LSM/LoadPin.rst
 
 YAMA SECURITY MODULE
 M:	Kees Cook <keescook@chromium.org>
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
