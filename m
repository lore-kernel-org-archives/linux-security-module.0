From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:53 -0700
Subject: [PATCH 12/18] LSM: Introduce ordering details in struct lsm_info
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-13-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Only minor LSMs have any ordering currently, but only capabilities
actually need to go first, so provide either "absolutely first" or
"mutable" ordering currently. Default order is "mutable".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 7 +++++++
 security/security.c       | 9 ++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e71e1c47fa1..89e6ec8eac07 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,10 +2044,17 @@ enum lsm_type {
 	LSM_TYPE_MINOR,
 };
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_MAX,
+};
+
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
 	int *enabled;		/* Optional: NULL means enabled. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	int (*init)(void);
 };
 
diff --git a/security/security.c b/security/security.c
index 3fedbee5f3ec..19afd7949426 100644
--- a/security/security.c
+++ b/security/security.c
@@ -96,10 +96,13 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
+	enum lsm_order order;
 
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->type == type)
-			maybe_enable_lsm(lsm);
+	for (order = LSM_ORDER_FIRST; order < LSM_ORDER_MAX; order++) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (lsm->type == type && lsm->order == order)
+				maybe_enable_lsm(lsm);
+		}
 	}
 }
 
-- 
2.17.1
