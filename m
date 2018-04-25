From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:59:43 +0000
Subject: [PATCH v7 5/6] security: Panic on forced unloading of security module
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <8daf3d7f289acc3a23c4652a8ddd8db2b9c39d85.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Although, when LSMs are loaded, the kernel takes a refcount on them, the
administrator can force unload the module if the
CONFIG_MODULE_FORCE_UNLOAD is set. Although this may be fine for some
cases, in the case of security modules, this is problematic, as it
may leave the system unsecure, or unaudited.

Although, a kernel panic will occur on the next attempt to make a
callback for that hook, new code could be loaded, which would not
trigger a panic, allowing for silent failure. Therefore, we must
panic on an attempt to forcefully unload an LSM.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 security/security.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/security.c b/security/security.c
index 8d8a227eeeea..204b9978ba24 100644
--- a/security/security.c
+++ b/security/security.c
@@ -89,6 +89,34 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+/*
+ * Check if one of our modules is being unloaded. This can happen if
+ * CONFIG_MODULE_FORCE_UNLOAD is enabled.
+ * If it is being unloaded, panic and let the user know what's going on
+ */
+static int security_module_cb(struct notifier_block *nb, unsigned long val,
+				void *data)
+{
+	struct module *mod = data;
+	struct lsm_info *info;
+
+	if (val != MODULE_STATE_GOING)
+		return NOTIFY_DONE;
+
+	mutex_lock(&lsm_info_lock);
+	hlist_for_each_entry(info, &lsm_info_head, list)
+		if (mod == info->owner)
+			panic("Security module %s is being unloaded forcefully\n",
+				info->name);
+	mutex_unlock(&lsm_info_lock);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block security_nb = {
+	.notifier_call	= security_module_cb,
+};
+
 /**
  * security_init - initializes the security framework
  *
@@ -99,6 +127,9 @@ int __init security_init(void)
 	pr_info("Security Framework initialized with%s writable hooks\n",
 		IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) ? "" : "out");
 
+	if (IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) &&
+		IS_ENABLED(CONFIG_MODULE_FORCE_UNLOAD))
+		register_module_notifier(&security_nb);
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
