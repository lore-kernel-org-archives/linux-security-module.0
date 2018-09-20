From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 09:23:29 -0700
Subject: [PATCH security-next v2 17/26] LSM: Refactor "security=" in terms of
	enable/disable
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Message-ID: <20180920162338.21060-18-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index 5cacbcefbc32..25a019cc4a2b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -81,14 +81,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (lsm->enabled && !*lsm->enabled)
 		return false;
 
-	/* Skip major-specific checks if not a major LSM. */
-	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-		return true;
-
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_major_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -150,8 +142,24 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *lsm;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(lsm->name, chosen_major_lsm) != 0)
+				set_enabled(lsm, false);
+		}
+	}
 
 	/*
 	 * Load minor LSMs, with the capability module always first.
-- 
2.17.1
