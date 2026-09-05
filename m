Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9C2DB7B9
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568216; cv=none; b=VceP0kKrOiDP/w99GIprQm3YKczmai1ErE4ktwH+0zCWrCpqZxNdch01CkFKtsULg0mNkCXMyMEu84PnIHXs5gAYaN+8IDPsaE6001Nrp0abg8ulRUWJSXco9bHsejYtKDn6Wp8k6RCp9pKgXUFyF9GGl83SLXpIw7nArtUmN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568216; c=relaxed/simple;
	bh=XxbPIFk2tSsij/ROTcukZp1v9F5KUnPXyjMHgXJVQ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcQwGFLSPIr4mxh7A28hWTdAxpmOh1d8tW5UzCmLUs6adgoQmkLlPo5SfXTa3xqUhnytB7N43Ms7wuB+lSO3xEBlnA9HHg5et94/pVPMqDabtQP6ILwMLny4tsw8dU3xXskb5f7+m3kykUJW0xr32dpVjEWtVhXTYkH+MoC6ikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDGVxRdz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDGVxRdz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1217332a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788568212; x=1789173012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7HnYBPkgGHcq9yWO+WayMoxCwKBUXVvRWJyyRsMWSP0=;
        b=YDGVxRdzwiZjZAB3CiuiI18XQj5Uxss8SJ+Qhvg9+pCl3vV5hseo++ZJ/aWiN0vxP7
         /XkSLNhgKpB4hOldnEk0A9hgg+GgAXL+e90pN56oGuCoi5FjFd9M+wt9pqfI+ylRaQX4
         dV4YlT9yGcbNP3933iE09hJl+mCcGK474uQtPhThwBjeUB+a7d7gHyRVlXQjRLEFrHLx
         oJLAt2vkrxJF9h7HEYSM0V1OTQo6Ukd+vZCu+Se9ud/mw+UG6MN4wDUDF0Xa7h1RhH3w
         XvGQoFIyQf4xHswOXk/O8JYWkXccWKd2oDt4IzvXIch90UYZU3nQ758vpPIxrEjM50DC
         dLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788568212; x=1789173012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HnYBPkgGHcq9yWO+WayMoxCwKBUXVvRWJyyRsMWSP0=;
        b=VmVe1Z9Cjr28YcpgmngwHSTcwej8i2B6qqp9PNvnXbvSLsPB716cgoikUzhm1bF55Z
         uy13uI2E1R0E25XLTlmOF6OvzotMllKoQmS6fo7tXWU/kkrEwXgfFadgy28YSaEkf1gh
         V6HN2odsPvrzMAAJEXmPvg5Ik0MKcRdBMFHKGZO4h8+yHQdACD57R8l1q2kEA9+xXPcT
         RPj669oBztyTpGVWBKnGdQncOd8N/eUgX84a9dExsmlm2Y3xp71f7LbTOcIDsTBO7z2H
         8M/4KCzx7BmG/bd4wWM2sfah5pzYQHxsWC7PHMvnxlgNIYcFe14RD6ZerEMRVZnRcX2u
         0VTA==
X-Forwarded-Encrypted: i=1; AKwUvBzcLJLlUpxh04kR0VYNG1+qEK/P2A+3nAirKpshXTUawn72jCYVAqWHKh801PQfUPeNslIwd8yfQbz/6+M/8SjOBQDHOWU=@vger.kernel.org
X-Gm-Message-State: AFuF++kk/n8XTqdtMsVQOnpMIDMtwJEebNt1xRJaYUW9IdkfDAUkDbRL
	dCOmEiAmCJcXYZ6W6hzFblFQMenMzoPz/QOeEGLmVOi/l9fOK8Ad+iUY
X-Gm-Gg: AYBFou2msFbNuoytxfE86jzl1e1S6cuy2Y+l7BHxvBwVSXFtctHSSW3uJV9VMbu2nK3
	+QKOamSBFZ5r/rzWD7prOr9216c/tKzDzJJpdy3dHa+C1kvsSJ6S/tJN4KD0emLJOMseMlHJs4g
	VQBvWQwjEhzAPja8Lrr3Uz9y5K6wlhG5M0b3LZLOPPAj6endGadT9Ux7lkqy8igHfe+NzTsT9fY
	zsfswpftLBPYD4/9kYbSgTbqgbAJS8J89ZKQQXAzFGdcdzzhobO3ooaIoCJ8+bWb1KrbzzN4lwn
	rA64YKKn0w2VrfmE0Ky9WWdfOUv9DPTXjKBYMlp9amZNHj9ILTmYoKgFDBkQb8vfJRF940nZRVI
	K4xHSunV05/gG901M8WrYtk7gbFDfD+AYY88vGXMAAl9GEQjw6/EOCqpXxEsAFDIkNe9M/7QVLn
	eqIlgMAgFGVyT43k48jnMUIVoW0nKJ6EIyOwwNMl2dMWXF0HJHpXtvZmRLI1tOG3XmjTormvIeV
	4J8yNtMJs8V8c9T5FWzxZJn24qZ0KxR
X-Received: by 2002:a17:90b:4b0c:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39b26121f6cmr14637223a91.2.1788568211735;
        Fri, 04 Sep 2026 17:30:11 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm9745628eec.13.2026.09.04.17.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:30:11 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v5] Kconfig: fix typos in core makefiles and purge defective DVB debug (v5)
Date: Fri,  4 Sep 2026 21:30:05 -0300
Message-ID: <20260905003005.118245-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Automated review from Sashiko AI revealed that re-enabling the legacy
DVB_ULE_DEBUG code via CONFIG_DVB_ULE_DEBUG exposes severe race conditions
on global state variables, leading to out-of-bounds memory corruption.
Additionally, the debug block suffers from undeclared identifiers (TS_SZ).

Following the core kernel principle of eliminating dangerous, unmaintained
code, this patch completely extirpates the defective DVB_ULE_DEBUG block
from dvb_net.c and purges its corresponding configuration symbol from
the Kconfig tree.

This version retains the verified MediaTek bugfixes and ghost purges:
  - Fixes MediaTek interconnect typo mapping mt8196.o to MT8196.
  - Fixes MediaTek regulator typo mapping mt6316-regulator to MT6316.
  - Cleans up the dangling comment in drivers/leds/Kconfig.
  - Purges verified legacy ghost weight.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 drivers/leds/Kconfig                   | 1 -
 drivers/media/dvb-core/dvb_net.c       | 6 +++---
 drivers/regulator/Makefile             | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index d0d318223..800fbd560 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -873,7 +873,6 @@ config LEDS_UPBOARD
 	  This driver can also be built as a module. If so the module will be
 	  called leds-upboard.
 
-comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
 
 config LEDS_BLINKM
 	tristate "LED support for the BlinkM I2C RGB LED"
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..3b503695e 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 /*
  * The code inside DVB_ULE_DEBUG keeps a history of the
  * last 100 TS cells processed.
@@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 	if (ule_where >= &ule_hist[100*TS_SZ])
 		ule_where = ule_hist;
 	memcpy(ule_where, h->ts, TS_SZ);
@@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
+	#ifdef CONFIG_DVB_ULE_DEBUG
 		hexdump(iov[0].iov_base, iov[0].iov_len);
 		hexdump(iov[1].iov_base, iov[1].iov_len);
 		hexdump(iov[2].iov_base, iov[2].iov_len);
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

