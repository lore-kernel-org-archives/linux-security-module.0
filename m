From: keescook@chromium.org (Kees Cook)
Date: Mon, 24 Sep 2018 17:18:11 -0700
Subject: [PATCH security-next v3 08/29] LSM: Record LSM name in struct lsm_info
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Message-ID: <20180925001832.18322-9-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Cc: James Morris <james.morris@microsoft.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 02ec717189f9..543636f18152 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,16 +2040,20 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	int (*init)(void);
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1
