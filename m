From: colin.king@canonical.com (Colin King)
Date: Sat, 14 Oct 2017 13:14:38 +0100
Subject: [PATCH] apparmor: remove unused redundant variable stop
Message-ID: <20171014121438.31958-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The boolean variable 'stop' is being set but never read. This
is a redundant variable and can be removed.

Cleans up clang warning: Value stored to 'stop' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/lib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 8818621b5d95..d78da4e973d9 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -427,7 +427,6 @@ int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
 		   void (*cb)(struct audit_buffer *, void *))
 {
 	int type, error;
-	bool stop = false;
 	u32 denied = request & (~perms->allow | perms->deny);
 
 	if (likely(!denied)) {
@@ -448,8 +447,6 @@ int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
 		else
 			type = AUDIT_APPARMOR_DENIED;
 
-		if (denied & perms->stop)
-			stop = true;
 		if (denied == (denied & perms->hide))
 			error = -ENOENT;
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
