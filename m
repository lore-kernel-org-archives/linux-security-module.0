From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:50 -0700
Subject: [PATCH 09/18] LSM: Record LSM name in struct lsm_info
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-10-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec3419b9b16f..a7833193e9e9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2045,6 +2045,7 @@ enum lsm_type {
 };
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
@@ -2052,10 +2053,13 @@ struct lsm_info {
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static const struct lsm_info __lsm_##lsm			\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1
