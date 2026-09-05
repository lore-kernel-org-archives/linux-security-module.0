Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A543C1D73
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616914; cv=none; b=nfW4uhThmzCZ9NgMa9aVyw4/tozGlyoYfYq7Lz9glhVVIXiLNAZyV/vdoYp69ugXGw5LgHGxDfrAiHS7WLhkDy/3S1nhYVtKV2ULRmNcy5Lac9ktPxE3fVKVm+RQFsSlB/XPlqQ/K5JsNTvnKPwgyv2EzxcFULw6mo5MoAmDFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616914; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcwrdTcasFNfa5u9yQBsaF9g+M7JHMwcH41a+ZGZfnsgvzXb9NJ3Xo+qPOeVM5xBg9YH8spVGLfl5dbmOR8Alqpf7mdKs0s7OgpBKXFH6MruWXii3b4E75pPWRNlQ7toao/BMw0xyr5CcdBSZ6F5Y3funYEgyk3kuz+q5DQZQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpV17zU; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpV17zU"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97e96666dd6so1292563241.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616883; x=1789221683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=MZpV17zU6O8ZzOYCM6mSh6Pc5bMWELB+jnQuQi5HQCi6EKwnfgmZ0AEBpaSpAQDW8S
         16IVmCmWPcQCQ7FUoAc2mjdXI6Vun4CESOtgp7TZ/BbzPL1ysQvKYMFBk+jIWWhuCbdj
         gBI6DgINw00GjdIA9p44lmwqHYK57/id3xwbTs5uCy8v4cZNIxLxiIv0AMx2XLjAnH3C
         Ea+l+j6WgNoLX1w28TuRU6e+lpGdTNOmLFjggreQG9OFR3L71bhcUPSJ4VvBiNxuPuvq
         ddKBGzFKZUmonKqMeFOYYTi1Tw6vtCRVa1cj6NAo3DraG3ex8OCKO8Q8YmVB4pM+sOEV
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616883; x=1789221683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=c0Q5QYBCj4hcP7NSPsoCc/XSN44cv+FpJlFRL9nk/nL5lW1qhJLd0lGzCNFWbT3YUj
         lxmtMgQwTnakO6Sx8yZj3BCNvXXLsCNbGAAkAd1gF95GSRhyMLEFpsxs63/we/EJcBv4
         mkC3By39qYYpHzh2+Am1r+VTOzplfhLbF79FEwZmliFYheDshTjXmQpyTlU0kuLnC/gb
         PJI4iLcq/IcDOcNnYMdN7BdVgbMoc4NxoZsecU941p1xoKb90SUu0ZmmKDqfP3x9HOsA
         i5KwEHb5AwaG2wCMvHwnAR/Vce36MA0SA5NfcPtYVQ4yyC3pLY9AuqoqzK/MzJlVrsgX
         Ch8w==
X-Forwarded-Encrypted: i=1; AKwUvBxFSElBNGYcnPoGGZK88uWsDCp5djvuvQD4ZGguvJBmiN085IyBNHyGL+3XAdEf+Y7axwXD9hRVsWqCKA5kc3qK0qtrwqE=@vger.kernel.org
X-Gm-Message-State: AFuF++mkFzNurdcJlUL+Z6os9u3QMbIEE+VpaERdpAyCMbIitpbfaANx
	8iscWhwkzVK4S47xGyC6K35TCtzZ5dnOAI0jpvXBpkKqB46BNnHpMSCAg69w33tq
X-Gm-Gg: AYBFou2OtZvBIesA9S6z4HtBSIcSllMP9SggHVLYuUUWjxYstq78dz6ovZSH2fYd48I
	MsDKWDWD/YxwRLGntFI9emV/p0OLoNMv5e4T9E9z8ogKUTCIVBlZDGPX7fVu9Kro6WIBAtdRNvf
	CAgVwNV2CX8UKbiK3xCSUkI9D9/XicKoyQCwVw+OJXr1/Ukfur3qGa/MH6laFS1h/FSWujkGyb2
	5ltnH5DzcvEEuDlEzhGtvEirwKf/Gyn+3ENVZ1/idlcbBUB1GwZqUibDf1S/rCguJqTzO1Axau1
	iAFg7ADZV7Zk5xk2+cTF1yl9cqzDHuKMEqZAfRmuYjaeSChkMNMi6RJb6IZQIP4373G+ZRdzzT2
	7azNP1uXFmZRL965cyvq2WiQtaY8GQbG/Yg1RkwYk+Ur7o/W4nmiLp/zLnNVGMOTXmu6BlUWHJI
	jDr2koxwfkVrOTox3t8hA7llXZ7z9bz23SQYMQARoisAFpZ4d1KYIjojLb8TwyRWTOa4JRq9a4M
	7990Q1AMP3cAQxNmMzGkjVIvtXlgdFY
X-Received: by 2002:a05:6102:1484:b0:785:1d9c:633c with SMTP id ada2fe7eead31-78a4a8436b7mr5213627137.7.1788616882765;
        Sat, 05 Sep 2026 07:01:22 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:20 -0700 (PDT)
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
Subject: [PATCH v11 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 11:01:11 -0300
Message-ID: <20260905140113.21638-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0

