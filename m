From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 10 Mar 2018 18:16:37 +0200
Subject: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

TCPA log are can be empty when the TPM is disabled. This commit changes the
behavior of tpm_read_log_acpi() to return successfully in this case.

Cc: stable at vger.kernel.org
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_eventlog_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_acpi.c b/drivers/char/tpm/tpm_eventlog_acpi.c
index 66f19e93c216..f5f66dcd6f30 100644
--- a/drivers/char/tpm/tpm_eventlog_acpi.c
+++ b/drivers/char/tpm/tpm_eventlog_acpi.c
@@ -84,8 +84,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		break;
 	}
 	if (!len) {
-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
-		return -EIO;
+		dev_info(&chip->dev, "TCPA log area is empty\n");
+		return 0;
 	}
 
 	/* malloc EventLog space */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
