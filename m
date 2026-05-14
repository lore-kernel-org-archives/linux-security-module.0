Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C830C371
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721305; cv=none; b=GebvFY2Zdc8DfrR4+ubK9RryQyU6yq5uw4OmR2Z8nGgjbEn6/dFvBQOdZ8lf7u7njqquSE99GdeW9qepa9R8yU2i+0LVEycr5tX+B58glCXpMhGoyDx98Yvw0FV6VRJIjhlqDOkaCqoWddpyQuolmq+mlBdJP8pB9cMY3+svqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721305; c=relaxed/simple;
	bh=Y86PnhQNXn+edLDKcBNwx7/SC5l4yOxfubsVzuIeuG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sm54oS3ZpUVGgGdqPLh0x9ktYxrJUBRkuJYMz2x9pIKI/vwEe1YiC8C+nxunbS40guRdQsfR+AqfUvKk4jPM1uhPAoYRHvESfdtEL8cGvU8e/fFTIBikGnAzbWE9CYxenb9h9TndszGZxb+Oa0vV3e+n7sbn5FsHT0VGl5QlZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HWQRa60r; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HWQRa60r"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90ea08cc5ceso295353085a.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778721302; x=1779326102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0PJzTXDkL/I37haP57932TFEW4mzU+xpK6WRUSCQYw=;
        b=HWQRa60rhwBngZtgNclnvE7a6WLhaLCsUmlUUEi7y088e4Qg9Y8uWJH5HaB7Z1NMmj
         lp/R64+LLFnbovgqisa39uNITGhX8kvYOZLsMABs7tfCsh/1qo5FPpesADGPXccjJIN5
         AxPam2P80pop8+hdg9uFuV41Q8t4tEKf/k3LUU4tmSnq/l86VjmuN48uSs0uh6uEt73A
         d5s+hFoxGOaGYLCFKAvqw0Npl7IRk5XyKVYRtAAj8SU9Sn/1wHZAKAR63dS+jtXPznxc
         8kfrSMiTduawWXE1IZ2Ffl5ro7dgz3OPMXegKaAySPXRGRpK+x39wv53Valk8jiyxdeL
         P2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778721302; x=1779326102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0PJzTXDkL/I37haP57932TFEW4mzU+xpK6WRUSCQYw=;
        b=enOaU0u/6jZxdEfTRz+YOVwMAmH3G4TfrC1knafPT2NLm9rqCRJmiuQ4JxuB8YqVEr
         749eKT+MQIGYAewY7K8lR359hg/142jTXASTtibVeOX9rdWUfFvw8uFAzcgswZdkjcSO
         wqfb8RKJIQ6PzqLbq1NzluKk51V1fOJbAldw7z7vpEybO0g2kfa1Ly8sF/ExSMtNXdfd
         GKn0Gv5owq2D9eMVc2uw0D7vuM1bg3kyGXR02PM4CfcIRONs3Pb60Sl1by00sXH7ceYf
         daIvGAE1DtWQkV1VhIpkNgEq4oSPCAFaeNa3efcL0gRMGf2piLztXCZFuz89aQ48RC7B
         SJ7Q==
X-Gm-Message-State: AOJu0YxQxAUkGLogVnilP51mGL89dE/yFou9HG1h3zCZavykXjWOHbaG
	rT3dxMtLJXEcFjwEYHD5MHKj6hu/5faIXsamEUQ75l4FuvagW5rN++OiijdFdO+sRutb2W6yMFE
	9fzU=
