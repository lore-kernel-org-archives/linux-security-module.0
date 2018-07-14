From: colin.king@canonical.com (Colin King)
Date: Sat, 14 Jul 2018 17:19:05 +0100
Subject: [PATCH] apparmor: remove redundant pointer 'info'
Message-ID: <20180714161905.5403-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'info' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'info' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/domain.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 098d546d8253..410d9ce09861 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1006,7 +1006,6 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 					 const char *name, bool sibling)
 {
 	struct aa_profile *root, *hat = NULL;
-	const char *info = NULL;
 	int error = 0;
 
 	if (sibling && PROFILE_IS_HAT(profile)) {
@@ -1014,7 +1013,6 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 	} else if (!sibling && !PROFILE_IS_HAT(profile)) {
 		root = aa_get_profile(profile);
 	} else {
-		info = "conflicting target types";
 		error = -EPERM;
 		goto audit;
 	}
@@ -1025,10 +1023,8 @@ static struct aa_label *build_change_hat(struct aa_profile *profile,
 		if (COMPLAIN_MODE(profile)) {
 			hat = aa_new_null_profile(profile, true, name,
 						  GFP_KERNEL);
-			if (!hat) {
-				info = "failed null profile create";
+			if (!hat)
 				error = -ENOMEM;
-			}
 		}
 	}
 	aa_put_profile(root);
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
