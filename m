From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Thu, 31 Aug 2017 19:18:56 +0200
Subject: [PATCH RESEND v2 1/3] tpm2-cmd: Trigger only missing self tests
In-Reply-To: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
References: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
Message-ID: <20170831171858.13252-2-Alexander.Steffen@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tpm2_do_selftest is only used during initialization of the TPM to ensure
that the device functions correctly. Therefore, it is sufficient to request
only missing self tests (parameter full_test=0), not a reexecution of all
self tests, as was done before. This allows for a faster execution of this
command.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e1a41b7..8e940a5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -865,7 +865,7 @@ static int tpm2_start_selftest(struct tpm_chip *chip, bool full)
 }
 
 /**
- * tpm2_do_selftest() - run a full self test
+ * tpm2_do_selftest() - ensure that all self tests have passed
  *
  * @chip: TPM chip to use
  *
@@ -886,7 +886,7 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
-	rc = tpm2_start_selftest(chip, true);
+	rc = tpm2_start_selftest(chip, false);
 	if (rc)
 		return rc;
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
