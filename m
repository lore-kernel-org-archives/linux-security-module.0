From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Sep 2017 00:58:12 -0400
Subject: [PATCH 1/3] vfs: constify path argument to kernel_read_file_from_path
In-Reply-To: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1505451494-30228-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch constifies the path argument to kernel_read_file_from_path.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/exec.c                  | 2 +-
 include/linux/fs.h         | 2 +-
 sound/oss/sound_firmware.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 62175cbcc801..54a4847649cc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -974,7 +974,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 			       loff_t max_size, enum kernel_read_file_id id)
 {
 	struct file *file;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fdec9b763b54..d783cc8340de 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2775,7 +2775,7 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
-extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
+extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
diff --git a/sound/oss/sound_firmware.h b/sound/oss/sound_firmware.h
index da4c67e005ed..2be465277ba0 100644
--- a/sound/oss/sound_firmware.h
+++ b/sound/oss/sound_firmware.h
@@ -21,7 +21,7 @@ static inline int mod_firmware_load(const char *fn, char **fp)
 	loff_t size;
 	int err;
 
-	err = kernel_read_file_from_path((char *)fn, (void **)fp, &size,
+	err = kernel_read_file_from_path(fn, (void **)fp, &size,
 					 131072, READING_FIRMWARE);
 	if (err < 0)
 		return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
