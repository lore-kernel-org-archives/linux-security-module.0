Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB953806CA
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003884; cv=none; b=P53pnzH4EYe4WVfFiO/M5FRSuknQQKPr9BBgf9LQByMd8Bl0SeSm6B9PHZI9+WZzJPnd0VyDKTeiWEO/rTirZDv6xEvObEWGeuYQRylQQhlp2HDPOYMotjkG9MMono+no111HfbfuaCyeIS4MDYU+W5fqPo76Fr5/7YsRbdDtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003884; c=relaxed/simple;
	bh=PVOsJ2scZCwKamLRKKCGFurJxX6DrE4y9M7XRORQcmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXiK5+pgc51BpB7Sad3fl5zBIfD18MEpuSt9NHEGHkEgZlJrmzDEUxkFEkziY2QQT2Wsk3SuJaVV3O3D2sJM7LW619dvTlYOEdTBIe9RKHmhjlmVSZ8zDqHeQy1m0Kn75zQ0DT8UmjbGl08vapGT/cdPFGqA+jZSRNH4d8LsVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSatQTqg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSatQTqg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1268347f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774003881; x=1774608681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PVOsJ2scZCwKamLRKKCGFurJxX6DrE4y9M7XRORQcmU=;
        b=TSatQTqgnl7ieT5Abp/5WpBz6GDPIAvOKx+bHlfjyR17QBzwlJbO3UmyRUxMmExe+p
         8d2vZt5cfaazvFr3Wn9fH7RItRSPd5aVSXAKE5AGEA3szK7hShu8PrPyeiknFNOeDzPs
         +lYTY6AbSLSrvhnUpLUfaYLMyVQ+Liu6P/15hgDSRuto2q35Q6mhvvw+gOygj+ndruTP
         VK+ld3UB0//KYeKjhYTxouDKj5tHkJV1+cQjnNNfiRuyWkOqqOEU2PkZkoKo+OlR+Z9W
         YkkjFBosC/SjlvvjLlRPgSYSv+RHptWROqVhhZj46MtdNiY8nVj2k3j2/TeV3LwrrMFg
         CPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774003881; x=1774608681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVOsJ2scZCwKamLRKKCGFurJxX6DrE4y9M7XRORQcmU=;
        b=B055APLFgTlPYTJSy6aaHdNQX/jStQIOHhB1iuWU9fLvHesFDUa23ZGrZmFyN1k5Ku
         kyZhrICwFHUtemYsOwHbiwB+QSSjZW4GCFSPKr2dc7aX83E+WxjIUaeFj/DJvQn84Nse
         PuvV7OavqY3MR4uWddM4EGcK+soIYb4suwFxWwfCv5Itv4gmwCjd9UAJuHEJP9bHtwdK
         qHj+eOy7X5dAvpqfq6q8P9i9aCDLuiUOQeOLZ4aJOSSCsxcP5fWKvKoYnfBsoOhwMj16
         ZzyOGID4if7RLPPJXZmxnfNB2+gDgDsnWyOViAO+phYilb6TR27hrUtbnP2wHsSIMjJL
         muLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNJnzzqDoRVpHOpC1RhJ5xEhdmFT6c6e4ypuWvV1n4j4kp0RKk5ULI10eNxLerM5AyKmaFYM2aQKvKGWhxkzjSX1ob1B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytW5DnpfTfelL0TiP9IHd9N2dCB4+UdxigineOtRS2bo2FMHfi
	c1/HMjYyF6LQYhi5+HsHnvP8bSMWSAEyHAiQ4eN+beUyNONW7uGB0jVRqhFoGUCA
X-Gm-Gg: ATEYQzzsu4TvrojJOkKNiVA5Zfk9syP6hXBrCOR09xIgLFEdZ6pu6aH1RZglgvazb7G
	fpinjgKq8lrH76SHDdKtmi5UpJSLjdApEB5N4LUyrCp3J1LHslWR9iOJDBfkgT/AKjWRTlOvwno
	0xdkbvJL0wm50mxIuLgqVSGOSaSDj2atNzZPYxwbDTo+ldv8FX6smA3OTll31lUDiezTNmKdcVk
	1Tg94iVBwHH8pOFlPy4L0zvLqwiqQhU8DCGL8ayy9vH9/trslRVx/USkm/cDUMqE/zhjyQnQs8Y
	qiwntynf9kDyTbrWllybTQw7Jk3xZ/YtYNU+2fEg4pa2FuXbyFwMGMAr8tSF6KU/gQoqI7Yh90s
	eLElrNW9w9cgHHXrdrsTQ5VsYKea5fL/EC6U220+hMacU0hVQqIVNyPr6mz7FsYdR6b2F0iMPkZ
	Rpx0tZd9KrKYvjRAwTTTJDIc5M2+odFtfq8y27v10S1bHh1FH9
X-Received: by 2002:a5d:588e:0:b0:439:beee:43aa with SMTP id ffacd0b85a97d-43b6424e655mr4384451f8f.16.1774003880816;
        Fri, 20 Mar 2026 03:51:20 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bce6esm6203862f8f.9.2026.03.20.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:51:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:51:19 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 5/9] landlock/selftests: Test
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260320.ccb4216a1fbd@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-6-gnoack3000@gmail.com>
 <20260318.eghahf0Chiez@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.eghahf0Chiez@digikod.net>

On Wed, Mar 18, 2026 at 05:53:15PM +0100, Mickaël Salaün wrote:
> The subject's prefix is swapped, it should be "selftests/landlock".

Thanks, done!

–Günther
