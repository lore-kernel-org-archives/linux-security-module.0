From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 07:06:17 -0400
Subject: [PATCH v5 3/5] tpm: Convert tpm_find_get_ops() to use
	tpm_default_chip()
In-Reply-To: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
Message-ID: <20180626110619.2362791-4-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
is passed in.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index f551061262c9..b01d34983766 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
  */
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 {
-	struct tpm_chip *res = NULL;
-	int chip_num = 0;
-	int chip_prev;
-
-	mutex_lock(&idr_lock);
+	int rc;
 
-	if (!chip) {
-		do {
-			chip_prev = chip_num;
-			chip = idr_get_next(&dev_nums_idr, &chip_num);
-			if (chip && !tpm_try_get_ops(chip)) {
-				res = chip;
-				break;
-			}
-		} while (chip_prev != chip_num);
-	} else {
+	if (chip) {
 		if (!tpm_try_get_ops(chip))
-			res = chip;
+			return chip;
+		return NULL;
 	}
 
-	mutex_unlock(&idr_lock);
-
-	return res;
+	chip = tpm_default_chip();
+	if (!chip)
+		return NULL;
+	rc = tpm_try_get_ops(chip);
+	/* release additional reference we got from tpm_default_chip() */
+	put_device(&chip->dev);
+	if (!rc)
+		return NULL;
+	return chip;
 }
 
 /**
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
