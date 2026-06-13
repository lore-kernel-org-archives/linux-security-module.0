Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8913E6386
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355870; cv=none; b=KBnC+OnajpG4Jl4z5prUcgCJApiGP3AlXd2UCE+CqA51KVurOoDayPPFWinEtyMxGQ7EJgEb4Mg0FRKH0z81M4QCJNlzSqVQRY5dtjdfS7QQZv1a7g1riPtkBt5dsoceLEDRP4a+ng8kSy6yep0sFCaqKQtOb7QLECXPNziYiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355870; c=relaxed/simple;
	bh=8rdVy967/KIekFumWZJodjNYinOgWN/JZjf+3u7FmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbZk62DmUIJKbClZDBfDZZ9FAjiXnSJc4oXf7Xu69ldjfHLLdhJfjf5dLBpBj8/vemDbWAggd3vzaA7+i0tHKui2ZR8kACeSyICulbMBg1wl7lTKHKk3ZibefXcQOuhHyAJ3kEEz8TaZNut02tTJRmS03U0CK3sO5TJFPJRQ0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8ID2Prw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ID2Prw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be03d47bso18676865e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355868; x=1781960668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=n8ID2PrwDMHD33lC0HfluqTgB3sNLcduK66hgkPgk4lz3G1OV3utNhHABA4/xzHoNg
         /Eju2lWceIX5YLnpV2IcDjvw0zlEFSUu8LLick6NRa2htEDsdTTREC/j1PsNGr87Cfu9
         JjBoskdoWPdv6jcu2TSMHmDHd0eLCzCqgX5drNOWuD3CgZRjDF0FsJQT7cAmv8nIsIDU
         6KHCDGrPry4mXvXlUKtp9bsXE7JTDSQjSeg5Y3jSasWoKwuRvt+JiXIihqFrNkmG9M/K
         mzBgeE0sBFZI5FXrA/v/s5urL3BOjqXlZ8Uqh2maEBPIpZbC7qt4rGEr/0d2DtaijB0Q
         mvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355868; x=1781960668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=r8BCKb+7SNT/ldR7YWYw8hkk5SrzfLXruckWvpM/ewxZkEbmyRbsrWl9rFuB4DXvIA
         TWd94JGsEoTG49B2eiHlcIeV19EWJgmg/2osGPlygG/bn+xhCA6Q//Z5KAq7d6vAzZy0
         OS+Cv32vXxt6c61uDJEcIlo1GcEZEJ+JPjUMYPX09PX2UKHav/pb/azTHwCVTUIaiNb7
         itvejETGgVsf+jOgU1Q27yMH9tkJw0WrzM2FuG7jUakR2LefvG+ak6Ie76wCFHSxtDQQ
         +YPafqsOF0D+gLfWE9SN9okCTvBqMPU7j8PFqfnFYAG8WdVkDavhmIfdXaU+2QpzKWbR
         phbg==
X-Forwarded-Encrypted: i=1; AFNElJ+CqDvZuMHr33WOE7DVNVPm+ElutRRw6kLAsQZ+m7aVqp0rhl488292c1qm6weeIPWY42LENe8fm6xriYUfFKzK2LutQRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi58U08m2p/JLPuhGmK9G5TKOANoSrn8z6Fc9pAZw28VpgdssX
	Acj0K76tuIGqN7Y5Sj2jgffJBCDv1lmNk54Hr3Yzb0zBcwhddjIp9ns=
X-Gm-Gg: Acq92OGmhOVM0Fgb5gZbsFTuFMX/Vm87Pc4CZiXBwzZ6oCF3SLuwRdDXD0nWqY/K2L+
	2Dac71DjLjZo6qcdgyQShnEtGbP8jr6ELV7d7/OdGe6qUQjhDTQIbClE/W1YKz6t/Ux7EvGJewz
	s7xN4CipRiYV0PjZF4kuBAuf8fKCvPgnJlXB1KDfhgnU2vsIGczL3r3iEPKuOxKLxG9s+OHMLOW
	eP2qhXaKJSe5F0ErA0IExUDoGnoYOeE/n+7tR+Z28TZzR1E77EQp3mw8DqSJd+uOJcUN5noK8xx
	l6Ud5o+zQDt0YGSqf9EGYFsKJW/fLs1bMyQrYImddtx6mOZ+dLDg6/hCoJt4cS+AmNVQVerX3Hv
	8/jrSjAbZJKUvjgy9RVilDyTUCODseUWjbnzDuyPbZXpdQncbUPxftEdA6XIZ3/wRQpPcRE+aBC
	IOidBJMVXhDIAdH9XTQoKq+/WzXzO3ihsTogQLl1d+5rot+oUeKi5KgqbmKPhhoq6pXeiy5Mi+Z
	7Z8Qz/4Ai37nt5onQlVpTYkxQPatQ==
X-Received: by 2002:a05:600d:8489:20b0:490:b724:507d with SMTP id 5b1f17b1804b1-490ec4cec11mr64189855e9.11.1781355867847;
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 1/2] keys: request_key: replace BUG with return -EINVAL
Date: Sat, 13 Jun 2026 14:04:07 +0100
Message-ID: <20260613130408.13709-2-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130408.13709-1-med08elkadiri@gmail.com>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in construct_get_dest_keyring() default case
with return -EINVAL to handle the unimplemented group keyring
destination gracefully.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/request_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18..fa2bb9f2f538 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -332,7 +332,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 
 		case KEY_REQKEY_DEFL_GROUP_KEYRING:
 		default:
-			BUG();
+			return -EINVAL;
 		}
 
 		/*
-- 
2.43.0

