From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 23 Oct 2017 13:31:55 +0200
Subject: [PATCH] tpm: remove a misleading error message from tpm_get_timeouts()
Message-ID: <20171023113155.12921-1-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tpm_transmit_cmd() takes care of printing a TPM error whereas the print
statement in tpm_get_timeouts() either duplicates its behavior or prints
a system error code still saying that it is a TPM error code.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ebe0a1d36d8c..d8e2e5bca903 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -664,13 +664,6 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 				sizeof(cap.timeout));
 	}
 
-	if (rc) {
-		dev_err(&chip->dev,
-			"A TPM error (%zd) occurred attempting to determine the timeouts\n",
-			rc);
-		return rc;
-	}
-
 	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
 	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
 	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
