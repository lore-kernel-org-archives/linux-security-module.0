From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed, 28 Feb 2018 14:18:27 -0500
Subject: [PATCH 2/3] tpm: reduce poll sleep time between send() and recv() in
	tpm_transmit()
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
Message-ID: <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In tpm_transmit, after send(), the code checks for status in a loop
with polling every 5msec. It is expected that the tpm might return
earlier than 5msec, so it might be adding to unnecessary delay.

This patch reduces the polling sleep time from 5msec to 1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~10.7sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 76df4fbcf089..2d22f981f0c9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -470,7 +470,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
