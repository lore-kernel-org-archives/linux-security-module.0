From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Fri, 10 Mar 2017 13:45:54 -0500
Subject: [PATCH 2/2] tpm: add sleep only for retry in
	i2c_nuvoton_write_status()
In-Reply-To: <1489171554-6844-1-git-send-email-nayna@linux.vnet.ibm.com>
References: <1489171554-6844-1-git-send-email-nayna@linux.vnet.ibm.com>
Message-ID: <1489171554-6844-2-git-send-email-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Currently, there is an unnecessary 1 msec delay added in
i2c_nuvoton_write_status() for the successful case. This 
function is called multiple times during send() and recv(),
which implies adding multiple extra delays for every TPM
operation.

This patch calls usleep_range() only if retry is to be done.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: stable at vger.kernel.org (linux-4.8)
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 0c98c42..c642877 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -124,8 +124,9 @@ static s32 i2c_nuvoton_write_status(struct i2c_client *client, u8 data)
 	/* this causes the current command to be aborted */
 	for (i = 0, status = -1; i < TPM_I2C_RETRY_COUNT && status < 0; i++) {
 		status = i2c_nuvoton_write_buf(client, TPM_STS, 1, &data);
-		usleep_range(TPM_I2C_BUS_DELAY, TPM_I2C_BUS_DELAY
-			     + TPM_I2C_DELAY_RANGE);
+		if (status < 0)
+			usleep_range(TPM_I2C_BUS_DELAY, TPM_I2C_BUS_DELAY
+				     + TPM_I2C_DELAY_RANGE);
 	}
 	return status;
 }
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
