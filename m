From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 19 Sep 2017 19:23:19 +0530
Subject: [PATCH] apparmor: make allperms structure const
Message-ID: <1505829199-6657-1-git-send-email-bhumirks@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make this structure const as it is only used as a copy operations in the
files referencing it. Add const to the declaration in the header too.

Structure found using a Coccinelle script and changes done by hand.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 security/apparmor/include/perms.h | 2 +-
 security/apparmor/lib.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
index af04d5a..95ac9b6 100644
--- a/security/apparmor/include/perms.h
+++ b/security/apparmor/include/perms.h
@@ -90,7 +90,7 @@ struct aa_perms {
 
 #define ALL_PERMS_MASK 0xffffffff
 extern struct aa_perms nullperms;
-extern struct aa_perms allperms;
+extern const struct aa_perms allperms;
 
 
 #define xcheck(FN1, FN2)	\
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 8818621..5b2c245 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -25,7 +25,7 @@
 #include "include/policy.h"
 
 struct aa_perms nullperms;
-struct aa_perms allperms = { .allow = ALL_PERMS_MASK,
+const struct aa_perms allperms = { .allow = ALL_PERMS_MASK,
 			     .quiet = ALL_PERMS_MASK,
 			     .hide = ALL_PERMS_MASK };
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
