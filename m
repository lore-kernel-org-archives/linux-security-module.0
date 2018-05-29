From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 29 May 2018 14:01:56 -0400
Subject: [PATCH v4 4/8] firmware: add call to LSM hook before firmware sysfs
	fallback
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>

Changelog v4:
- call new LSM security_kernel_arg hook

Changelog v2:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.
---
 drivers/base/firmware_loader/fallback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..2443bda81631 100644
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
+	ret = security_kernel_load_data(LOADING_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
