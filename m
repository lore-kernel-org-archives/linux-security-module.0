From: brdeoliv@redhat.com (Bruno E. O. Meneguele)
Date: Mon, 23 Oct 2017 14:43:01 -0200
Subject: [PATCH v2 1/2] module: export module signature enforcement status
In-Reply-To: <cover.1508776704.git.brdeoliv@redhat.com>
References: <cover.1508776704.git.brdeoliv@redhat.com>
Message-ID: <52c9c671996c472db9112affbbecfabfab09bad8.1508776704.git.brdeoliv@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A static variable sig_enforce is used as status var to indicate the real
value of CONFIG_MODULE_SIG_FORCE, once this one is set the var will hold
true, but if the CONFIG is not set the status var will hold whatever
value is present in the module.sig_enforce kernel cmdline param: true
when =1 and false when =0 or not present.

Considering this cmdline param take place over the CONFIG value when
it's not set, other places in the kernel could misbehave since they
would have only the CONFIG_MODULE_SIG_FORCE value to rely on. Exporting
this status var allows the kernel to rely in the effective value of
module signature enforcement, being it from CONFIG value or cmdline
param.

Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
---
 include/linux/module.h |  2 ++
 kernel/module.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index fe5aa3736707..ddfe17e3a85c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -806,4 +806,6 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+bool is_module_sig_enforced(void);
+
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module.c b/kernel/module.c
index de66ec825992..d1c194b057a2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -278,6 +278,16 @@ static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
 #endif /* !CONFIG_MODULE_SIG_FORCE */
 
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
