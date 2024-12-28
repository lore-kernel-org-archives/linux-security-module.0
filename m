Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92A382;
	Sat, 28 Dec 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735370378; cv=none; b=bGmdRJA2Aw0Q16Vhmm0itWwbMgzCL/5RvQXWto1XFVOvPxdz8QxnrovhIHaR590ojM+N5Tgwsd1uRWo4nT/wgi8sf6wk6fwHMwVT1e6xNMi6WZzH42ijyNxaLIUKAj3hSsqAHAcx3Vi74D3JBKOz5O/ckT/xlv3mLgPD40yIiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735370378; c=relaxed/simple;
	bh=4KwWDFrVIiAUCh6RuYrk4TtUGKgA0Pwrse8b0Xdx86k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9srCPaYiy2Mw72v7B7nACBe6EL52spgtAAe4OxSxKh+0LegGOXbeZgR2tMI1+4hSig809YYfaW59W8sd/jLtbBkkjJ6j4sUillb0+D4qsnGts6Pw5uuchUdAEWe4rYNG7wznWAHzMExJPdNQ/gvH/lIMQmYNJdg/CmO6go+Ha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIUrKRo5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIUrKRo5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so9604731a91.3;
        Fri, 27 Dec 2024 23:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735370377; x=1735975177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuk+OwsG8wE47Qn7uAGquvLMJ51bkY+IclAv3LqIRvA=;
        b=kIUrKRo5K02NFe7ytRfsHzu/4vqN6w0ni9Ugj1TZLpXTSVHAkdhh8gXMLnsSMpcz7w
         5pdRTHmsGw/0uSIHIphw1QbOFCv2mxKPgrNvp6I0UEqs+y5QsD8U5zKaphtjEeQJxVQt
         1Y/lTp4jfjsq9Mm3aP+Yb+8ohTEcKvLdnM50cJNEACEFfHceRiGERYqraaVPOdjtMexq
         lkKwoQlW80/Fg/oo3HqIzGrd5L/RQSjWPCJIgNDtihdpQzOmxuR5/rhMvrLsKzor4mSy
         BRt6t+5nw4n3kgzCmKcrVd64dlTsavw6C0c0oeu1JcW68XnPJ6ORP6tCeog+07og9A+r
         amVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735370377; x=1735975177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuk+OwsG8wE47Qn7uAGquvLMJ51bkY+IclAv3LqIRvA=;
        b=DAf9mUh+DYC8alwfd/Zw/RAyZ4J7sGLqR2vJP0/aDRAfmLGju1c1D73cIRq9LKoK5b
         Vyw+Ar5jkZw5L3Yl5qhxKCb0CDDd8usb/9fIE/r6OVfxzAkIquKoXx9FXdHpn51dq0wA
         0N/Yty3vixyyFK4T6PNLxBm8A+UtwGBUoOqqy+F+qT/C4uj2V0ictdiykadwivzy/I/d
         WLLodYOBd4Ndv5AfroP+bzC/zoroD2fE46kpMj2vn6vmFfa5r8ZvU4IP2hw2daOvEYFY
         SqSVpt/5zbroCYxY1b81pm7Mz3SZP2aajqlxkhOiYuFSbAA/qi6YUPL5byhrwscV6Qbh
         dW0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdFyvFKs55RPW8/yuogkL/I+HVgqAeHXu6DrsLW9Ww6U+xseuCI2WinNWTc87HsA7pcIzTD9+y6mnxuIs=@vger.kernel.org, AJvYcCWr7yh7XEYtHKh3k6oivyitRSUo9PSHEv8kmXumBT5m4da7jGBTTxV7Z55p5MI6pNaFnyWLygYG9T3ciqwpZy6YyYV4xTFV@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHYsY/DQynOiCnReMEL+Qau/fp70JQhkL7N/chqZ4UFBR6PUe
	KcdyHPCl24ZfwW/iSOFyXxqqwQc7cNatowg0A6Z8uWP0FpK7pEed
X-Gm-Gg: ASbGncvccTrx/shxmMD5P0v/ZH6WaFTHd24cFSzocwIIDiwXZ4JyVQZuNnyS3eatP8O
	Pr1BTNu2uvJjuJxjW9z4Mh7YrxgTwvtpClhspAwtIoio0ra5VjsDBahKYkTk09YklUSD3XMZtfG
	fjRpgX6Vcs8Q0GTZ4GeyoIGdxRP7vBKRTVv+aBh30DCsn95ZM2Lpiwn6+sTXWtyIBXCvJ/zPhMS
	qFOek+6SCOGu6myqgU8MCQ7DwX+1EH/LKjHoCtqh8HhRJBYuJ3/
X-Google-Smtp-Source: AGHT+IHrgo5ZOaXGBmSTqScn8CCWCd6iKoCMFdrinvK7+1T1Ca4EkVHgv62qgwC99lLVt+etF8RHxQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2f452dfccacmr49022806a91.8.1735370376758;
        Fri, 27 Dec 2024 23:19:36 -0800 (PST)
Received: from localhost.localdomain ([45.115.0.249])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f4477c8537sm16820792a91.21.2024.12.27.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 23:19:36 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: kees@kernel.org,
	yuehaibing@huawei.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	tanyaagarwal25699@gmail.com
Subject: [PATCH] ALSA: usb-audio: US16x08: Initialize array before use
Date: Sat, 28 Dec 2024 12:49:20 +0530
Message-Id: <20241228071920.3252-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Initialize array before use in mixer_us16x08.c to prevent the
issues related to uninitialized memory access.

CID 1410197: (#1 of 1): Uninitialized scalar variable (UNINIT)
uninit_use_in_call: Using uninitialized value *meter_urb when
calling get_meter_levels_from_urb

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1410197

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 6eb7d93b358d..20ac32635f1f 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -687,7 +687,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_info *elem = kcontrol->private_data;
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
-	u8 meter_urb[64];
+	u8 meter_urb[64] = {0};
 
 	switch (kcontrol->private_value) {
 	case 0: {
-- 
2.39.5

