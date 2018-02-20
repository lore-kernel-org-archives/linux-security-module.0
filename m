From: sargun@sargun.me (Sargun Dhillon)
Date: Tue, 20 Feb 2018 02:14:38 +0000
Subject: [RFC PATCH v3 3/3] security: Add an example sample dynamic LSM
In-Reply-To: <cover.1519092378.git.sargun@sargun.me>
References: <cover.1519092378.git.sargun@sargun.me>
Message-ID: <f8a4c9c114da9f8472728d31e68244425fe060b1.1519092378.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This adds an example LSM that utilizes the features added by the
dynamically loadable LSMs patch. Once the module is unloaded, the
command is once again allowed. It prevents the user from running:
date --set="October 21 2015 16:29:00 PDT"

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 samples/Kconfig           |  6 ++++++
 samples/Makefile          |  2 +-
 samples/lsm/Makefile      |  4 ++++
 samples/lsm/lsm_example.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b9de05..022242c0b50b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -117,4 +117,10 @@ config SAMPLE_STATX
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
+config SAMPLE_DYNAMIC_LSM
+	tristate "Build LSM examples -- loadable modules only"
+	depends on SECURITY_DYNAMIC_HOOKS && m
+	help
+	  This builds an example dynamic LSM
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index db54e766ddb1..9d23835d6e6d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
-			   vfio-mdev/ statx/
+			   vfio-mdev/ statx/ lsm/
diff --git a/samples/lsm/Makefile b/samples/lsm/Makefile
new file mode 100644
index 000000000000..d4ccb940f18b
--- /dev/null
+++ b/samples/lsm/Makefile
@@ -0,0 +1,4 @@
+# builds the loadable LSM example kernel modules;
+# then to use one (as root):  insmod <module_name.ko>
+# and to unload: rmmod module_name
+obj-$(CONFIG_SAMPLE_DYNAMIC_LSM) += lsm_example.o
diff --git a/samples/lsm/lsm_example.c b/samples/lsm/lsm_example.c
new file mode 100644
index 000000000000..f29fddb7cae0
--- /dev/null
+++ b/samples/lsm/lsm_example.c
@@ -0,0 +1,33 @@
+/*
+ * This sample hooks into the "path_chroot"
+ *
+ * Once you run it, the following will not be allowed:
+ * date --set="October 21 2015 16:29:00 PDT"
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+
+static int settime_cb(const struct timespec *ts, const struct timezone *tz)
+{
+	/* We aren't allowed to travel to October 21 2015 16:29 PDT */
+	if (ts->tv_sec >= 1445470140 && ts->tv_sec < 1445470200)
+		return -EPERM;
+
+	return 0;
+}
+
+static struct security_hook_list sample_hooks[] = {
+	LSM_HOOK_INIT(settime, settime_cb),
+};
+
+static int __init lsm_init(void)
+{
+	security_add_dynamic_hooks(sample_hooks, ARRAY_SIZE(sample_hooks),
+				   "sample");
+	return 0;
+}
+
+module_init(lsm_init)
+MODULE_LICENSE("GPL");
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
