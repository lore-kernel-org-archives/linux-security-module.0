From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 09:23:24 -0700
Subject: [PATCH security-next v2 12/26] LSM: Provide separate ordered
	initialization
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Message-ID: <20180920162338.21060-13-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This provides a place for ordered LSMs to be initialized, separate from
the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
ordered_lsm_init(), but it will change drastically in later patches.

What is not obvious in the patch is that this change moves the integrity
LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
list, there is no reordering yet created.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 1f055936a746..a886a978214a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static bool debug __initdata;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info *lsm;
+	int ret;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
+			continue;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			continue;
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
@@ -87,6 +105,9 @@ int __init security_init(void)
 	yama_add_hooks();
 	loadpin_add_hooks();
 
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
 	/*
 	 * Load all the remaining security modules.
 	 */
-- 
2.17.1
