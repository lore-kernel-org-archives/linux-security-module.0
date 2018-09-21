From: tomas.winkler@intel.com (Tomas Winkler)
Date: Fri, 21 Sep 2018 16:58:17 +0300
Subject: [PATCH v4 18/21] tmp1: rename tpm1_pcr_read_dev to tpm1_pcr_read().
In-Reply-To: <20180921135820.20549-1-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
Message-ID: <20180921135820.20549-19-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rename tpm1_pcr_read_dev to tpm1_pcr_read() to match
the counterpart tpm2_pcr_read().


Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V4: New in the series.

 drivers/char/tpm/tpm-interface.c | 2 +-
 drivers/char/tpm/tpm-sysfs.c     | 2 +-
 drivers/char/tpm/tpm.h           | 2 +-
 drivers/char/tpm/tpm1-cmd.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c84d8cf84f7d..a6d9d148a3bc 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -465,7 +465,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_pcr_read(chip, pcr_idx, res_buf);
 	else
-		rc = tpm1_pcr_read_dev(chip, pcr_idx, res_buf);
+		rc = tpm1_pcr_read(chip, pcr_idx, res_buf);
 
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 861acafd8f29..96fc7433c57d 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -114,7 +114,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 
 	num_pcrs = be32_to_cpu(cap.num_pcrs);
 	for (i = 0; i < num_pcrs; i++) {
-		rc = tpm1_pcr_read_dev(chip, i, digest);
+		rc = tpm1_pcr_read(chip, i, digest);
 		if (rc)
 			break;
 		str += sprintf(str, "PCR-%02d: ", i);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index d0402aa122ec..2f06740f993d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -525,7 +525,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
-int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
+int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 8fd67be2d44a..ef37c91b6844 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -574,7 +574,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 }
 
 #define TPM_ORD_PCRREAD 21
-int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 {
 	struct tpm_buf buf;
 	int rc;
@@ -662,7 +662,7 @@ int tpm1_do_selftest(struct tpm_chip *chip)
 
 	do {
 		/* Attempt to read a PCR value */
-		rc = tpm1_pcr_read_dev(chip, 0, dummy);
+		rc = tpm1_pcr_read(chip, 0, dummy);
 
 		/* Some buggy TPMs will not respond to tpm_tis_ready() for
 		 * around 300ms while the self test is ongoing, keep trying
-- 
2.14.4
