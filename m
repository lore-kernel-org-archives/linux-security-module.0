From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Thu, 31 Aug 2017 19:18:57 +0200
Subject: [PATCH RESEND v2 2/3] tpm2-cmd: Use dynamic delay to wait for self
	test result
In-Reply-To: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
References: <20170831171858.13252-1-Alexander.Steffen@infineon.com>
Message-ID: <20170831171858.13252-3-Alexander.Steffen@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order to avoid delaying the code longer than necessary while still
giving the TPM enough time to execute the self tests asynchronously, start
with a small delay between two polls and increase it each round.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 8e940a5..2178437 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -877,20 +877,17 @@ static int tpm2_start_selftest(struct tpm_chip *chip, bool full)
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
 	int rc;
-	unsigned int loops;
-	unsigned int delay_msec = 100;
-	unsigned long duration;
-	int i;
-
-	duration = tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST);
+	unsigned int delay_msec = 20;
+	long duration;
 
-	loops = jiffies_to_msecs(duration) / delay_msec;
+	duration = jiffies_to_msecs(
+		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
 
 	rc = tpm2_start_selftest(chip, false);
 	if (rc)
 		return rc;
 
-	for (i = 0; i < loops; i++) {
+	while (duration > 0) {
 		/* Attempt to read a PCR value */
 		rc = tpm2_pcr_read(chip, 0, NULL);
 		if (rc < 0)
@@ -900,6 +897,10 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 			break;
 
 		tpm_msleep(delay_msec);
+		duration -= delay_msec;
+
+		/* wait longer the next round */
+		delay_msec *= 2;
 	}
 
 	return rc;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
