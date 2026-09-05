Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482147988B
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612286; cv=none; b=lN8pLbIAjPWTPY9F7HtljeAR0iNkBB2/hixGm+gP8gp1NJy2E+slTKKBlT3OA4cuIm2V9XOkD1xnuFUR9ZXIqLhKxOzAvJkLcsWM7HaiGKvVBhfiUt2410vVTEeYDWh0By7Eds5C4z5k68qiSa/VqR02rATaMv6JlFBDpl5Dwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612286; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYzSmqw7H6ClE/ejV0jCFs6gLUMRUNaMCQm7NfUkeIfN53gexoDtwKKtSgjgbW7u8y1HmmGszMQZWiH4oDv2hzC+uiLX/kRjAr3wmD0l1u6bAosmFcthDu9hD9tjEdAYJnNNuree3MHgeU7CgseH4QIYvyPSSBClDrd52QKQ5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxA+t2+o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxA+t2+o"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1319584b3a.3
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612284; x=1789217084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=kxA+t2+oXL2x7EMXQO7yKd8Q2TsrzpN5J8KcJOxJtzo8UCq3Pq/eQ6OvRiTbgGBKxU
         FG+jB4lrUw+ogJbMGc97bJp0QdX+qQ3BK2GPWguDm7swABoeHQMsqmGcQmA97C9Fwg87
         4yx1Ama1LFuuEwDwqpCNuCA44gll0EabgP7oCJwFKGpQ5NOlDYja3XbJ0+PkaGDAt5RZ
         +xf/jqCwbhA94ngMM55TRADZAAVSgHx55/KmIatYzZFnJbkstYvE7oH1T76VfioL9+T8
         Fv2sShwtLS4PLZy6xiVs5TQmfgI+fDgrCi1pWTrl0JpdRy1g+SFUxkjJy4RjNKv418nJ
         7V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612284; x=1789217084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=h/PknO7Xo1waXW38jFASulSQGx+5EdzZcgOznbAUQ4pJBJ90VZ4Ub7siNdgHfSitmD
         Sy3qVF852HLgmzMMu7CrRSZmiE8/FCKytljr3vlpOU1uaZ7uvY3zGVAun88IPYdHUX7Q
         uCM9rUFh1xF+3kwgJsu16FY0OvXmbJO/8yOcrXE+T+uVmeQ0ApkSV8cUcUwtCyYEo5oI
         wfZ3ModEIMPYa0ek/YYeJPz5mUMVOKYTHy/ncSrqMLV003MGZ/A9GwcbjtySnwBUMZws
         wg00BLLnZcozOA2wqrGQNyS+UIWGi1unJyZJL550i0PlOG9PFfKcMMHA8f7S13mjQ5BX
         y9xg==
X-Forwarded-Encrypted: i=1; AKwUvBx9Q/hldwwom61JTVlWTXQmbOqSuKi8UpVxU+R2bdfQA2Nq4cf21xm8Jw37ooop5FIPrBVbw8kt4K+m1BlCcjz1w66kEUk=@vger.kernel.org
X-Gm-Message-State: AFuF++nA7IV576igXbBXymesj8kyQuqmX+Ew3iM19GW/VIk8QognGoO9
	WTDUn5U8TZ59CLavCsy4eY1Qw5UtCU0MmDqPIxSx+tEjnOG4HsnGr2eR
X-Gm-Gg: AYBFou1cmRFtG6cvlZDtiwba+vzpSWfXzNQBeuqBHXki43GF7BNCSQrevnS8pmw7b0a
	XMB6smlLxChao0L6wWEncIDkevjOj0PQN3NuXoUVbuHXltHB7m5FAPd0UfQGC3ZRs9zVJEWdur1
	uI7lCocOOGcNFonhblhx47J3IYprErYmrTwPE5MbEfKTfdjXIm/b18RegTJnPocRIymCOqeuwoj
	O70Ty84OCN2icFsW3MM4nMctbv+FMYmpwaIyEKebQfD6bCjH5xnGwStpZPpfWIhprFX/peWi05C
	MKVAHf2Cq8tME3hRSmfC999+hrqxDrLIUZfNFuBqjfIBLJhRpKhsDCDmPaf8Sbwc5vke80uqwkr
	SvRJh8r8xdduEYvNjbq+3/7GNn9OHE2jgX9DUJj/LRL9eKeAnwWfKGf2pIYowzpI677VzdP8Bw6
	rMqoitPt1hZpRTvNhgvPb5hNRY6tZfLHP/K/iU9kEcbuyIAZo1a3Ygx00JEii/D9S8EMsaUxRIv
	IRo4flLjlcVJ62aqCEvx1hpoqbN/YCNa7s1e1bWmtYX
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3da3a0cc429mr18182599637.23.1788612283674;
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm11740417eec.3.2026.09.05.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
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
Subject: [PATCH v7 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:44:33 -0300
Message-ID: <20260905124434.6163-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905124434.6163-1-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
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

