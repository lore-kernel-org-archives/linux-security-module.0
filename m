From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 24 May 2018 07:09:36 -0400
Subject: [RFC PATCH v3 7/7] ima: based on policy prevent loading firmware
	(pre-allocated buffer)
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527160176-29269-8-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Question: can the device access the pre-allocated buffer at any time?
(Still waiting to hear from Qualcomm...)

By allowing devices to request firmware be loaded directly into a
pre-allocated buffer, will this allow the device access to the firmware
before the kernel has verified the firmware signature?

Is it dependent on the type of buffer allocated (eg. DMA)?  For example,
qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent().

With an IMA policy requiring signed firmware, this patch would prevent
loading firmware into a pre-allocated buffer.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 security/integrity/ima/ima_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dd1f263f950a..d114b7ad2c86 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -457,6 +457,12 @@ int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case READING_FIRMWARE_PREALLOC_BUFFER:
+		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
+			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
+			return -EACCES;
+		}
 	default:
 		break;
 	}
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
