From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed,  6 Sep 2017 08:56:39 -0400
Subject: [PATCH v2 4/4] tpm: use tpm_msleep() value as max delay
In-Reply-To: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
References: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
Message-ID: <20170906125643.5070-5-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Currently, tpm_msleep() uses delay_msec as the minimum value in
usleep_range. However, that is the maximum time we want to wait.
The function is modified to use the delay_msec as the maximum
value, not the minimum value.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~9sec to ~8sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index eb2f8818eded..ff5a8b7b80b9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -533,8 +533,8 @@ int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range(delay_msec * 1000,
-		     (delay_msec * 1000) + TPM_TIMEOUT_RANGE_US);
+	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
+		     delay_msec * 1000);
 };
 
 struct tpm_chip *tpm_chip_find_get(int chip_num);
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
