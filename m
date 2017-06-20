From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 20 Jun 2017 11:38:02 +0200
Subject: [PATCH 1/2] tpm: fix a kernel memory leak in tpm-sysfs.c
In-Reply-To: <20170620093804.23803-1-jarkko.sakkinen@linux.intel.com>
References: <20170620093804.23803-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170620093804.23803-2-jarkko.sakkinen@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

While cleaning up sysfs callback that prints EK we discovered a kernel
memory leak. This commit fixes the issue by zeroing the buffer used for
TPM command/response.

The leak happen when we use either tpm_vtpm_proxy, tpm_ibmvtpm or
xen-tpmfront.

Cc: stable at vger.kernel.org
Fixes: 0883743825e3 ("TPM: sysfs functions consolidation")
Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 4bd0997cfa2d..eedb8e47bde2 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -36,9 +36,10 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	ssize_t err;
 	int i, rc;
 	char *str = buf;
-
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
+	memset(&tpm_cmd, 0, sizeof(tpm_cmd));
+
 	tpm_cmd.header.in = tpm_readpubek_header;
 	err = tpm_transmit_cmd(chip, NULL, &tpm_cmd, READ_PUBEK_RESULT_SIZE,
 			       READ_PUBEK_RESULT_MIN_BODY_SIZE, 0,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
