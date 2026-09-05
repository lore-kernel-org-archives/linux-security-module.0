Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE926367B97
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616914; cv=none; b=VpGv19835WWI6ih1Ifl42MtTFLznVLnr6dT6gsuLSDWeQku3j+qjtQq3DRCm/FWiPLgIeMGm8TX+DkXg308e9THWMWiwH4kztWeH951jGzJBO1xw1eeXAQ/KZ8ygYpecWd0b86XXFsl5osTzUj1D7BWsURsmYWwpvCS5YRPNw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616914; c=relaxed/simple;
	bh=EizzPFcHBTIh2Y7GKphJQqpoh7RMlGuXmOyHqJPayZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6jcp/gOtOjLy91N2gLlN1+WZRyBcj92zB6d2WoydZCUmEVVgPCyN7vgxam8TFJgrguUYQgYYjKO3/7ktlGEozatogOKddyNHUM117ZpoWw4w2dX1pi1zlJN/Nhq5aqESlvTGQVl80xwr9h3EDIDDjQ1JpRlpRyIID9iL86Ydfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAWHDYpH; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAWHDYpH"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-783d429d0cfso1589009137.3
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616889; x=1789221689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=ZAWHDYpHOMJ2pb1rznJGqWziVaas9dmvZpinpC8dpdVqj28oQXoc8EcWh4t0vpBJzr
         OfhyVTe5DH/gmR5zTbIvGvTij3vy5znr4MnvveqiDbMkf1FnVpTTGTs6pPzlKhmqp3sz
         3YkwoIj1bZPG4c5xVmHJvjO423C0j8ygBV7y8w96COK+Mrg6bjL66EJZ8f6zhaipTXCA
         shq6D7fnizDyjnuKBYcpdih1sLm8oHZjgJYRBxZorjypAjnKdQNVQabQdDtTPlev5008
         KLDjEmNRmj3wxviz0WV5c0/pYxoL+Vd+BAWA+ZhPGQWWDpR2WZGmObxm4RgatpKhkaDT
         jmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616889; x=1789221689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=nubALsLLDuln+T0M3Ie66yWe8p/zXgvjA8LCMJ6C7M4Pba5ALckrdGiCHIr94APbIW
         udCf6SP2aGyAR5+T9AYsq0+/UVPJMSNIyYgpJY+4KLdYcYtSlVeS3zUHOIEec4UOx0Wm
         q4YBXeImhO/i/AW49rr6pPb1+8mc/7jIegM+1tF+tmTmvAqkhoZ3/dMV3Wv+PAL7e/cu
         BtVn8lTlA0W7Zi3TKt9R/o6YADKnKHY5J1FMuSohsvS7mh8QhE5xGe3UqY6Lx2uP/MnX
         nxo1oXG3k8JhuGQasEj1IREM6cqRWyNQKtLzuDeC5rEk7QRCHy65VYMWjCHfCPXQ2bU1
         8r8w==
X-Forwarded-Encrypted: i=1; AKwUvBxY+S/+cLqLOSYAdDJMqoamNPN1XZOtjd436vdyecGCzQx6QxthOaIY3u2stXUHqdQMv9gNCPo7JWR1bxy9FeA9qfk6yJE=@vger.kernel.org
X-Gm-Message-State: AFuF++naR4Q+jM+QPs+GDuEHj7UckP+7SH3+9KJm0oZjf/rI6uULXAsv
	upFkuVtuKXpSB65maYE3q2Z4L+4iAa4AYep3+PsGIMiTho38vrDylH4a
X-Gm-Gg: AYBFou3N4sDvNu7BbnNhnogkio56bspXVOhf1sznw/can9WWaKjvN9VdV/7ZVHoc5G8
	HaEhu+6lLz6COzaDi8m8fmL/whxwNypuLJLJtFLgAYs99GyQM7oZiXzbpWOEoxcPp/jgt1wWHfz
	cS53mAA2kLG9OMLU/a/gPEQiPORPb5O4piw0e8f+h+7POocjISBmU0uSmsO0W8RlD8tWzAuXfMN
	9FoKlS08mapJqdc/AdZGlaD87lc/Gd7XLuaz9/o0siPx9qZiM1uGOWI8UIxwhp0RKa5jktltwnW
	6zt688jDLh3C31W6U60zQ9MyFwEFvwOxWA4FG5Rx22mPktbxHE082A6QbiC8wxjrJBTJsqzHDMp
	7OCfr3MKYuewWJgBHrnPd3O2afRaGTmSpc41jj0MGl0oKOdjv/seO96wX5VCuVV2nBsm0ueayO1
	1CsyG4Ugg1Niv78IW6WB/Ai/MIT4sZbtFWaNLoNZCSQXOpXTNfGE+DF7Akrk8dKwyCWJDMWP/R4
	fvxlSHq/oxQJk6zQ2qpUmME3Hkjpa+6
X-Received: by 2002:a05:6102:e0d:b0:789:5b58:e105 with SMTP id ada2fe7eead31-78a4a90fdd3mr5362480137.2.1788616888537;
        Sat, 05 Sep 2026 07:01:28 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:26 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v11 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 11:01:12 -0300
Message-ID: <20260905140113.21638-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..3a0db1be6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316) += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

