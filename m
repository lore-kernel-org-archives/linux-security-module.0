From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue,  2 May 2017 20:27:41 +0200
Subject: [PATCH trivial] security: Grammar s/allocates/allocated/
Message-ID: <1493749661-22686-1-git-send-email-geert@linux-m68k.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 213df4d4f2c1527a..1bb0c5bc9caadf8c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -134,7 +134,7 @@ config HARDENED_USERCOPY
 	  copying memory to/from the kernel (via copy_to_user() and
 	  copy_from_user() functions) by rejecting memory ranges that
 	  are larger than the specified heap object, span multiple
-	  separately allocates pages, are not on the process stack,
+	  separately allocated pages, are not on the process stack,
 	  or are part of the kernel text. This kills entire classes
 	  of heap overflow exploits and similar kernel memory exposures.
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
