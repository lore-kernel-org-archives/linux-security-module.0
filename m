From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue, 18 Sep 2018 12:34:52 +0300
Subject: [PATCH v3 13/20] tpm: add tpm_auto_startup into tpm-interface
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Message-ID: <20180918093459.19165-14-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add wrapper tpm_auto_startup() to tpm-interface.c
instead of open coded decision between tpm 1.2 and tpm 2.0
in tpm-chip.c

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series

 drivers/char/tpm/tpm-chip.c      | 11 +++--------
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 46caadca916a..32db84683c40 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -451,14 +451,9 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
-	if (chip->ops->flags & TPM_OPS_AUTO_STARTUP) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
-			rc = tpm2_auto_startup(chip);
-		else
-			rc = tpm1_auto_startup(chip);
-		if (rc)
-			return rc;
-	}
+	rc = tpm_auto_startup(chip);
+	if (rc)
+		return rc;
 
 	tpm_sysfs_add_device(chip);
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 54e2cc592bd9..a8f8e0bcb434 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -520,6 +520,21 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 }
 EXPORT_SYMBOL_GPL(tpm_send);
 
+int tpm_auto_startup(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
+		return 0;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_auto_startup(chip);
+	else
+		rc = tpm1_auto_startup(chip);
+
+	return rc;
+}
+
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f0963a0a8acd..4ccffbb56864 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -541,6 +541,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_get_timeouts(struct tpm_chip *);
+int tpm_auto_startup(struct tpm_chip *chip);
 
 int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
 int tpm1_do_selftest(struct tpm_chip *chip);
-- 
2.14.4
