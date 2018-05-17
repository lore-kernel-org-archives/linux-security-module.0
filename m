From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:48 -0400
Subject: [PATCH v2 7/9] ima: based on policy require signed firmware (sysfs
	fallback)
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1526568530-9144-8-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7e1a127f18fe..29d1a929af5c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -451,7 +451,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;
 	}
+
+	if (read_id == READING_FIRMWARE_FALLBACK_SYSFS) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware sysfs fallback loading.\n");
+			return -EACCES;
+		}
+		return 0;
+	}
 	return 0;
+
 }
 
 static int read_idmap[READING_MAX_ID] = {
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
