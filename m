From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue, 18 Sep 2018 12:34:50 +0300
Subject: [PATCH v3 11/20] tpm: factor out tpm_startup function
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Message-ID: <20180918093459.19165-12-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tpm manual startup is used only from within tpm1 or tpm2
code, hence remove tpm_startup function from tpm-interface.c
and add two static functions implementations tpm1_startup
and tpm2_startup into to tpm1-cmd.c and tpm2-cmd.c respectively.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2-V3: Rebase

 drivers/char/tpm/tpm-interface.c | 41 ----------------------------------------
 drivers/char/tpm/tpm.h           |  1 -
 drivers/char/tpm/tpm1-cmd.c      | 37 +++++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c      | 34 +++++++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1ddf9d7e2069..3a2eef9e8665 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -403,47 +403,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 }
 EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
 
-#define TPM_ORD_STARTUP 153
-#define TPM_ST_CLEAR 1
-
-/**
- * tpm_startup - turn on the TPM
- * @chip: TPM chip to use
- *
- * Normally the firmware should start the TPM. This function is provided as a
- * workaround if this does not happen. A legal case for this could be for
- * example when a TPM emulator is used.
- *
- * Return: same as tpm_transmit_cmd()
- */
-int tpm_startup(struct tpm_chip *chip)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	dev_info(&chip->dev, "starting up the TPM manually\n");
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
-		if (rc < 0)
-			return rc;
-
-		tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	} else {
-		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
-		if (rc < 0)
-			return rc;
-
-		tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
-	}
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			      "attempting to start the TPM");
-
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
 int tpm_get_timeouts(struct tpm_chip *chip)
 {
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 862c9262e037..fa88102a0cab 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -540,7 +540,6 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
-int tpm_startup(struct tpm_chip *chip);
 int tpm_get_timeouts(struct tpm_chip *);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 5fdc44feea0f..f93776621e49 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -307,6 +307,40 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
+#define TPM_ORD_STARTUP 153
+#define TPM_ST_CLEAR 1
+
+/**
+ * tpm_startup - turn on the TPM
+ * @chip: TPM chip to use
+ *
+ * Normally the firmware should start the TPM. This function is provided as a
+ * workaround if this does not happen. A legal case for this could be for
+ * example when a TPM emulator is used.
+ *
+ * Return: same as tpm_transmit_cmd()
+ */
+static int tpm1_startup(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	dev_info(&chip->dev, "starting up the TPM manually\n");
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
+	if (rc < 0)
+		return rc;
+
+	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
+
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			      "attempting to start the TPM");
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 int tpm1_get_timeouts(struct tpm_chip *chip)
 {
 	cap_t cap;
@@ -316,7 +350,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
 			 sizeof(cap.timeout));
 	if (rc == TPM_ERR_INVALID_POSTINIT) {
-		if (tpm_startup(chip))
+		if (tpm1_startup(chip))
 			return rc;
 
 		rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
@@ -721,3 +755,4 @@ int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
 
 	return rc;
 }
+
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4ca0555f23c8..333631eab4c7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -943,6 +943,36 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	return rc;
 }
 
+/**
+ * tpm2_startup - turn on the TPM
+ * @chip: TPM chip to use
+ *
+ * Normally the firmware should start the TPM. This function is provided as a
+ * workaround if this does not happen. A legal case for this could be for
+ * example when a TPM emulator is used.
+ *
+ * Return: same as tpm_transmit_cmd()
+ */
+
+static int tpm2_startup(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	dev_info(&chip->dev, "starting up the TPM manually\n");
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
+	if (rc < 0)
+		return rc;
+
+	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
+			      "attempting to start the TPM");
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
 /**
  * tpm2_auto_startup - Perform the standard automatic TPM initialization
  *                     sequence
@@ -954,7 +984,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = tpm_get_timeouts(chip);
+	rc = tpm2_get_timeouts(chip);
 	if (rc)
 		goto out;
 
@@ -963,7 +993,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
-		rc = tpm_startup(chip);
+		rc = tpm2_startup(chip);
 		if (rc)
 			goto out;
 
-- 
2.14.4
