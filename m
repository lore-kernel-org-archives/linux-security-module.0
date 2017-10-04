From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed,  4 Oct 2017 06:29:22 -0400
Subject: [PATCH v3 3/5] tpm: reduce polling delay in tpm_tis
	wait_for_tpm_stat()
In-Reply-To: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Message-ID: <20171004102924.12355-4-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing wait_for_tpm_stat() polls for the chip status after
5msec sleep. As per TCG ddwg input, it is expected that tpm might
return status in few usec. So, reducing the delay in polling to
1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~10sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8da425e1783f..224842e06105 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,6 +31,8 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
+#define TPM_POLL_SLEEP	1
+
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 					bool check_cancel, bool *canceled)
 {
@@ -82,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT);
+			tpm_msleep(TPM_POLL_SLEEP);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
