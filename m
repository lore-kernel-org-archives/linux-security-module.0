From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 28 Feb 2018 21:58:16 +0200
Subject: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
In-Reply-To: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order to make struct tpm_buf the first class object for constructing TPM
commands, migrate tpm2_probe() to use it.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5f92141b1e16..36f6b0ac412b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -856,19 +856,22 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
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
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	if (rc)
+		return rc;
+	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(&buf, 1);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
+	tpm_buf_destroy(&buf);
 	if (rc <  0)
 		return rc;
-
-	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
+	out = (struct tpm_output_header *)buf.data;
+	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
 
 	return 0;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
