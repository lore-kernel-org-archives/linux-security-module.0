From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 13:23:28 -0400
Subject: [PATCH v6 2/5] tpm: Implement tpm_default_chip() to find a TPM chip
In-Reply-To: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
Message-ID: <20180626172331.2505541-3-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Implement tpm_default_chip() to find the first TPM chip and return it to
the caller while increasing the reference count on its device. This
function can be used by other subsystems, such as IMA, to find the system's
default TPM chip and use it for all subsequent TPM operations.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
 include/linux/tpm.h         |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 242b716aed5e..f551061262c9 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -80,6 +80,33 @@ void tpm_put_ops(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
+/**
+ * tpm_default_chip() - find a TPM chip and get a reference to it
+ */
+struct tpm_chip *tpm_default_chip(void)
+{
+	struct tpm_chip *chip, *res = NULL;
+	int chip_num = 0;
+	int chip_prev;
+
+	mutex_lock(&idr_lock);
+
+	do {
+		chip_prev = chip_num;
+		chip = idr_get_next(&dev_nums_idr, &chip_num);
+		if (chip) {
+			get_device(&chip->dev);
+			res = chip;
+			break;
+		}
+	} while (chip_prev != chip_num);
+
+	mutex_unlock(&idr_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(tpm_default_chip);
+
 /**
  * tpm_find_get_ops() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 06639fb6ab85..e0e51c49a0e6 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -61,6 +61,7 @@ extern int tpm_seal_trusted(struct tpm_chip *chip,
 extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
+extern struct tpm_chip *tpm_default_chip(void);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -96,5 +97,9 @@ static inline int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	return -ENODEV;
 }
+static inline struct tpm_chip *tpm_default_chip(void)
+{
+	return NULL;
+}
 #endif
 #endif
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
