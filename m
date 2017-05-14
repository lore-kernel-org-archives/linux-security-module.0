From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 14 May 2017 16:18:35 +0900
Subject: [PATCH] tomoyo: Update URLs in Documentation/security/tomoyo.txt
Message-ID: <1494746315-3261-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Fix outdated links.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 Documentation/security/tomoyo.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/security/tomoyo.txt b/Documentation/security/tomoyo.txt
index 200a2d3..0aa3971 100644
--- a/Documentation/security/tomoyo.txt
+++ b/Documentation/security/tomoyo.txt
@@ -3,8 +3,8 @@
 TOMOYO is a name-based MAC extension (LSM module) for the Linux kernel.
 
 LiveCD-based tutorials are available at
-http://tomoyo.sourceforge.jp/1.7/1st-step/ubuntu10.04-live/
-http://tomoyo.sourceforge.jp/1.7/1st-step/centos5-live/ .
+http://tomoyo.osdn.jp/1.8/ubuntu12.04-live.html
+http://tomoyo.osdn.jp/1.8/centos6-live.html .
 Though these tutorials use non-LSM version of TOMOYO, they are useful for you
 to know what TOMOYO is.
 
@@ -13,34 +13,34 @@ to know what TOMOYO is.
 Build the kernel with CONFIG_SECURITY_TOMOYO=y and pass "security=tomoyo" on
 kernel's command line.
 
-Please see http://tomoyo.sourceforge.jp/2.3/ for details.
+Please see http://tomoyo.osdn.jp/2.5/ for details.
 
 --- Where is documentation? ---
 
 User <-> Kernel interface documentation is available at
-http://tomoyo.sourceforge.jp/2.3/policy-reference.html .
+http://tomoyo.osdn.jp/2.5/policy-specification/index.html .
 
 Materials we prepared for seminars and symposiums are available at
-http://sourceforge.jp/projects/tomoyo/docs/?category_id=532&language_id=1 .
+http://osdn.jp/projects/tomoyo/docs/?category_id=532&language_id=1 .
 Below lists are chosen from three aspects.
 
 What is TOMOYO?
   TOMOYO Linux Overview
-    http://sourceforge.jp/projects/tomoyo/docs/lca2009-takeda.pdf
+    http://osdn.jp/projects/tomoyo/docs/lca2009-takeda.pdf
   TOMOYO Linux: pragmatic and manageable security for Linux
-    http://sourceforge.jp/projects/tomoyo/docs/freedomhectaipei-tomoyo.pdf
+    http://osdn.jp/projects/tomoyo/docs/freedomhectaipei-tomoyo.pdf
   TOMOYO Linux: A Practical Method to Understand and Protect Your Own Linux Box
-    http://sourceforge.jp/projects/tomoyo/docs/PacSec2007-en-no-demo.pdf
+    http://osdn.jp/projects/tomoyo/docs/PacSec2007-en-no-demo.pdf
 
 What can TOMOYO do?
   Deep inside TOMOYO Linux
-    http://sourceforge.jp/projects/tomoyo/docs/lca2009-kumaneko.pdf
+    http://osdn.jp/projects/tomoyo/docs/lca2009-kumaneko.pdf
   The role of "pathname based access control" in security.
-    http://sourceforge.jp/projects/tomoyo/docs/lfj2008-bof.pdf
+    http://osdn.jp/projects/tomoyo/docs/lfj2008-bof.pdf
 
 History of TOMOYO?
   Realities of Mainlining
-    http://sourceforge.jp/projects/tomoyo/docs/lfj2008.pdf
+    http://osdn.jp/projects/tomoyo/docs/lfj2008.pdf
 
 --- What is future plan? ---
 
@@ -50,6 +50,6 @@ multiple LSM modules at the same time. We feel sorry that you have to give up
 SELinux/SMACK/AppArmor etc. when you want to use TOMOYO.
 
 We hope that LSM becomes stackable in future. Meanwhile, you can use non-LSM
-version of TOMOYO, available at http://tomoyo.sourceforge.jp/1.7/ .
+version of TOMOYO, available at http://tomoyo.osdn.jp/1.8/ .
 LSM version of TOMOYO is a subset of non-LSM version of TOMOYO. We are planning
 to port non-LSM version's functionalities to LSM versions.
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
