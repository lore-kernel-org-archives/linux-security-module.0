From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed,  5 Apr 2017 14:10:47 +0300
Subject: [PATCH] tpm_crb: remove a cruft constant
Message-ID: <20170405111047.15630-1-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Remove a useless constant that slipped through me when I did the code
review. This commit fixes the issue.

Cc: Jiandi An <anjiandi@codeaurora.org>
Fixes: 69c558de63c7 ("tpm/tpm_crb: Enable TPM CRB interface for ARM64")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_crb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 72b03c3..b917b9d 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -572,8 +572,7 @@ static int crb_acpi_add(struct acpi_device *device)
 				ACPI_TPM2_COMMAND_BUFFER_WITH_SMC);
 			return -EINVAL;
 		}
-		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf,
-				       ACPI_TPM2_START_METHOD_PARAMETER_OFFSET);
+		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
 		priv->smc_func_id = crb_smc->smc_func_id;
 		priv->flags |= CRB_FL_CRB_SMC_START;
 	}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
