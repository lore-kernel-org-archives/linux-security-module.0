Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5747A4C
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963102; cv=none; b=I0Fxr4xEFYYkqH4FJdwFaN49NKFvt8a+2KvHhSreE+rBKuAEbGOp+8Q/+T2dm1GiY32RXBPsVPKcIx6PrK/jHU/c9vXwYOenwL6X3ccbvMVjEzXznCMnsa+C6vnYwo+IpeX7X4oHijvmgAFUpoZEMfTrqp3Mab2qJdr6pRF5XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963102; c=relaxed/simple;
	bh=zwYrYMjd46tRAc1s8WfUpUtE5XVT9C0iCl5X9xL3yRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkFtfB53PUO2B751GGvI/P6GU92p8fnF5mNb0tJbDW2sh8XJQAYwlLaRYLYt70F7Pwz+RXoMH+7/6vqK8mtQ63xIJFqYlk16UP1+nVLWBNIFUNNUHJ0olK5imkCaD+GQvmtR9vCarqIXZEKJQfvsc+ll/SeX+8RkRh0ATLMwLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LefYejKC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LefYejKC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45019dccc3aso5078171cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2024 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722963100; x=1723567900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwhrn6L/BEax4z8Y9Ps+jMGT26+SKh+43Sy/rMhIBig=;
        b=LefYejKC+a7bQvRIXQJ+6GhzLhCDOzMEBf+BLGowb1TdSWIGkUThrrXuT3dPesLDOH
         5tcwmXB8qh+nTS38kpXmrh1D0u8Ne5mGoM9VwEVkQJNWZpGvJjU0jW/3GAiAuZmlf/WK
         B877QvQceuH5MuPc3dTkTuW4pqTbUp6yQczB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963100; x=1723567900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xwhrn6L/BEax4z8Y9Ps+jMGT26+SKh+43Sy/rMhIBig=;
        b=Y9HtXwsChj/PzIC+6cB6X2KMr7PvnLuq1Z38urzDjlmmnowW9hSlyQmm9mXMbI4Yqo
         5gFP5NZw6V9G51KmryBRuUq2004taYKrWjtwGo00VYALdm6qDmCdJN0UearoUaCg9GWa
         ZhPelmQkGNhSekIJy0Fsr1tRq/Fa57YD7bwBCpVD+cmIptjLqqTlfm+ySk/F2/3Udva/
         xlAhu28mOoPYKueHqMAr/L2A2E7yYTRdUkFoUM5ImCzFwUVB+8xX6OZcKAaut2QGBAk+
         GzBsuv17UPx6RvAfkUxL4DtaVbl6OdAaWLNt8Hrx0ZF/0zbCtBzdE2UJzvujkW0VjwIb
         7sUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJuhsq38eEWaVDFR7Du0UvRGk9Z8+3cVCrX+8zwXFjer8CLasggkEraEHc17dpaAPwYA/NMlDYJed3r43kXYy+Y1Y1R3i3zCFb3WLhn2xpeqkVDo3y
X-Gm-Message-State: AOJu0YwJi3c8eeEIFotWXTYh1nUIWV1dtcv+pSzhtdGSmxADSDb1qte4
	MK4Wp1cnZ6TjfKhbm3MMIZBTyNbR6selE0+ZjDGAIQykeKmleW2yalTAL0JYXg==
X-Google-Smtp-Source: AGHT+IEIJDB0Wd/AEg4ps8OtmLu1icwcxdK69nWNNqRPnsYe91O137kk69C/uJq5/hfxb5REkl/+gA==
X-Received: by 2002:ac8:5a4a:0:b0:447:efb8:97f4 with SMTP id d75a77b69052e-45189208315mr162589391cf.2.1722963100004;
        Tue, 06 Aug 2024 09:51:40 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451ae326f9dsm18974831cf.38.2024.08.06.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:51:39 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jettrink@chromium.org,
	linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v5] tpm: Add new device/vendor ID 0x50666666
Date: Tue,  6 Aug 2024 16:51:10 +0000
Message-ID: <20240806165134.1692428-1-jettrink@chromium.org>
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

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v5:
Correct Suggested-by tag form.

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

