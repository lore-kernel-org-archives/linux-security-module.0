From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 09 Jun 2017 09:22:08 -0400
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
Message-ID: <1497014528.21594.190.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch defines a new, minor LSM named "shebang", that restricts
python such that scripts are allowed to execute, while the interactive
prompt/interpreter is not available.  When used in conjunction with an
IMA appraise execute policy requiring files signatures, only signed
python scripts would be allowed to execute.  (A separate method for
identifying "imported" code would need to be defined in order to verify
their file signatures.)

A blank/comma delimited list of interpreter pathnames is converted to
a list of inodes, which is used to detect and prevent the interactive
prompt/interpreter's usage.

Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/Kconfig                  |   1 +
 security/Makefile                 |   2 +
 security/shebang/Kconfig          |  16 ++++++
 security/shebang/Makefile         |   3 +
 security/shebang/shebang_python.c | 117 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 security/shebang/Kconfig
 create mode 100644 security/shebang/Makefile
 create mode 100644 security/shebang/shebang_python.c

diff --git a/security/Kconfig b/security/Kconfig
index bdcbb92927ab..4453299c430e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -195,6 +195,7 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/loadpin/Kconfig
 source security/yama/Kconfig
+source security/shebang/Kconfig
 
 source security/integrity/Kconfig
 
diff --git a/security/Makefile b/security/Makefile
index f2d71cdb8e19..00a8dbebb07f 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -9,6 +9,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
+subdir-$(CONFIG_SECURITY_SHEBANG)	+= shebang
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -24,6 +25,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
+obj-$(CONFIG_SECURITY_SHEBANG)		+= shebang/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/shebang/Kconfig b/security/shebang/Kconfig
new file mode 100644
index 000000000000..1b977b266413
--- /dev/null
+++ b/security/shebang/Kconfig
@@ -0,0 +1,16 @@
+config SECURITY_SHEBANG
+	bool "Restrict python interactive prompt/interpreter"
+	depends on SECURITY
+	help
+	  Restrict python so that python scripts are allowed to execute,
+	  while the interactive prompt/interpreter is not available.  When
+	  used in conjunction with an IMA appraise policy requiring files
+	  signatures, only signed scripts will be executed.
+
+config SECURITY_SHEBANG_PATHNAME
+	string "interactive prompt/interpreter pathname"
+	depends on SECURITY_SHEBANG
+	default "/usr/bin/python2, /usr/bin/python3"
+	help
+	  This option defines a blank/comma delimited list of
+	  interpreter pathnames.
diff --git a/security/shebang/Makefile b/security/shebang/Makefile
new file mode 100644
index 000000000000..f1b83dcb96d1
--- /dev/null
+++ b/security/shebang/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SECURITY_SHEBANG) += shebang.o
+
+shebang-y := shebang_python.o
diff --git a/security/shebang/shebang_python.c b/security/shebang/shebang_python.c
new file mode 100644
index 000000000000..6f98cce38ea4
--- /dev/null
+++ b/security/shebang/shebang_python.c
@@ -0,0 +1,117 @@
+/*
+ * shebang security module
+ *
+ * Copyright (C) 2017 IBM Corporation
+ *
+ * Authors:
+ * Mimi Zohar <zohar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "shebang: " fmt
+
+#include <linux/module.h>
+#include <linux/binfmts.h>
+#include <linux/namei.h>
+#include <linux/lsm_hooks.h>
+
+static int initialized;
+
+#define MAX_INODES 6 
+static char *pathnames;
+static int pathnames_len;
+static unsigned long inode_list[MAX_INODES];
+static int total;
+
+/*
+ * Get the inodes associated with the list of pathnames, as specified
+ * on CONFIG_SECURITY_SHEBANG_PATHNAME.
+ */
+static void init_inode_list(void)
+{
+	char *tmp_pathnames = pathnames;
+	char *p;
+	struct path path;
+	int i;
+	int ret;
+
+	total = 0;
+	while ((p = strsep(&tmp_pathnames, " ,")) != NULL) {
+		if ((*p == '\0') || (*p == ' ') || (*p == ','))
+			continue;
+
+		if (total > MAX_INODES - 1) {
+			pr_info("too many interpreters\n");
+			break;
+		}
+
+		ret = kern_path(p, LOOKUP_FOLLOW, &path);
+		if (!ret) {
+			struct inode *inode = d_backing_inode(path.dentry);
+
+			inode_list[total] = inode->i_ino;
+			pr_info("pathname:%s i_ino: %lu\n",
+				p, inode_list[total]);
+			initialized = 1;
+			total++;
+		}
+	}
+
+	/* cleanup in case we need to lookup the inodes again. */
+	tmp_pathnames = pathnames;
+	for (i = 0; i < pathnames_len; i++)
+		if (tmp_pathnames[i] == '\0')
+			tmp_pathnames[i] = ' ';
+}
+
+/**
+ * shebang_bprm_check - prevent python interactive prompt/interpreter
+ * @bprm: contains the linux_binprm structure
+ *
+ * Restrict python such that scripts are allowed to execute, while the
+ * interactive prompt/interpreter is not available.
+ */
+static int shebang_bprm_check(struct linux_binprm *bprm)
+{
+	struct inode *inode = file_inode(bprm->file);
+	int i = 0;
+
+	if (bprm->interp != bprm->filename)	/* allow scripts */
+		return 0;
+
+	if (!initialized)
+		init_inode_list();
+
+	while (i < total) {
+		if (inode_list[i++] != inode->i_ino)
+			continue;
+
+		pr_info("prevent executing %s (ino=%lu)\n",
+			bprm->interp, inode->i_ino);
+		return -EPERM;
+	}
+	return 0;
+}
+
+static struct security_hook_list shebang_hooks[] = {
+	LSM_HOOK_INIT(bprm_check_security, shebang_bprm_check)
+};
+
+static int __init init_shebang(void)
+{
+	pathnames = kstrdup(CONFIG_SECURITY_SHEBANG_PATHNAME, GFP_KERNEL);
+	if (!pathnames)
+		return -ENOMEM;
+	pathnames_len = strlen(pathnames);
+
+	security_add_hooks(shebang_hooks, ARRAY_SIZE(shebang_hooks), "shebang");
+	pr_info("initialized\n");
+	return 0;
+}
+
+late_initcall(init_shebang);
+MODULE_LICENSE("GPL");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
