From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Mon,  7 May 2018 21:09:41 +0530
Subject: [PATCH v2] tpm: check selftest status before retrying full selftest
Message-ID: <20180507153941.4952-1-nayna@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

As per the TCG Specification[1][2], RC_COMMAND_CODE indicates that the TPM
command is not implemented or not supported. When RC_COMMAND_CODE is
returned in response to the partial selftest, this is not the case. TPM 2.0
supports TPM2_GetTestResult[3], which can be used to check the selftest
status before sending the full selftest command.

This patch implements the tpm2_get_selftest_result function to check the
selftest status when partial selftest returns RC_COMMAND_CODE.

This change results in finishing of the selftest much earlier compared to
the existing case where full selftest is immediately sent to retry. The
Pi's dmesg shows: the TPM selftest completed at 1.243864 secs compared
with the previous timestamp of 1.939667 secs.

[1] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Structures, Section 6.6.3 and Section 4.18:

"RC_COMMAND_CODE indicates the response code that is returned if the TPM is
unmarshalling a value that it expects to be a TPM_CC and the input value is
not in the table."

[2] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Commands, Section 5.2:

"The TPM shall successfully unmarshal a TPM_CC and verify that the command
is implemented (TPM_RC_COMMAND_CODE)."

[3] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Commands, Section 10.4:

"This command(TPM2_GetTestResult) returns manufacturer-specific information
regarding the results of a self-test and an indication of the test status."

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
---

Changelog v2:
* changed the subject and updated patch description
* removed the logs

 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index af3bb87d3ea1..1de4240b52c4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -114,6 +114,7 @@ enum tpm2_return_codes {
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_NEEDS_TEST      = 0x0153,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
@@ -144,6 +145,7 @@ enum tpm2_command_codes {
 	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
 	TPM2_CC_GET_CAPABILITY	= 0x017A,
 	TPM2_CC_GET_RANDOM	= 0x017B,
+	TPM2_CC_GET_TEST_RESULT = 0x017C,
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_LAST		= 0x018F,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 96c77c8e7f40..4abba0ebe25b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -825,6 +825,50 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 /**
+ * tpm2_get_selftest_result() - get the status of self tests
+ *
+ * @chip: TPM chip to use
+ *
+ * Return: If error return rc, else return the result of the self tests.
+ * TPM_RC_NEEDS_TESTING: No self tests are done. Needs testing.
+ * TPM_RC_TESTING: Self tests are in progress.
+ * TPM_RC_SUCCESS: Self tests completed successfully.
+ * TPM_RC_FAILURE: Self tests completed failure.
+ *
+ * This function can be used to check the status of self tests on the TPM.
+ */
+static int tpm2_get_selftest_result(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+	int test_result;
+	uint16_t data_size;
+	int len;
+	const struct tpm_output_header *header;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
+	if (rc)
+		return rc;
+
+	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
+	if (len <  0)
+		return len;
+
+	header = (struct tpm_output_header *)buf.data;
+
+	rc = be32_to_cpu(header->return_code);
+	if (rc)
+		return rc;
+
+	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
+
+	test_result = be32_to_cpup((__be32 *)
+			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));
+
+	return test_result;
+}
+
+/**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
  * @chip: TPM chip to use
@@ -853,6 +897,10 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
+		/* Check the selftest status */
+		if (rc == TPM2_RC_COMMAND_CODE)
+			rc = tpm2_get_selftest_result(chip);
+
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
