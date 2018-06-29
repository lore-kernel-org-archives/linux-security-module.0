From: kamal@canonical.com (Kamal Mostafa)
Date: Fri, 29 Jun 2018 13:04:21 -0700
Subject: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to select BUG
Message-ID: <1530302661-20953-1-git-send-email-kamal@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Allows for CONFIG_HARDENED_USERCOPY without CONFIG_BUG.

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 security/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index c430206..7667774 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -153,7 +153,6 @@ config HAVE_HARDENED_USERCOPY_ALLOCATOR
 config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
-	select BUG
 	imply STRICT_DEVMEM
 	help
 	  This option checks for obviously wrong memory regions when
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
