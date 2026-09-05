Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF780392837
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611706; cv=none; b=Ub6YSu047kk/sQVpPxb4zTKnQMfaF8ZWPGsvqMP7noucb2xVz4b+Usy7nsydMQ4q/a2Mj/yqExnsjCD2WqnbyvJEG94yvDl2RXCg671dhkGWzYREhYm55OiVAP5P9/BKLxXkWyWNWbpxUw70f7Ds/Kl73bK5smXcpwJqsIBgBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611706; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL7MqYbSIECJvI754U0kkfFdJOieBNbSPb8Ri8TeJrhyiInkXUYwd4D9eIobGB/eDdfFbSUq6fNV4deB8pR3WMSMf5F8gfTwHPLzvWaFqlRfiF8gryyE48KkDN1bdVxJ2Dvhm/tShdsphtDUiCOhTjKCbURuOF+85RkiGEb8lGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfFc8NvH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfFc8NvH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so2689193a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611700; x=1789216500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=KfFc8NvHycwffxp/MuDnnI6GzEu6tIHkW7Y9k8dKiMJfZJeskPB3P5q6k9dVF+jvmM
         Ydfr1SY5F1o8KsO693B+bapTI3AmcIOQ12mZdNgtxBsDzt+uI8iSj/szdJu6H07pswID
         u8iCSNqEj9vr68rZF+sv77X7kqqF5mgcH6wEp8ep1ZBshraYqUf6C7sX5GQFyCG6wSjl
         dfzPw+cDm9IQOLhTcptEpWKPK4shPYU1u3ooFNYAlUKrOtMEVQvSj2jq57ArrJsZdR65
         R3YTlfJcbI2egUYL501e7Etl32DKVwR7vi6VJxGAv2j+HB8slAKHeTVFYzsbD9isqzK1
         FW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611700; x=1789216500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=RFPU4a5j9vPaENwjeDImlTSQGihNhr2/tPn/OxlnDSVdO9CPK2W7BdUp1mubeEbqKi
         tX1y8SYAdHHtT8iPq38m4Oz4cyPOFcOE49w98F8wTJrhwx3YoEu39TPaEaWGFROTdA2x
         zdGCypFzc++gt77YXJ0RjdH6sya2fs4hVZ5i/bpq2MG6+EqEJDqKQreC4TEqAkBkLfzn
         iHOiyGarMLb6C0rc54vZnYTp+tdFGVDxOgzv4niNkr+h/GE3FcfuTuimJOaSgCZTx9rE
         7CJgo6yyHE76/V//95WC513Vtw0lvCv+TLS0R1oh70au12v+0AqQky0cUZpGdYb2/6zc
         C5xA==
X-Forwarded-Encrypted: i=1; AKwUvBwWOamYGkkFmda/oDf44DBNrKGYEBDPCfAQX7TfILU1Js+xijgPZbI17e5yox0CFS5Lsaqm7sFHkgUyGpPuwX2774EOips=@vger.kernel.org
X-Gm-Message-State: AFuF++mFW99z09/pO5ljs8/Z2H+JIGCqSvi3jOkLa3BnbduXtZDkPYdP
	cboyBmIbC8O5xYuWgCIM0XJbpUu1DVl0r0R+d9dDR/79jKNhrTZ9EkCV
X-Gm-Gg: AYBFou18TZ+A/mprgALs63J8CDJ72Qb5peD6gqJViAXgJVvtytjjekgHUzmpwVD4Bm2
	7N7W6C6vifJLQ575nlkT3q+WYEIuCoKUm3g6Pwvk8izdQeP6sF7Mp5XanBPl9empjSijcbtqPif
	ZSe1cOkwHBoF6ZG+KQrO2uAufEVbCo0zPwUlULh3b1wn4oi1guo6nOsOYjU9iHoC/Vef83ZiZFI
	mqqspBpVGGwElpVcW7X5CN2qIXjVqNglTv5vx3s06kTzDV47q8nHRuxmlFGrJ4g981DqJ7rK/XU
	viqhpGc6ZRolyc7dDZipyljBAne/jB2SqFeq3eBMfozCwkcZF62CGCz/09qvEUJz/GNB39Zm83P
	LHNygqAnCXD6tjad8trdz5PwxazvU7uxOdsm0rBSP/c3tbmZmJnyj4Hg4Qr5alFKWTtFUfkPUaV
	UtMLcwvLv5VLhsSFfLRvGGe9ZKr8DhB/GRrB24uGjhUp3Ma9WbKT81yisR7LXUDtyHknQXCBNam
	A/5doYqXmvYKKVByTN39oIWhpcTNg2S
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr18508993a91.23.1788611699999;
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:59 -0700 (PDT)
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
Subject: [PATCH v6 2/4] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:34:48 -0300
Message-ID: <20260905123450.5620-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
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

