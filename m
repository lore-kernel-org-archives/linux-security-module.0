From: tycho@docker.com (Tycho Andersen)
Date: Thu,  9 Mar 2017 09:29:21 -0800
Subject: [PATCH] security/Kconfig: further restrict HARDENED_USERCOPY
Message-ID: <1489080561-30786-1-git-send-email-tycho@docker.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

It doesn't make sense to have HARDENED_USERCOPY when either /dev/kmem is
enabled or /dev/mem can be used to read kernel memory.

v2: add !MMU depend as well

Signed-off-by: Tycho Andersen <tycho@docker.com>
CC: Kees Cook <keescook@chromium.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: James Morris <james.l.morris@oracle.com>
---
 security/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/Kconfig b/security/Kconfig
index 3ff1bf9..aeabd40 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -142,6 +142,8 @@ config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	depends on HAVE_ARCH_HARDENED_USERCOPY
 	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
+	depends on !DEVKMEM
+	depends on !ARCH_HAS_DEVMEM_IS_ALLOWED || STRICT_DEVMEM || !MMU
 	select BUG
 	help
 	  This option checks for obviously wrong memory regions when
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
