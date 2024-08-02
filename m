Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFF74BE1
	for <linux-security-module@vger.kernel.org>; Fri,  2 Aug 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632691; cv=none; b=JlfeazUu1VTWX9nbWb+cEyJWtsFb5xPQjomQUQao3saGGKlWBzwZnUMs5N6uYM3NfYEKSd+g5H0asQNpAgRp0zwgTcIp0zCobM4dYZzGPKQSDX1xA81hVSQtDvDGqdZBAVohEo+uDul15rKU5GkQWqrq2OzPtFmT/f2onTI47W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632691; c=relaxed/simple;
	bh=z1RdEZ7A8nCpAdJiYNdv+o6BPnQVzKEX+9aqwiP/Jig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7GyoSbvt9aLbtUZnFIR3SzE44HuKUlJIMUkuV60VzPLHbZgl7vIrFDh51FMDNIAYz4T4Tla+fiXjvYYX0KayxbRBRavHZqlnOtUn9VtzX5XWaNBsCEoO2gZF2EynF+bmFtFa63Mtg3xY9te/M6I5naLHXrVNdHFW5tIDX6aRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hdmolVEE; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdmolVEE"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81fd9251d99so40572839f.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 Aug 2024 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722632687; x=1723237487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=hdmolVEEz3F+RJMK0XoDpq4DHzYtDE48C+k1TzlEB82oZRtD2cAQ/W4mZKgG0P9itj
         DfLFI3EmT8cl5zas7GmWLAvl3x78g0ob/r1oQyLyElpnF00LKaVFzZwoI0twQU48di2B
         n6KYi5qkGPGL85W00E/yq6pqAncO7syKTcEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632687; x=1723237487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=aE4KleRpl2/r/Xj96A86DtC/RGFacExxH7L5GsxjmJDvy1OvfjhpMLnpKIeAkTMJo/
         1nTECD+m9TmPrO/d2DsWRreB4Z9ioH2VNkxr76AXR0P+oY7h8ayJtAzXfzF3slPeKM6l
         ifMntxq38jCP3+GHbstZEBjLq2+wG2L3Vq0r5yCQBSfU+nBYaZukVY0v60zPIJLAV8xs
         jK0+KO716YI4cFQeXbhfZtUqx4K96uJWmN+JfeFKPCSt5hIFbKTMXsheDpi7Q9w8PzYZ
         O4th8zBOlK4tsFXMxxjo/YeSz1QM7YNBwq0G6ndVwDM0iAKe2r1HQ4Y5avjI7idA4Pht
         sIGw==
X-Gm-Message-State: AOJu0Yx8PldEf/aGM3LpzaVmanD2NBkV5NUkybEOQxEysSWw10Y4NCX5
	HMzHKp7JQUKs4lf+q2sra4/xWY4zBRCvJSXqoDQBOpQxPfDRFMtwHHvVbR+wE60JHmKM53rmjR8
	67A==
X-Google-Smtp-Source: AGHT+IHUFG1Og3qZnJuB+WHW/Mj9RyaQmwZbLxjxKt93uYCF5XTb9EODVbRysfl5tZk2LzoGN4JDew==
X-Received: by 2002:a05:6602:3ca:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-81fd43e3415mr598235239f.12.1722632687275;
        Fri, 02 Aug 2024 14:04:47 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d7223csm70159939f.42.2024.08.02.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:04:46 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org,
	jettrink@chromium.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Add new device/vendor ID 0x50666666
Date: Fri,  2 Aug 2024 21:04:32 +0000
Message-ID: <20240802210441.625738-1-jettrink@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept another DID:VID for the next generation Google TPM. This TPM
has the same Ti50 firmware and fulfills the same interface.

Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v3:
Refactor ternary operators into helper method.

Changes in v2:
Patchset 2 applies cleanly

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..1f83cfe2724c 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,7 +31,8 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
-#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_DT_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_OT_I2C_DID_VID		0x50666666L	/* Device and vendor ID reg value */
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
@@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
 #endif
 
+/**
+ * tpm_cr50_vid_to_name() - Maps VID to name.
+ * @vendor:	Vendor identifier to map to name
+ *
+ * Return:
+ *	A valid string for the vendor or empty string
+ */
+static const char *tpm_cr50_vid_to_name(u32 vendor)
+{
+	switch (vendor) {
+	case TPM_CR50_I2C_DID_VID:
+		return "cr50";
+	case TPM_TI50_DT_I2C_DID_VID:
+		return "ti50 DT";
+	case TPM_TI50_OT_I2C_DID_VID:
+		return "ti50 OT";
+	default:
+		return "";
+	}
+}
+
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
@@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
+	if (vendor != TPM_CR50_I2C_DID_VID &&
+	    vendor != TPM_TI50_DT_I2C_DID_VID &&
+	    vendor != TPM_TI50_OT_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
 		tpm_cr50_release_locality(chip, true);
 		return -ENODEV;
 	}
 
 	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
-		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
+		 tpm_cr50_vid_to_name(vendor),
 		 client->addr, client->irq, vendor >> 16);
 	return tpm_chip_register(chip);
 }
-- 
2.46.0.rc2.264.g509ed76dc8-goog

