From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 24 May 2018 07:09:33 -0400
Subject: [PATCH v3 4/7] firmware: add call to LSM hook before firmware sysfs
	fallback
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527160176-29269-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>

Changelog:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.
---
 drivers/base/firmware_loader/fallback.c | 7 +++++++
 include/linux/fs.h                      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..ae102efcc9f0 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
+	int ret;
+
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
@@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
+	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
+	ret = security_kernel_read_data(NULL, READING_FIRMWARE_FALLBACK_SYSFS);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..6e31d9207435 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2810,6 +2810,7 @@ extern int do_pipe_flags(int *, int);
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
+	id(FIRMWARE_FALLBACK_SYSFS, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
