Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843D1DA0E1
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274874; cv=none; b=VNBVhiccZ4tc7AtMU4nmsh4iSkPgpV10bjEu2jzrXQxgbN7iKaE+GFY5oJczaIEOk6vN4zN/7lT5M1xJgVsZJp0OuShbc2Yp7vg8MaWOe20AL5gh9jdtC8YSVbsIhNTCWOKbnm174yS2LNhofY0fYgBtYqpZjYdcn2Bsx1tW+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274874; c=relaxed/simple;
	bh=TTGH7CF+awpVkjkg3DD+EpAYnFPQDb7pV9ExIPtGFZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8dtEDdAwf1lniVqKzyQbvYNVIeLo+Gbg0qGWTMCKfwaba6RVYxAJCgqSgG2Wtv5z7jNRebfmxYF6glp+NsacikG6+X3X44QnQkdeBjqiTLjAaOY1sGgJ4LUPVGw86kHIf53XWOH7YElQRWUaIP+5RBIF9mvJzrbjOr/LjgU/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxRailP3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxRailP3"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so13610952a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274871; x=1767879671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NedCTQV+XPHIad3pX66g0tEvbeylFKyE2Vce9e3S034=;
        b=FxRailP39iNsVmq3EKuP0A4ztgkRzXuURrfNiPZcFWnPd8qYSkQwYJYnrcDudHD/cv
         ss0KyH8sgbGAboe0kNP9WcGffpLpybsfiN4qPXrS+prQ4mCYatJd35r9XFACApbkRZQK
         GyqIl+ae44QXcvpvvq72CqSO1gHYp1wl51lVICo6ei6PQPkWO9y0umDXpxy8M9RTh3Iv
         R6b8s4pu77/IJgrvP2O8YFOK4gk4MWxDQtknikxSK+X+2ySkzFwnrMWKhj476u4rfkxZ
         7YxkyubW/gLwkvhjLwmXktxQTfekIzo1mP+miiKKaEZ5mD2lGcdRSpv59xRy2d3St1LP
         efSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274871; x=1767879671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NedCTQV+XPHIad3pX66g0tEvbeylFKyE2Vce9e3S034=;
        b=tt/X73UBW42oiy39gmUODdyVPdez68IOQS5jRbCq1HoDXXTdjvj2QytPxSvhwenvQq
         LGn6iHBPTA+MMYPrEzx5mwebMb9wPMS82HZZW7+KTCu8VPUd54zBRfZVAC3QKxxkye4P
         qrA4JEfHEr6tebiyb71YXh47KMn137+D1aGZ5G0E0EcTv0EQIfwT15BThmRvlEVGWIl2
         buoTUTUTnrjPl2tYU4Gt54SbCr2yG4xSeFSPY6liwIvYJT/k4uCHwKvwCqHoCUYEQ9FH
         oqVVuzDU35GlS0ebBQ6VqZPi+hPDu/H5sZNFQtxLygM/dBMNSgBFvIg8OMugarlI3mpG
         E4sQ==
X-Gm-Message-State: AOJu0YxrVk3a5meyZ02JMiAdAKoVgogd4QPDZinl/28trADowQ6y59sG
	Gxdzv7ZvIx8S8LH9G8MDqOzyAeAkLWNO8v1SnQGLVH1Rd/j6OrP7OKAZ
X-Gm-Gg: AY/fxX7+mCvvwlW34JF7IIjDfGtOZlR7n5roml6yVViQ90lKRD8jb1YaM7Rut8a3JEb
	aKJrfpdcQJRQ8mVtGB2wbJtPWuEjomG34DV28X0dMZzOdGDXOns4VL8e9p14Eau5paAVokF8JV4
	LMku4vUumt5nffE4wl6v3Ge3d9Qn08cfIGYOBlIEpZSTq7fVEhHNxYNDgNtqj7MX/ozhU+lJL9i
	IvM7UleZaNWCzl6P1AuJ/7hN7w2ByjRvmnFC8Zsy/U1YICRVn09yJGtipxlLd6BmT9pfuiWvN5X
	xmrRHctwTIrhsPYNAYgFP4Cq7/ztkxCyblA3nSIsDpdResC2NQ7oGa6ECcgdl7xn+vWdvO8Ui1p
	hUVPBh0Wy1hXyxpWGtnKjO94RwAi2UwnV6BHCrMY7g2VFOxzj0yd0u+Bvg4vWgDCLlykfWGvj9D
	Y5wa9sAGWiDrkERhp1CCxyRGBkermyqzQWfwdN
X-Google-Smtp-Source: AGHT+IHZpF3IpX9gfOvHHIGumldaj0WCM/DbfIUnVDbRQ0zMpS9kbulfgEZBN1QjPQ608oE2K8PsmQ==
X-Received: by 2002:a05:6402:2348:b0:64d:65d:2314 with SMTP id 4fb4d7f45d1cf-64d065d3f0amr32519449a12.23.1767274871038;
        Thu, 01 Jan 2026 05:41:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105a9c4sm40880504a12.12.2026.01.01.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:10 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 1/5] landlock/selftests: add a missing close(srv_fd) call
Date: Thu,  1 Jan 2026 14:40:58 +0100
Message-ID: <20260101134102.25938-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 37a5a3df712ec..16503f2e6a481 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4400,6 +4400,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
 
 	ASSERT_EQ(0, close(cli_fd));
+	ASSERT_EQ(0, close(srv_fd));
 }
 
 /* clang-format off */
-- 
2.52.0

