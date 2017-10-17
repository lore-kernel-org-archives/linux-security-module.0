From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Tue, 17 Oct 2017 16:32:31 -0400
Subject: [PATCH v4 3/4] tpm: reduce tpm polling delay in tpm_tis_core
In-Reply-To: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
Message-ID: <20171017203232.2262-4-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing wait_for_tpm_stat() polls for the chip status after
5msec sleep. As per TCG ddwg input, it is expected that tpm might
return status in few usec. So, reducing the delay in polling to
1msec.
Similarly, get_burstcount() function sleeps for 5msec before
retrying for next query to burstcount in a loop. If it takes
lesser time for TPM to return, this 5msec delay is longer than
necessary.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 993328ae988c..8b55fdaa67f2 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,6 +31,12 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+/* This is a polling delay to check for status and burstcount.
+ * As per ddwg input, expectation is that status check and burstcount
+ * check should return within few usecs.
+ */
+#define TPM_POLL_SLEEP	1  /* msec */
+
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 					bool check_cancel, bool *canceled)
 {
@@ -82,7 +88,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_POLL_SLEEP);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -224,7 +230,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_POLL_SLEEP);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
