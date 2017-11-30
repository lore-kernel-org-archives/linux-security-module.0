From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:06 +0100
Subject: [RFC][PATCH v2 5/9] ima: measure/appraise/audit inherited file
	descriptors
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-6-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA measures accessed files when the open() system call is executed. File
descriptors inherited during fork() can be used by another application, if
the child process invoked execve(). If credentials changed, it is possible
that opened files need to be measured/appraised/audited.

This patch introduces the function flush_unauthorized_files(), which
calls process_measurement() for each inherited file descriptors, and passes
to that function the new credentials of the process. If the appraisal
status is not valid, IMA prevents the process from using the inherited file
descriptor.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 61 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fb144177a783..a12f8a148e5e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
+#include <linux/fdtable.h>
 
 #include "ima.h"
 
@@ -279,6 +280,57 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	return 0;
 }
 
+static int match_file(const void *p, struct file *file, unsigned int fd)
+{
+	*((struct file **) p) = file;
+	return fd + 1;
+}
+
+static int file_mode_to_mask(struct file *file)
+{
+	int mask = 0;
+
+	if (file->f_mode & FMODE_READ)
+		mask |= MAY_READ;
+	if (file->f_mode & FMODE_WRITE)
+		mask |= MAY_WRITE;
+	if (file->f_mode & FMODE_EXEC)
+		mask |= MAY_EXEC;
+
+	return mask;
+}
+
+/* derived from security/selinux/hooks.c */
+static inline void flush_unauthorized_files(const struct cred *cred,
+					    struct files_struct *files)
+{
+	struct file *devnull = NULL;
+	struct file *file;
+	int result, mask;
+
+	unsigned int n;
+
+	/* Revalidate access to inherited open files. */
+	n = iterate_fd(files, 0, match_file, &file);
+	if (!n) /* none found? */
+		return;
+
+	devnull = dentry_open(&ima_null, O_RDWR, cred);
+	if (IS_ERR(devnull))
+		devnull = NULL;
+	/* replace all the matching ones with this */
+	do {
+		mask = file_mode_to_mask(file);
+		result = process_measurement(file, cred, NULL, 0,
+				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
+				   MAY_APPEND), FILE_CHECK, 0);
+		if (result < 0)
+			replace_fd(n - 1, devnull, 0);
+	} while ((n = iterate_fd(files, n, match_file, &file)) != 0);
+	if (devnull)
+		fput(devnull);
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -319,8 +371,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 				  MAY_EXEC, BPRM_CHECK, 0);
 	if (ret)
 		return ret;
-	return process_measurement(bprm->file, bprm->cred, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK, 0);
+	ret = process_measurement(bprm->file, bprm->cred, NULL, 0,
+				  MAY_EXEC, CREDS_CHECK, 0);
+	if (ret)
+		return ret;
+
+	flush_unauthorized_files(bprm->cred, current->files);
+	return 0;
 }
 
 /**
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
