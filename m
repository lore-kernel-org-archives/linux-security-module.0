Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826573;
	b=VTL7s672OYiq9zhC2+5wTV9DHabtE+YTImy2b/ngrYqvrb8o/rPpB2aNRHxPhmIBw7WX
	 lF7emxwKd6sLIKjn7naFjHWIA8UOTMHZH99+dw4gKDbVewu4ZrLpgUOB/ki5xcjqMIr0f
	 KYs+Gk31FVmX20oMuOkHysv/UTlrRkZtLQ1DPc0UbNT75R5AqSaK6skw2jewTtOwRoNUo
	 CVFJTQiP6UZzgf2lC98/Mss/0wRZfC5y5opLkcqdNZkf3wKdHJLCEbF0iv2/8k1amE/Fn
	 /FhxUhbflB+VjGnZchn1D1AIwJRox1Fp1DCmBhN6CICSFOBw/AxAHGRbp0hZu4VYEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Ss5K7VdimwtEzHrJxiGNHkTNhcFCp3+4eOm/oJ/PrYc=;
	b=0SPtbRBB6EOX2AR5cumEb8g1ODb4bKp9AcUl0KP3CPz3H0DonHXAznAQgivLWKu9E+L7
	 vzmXwfmNwETnKLgCLWzKtjlwL1w82zjHPTqo3urXx9clZVeXtZ2ea00hgck8SwUbiP24V
	 pDsoiiuH9B7gCXKMziFSZJC9mvddQ+4BxIWv+qnqFi9nZgEgwzw2XUgkT3zafwXH6jUNQ
	 zx7JuqDUvM7Hh07Zx0bUrOajT8EutIn4GFVXJMd72r/QwEdvYHaiddVvCUGIu8DxephN2
	 TxEnEToFUP98U3CguxZKv1J92s59J+8fh1p0KZ+55sfUNE4xTalj69sb/HeQrQZSQ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNleuUFv;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD6607E91C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AD6607E91C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNleuUFv
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so11978565e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826571; x=1794431371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss5K7VdimwtEzHrJxiGNHkTNhcFCp3+4eOm/oJ/PrYc=;
        b=yNleuUFvXKHQO5Qgbw//ExknATpNsOSVaC3K/xU3oDknAycNLKqEzInKcKsAtr5EPf
         Qy8MqurLXPEku7zhwKGhHi4YCR163qp3/bmpBefEtKKjbDV8x5iwk319b27zPIsZ8BQC
         GQCzghEJHgG2piORnYWKLx8CwtHDbKmbwrRs3TtMEu443e9gggfO78/v2w4vdRQZAC1o
         0hGj3M1pnqz78vq/OKDi632mKvpzbuxRPbH5pe2SbA3h6whxFEhwwGwztbxcCWvFzgx7
         6K3aCYxbxH2qvQDVbouruIm7cCVVkB/GHlsvxSHaoXZM2hYIOpO55EQe8GAh6Vq7cPOo
         4JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826571; x=1794431371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ss5K7VdimwtEzHrJxiGNHkTNhcFCp3+4eOm/oJ/PrYc=;
        b=V3OVmokXxUef+8+EQCrQYAqSCdRoykaf0tVTzGLrR2gnCX1ciUC8OilYGwDJio9EEs
         V+li1DENjfypXwWE3BYWdTJ2TuUqNqzziiwa2okpg7jGK9u7gMP2sLzpSVB7RggWc3W4
         +t66QvBT79WoS/Evq816ViT8d+PJq2ku2Kp7X+1HUiuqVgJdpzz1nhq8xuQwsQ0UZ4rT
         sugNQUDjAOtcX28RN6HiheODc72u6XafmqnaXp+95BC6Uge8eaR0hKdyme+XS5FsfRaV
         DQo4Yi2E3XK/gnXXyyvobwCe+qf/g4rZIvuI8vp8s7kLgHAMDRVo3+9qWO1L789PXR5e
         nnCQ==
X-Gm-Message-State: APuU4Z/8f5xaFuTLyQPhVsAXvByC6QgV8LLGGYTUsFS9VhMPD6rb/SgS
	YmNrmQKu4+we4PiSzxDTBOhLetoZTPHHUXT/RcZ8Y9OxLUCkj+gw22xqYCEUOg94
X-Gm-Gg: AYBFou2Irx23uezU4Uah9xPfgxT6XpvVpFWYwWFjIoPYtEPF0gZwoNELxWuvWDOBA3F
	yGssTwdg0h2mLRJXcJk3WDKXzB7/nBz6Dgp55/S7HxRMDL/Ar2OBrrqAatCSAzgwZJa5VeUGNZa
	IATyC+Ggvd0RcuQ4392cPftPhqkwXlKBol50AZdIkLfa2FLqqftbpLuL6UZjXL0ZYv2rQKNp/r7
	z66LbXqpIT+DnfxotMHrPwHTk0CClevIpJmJZ51u4EGKiLoPgyQsZzftIfqR6somTFsBEDpSFjN
	WohNsYLCCtxn/A8hqgXUVJ6EzXTQnTkrfJif9j2b+Nl7zPbrb9gGIGoQBHT6tAvndB9PFhu9Sc3
	0YD3Jv8acMOGw4l+q2tSE8H1flVeBjb3+40kfJKiRvDIeJKEU3xPqFTJ1Pc07oH/zyyfsKKjhin
	Ip/JFNlO/T7xCQC5gPs0vIE56Od81Eb8uQtLlFSdFjJUH4SwG/XQxzw1cuU0/8I9TYxfb+cvZ0O
	V0GzkmL1VGHf9R53k/QyaTg7XT45cnQQAoFPtwe8WSdGIB+5V+EgPv4ps7ijdDcYDjwmADmFyh7
	b00kZ6rC7jZaCh6FoRK3cpBpKlA8p7x9hh2rQ9Q3OCPhJ4PObDd7Rg==
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ac151a84f0mr390832275e9.3.1793826571178;
        Wed, 04 Nov 2026 13:09:31 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac17c1sm5654419f8f.10.2026.11.04.13.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:21 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:02 +0100
Subject: [PATCH v2 16/27] selftests/landlock: Check errno for combined
 VERSION and ERRATA flags
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-16-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

The errata test checks that combining LANDLOCK_CREATE_RULESET_VERSION
and LANDLOCK_CREATE_RULESET_ERRATA fails, but not the resulting errno,
unlike the other checks in this test.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index a6d355807dab..9a1d5b8aacb8 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -136,6 +136,8 @@ TEST(errata)
 			      NULL, 0,
 			      LANDLOCK_CREATE_RULESET_VERSION |
 				      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA |
 						      1 << 31));

-- 
2.56.0

