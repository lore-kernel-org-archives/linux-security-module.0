From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 29 May 2018 14:01:59 -0400
Subject: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
	(pre-allocated buffer)
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Some systems are memory constrained but they need to load very large
firmwares.  The firmware subsystem allows drivers to request this
firmware be loaded from the filesystem, but this requires that the
entire firmware be loaded into kernel memory first before it's provided
to the driver.  This can lead to a situation where we map the firmware
twice, once to load the firmware into kernel memory and once to copy the
firmware into the final resting place.

To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
into a pre-allocated buffer") introduced request_firmware_into_buf() API
that allows drivers to request firmware be loaded directly into a
pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
allocate this buffer.  According to Documentation/DMA-API.txt,

     Consistent memory is memory for which a write by either the
     device or the processor can immediately be read by the processor
     or device without having to worry about caching effects.  (You
     may however need to make sure to flush the processor's write
     buffers before telling devices to read that memory.)

Devices using pre-allocated DMA memory run the risk of the firmware
being accessible by the device prior to the kernel's firmware signature
verification has completed.

Loading firmware already calls the security_kernel_read_file LSM hook.
With an IMA policy requiring signed firmware, this patch prevents
loading firmware into a pre-allocated buffer.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 security/integrity/ima/ima_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4a87f78098c8..3dae605a1604 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -419,6 +419,15 @@ void ima_post_path_mknod(struct dentry *dentry)
 		iint->flags |= IMA_NEW_FILE;
 }
 
+static int read_idmap[READING_MAX_ID] = {
+	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
+	[READING_MODULE] = MODULE_CHECK,
+	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
+	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
+	[READING_POLICY] = POLICY_CHECK
+};
+
 /**
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
@@ -442,18 +451,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;	/* We rely on module signature checking */
 	}
+
+	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
+			return -EACCES;
+		}
+	}
 	return 0;
 }
 
-static int read_idmap[READING_MAX_ID] = {
-	[READING_FIRMWARE] = FIRMWARE_CHECK,
-	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
-	[READING_MODULE] = MODULE_CHECK,
-	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
-	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
-};
-
 /**
  * ima_post_read_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
