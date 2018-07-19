From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 19 Jul 2018 08:52:32 -0700
Subject: [PATCH] tpm: add support for partial reads
Message-ID: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Currently to read a response from the TPM device an application needs
provide "big enough" buffer for the whole response and read it in one go.
The application doesn't know how big the response it beforehand so it
always needs to maintain a 4K buffer and read the max (4K).
In case if the user of the TSS library doesn't provide big enough buffer
the TCTI spec says that the library should set the required size and return
TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
allocate a bigger buffer and call receive again.
To make it possible in the TSS library this requires being able to do
partial reads from the driver.
The library would read the header first to get the actual size of the
response from the header and then read the rest of the response.
This patch adds support for partial reads.

The usecase is implemented in this TSS commit:
https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 3f2089f75c30..f5b614984dbc 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -99,20 +99,34 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	ssize_t ret_size = 0;
 	int rc;
 
-	del_singleshot_timer_sync(&priv->user_read_timer);
-	flush_work(&priv->timeout_work);
 	mutex_lock(&priv->buffer_mutex);
 
 	if (priv->data_pending) {
-		ret_size = min_t(ssize_t, size, priv->data_pending);
-		if (ret_size > 0) {
-			rc = copy_to_user(buf, priv->data_buffer, ret_size);
-			memset(priv->data_buffer, 0, priv->data_pending);
-			if (rc)
-				ret_size = -EFAULT;
+		ret_size = min_t(ssize_t, size + *off, priv->data_pending);
+		if (ret_size <= 0) {
+			ret_size = 0;
+			priv->data_pending = 0;
+			*off = 0;
+			goto out;
 		}
 
-		priv->data_pending = 0;
+		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
+		if (rc) {
+			memset(priv->data_buffer, 0, priv->data_pending);
+			ret_size = -EFAULT;
+			priv->data_pending = 0;
+			*off = 0;
+		} else {
+			memset(priv->data_buffer + *off, 0, ret_size);
+			priv->data_pending -= ret_size;
+			*off += ret_size;
+		}
+	}
+out:
+	if (!priv->data_pending) {
+		del_singleshot_timer_sync(&priv->user_read_timer);
+		flush_work(&priv->timeout_work);
+		*off = 0;
 	}
 
 	mutex_unlock(&priv->buffer_mutex);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
