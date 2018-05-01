From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  1 May 2018 09:48:21 -0400
Subject: [PATCH 4/6] ima: coordinate with signed regulatory.db
In-Reply-To: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1525182503-13849-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Based on IMA policy, measure and appraise regulatory.db firmware as
usual, but on signature verification failure rely on regdb signature.

For systems wanting IMA-appraisal enforcement on all firmware, including
regdb, do not enable CONFIG_CFG80211_REQUIRE_SIGNED_REGDB.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 security/integrity/ima/ima_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8759280dccf6..71b5a51c6709 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -468,6 +468,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_REGULATORY_DB] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
@@ -515,8 +516,12 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func, 0);
+	ret = process_measurement(file, current_cred(), secid, buf, size,
+				  MAY_READ, func, 0);
+
+	/* Co-ordination with signed regdb */
+	if (ret < -EACCES && read_id == READING_FIRMWARE_REGULATORY_DB)
+		return 0;
 }
 
 static int __init init_ima(void)
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
