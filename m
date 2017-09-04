From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Mon, 4 Sep 2017 19:36:42 +0200
Subject: [PATCH v2] tpm-dev-common: Reject too short writes
Message-ID: <20170904173642.5988-1-Alexander.Steffen@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tpm_transmit() does not offer an explicit interface to indicate the number
of valid bytes in the communication buffer. Instead, it relies on the
commandSize field in the TPM header that is encoded within the buffer.
Therefore, ensure that a) enough data has been written to the buffer, so
that the commandSize field is present and b) the commandSize field does not
announce more data than has been written to the buffer.

This should have been fixed with CVE-2011-1161 long ago, but apparently
a correct version of that patch never made it into the kernel.

Cc: stable at vger.kernel.org
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
v2:
- Moved all changes to tpm_common_write in a single patch.

 drivers/char/tpm/tpm-dev-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 610638a..ac25574 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -99,7 +99,8 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	if (atomic_read(&priv->data_pending) != 0)
 		return -EBUSY;
 
-	if (in_size > TPM_BUFSIZE)
+	if (in_size > sizeof(priv->data_buffer) || in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (buf + 2))))
 		return -E2BIG;
 
 	mutex_lock(&priv->buffer_mutex);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
