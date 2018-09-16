From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:48 -0700
Subject: [PATCH 07/18] LSM: Add minor LSM initialization loop
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-8-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Split initialization loop into two phases: "exclusive" LSMs and "minor"
LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 8 +++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f8e618e2bdd2..ec3419b9b16f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,7 +2039,13 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+enum lsm_type {
+	LSM_TYPE_EXCLUSIVE = 0,
+	LSM_TYPE_MINOR,
+};
+
 struct lsm_info {
+	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
 
diff --git a/security/security.c b/security/security.c
index 74ab98f82d34..da2a923f2609 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,12 +43,13 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
-static void __init major_lsm_init(void)
+static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		lsm->init();
+		if (lsm->type == type)
+			lsm->init();
 	}
 }
 
@@ -73,11 +74,12 @@ int __init security_init(void)
 	capability_add_hooks();
 	yama_add_hooks();
 	loadpin_add_hooks();
+	lsm_init(LSM_TYPE_MINOR);
 
 	/*
 	 * Load all the remaining security modules.
 	 */
-	major_lsm_init();
+	lsm_init(LSM_TYPE_EXCLUSIVE);
 
 	return 0;
 }
-- 
2.17.1
