From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2018 22:23:37 +0200
Subject: [PATCH] security: export security_kernel_load_data function
Message-ID: <20180717202355.2119407-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The firmware_loader can be built as a loadable module, which now
fails when CONFIG_SECURITY is enabled, because a call to the
security_kernel_load_data() function got added, and this is
not exported to modules:

ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!

Add an EXPORT_SYMBOL_GPL() to make it available here.

Fixes: 6e852651f28e ("firmware: add call to LSM hook before firmware sysfs fallback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 03e98be76d58..7f9618eaba10 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1121,6 +1121,7 @@ int security_kernel_load_data(enum kernel_load_data_id id)
 		return ret;
 	return ima_load_data(id);
 }
+EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
