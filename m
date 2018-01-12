From: wking@tremily.us (W. Trevor King)
Date: Fri, 12 Jan 2018 13:58:23 -0800
Subject: [PATCH] security/Kconfig: Remove pagetable-isolation.txt reference
Message-ID: <0ccf9a4d2e42bcb823ab877e4fb21274f27878bd.1515794059.git.wking@tremily.us>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The reference landed with the config option in 385ce0ea (x86/mm/pti:
Add Kconfig, 2017-12-04), but the referenced file was never committed.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 security/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 3d4debd0257e..6c02b69581c8 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -63,8 +63,6 @@ config PAGE_TABLE_ISOLATION
 	  ensuring that the majority of kernel addresses are not mapped
 	  into userspace.
 
-	  See Documentation/x86/pagetable-isolation.txt for more details.
-
 config SECURITY_INFINIBAND
 	bool "Infiniband Security Hooks"
 	depends on SECURITY && INFINIBAND
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
