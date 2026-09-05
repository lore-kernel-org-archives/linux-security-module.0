Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BC4A2625
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613044; cv=none; b=Ksr+3e3x7MSdrq7VBsvBz4OwaUj95dH0xtZIVR6JPbclXCctLWEGuucrDhuFk5qCooQimaXCqNQwB/i4LNPGBeCAe0TU0JlFSCyWNMG1RPXJ86iLkkw7be4zqqMDDx38qXaNccybzVl2p2/QyT19tPaFU9Cs/seuIEBOH3+lXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613044; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlteljqLCQVKO63nzN24GWfzVkN+X9V/KXteymk0mRzANLnXCe2sjiBxGFImRCPW3LcgdH6g9ipj0gTxQYezF7ohhVJYrtJW/QrCjikMbtuuo/Ure88oMA8VbSvNa5gWrLaK1J4Ohwh+09C6oTGlrj+xrDINd8bQKOHVBHMibb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oL64eJiy; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL64eJiy"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso837206e0c.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613042; x=1789217842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=oL64eJiyZHx/JqXDa0DLvHL/BUopETrEFGRWlFErEtn5Vzcf0K1vZj5bfCjV0JTq5V
         wh9HWgh/Be4BkF4E75rIGN1PaxFiOM/a2z4Wkt+cGz9ucsTKSW2SPudorALbIM9YuLc0
         0/rMSo2ZsqcwuOKWbDecJDkcudLIJKxxOSF+EN2NhgZzrlPtP9aYhZdsW6sBI9OWyyUL
         zybdeZ9TJqBDU9IdHbsfUAWKFmiv5naM4CY2HTJj/oHoBgX3P9VfuE90DKXyEV8YZYE0
         uT0tLKEphUgSKWBDq5O05H82PZZj6CXecUWWtxF5ZkuyDmBzP1Fau+7xvpG8GreBgDkj
         UOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613042; x=1789217842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=O3vFzCMgWcpSMYODcUOpS0i/5ZqHeBSETyvar5T8d9Hwnf5GYtcyOa8a8mx9hXNZdI
         5hJ/OttZbPjzssXWVXRAkYbAb22ippipuUq4GAYSWXksfTuYO/e8Kt4wgF0YlClfwX0I
         ZlUSNrgT5je3ZxrVSO2MkjKZ4Hw864+WaKk49WS0335GZa5w48fSbq80SDQh2jcs5XCs
         AKT/w5cAkFlaMjobKUzXXiDhl5mVPhV05HNvWwu2BGAOpBSFfmIYNjVJuOiAJSdRlMqf
         QFQfLpn65CydNniSUADBxtOooUUSPdig9t/UYOpFWP92/yqAvmB1nstUhq+9wK2wBQs+
         Iy/A==
X-Forwarded-Encrypted: i=1; AKwUvBzCcxwHvDNihZ/ueqhzfDulx27MD3kLXXgnP838iumX62BO0ZAHz7+Rj9l4s6uxsCdSZoEdXb7KIZ0RPgkOYkk0lS3qmZY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3E6a2id3BP/5+Yhe9+720x6el8HwspM4yp4uBeVXJLr3qv8ME
	WJHN/HTMi+ufWlXugZOtlPZzQvB2MdDcSOjsdwhPx283AB3HWpCJmUpL
X-Gm-Gg: AYBFou3LKgmg7IolYGOuzqTRRy9t5qipEQhpqM9CmERnvL1QjTOO61zTfGrPkv8TCQ8
	17V8Py70Qt9rbg0dM71+zj4F0fZSk21QHVm7KRbaF2SKs5MMtCvNwJ+qfH/IYZ1/Il5s9sbNaZY
	U0nL8pJ5uGLRGdWUJ/SC7Pw5Hi24TIa3hGZZrVXyNChQXs8Gf1cRP+Jw8DVuJgd8pETzPp6l06T
	FGjUiClFsL5QZT83bri8sZLOZIwfeXJAvF19ZVCwynTkUx2+H8LrQm57+sOMSXX08J6pT4qOcpR
	AUw7D3FCuyBYX0EVX4N69/+tf/MVAzG2y4ujRnSPSMSwIRA1iKYNBwYou8gFHSZ/p4vhHd2Tayt
	5WFtZxhsdKDfLf/InvPQcAQWm7C9RmiMi4l2POU2SXpACl3lT3NByIYY8G8MgnBjTV+aVXVftLq
	uV9OwCs8g9SAIEpmnPgU6fRx1ighrppKwdPWH2U9wg9zwkzJzOjzEsYivg3N78O9lMXKEj80XTa
	9haZgk7C9PMNyxUD2y1CoF7myT8cFE0bZDzJJtYZ7M=
X-Received: by 2002:a05:6122:4fa2:b0:5c7:c666:ec22 with SMTP id 71dfb90a1353d-5c7ed407509mr5471080e0c.6.1788613041673;
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
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
Subject: [PATCH v8 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:57:05 -0300
Message-ID: <20260905125706.6550-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905125706.6550-1-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
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

