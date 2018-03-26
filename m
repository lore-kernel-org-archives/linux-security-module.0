From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 26 Mar 2018 15:14:04 +0300
Subject: [PATCH v4 2/4] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_probe() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7665661d9230..7bffd0fd1dca 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -844,30 +844,35 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 
 /**
  * tpm2_probe() - probe TPM 2.0
- * @chip: TPM chip to use
+ * @chip: a TPM chip to probe
  *
- * Return: < 0 error and 0 on success.
+ * Return: 0 on success,
+ *         -errno otherwise
  *
- * Send idempotent TPM 2.0 command and see whether TPM 2.0 chip replied based on
- * the reply tag.
+ * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
+ * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set if
+ * this is the case.
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
-	struct tpm2_cmd cmd;
+	struct tpm_output_header *out;
+	struct tpm_buf buf;
 	int rc;
 
-	cmd.header.in = tpm2_get_tpm_pt_header;
-	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
-	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
-	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
-
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
-	if (rc <  0)
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
 		return rc;
-
-	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
-		chip->flags |= TPM_CHIP_FLAG_TPM2;
-
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	/* We ignore TPM return codes on purpose. */
+	if (rc >=  0) {
+		out = (struct tpm_output_header *)buf.data;
+		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
+			chip->flags |= TPM_CHIP_FLAG_TPM2;
+	}
+	tpm_buf_destroy(&buf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
