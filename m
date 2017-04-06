From: john.johansen@canonical.com (John Johansen)
Date: Thu,  6 Apr 2017 06:55:20 -0700
Subject: [PATCH 2/6] security/apparmor/lsm.c: set debug messages
In-Reply-To: <20170406135524.25481-1-john.johansen@canonical.com>
References: <20170406135524.25481-1-john.johansen@canonical.com>
Message-ID: <20170406135524.25481-3-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Valentin Rothberg <valentinrothberg@gmail.com>

Add the _APPARMOR substring to reference the intended Kconfig option.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 709eacd..5f7d4dd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -681,7 +681,7 @@ module_param_named(hash_policy, aa_g_hash_policy, aabool, S_IRUSR | S_IWUSR);
 #endif
 
 /* Debug mode */
-bool aa_g_debug = IS_ENABLED(CONFIG_SECURITY_DEBUG_MESSAGES);
+bool aa_g_debug = IS_ENABLED(CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES);
 module_param_named(debug, aa_g_debug, aabool, S_IRUSR | S_IWUSR);
 
 /* Audit mode */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
