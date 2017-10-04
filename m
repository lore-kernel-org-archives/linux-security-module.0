From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed,  4 Oct 2017 06:29:23 -0400
Subject: [PATCH v3 4/5] tpm: reduce tpm_msleep() time in get_burstcount()
In-Reply-To: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
Message-ID: <20171004102924.12355-5-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Currently, get_burstcount() function sleeps for 5msec in a loop
before retrying for next query to burstcount. However, if it takes
lesser time for TPM to return, this 5msec delay is longer
than necessary.

This patch replaces the tpm_msleep time from 5msec to 1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10sec to ~9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 224842e06105..826a0b9c9201 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -226,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
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
