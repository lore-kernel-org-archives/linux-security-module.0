From: wking@tremily.us (W. Trevor King)
Date: Fri, 12 Jan 2018 15:24:59 -0800
Subject: [PATCH] security/Kconfig: Replace pagetable-isolation.txt reference
	with pti.txt
In-Reply-To: <9b21ce8f-625c-6915-654b-42334cf38e99@linux.intel.com>
References: <9b21ce8f-625c-6915-654b-42334cf38e99@linux.intel.com>
Message-ID: <3009cc8ccbddcd897ec1e0cb6dda524929de0d14.1515799398.git.wking@tremily.us>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The reference landed with the config option in 385ce0ea (x86/mm/pti:
Add Kconfig, 2017-12-04), but the referenced file was not committed
then.  It eventually landed in 01c9b17b (x86/Documentation: Add PTI
description, 2018-01-05) as pti.txt.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
On Fri, Jan 12, 2018 at 03:10:53PM -0800, Dave Hansen wrote:
> There is a new file in -tip:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/pti&id=01c9b17bf673b05bb401b76ec763e9730ccf1376
>
> If you're going to patch this, please send an update to -tip that
> corrects the filename.

Here you go :).

Cheers,
Trevor

 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 3d4debd0257e..b0cb9a5f9448 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -63,7 +63,7 @@ config PAGE_TABLE_ISOLATION
 	  ensuring that the majority of kernel addresses are not mapped
 	  into userspace.
 
-	  See Documentation/x86/pagetable-isolation.txt for more details.
+	  See Documentation/x86/pti.txt for more details.
 
 config SECURITY_INFINIBAND
 	bool "Infiniband Security Hooks"
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
