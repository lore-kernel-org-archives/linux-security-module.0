Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826582;
	b=Iez/6ylaleo4AQus5WqtW6xK0f/EnCNPScCwt/QlxIwz/z8WRjqbTfKzaHmndl4wplDo
	 0i/ldPCWOaTXlT8dU7KGv7w0L/r/VrLp35GOKPKwdnmX2GLelS8Wqe6WIUflS6tIo5baE
	 XpMQKfOKjDM19tfT86ui6JuPTXS3SluuZniW9EaVwdK2kPXB0L+1QF6LcsO3MmunUNpCC
	 CscOtI3DGdQ/QymcSRk0f7WhtksGwvyP8wWvJFy+Pzd3LtT2rLAoqpbKtiH92LAcGsn5O
	 rd9gR7KxOl2kl1XjRDA9nICaizle2H3UtD3cRY/oAYpW5jFXaKsntbVZvX/+UD6RCFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wGIoR4gp9in+6KA2rLo+JQCdAPIELIZ6U8ykblXyZGY=;
	b=rUujMc6W+V05jULr/GN9VaiRosg790e06fMs0Bx79ZFb6ybszU7jG+I/UnwutZ3+ENvo
	 PUfiQ5lgbMGgdtOEon8dJTCLDigVVGmxvCqm23bSXG38ynLa6RIrJoIg/C1g5r1CyUlK8
	 dcd3m6cJPeY+qe+UUPqw/UyhfSAM/Yk2rCSO9ginnnc8+0xLz3klF+/AcZSdRgeNwvYKp
	 T5XAPCyzU6lNSvetCE1+R7Z/tdIvSHmrTyH+m0AXsjOoYZJpLPXVAvy7m1BEeYaU4a/IG
	 be0uzF4K9heNxSucnOl8wNt5iVOwp8xx85VDLfAaSa+XaOt3iPRY8Kg9V5L0mAFfuDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLfxyyNn;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD742607F2A8
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD742607F2A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLfxyyNn
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso554495f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826580; x=1794431380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGIoR4gp9in+6KA2rLo+JQCdAPIELIZ6U8ykblXyZGY=;
        b=MLfxyyNnEZcm5BNvBQl93qnqyelGby9KG1DmschMbVmDIbOW54mBF0Dkyzgm7I3hLG
         gOeX+pS5P1Iv9wi3WpVNIjLe0xoOtkzydwj59wN2x255Ea8oVvyJSmkGqNsEmVH4cfpw
         aMdQYaplGYqM/tHOEkiRPHKF2zCJPv9ex0HBmc6Y5LCioAEYXXzkN77/o1/EN1JUa2mE
         OjLbY4dlqZiv/f/6CENHFs8d3nXO9C9N2DKIebXsTOMIibxvHv8JmbUmAV4RS7X2s8JP
         LHT6qJG58btj+Pa+EVsCsDFQRsKkAwIBCSChwZOAsX9FYfRQ58RktUM1PM/KofiigjbC
         3gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826580; x=1794431380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGIoR4gp9in+6KA2rLo+JQCdAPIELIZ6U8ykblXyZGY=;
        b=0X0sLh56nabQ4+Ej03oY9XFGekwKP2CXdPfKZQFjhpMJrHkjAU0GajtbmJxuaNg7YP
         bH7bWjT7Md7Gtn1cs+G23Fzb6tX8q1B0mbMjZILuoXtZXvHnGGpU3Wmz5X1YJZP9UTDC
         k63faMVGTggskEci/R635IIzblUdwJcs6dyum2rAdQZRi/R3LVph1JW0LQZo8pVIJJo9
         Exq9vJpqX7Wqmfrm7ZBrgEBJ5aMvcOUubMnQTGxy+T//9Ev7s/QC/AeOqHkrC532yph5
         rS3BAYu74Ot4r3IWovi5y68raTxUisbXlf0vyiloaa1c8tLTM9AXGVXfk0J4QXINGo2K
         Dsqg==
X-Gm-Message-State: APuU4Z9tTuv2SKoJAF5WuMk8FUaoyUPE9dUWO+5IXdR0I4A3sZlBZBpP
	zdDl+a/CM6pgKYB8qnxPL8kEbhzQBHQ5zyAHShX0VesEUuZKawrRC/dg
X-Gm-Gg: AYBFou0bG3GCH5kpfMXrxZslJqV4B2Cqau1a8CSXVteH0lODg30LkcMXXReklga196Q
	Zl9niMLWNhvsn3HuBhmky6V/Br6N7FX9alwHOq9CR2/D7Hrj9YuDhUMknInkTVq0TCEXp/NdyyF
	ttOYoEkBF7xckMvv5F9V3cNuH7iSScYB50T7Q6kwctP3hE+Mo+OO0/QYiO97WgybB6Yeb2GW7vJ
	K7TT8TXyNrAldOsbn/CWSDsEYAb1rR8i5xR02JTSQQ53DBNPFPt5UXorXYpjR21xapyvQCvvS0i
	kB6ytNoNBnqfuL0oJEj6ZxsUz666a/756mHMCFaUUKrdKQd80m+7bbcxl2snu1gvbEKlOyeaHdX
	t4uNz6t2rDPmYlb89meERtMV7YC7V6tNMhjSl9QGdoM5qjsC0+MRhT/Nr56I8My/Cr3MHwowjaG
	ylN17iE0feNVdZXs+NK/5dsxTvl+rwoFq6tSKEGAa7UNzTQvBbrkutH59XKks0ic1ddLkbxJcqS
	SaKZYPR4Yn9gerez2tjbUY4v3c8erReEa2dY1gKiEmDAYzx3J1GKmTftKuh+UJ672P5UsNc/naN
	Ou4r3l126Ir4iu/uxON/gHFcB3d2jI9UguwYLq6S0/n5SrDv9qg4Dak=
X-Received: by 2002:a5d:59ca:0:b0:48f:bcf0:2026 with SMTP id ffacd0b85a97d-48fbcf02289mr9041398f8f.13.1793826580198;
        Wed, 04 Nov 2026 13:09:40 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm5568567f8f.52.2026.11.04.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:40 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:06 +0100
Subject: [PATCH v2 20/27] selftests/landlock: Fix the snprintf() error
 check in matches_log_fs_extra()
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
Message-Id: <20261104-selftests-refactor-v2-20-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

By storing the snprintf result in a size_t, the chunk_len < 0 check
could never be true.  Store it in an int instead, matching the return
type of snprintf().

Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10a386a573dd..1e94a3171e02 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7449,7 +7449,7 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
 				     (extra ? strlen(extra) : 0) + 1;
 	char log_match[log_match_remaining];
 	char *log_match_cursor = log_match;
-	size_t chunk_len;
+	int chunk_len;
 	ssize_t escaped_len;
 
 	chunk_len = snprintf(log_match_cursor, log_match_remaining,

-- 
2.56.0