X-Gm-Gg: Acq92OHZ4GbuS8BntUfKDQN279GoAUdWRLDQnwt93Wuo0GcSVD/B9MjPC1zRGPobbyP
	iAVORv9fqUQHY49tUhd5ZDR0T9CVR/+hs2dgnoETi1TExzo6iFRh427td3Q/3sAvUat9SMYJqs+
	a/VAJxr/VwrYUmEihEQtNCJnyFOKQc373/md2kwDMxcsa7LVsQV16RnoptqKAjJeoKZDZ6OQoxt
	yQ9uzEny7Zq6XZgG5mGHkVOABg5YAkSkVhBzx8Jfhbs2au61AIvIkSWPyy6UMuOc0eZGFK7Ds03
	l0tou4SKVSa8kIr3YZ5/y/PMaBdjsWrqQTMoYb74LR+N7U0PRPwHQLYlLFicB20yF2RexfCqi1j
	J0p5QP8yjKvPGx9TtHQ8xvnWPmKAGvofoGlL3OgIdqlzIm6dMTRUTT6gxEOyaOD1vvIP+5D6zpW
	9iZt/qD1SyOC9+swpqENYdL59Ev4N++ItWAafiujPOE0OY8HTefib4RlwcqYmX22EDfHz6cp7ur
	gh5/uw=
X-Received: by 2002:a05:620a:280b:b0:902:e45b:45d4 with SMTP id af79cd13be357-90f8a1480f2mr940295385a.32.1778721301862;
        Wed, 13 May 2026 18:15:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae27359sm123867885a.17.2026.05.13.18.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:15:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: [PATCH] hornet: depend on CONFIG_SECURITY and CONFIG_BPF_SYSCALL
Date: Wed, 13 May 2026 21:14:57 -0400
Message-ID: <20260514011456.504527-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=paul@paul-moore.com; h=from:subject; bh=Y86PnhQNXn+edLDKcBNwx7/SC5l4yOxfubsVzuIeuG4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqBSIQpWxqhxaxfUkh8YIobTlX1X7hAeFeGmCmv n52/QND/A+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCagUiEAAKCRDqIPLalzeJ czoND/9VeAW7zGpOntghUyhDZgGTwYXLyGkMt7IWifxca+MjQD9wOf+GcmWWB3FRKsrWtKKMuRn V2gUy6YcPmT3x2epRopFN1l7jZ9GC3dE09hqSeoLRCq0bGjIOAJ3njPTb+axQ3PMRjUjQ5mJbW4 UrjJk7nnxkv78Dzve7biIs81gmgYnCV4pYYpBQueJE+sUQUu56+U90sJKlQf8zODP578YMCizMh RpTLj66y7v2j0bNfqCkhmQXdCY/hRq2Z1XYMG7W+q8/i64s1y4NyhtiLXl3rLClHrT5yRqG5Op+ E0GLVHg5uv2G1xv+5OoiTzM7OX9OIImyz0PYlF/PKnKzVBJuF7V7TgvpYmRD1yUly2kgj4BRso9 wRF3CsYKCG1wjhEoZehkfKdwKuBzIgkxdDlXzBd2i2jLlOpo2L6+3YPeaL2faaqZgCW7OyaTAcQ /EpoiObFleBCOQyb1BEpZO+wc6j8D3MstQe3JusTQf4sSCu4mFK7M661RVfEFWHsY84SztmQPlv 1yeBFLW19RpsQWlRZl6Cdbdba94ikF30+w4w1EdqBR7c2YHQtxbfeq5iBhTQg76Y9zL4RbfVe2l xSY5j496bQKbVzlRzKTyMiCM9WYwhyzWkekdlIKwvx1EjZIkPJV19uva4Ryb0kUDE5Ivs3EqRNQ 35M1wRfwAAZmcRg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Hornet only makes sense as a LSM if the LSM framework is enabled
via CONFIG_SECURITY and eBPF is enabled via CONFIG_BPF_SYSCALL.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605140655.YX9jzufG-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/hornet/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
index 5be71d97daee..537ad015958c 100644
--- a/security/hornet/Kconfig
+++ b/security/hornet/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SECURITY_HORNET
 	bool "Hornet support"
+	depends on SECURITY && BPF_SYSCALL
 	select CRYPTO_LIB_SHA256
 	select PKCS7_MESSAGE_PARSER
 	select SYSTEM_DATA_VERIFICATION
-- 
2.54.0

