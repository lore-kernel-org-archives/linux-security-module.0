From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:46 -0700
Subject: [PATCH 10/17] doc: ReSTify tomoyo.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-11-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/LSM/index.rst            |  1 +
 .../tomoyo.txt => admin-guide/LSM/tomoyo.rst}      | 22 ++++++++++++++++------
 Documentation/security/00-INDEX                    |  2 --
 3 files changed, 17 insertions(+), 8 deletions(-)
 rename Documentation/{security/tomoyo.txt => admin-guide/LSM/tomoyo.rst} (85%)

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index a4db29410ea0..6aa4e0dc588b 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -35,3 +35,4 @@ the one "major" module (e.g. SELinux) if there is one configured.
 
    apparmor
    SELinux
+   tomoyo
diff --git a/Documentation/security/tomoyo.txt b/Documentation/admin-guide/LSM/tomoyo.rst
similarity index 85%
rename from Documentation/security/tomoyo.txt
rename to Documentation/admin-guide/LSM/tomoyo.rst
index 200a2d37cbc8..a5947218fa64 100644
--- a/Documentation/security/tomoyo.txt
+++ b/Documentation/admin-guide/LSM/tomoyo.rst
@@ -1,21 +1,30 @@
---- What is TOMOYO? ---
+======
+TOMOYO
+======
+
+What is TOMOYO?
+===============
 
 TOMOYO is a name-based MAC extension (LSM module) for the Linux kernel.
 
 LiveCD-based tutorials are available at
+
 http://tomoyo.sourceforge.jp/1.7/1st-step/ubuntu10.04-live/
-http://tomoyo.sourceforge.jp/1.7/1st-step/centos5-live/ .
+http://tomoyo.sourceforge.jp/1.7/1st-step/centos5-live/
+
 Though these tutorials use non-LSM version of TOMOYO, they are useful for you
 to know what TOMOYO is.
 
---- How to enable TOMOYO? ---
+How to enable TOMOYO?
+=====================
 
-Build the kernel with CONFIG_SECURITY_TOMOYO=y and pass "security=tomoyo" on
+Build the kernel with ``CONFIG_SECURITY_TOMOYO=y`` and pass ``security=tomoyo`` on
 kernel's command line.
 
 Please see http://tomoyo.sourceforge.jp/2.3/ for details.
 
---- Where is documentation? ---
+Where is documentation?
+=======================
 
 User <-> Kernel interface documentation is available at
 http://tomoyo.sourceforge.jp/2.3/policy-reference.html .
@@ -42,7 +51,8 @@ History of TOMOYO?
   Realities of Mainlining
     http://sourceforge.jp/projects/tomoyo/docs/lfj2008.pdf
 
---- What is future plan? ---
+What is future plan?
+====================
 
 We believe that inode based security and name based security are complementary
 and both should be used together. But unfortunately, so far, we cannot enable
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index 22ebdc02f0dc..04ef62511ea1 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -12,5 +12,3 @@ keys-trusted-encrypted.txt
 	- info on the Trusted and Encrypted keys in the kernel key ring service.
 keys.txt
 	- description of the kernel key retention service.
-tomoyo.txt
-	- documentation on the TOMOYO Linux Security Module.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
