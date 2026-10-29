Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264410;
	b=wUpGrhr/kogE7Fyl3YVKXWANOj4Evf6SU5MnzRFd/R8Ni1FUSdbsFtvEbFJ172v0sZZf
	 2sQLDDPn+l7nQUdE5PgKwMo1kZgLDkXEEpKGAjOLI/Q0vLpbUx7hdlsHSfq0xUssZY6hO
	 00nYo7vC93ahCgfuhpPa4oFhx61Y1Bj5/J03kV0lD6AnLrkFxLYYZwFTaIjp7nwxJB7p5
	 dZUrjebvPkI4A+3AC3XEVPcBNGgH+mkKjftzkEEunrtSKig3nNViqtk5hvAnnuscXZ9+a
	 MkoSxjeVoYZ6eQks+FgU4Q9e+avjW+21m7ErJfvFNZoID7BTamQBA/mxzOb2BXG4M+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
	b=HG79jfOaIzNFdxFTLlbezfv6u8VtW4NPqzqZ/yrRVYFMJ5VutROp1gfjNsSw+bamjnyX
	 VHefmRpQSih1b9IN+jk8kjbOJ0xHvVLQVRHo5/EDQR8Ubfj14CJl7MKIr5p2e5KvReNzP
	 Bh20mf/bN37ePX8xak+8igGBmthhMEKUPceku7VA8DrAK83An8WKKf8unG8tM7VpdIEfH
	 tS2kOOIMIW7MnY4KvLMNKrOxgOf4XLuW+n37tSEZtDdcFG+F/i+nTvHkJO3yum0qIuR9o
	 Ad9Pa80TF+QBcNw0i2QqhSbAhEbhCjsVVF11HzbLYhNRIfcEmyTdx4mm2hNyjxKPxog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xt7r6i1X;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F1606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xt7r6i1X
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1178421eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264409; x=1793869209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
        b=xt7r6i1XB1wkXiieaXlil0rUqSFTNnvo7KXs2PxxFwFRllKLzCjc3lAJO51BFf/aQE
         xwbahwlJGxoNmGtKzWB5ciUYUa8c3l5IJQsM+quncSLh590orvnt0rglBklJg/4hSSr5
         zUPZzBSdVHkEFdUOEXNz8+Iq29pYNSRU0vAv9U/jDNds4FjL0ObkXxPo6wW9U7n8MZge
         OCHy/7VRQ2HxiSov3eT+s6eDTuNFwtOZq9jcBMY8gKElsY6t9e3T1UTNnMtDHZO16180
         l9J76Q96/yivgS/e1DmrD4Nu65RQWYxclEk/7RuWeTqfVqY8JXOD8ciHHvZVApvrwhvR
         6rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264409; x=1793869209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bas+A2pwMPdYKlr8K9rmQmJzztUh1FCL0UJNjmXGJUs=;
        b=GGO4MtYwAfccSi1b+vdYElf7C6YFPvsFik6P0ygyVp11eBKSFogaxS5yM2IUekBKPM
         4zXbKbMkQn/rTDffKSbS2zWtn3w4s93N7dUv6F57tw2dpIM6onDSNeCzFVOuzRMHxTsa
         8ADPaGQjeZqu9daCU4CTv3RVxAPXx6TVhgRipq8XcUvc6ElKRw4fXiJxvT+p1a4MVcwT
         w5nFEYaqAN7aOn8ZLdpIzy996Hlg1w0C2W/LU7Cffk55e8VHfLsiXnHrEUpa0FnCK0yL
         qTGB7blvOgRRsEbkRpkepu1jJAG1jwa8WRRUxumAWR8FInTABdkaLErkRTzRCIZsSmhB
         oFFA==
X-Forwarded-Encrypted: i=1; AKwUvByKUd9CXufHbARzNI7M/HjNWi3avLeWoGJmCWveRPMojcab9fPdHvJLzBhmFyNckmZ8ANSH3uliLLkehC7jSQrpHR+CwHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKP5aV0qufnr7KizGWRtSV/kkpNY5DVcMI2da8HgyVQzi7iDNAg
	rvhVWZFg0969IKrGju6+frY3ZabR1kViOhgInIdzXk7QYCaPT+nC2tI=
X-Gm-Gg: AYBFou3VI6MzY+f+6TiE+qSzhHfzoUcAyrATjV1GmRol70hSAy6Jbw8qOSfH9VT+/fd
	7E85D6vOBg/n+EsnSboOjuWVDaBS9bYZWd4AdN4E0/2h8NY96SkytxqhalLdMbmK/cx3yWhBIN+
	Zyrrr1TF0qTKRHsMfuS91p+23dpjHunbJBLF1wcQjC9/K2l72WrR+3BVVigOR2F+ZjUO9lg3Fbi
	XNgV/dfbus/1Vn1mnhqS898gEKHGqQw8UxrhzExGmbR4qY0QzjQdsNToBk2WbyqmcPHXpYBZHrd
	Aa0TpAXerDxIl/33SgPW5BpqGu5nMu6drEPkrDWwXhX1wNyquv/gJrIy6EsfMeSTkT1Ls39s1te
	YnDOJ13ia6+wBxXpRp47mAurY59PLtmtJ024G/WdVY+4QPTMf7/s1KywiSu5negT/fqrCFL3u8N
	XYZgkIQz3TigHbC0KMTjFpxR+3JgkS5+LScONDGw2aJAgYeGu/l6oPN3a/UJUJHFIMgex936rOu
	OvUDrsei4q8MoYlozuQ3SKHl3httE02iJbs99cgxwxcC1JFIUTMHK0YvCYOluMbjXxMUcZQZGIY
	nXMaPKmiaFQCkeyxhKyUX2lqBmPH4wytXuADSWYNaxTuldqDfd4QMefTVZB3yQ==
X-Received: by 2002:a05:7301:d185:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-36a20119d21mr7048294eec.0.1793264408741;
        Thu, 29 Oct 2026 02:00:08 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:00:08 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 09/14] treewide: disable other rtc's in t2 macs
Date: Thu, 29 Oct 2026 04:52:06 -0400
Message-ID: <20261029085504.3547-10-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMOS RTC and the ACPI TAD clock don't work correctly on
T2 Macs. When macsmc-rtc is enabled, turn them off on these
machines so macsmc-rtc is the only clock.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/acpi_tad.c | 4 ++++
 drivers/rtc/rtc-cmos.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 45459a4ca..a137a39e5 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -28,6 +28,7 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -845,6 +846,9 @@ static int acpi_tad_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
+		caps &= ~ACPI_TAD_RT;
+
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
 		caps &= ~(ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE);
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece15..bdb436e24 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/log2.h>
 #include <linux/pm.h>
@@ -944,6 +945,9 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		.priv = &cmos_rtc,
 	};
 
+	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
+		return -ENODEV;
+
 	/* there can be only one ... */
 	if (cmos_rtc.dev)
 		return -EBUSY;
-- 
2.55.0

