From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue, 18 Sep 2018 12:34:59 +0300
Subject: [PATCH v3 20/20] tpm1: reimplement tpm1_continue_selftest() using
	tpm_buf
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Message-ID: <20180918093459.19165-21-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Reimplement tpm1_continue_selftest() using tpm_buf structure.
This is the last command using the old tpm_cmd_t structure
and now the structure can be removed.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series
 drivers/char/tpm/tpm.h      |  9 ---------
 drivers/char/tpm/tpm1-cmd.c | 16 ++++++++--------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index dbbfb7118c31..5d018f61b812 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -377,15 +377,6 @@ enum tpm_sub_capabilities {
 	TPM_CAP_PROP_TIS_DURATION = 0x120,
 };
 
-typedef union {
-	struct	tpm_input_header in;
-	struct	tpm_output_header out;
-} tpm_cmd_header;
-
-struct tpm_cmd_t {
-	tpm_cmd_header	header;
-} __packed;
-
 
 /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
  * bytes, but 128 is still a relatively large number of random bytes and
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index c4a0bacb1378..f30d2801c2e0 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -604,11 +604,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 #define TPM_ORD_CONTINUE_SELFTEST 83
 #define CONTINUE_SELFTEST_RESULT_SIZE 10
-static const struct tpm_input_header continue_selftest_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(10),
-	.ordinal = cpu_to_be32(TPM_ORD_CONTINUE_SELFTEST),
-};
 
 /**
  * tpm_continue_selftest -- run TPM's selftest
@@ -619,12 +614,17 @@ static const struct tpm_input_header continue_selftest_header = {
  */
 static int tpm1_continue_selftest(struct tpm_chip *chip)
 {
+	struct tpm_buf buf;
 	int rc;
-	struct tpm_cmd_t cmd;
 
-	cmd.header.in = continue_selftest_header;
-	rc = tpm_transmit_cmd(chip, NULL, &cmd, CONTINUE_SELFTEST_RESULT_SIZE,
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
+	if (rc)
+		return rc;
+	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
 			      0, 0, "continue selftest");
+
+	tpm_buf_destroy(&buf);
+
 	return rc;
 }
 
-- 
2.14.4
