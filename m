Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051A7404E
	for <linux-security-module@vger.kernel.org>; Fri,  2 Aug 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633002; cv=none; b=WR8Prx+9JP/tksH3+PmfUDZgbEdSyNw5KDaLBM1/hxM44mbanxy42pjLX6YRJBvT9oeXIEEL6HgdQS0P6J7zVAvTLkmucNU14Qzt2knyOftKig1zXs+QosV6iRKAjoFRaaCMY0k3JUhXW/Ugf0cW0IBQR3oOSK49bpVksvnjNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633002; c=relaxed/simple;
	bh=QR7Wn2vDRe55ZkodaookIE2MGefBuwafHb8wooCogaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofrVchkDaxsRA78OZbIQontY77S60ANuVCxXR8AwYA1MQxCtQ3asJeFxFmVby0Rm8TiGynG8/Hr9YYBJm6BrKlT6PBCZ/Js1XyzXRhRsMLPIDLtQ07j01Q/Z8uhnukmAY8/JHjPJarSly4FXtVQ66uVyMUh9fZO8wOg5ITApeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RSUfow7Y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSUfow7Y"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f8f0198beso358383339f.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Aug 2024 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722633000; x=1723237800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/yfcznWxxx4DX0YlV9aqLeKa/e1pHrgY/gQ9qBV8dw=;
        b=RSUfow7YpfUzXHtTeIXrvRQm1PAE45Eo7Rbr4xh+Dbl7ysE1VAX2r+eZkDZypnfO4f
         JfcJG8CFnoJbYJXweX1mi5yshWSYnh8NK/YsY0rgcqnkwVUe+zTgaekCj/2IiqORRVtT
         +z87YJOmfI7rdcb8gK7PU0qAYovo2G6w8vnxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633000; x=1723237800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/yfcznWxxx4DX0YlV9aqLeKa/e1pHrgY/gQ9qBV8dw=;
        b=IJ69UC6dgS9m9W5g3vjWyXex/YmpnLaS4EaobwJOai7CUf3vfWfC62XYusSi3ZA9Ie
         p5El1Q5+rPSmv/EXYH+rqutu/2/lryMtndwLsfrO5Mmy09XUoq0GNk/NtL1XbqPVePdN
         fVEKzJ4UYGfrJ5Y/Nmluj14r1vmAQ59KFm+hhvEpov0AVuf6f4Zht1NlBUhlyqI5gMjS
         +Tst36EbUP9+QHI7PYsvQfokhzcqgxZvWs5zYQ3m35h3GiRd8siynnZcLYElExYzdHvb
         NdCB3F07rkI/oAeJIxg33L3HX7FM4pr10Kz+UlpgB5QeDRbNxzSnZPqvi1LAS6tt3M/7
         Gp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8S5eitRgY0VijUlnJX1/zrTjixAMU+GDfgvV2n1Z3EZOV/p+w/NBQMzH9h3or+4qA42Zab3XSldVqbceFlDFzt3sVTlihIYsmoYPstulUofU7ZNc7
X-Gm-Message-State: AOJu0YxY5YbSUnnPsT0xFUP9O4lnofP0JaedIIlnQnUc60XmvaeHIV6x
	IfGinW1Qp9AC3DAc24s0b/Js3W5bv32d1vDQ7DOK0hvvJVge7XSrvG7DpZgSkw==
X-Google-Smtp-Source: AGHT+IEe4BsGZ0ERqD25XGYDxPZckY6iYmRnz1fcfLEocufMVco8mQyaSdn+Ig7QKg9Z0RgVpQOgBw==
X-Received: by 2002:a05:6602:6194:b0:807:f0fb:1192 with SMTP id ca18e2360f4ac-81fd435099emr598672039f.1.1722632999995;
        Fri, 02 Aug 2024 14:09:59 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3e372sm617048173.144.2024.08.02.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:09:59 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jettrink@chromium.org,
	linux-security-module@vger.kernel.org,
	jarkko@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v4] tpm: Add new device/vendor ID 0x50666666
Date: Fri,  2 Aug 2024 21:09:25 +0000
Message-ID: <20240802210957.629455-1-jettrink@chromium.org>
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

Suggested-by: jarkko@kernel.org

Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v4:
Add Suggested-by tag. Sorry that I forget.

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

