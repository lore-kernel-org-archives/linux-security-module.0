From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 07 Mar 2018 15:33:43 -0800
Subject: [RFC v2 5/5] tpm2-sessions: NOT FOR COMMITTING add sessions testing
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Message-ID: <1520465623.4894.17.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>From f69d2ec1bdddefa87c7130699c797cd5e24fcaf2 Mon Sep 17 00:00:00 2001
This runs through a preset sequence using sessions to demonstrate that
the session handling code functions.  It does both HMAC, encryption
and decryption by testing an encrypted sealing operation with
authority and proving that the same sealed data comes back again via
an HMAC and response encryption.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/Makefile             |   1 +
 drivers/char/tpm/tpm-chip.c           |   1 +
 drivers/char/tpm/tpm2-sessions-test.c | 177 ++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index b83737ccaa81..1ac7a4046630 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
 	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
          tpm2-space.o tpm-buf.o tpm2-sessions.o
+obj-m +=  tpm2-sessions-test.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..ca174ee1e670 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -118,6 +118,7 @@ struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
 
 	return res;
 }
+EXPORT_SYMBOL(tpm_chip_find_get);
 
 /**
  * tpm_dev_release() - free chip memory and the device number
diff --git a/drivers/char/tpm/tpm2-sessions-test.c b/drivers/char/tpm/tpm2-sessions-test.c
new file mode 100644
index 000000000000..bd599648c971
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions-test.c
@@ -0,0 +1,177 @@
+/* run a set of tests of the sessions code */
+#include "tpm.h"
+#include "tpm2-sessions.h"
+
+#include <linux/random.h>
+
+int tpm2_sessions_test(void)
+{
+	struct tpm2_auth *auth;
+	struct tpm_buf buf, b1;
+	struct tpm_buf t2b;
+	struct tpm_chip *chip;
+	int rc;
+	char payload[29];
+	char *password = "Passw0Rd";
+	const u8 *p;
+	u32 h;
+	u8 name[34];
+	u16 len;
+	int ret = -EINVAL;
+
+	chip = tpm_chip_find_get(NULL);
+	if (!chip)
+		return -ENODEV;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return -ENODEV;
+
+	get_random_bytes(payload, sizeof(payload));
+
+	/* precursor: get a session */
+	rc = tpm2_start_auth_session(chip, &auth);
+	dev_info(&chip->dev, "TPM: start auth session returned %d\n", rc);
+	if (rc)
+		goto out;
+
+	/* first test: get random bytes from TPM */
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT
+				    | TPM2_SA_CONTINUE_SESSION, NULL, 0);
+	tpm_buf_append_u16(&buf, 29);
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      0, 0, "get random");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	dev_info(&chip->dev, "TPM: check hmac response returned %d\n", rc);
+	tpm_buf_destroy(&buf);
+
+	/*
+	 * second test, seal random data protecting sensitive by
+	 * encryption and also doing response encryption (not
+	 * necessary) The encrypted payload has two components: an
+	 * authorization password which must be presented on useal and
+	 * the actual data (the random payload)
+	 */
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	tpm_buf_append_name(&buf, auth, chip->tpmkey, chip->tpmkeyname);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT
+				    | TPM2_SA_ENCRYPT
+				    | TPM2_SA_CONTINUE_SESSION, NULL, 0);
+	/* sensitive */
+	tpm_buf_init_2b(&t2b);
+	/* the authorization */
+	tpm_buf_append_u16(&t2b, strlen(password));
+	tpm_buf_append(&t2b, password, strlen(password));
+	/* the payload */
+	tpm_buf_append_u16(&t2b, sizeof(payload));
+	tpm_buf_append(&t2b, payload, sizeof(payload));
+	tpm_buf_append_2b(&buf, &t2b);
+	/* the public */
+	/* type */
+	tpm_buf_append_u16(&t2b, TPM2_ALG_KEYEDHASH);
+	/* name hash */
+	tpm_buf_append_u16(&t2b, TPM2_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&t2b, TPM2_OA_USER_WITH_AUTH | TPM2_OA_NO_DA);
+	/* auth policy (empty) */
+	tpm_buf_append_u16(&t2b, 0);
+	/* keyed hash parameters (we're null for a non-HMAC data blob) */
+	tpm_buf_append_u16(&t2b, TPM2_ALG_NULL);
+	/* unique */
+	tpm_buf_append_u16(&t2b, 0);
+	tpm_buf_append_2b(&buf, &t2b);
+	/* outside info (also empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (empty) */
+	tpm_buf_append_u32(&buf, 0);
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      4, 0, "sealing data");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+	dev_info(&chip->dev, "TPM: sealing response returned %d\n", rc);
+	if (rc)
+		goto out;
+
+	/*
+	 * now load the sealed object (we need the pub and priv parts
+	 * returned from prior command
+	 */
+	tpm_buf_init(&b1, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	/* parent */
+	tpm_buf_append_name(&b1, auth, chip->tpmkey, chip->tpmkeyname);
+	tpm_buf_append_hmac_session(&b1, auth, TPM2_SA_CONTINUE_SESSION,
+				    NULL, 0);
+	p = &buf.data[TPM_HEADER_SIZE+4];
+	/* private */
+	len = tpm_get_inc_u16(&p);
+	tpm_buf_append_u16(&b1, len);
+	tpm_buf_append(&b1, p, len);
+	p += len;
+	/* public */
+	len = tpm_get_inc_u16(&p);
+	tpm_buf_append_u16(&b1, len);
+	tpm_buf_append(&b1, p, len);
+	tpm_buf_fill_hmac_session(&b1, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, b1.data, PAGE_SIZE,
+			      4, 0, "loading seal");
+	if (rc)
+		goto out;
+	rc = tpm_buf_check_hmac_response(&b1, auth, rc);
+	dev_info(&chip->dev, "TPM: load response returned %d\n", rc);
+	if (rc)
+		goto out;
+	p = &b1.data[TPM_HEADER_SIZE];
+	h = tpm_get_inc_u32(&p);
+	dev_info(&chip->dev, "sealed data loaded at %08x\n", h);
+	/* skip over parameter size */
+	p += 4;
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(name)) {
+		dev_err(&chip->dev, "Wrong name size %d\n", len);
+		goto out;
+	}
+	memcpy(name, p, len);
+	tpm_buf_destroy(&b1);
+	tpm_buf_destroy(&buf);
+
+	/*
+	 * now unseal the data using the authority in a HMAC and
+	 * protecting the returned unseal by encryption
+	 */
+	tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	tpm_buf_append_name(&buf, auth, h, name);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+				    password, strlen(password));
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      4, 0, "unseal");
+	dev_info(&chip->dev, "unseal returns %d\n", rc);
+	if (rc)
+		goto out;
+	tpm_buf_check_hmac_response(&buf, auth, rc);
+	if (rc)
+		goto out;
+	p = &buf.data[TPM_HEADER_SIZE + 4];
+	len = tpm_get_inc_u16(&p);
+	if (len != sizeof(payload)) {
+		dev_err(&chip->dev, "wrong unseal payload size %d != %ld",
+			len, sizeof(payload));
+		goto out;
+	}
+	if (memcmp(payload, p, len) != 0) {
+		dev_err(&chip->dev, "Payload DID NOT compare correctly\n");
+		goto out;
+	}
+	dev_info(&chip->dev, "All tests passed\n");
+	ret = 0;
+
+ out:
+	tpm_put_ops(chip);
+
+	return ret;
+}
+
+module_init(tpm2_sessions_test);
+
+MODULE_LICENSE("GPL");
-- 
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
