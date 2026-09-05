Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0334A2A70
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613039; cv=none; b=EcNnHh6jhAHWrP/KC6wvvvSQczKw/gvlwMY4WIamgKkuN5QU0FQWDH2IPDjokJWpiyXwS8nExL0z/PqhgrLTZJDy6RBT/ykoagcKR30j8B12ohDhJUpW4+ACu58c6dhrTvZiDSNnrlLk02SX03TId5Az/bD9VK35KzsrDXTAjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613039; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b61CqNhN5dFX5rE24w4FeSAaNWAqBQB4Q590HUM2sX1O+h9oSz6IPUOWCT7VTyb5iI8EYWgfswgArVmNXavzBfoMvJO/gfreluHiUMWUpPYlgJHpB4W/XkC0fidEhr8WKTi5erJUw7KlTJVknTVaqmpGFJ2ifnLVVKtr8wriVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8O7Izck; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8O7Izck"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso837188e0c.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613037; x=1789217837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=X8O7Izckbl8XP09kHuq+59tA+camv+9u0pni0j1AI7oKnKiujhYRiqxKOMzfFn8DTj
         UWwBvzpUn6ET9u+UO+2e4tTQFEgSgfcw/C+4xPeh7JMk0T9uuItZpFoHX2Gc13MusjX3
         7XY/oXm3e6EYB5KkStk6fLRo9/E30H2HACmfygMaTGf/8+loDGq9cz9bUrcczaa6LqEK
         sdzBhmCGxS+5K9UKlv4Q2McJJ0gY+yYAT+G1EajP1ZY60+dqrM/5Tceu3HMjwtMd4Toi
         +b0lBoUlWtHB9PFWhfZ+hhww3wbjKRQbXakyZe52H/bmzFip0ct8FytW8mqjnDq76jtr
         SjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613037; x=1789217837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=j3Z4Wto15qNzOYLpW2MctsgAGo59RaFbG+mFPhHdy4o1p06T/oIp4cK/rZnvmvVwYo
         9A87WgnMjQcb8oLMtWaODCWXFVLEyWyNeJNNGn2NmFzph6RDxe7BJ7/o0ZRwJYjXyd8K
         ZD9n8vge73aQJrXfeQsh4v7wwYov2Hpe5u0ZAolkH7qvMlq1G8Iwx5+lMQCtxRmnX97r
         Vy1fJ3SNWMgLJLan8RBo7SZjKx97qq5tVopIZMir5zSsNn5TCqtkJaUCd0nE3Y/1wDS6
         GI0UGMbe0Ev8wUGTyeKoQMEMKOt0Wr8b0ZuEL5iA9FkTjrRxlLuT7BzKP5jsZ5+vYMLP
         j5aQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHKWk8k0ZMVGazMs2SyxQZeHzp+S98NzWlYLMIkV1+yfVtJVBgZlys8z5O9GCj8OL8VNRIUFR3B/zjCbQpE9wAap2KDtI=@vger.kernel.org
X-Gm-Message-State: AFuF++nl2XDzav2E6EY/TI9wIHZQ3X7lLmG/1NB2p7x3b0fWA6IsW0bj
	j1Lqrs3ahvqFvhJNdKAXbKYbKnTHok2U8iaf2GtWtmM6/gWTmDaZVoye
X-Gm-Gg: AYBFou3tfIsLqQsghllpbooNWZJT8yiAFRTzr9xFCjf6emvXfjWnBirI80tJ9K2BwUj
	2tJdUAO/76fB+N2B2oabZHppz55MhRO6IMwh8FKG/YWvtTprze/OQtyXw2VAvL9EA5Aytdeg1IF
	3Y1QXz3AIlHmqsugbUulIzOWFpbUvVQY7korfzl0grNTRMGUnuB45Vvwtod92/t+/rttts19KQw
	D8TfOOW/rUpZD/zgRXgnfwaPFMUiokZV6lCqzkqW1tpSdQAPD2sHJHglY83RivaIaCe1VoaTBB4
	14PL87UICMgCBET2Q/dq3mr815J1GvCR89clJYAj9gtbfpRs+AyGG0aQerQDEZJejzaKAGWwQQI
	LJJtuKgaiT/czJx5F4OQgG2p3YayX0VCHiO9T3Orxo7xOrn5vFt10C39KJrIARiuNOlVc8DShHM
	hHV1n7x5iahI1IktlBdMlSSUIzKM7QbwdOMId1j+QfjPL/3Xj9mnEOM8G67MFKpaKEOkLggZ7Lb
	OPHSGGcK6Pb0WjFRTARHiVIfC8pJL/6MVhB4rwmuVI=
X-Received: by 2002:a05:6122:32cc:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c7ed0c4c20mr6435898e0c.0.1788613035512;
        Sat, 05 Sep 2026 05:57:15 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:14 -0700 (PDT)
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
Subject: [PATCH v8 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:57:04 -0300
Message-ID: <20260905125706.6550-1-breno3011alves@gmail.com>
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

