From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Jul 2018 14:06:03 -0400
Subject: [PATCH v6 8/8] ima: based on policy warn about loading firmware
	(pre-allocated buffer)
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
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
pre-allocated buffer.

Do devices using pre-allocated memory run the risk of the firmware being
accessible to the device prior to the completion of IMA's signature
verification any more than when using two buffers? (Refer to mailing list
discussion[1]).

Only on systems with an IOMMU can the access be prevented.  As long as
the signature verification completes prior to the DMA map is performed,
the device can not access the buffer.  This implies that the same buffer
can not be re-used.  Can we ensure the buffer has not been DMA mapped
before using the pre-allocated buffer?

[1] https://lkml.org/lkml/2018/7/10/56

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
Changelog v6:
- Change warning to comment.

Changelog v5:
- Instead of preventing loading firmware from a pre-allocate buffer,
emit a warning.

 security/integrity/ima/ima_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ef349a761609..b82500cd6fbd 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -429,6 +429,14 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	/*
+	 * READING_FIRMWARE_PREALLOC_BUFFER
+	 *
+	 * Do devices using pre-allocated memory run the risk of the
+	 * firmware being accessible to the device prior to the completion
+	 * of IMA's signature verification any more than when using two
+	 * buffers?
+	 */
 	return 0;
 }
 
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
