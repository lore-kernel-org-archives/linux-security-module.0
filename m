From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed, 28 Feb 2018 14:18:28 -0500
Subject: [RFC PATCH 3/3] tpm: tpm_msleep() with finer granularity improves
	performance
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
Message-ID: <20180228191828.20056-3-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When 'commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
in TPM 1.2/2.0 generic drivers")' was upstreamed, it replaced the
msleep() calls with usleep_range(), but did not change the
granularity of the calls. They're still defined in terms of msec.
Test results show that refining the granularity further improves
the performance. We're posting this patch as an RFC to show that there
needs to be another function which allows finer granularity.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10.7sec to ~6.9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7e797377e1eb..8cad6bfc5f46 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -522,8 +522,7 @@ int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
-		     delay_msec * 1000);
+	usleep_range((delay_msec * 1000) / 10, (delay_msec * 1000) / 2);
 };
 
 struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
