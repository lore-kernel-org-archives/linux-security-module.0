Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016261EF0A1
	for <linux-security-module@vger.kernel.org>; Mon,  7 Apr 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744061642; cv=none; b=Z9uTnbFxTM75bLzWVaxfo7190px3HUVfEhpRDfe4tQ3BjLMiwKDX26hlAqbZBg4KNk7TV+sqbALRG/kxDyQ9/8ScqulEY5IWSX0j0hmJiQ1cSWzfxnaEp++cVlSMyHV55kKsjYmmKaUY+wToPY5ufNRCgNjWi0M9ZF4av2TK5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744061642; c=relaxed/simple;
	bh=c1iUpbhcrXzPl8Azbq+GjxoxxV7VV/BdFZJ0L+31bsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sk6AaiJGcJkDJwrnc8WXKam0kQXcj5L1VVPo6AgMt08kIvnBKbsNVIE3anE3ceUgp2A/lobgs3pjER3YZvOWaVoCYQPqzZg3PjzmV24PIUxVdsy3nxeIeB0KUIZpffccCSNLKXKzL25ezorJfUSpW1lq96WIigQhMiKlyWVZBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dfZQRy89; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dfZQRy89"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so817443166b.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Apr 2025 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744061638; x=1744666438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ypbOCgQfA8w2KdlopYIWQGlt+OxpNY3XdMomop2Fvk4=;
        b=dfZQRy89UQxnn5a8yKYYkbPuEyiGMUlg6c9qtJ5M/zpJSajErcgPQfbUls4bGL7DMr
         Rsku9FTJDrN2o0y9b+un/p4rFp/WX8LeeyXY8u5dHjCg5iBAaY7z7imlEwbFvaCuiFiU
         AH/RNM4MA0t+ZHOT6CXsKinruIRIkx7956eTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061638; x=1744666438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypbOCgQfA8w2KdlopYIWQGlt+OxpNY3XdMomop2Fvk4=;
        b=BEBwZqjip+5TUXiWmx5gwYMaFZGi8qMOWfSfKVQffLBYJRmoTeu3EPm6HEvW2+5wlj
         EiCLH76qFjA6nZJuIpOY1sljhE5g5WblG0GOQw5KoognguY4tKdGGwi90bxXXV9kf+7c
         DP39hXt+95JL+IRX6chIMzx/b8D0qXT1+bJnpuCwDS6jKbdAycY+KkQwUdhbTgzAnry0
         LaTz3DPzQMBBDV+LI/hGQ/c1Lc/cd8OfTLNHT3RWXQP+brjd0ruvY80hEPXMpyAsG3p6
         mJaENiYe9OaJeEpAJadoR4T57laIL5Tlpb8kTQeG0SchZTlkErxS6K9dZqnwoBQPeqxn
         phPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgRtRla00wjrVLlh2r6teJFd4Lzj4CKwrx/yrIyX/8ePr5aXdQh5FZ/48+h1AjDuEbM8EiYuDrbRGHwJ7oB61o9na4PrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyY+nuyuUFt8n3X3wB/fsrIDWkuvjk8By/7TmaVsE+NXfhydI
	oehhXfTm1NBposTFI/zjOrnzkmIo4n7lZWCil6vAP4d4EOc/vdTv6JdJsZDGrVP6irwKpkTp/pS
	hEkY=
X-Gm-Gg: ASbGnct7c9rEbo5I4Ykov6Zn9yPTKXz37BK0zAkD/IPZerAGGfuMnZ3YErOV5hsPP6/
	24ulFTqdoKhLra1fAdiJ/aRyYAr2OkNcp4vfoxM9QDco/QU5xTbeb3OldLo4svZPySADVX9KCup
	des4fhH9v4Yar9jZEvmhXmILGvbB3gfTDmfFf4XkWMmUA9LG0VzElQNAVN3PK3yenc+C+7m+13H
	kywqj/QdGywrMyjKQ/Yd2lA1W1+f78hVhDVRYCnoJ+ojD2kIwL8OFOqUUkwyamArllIPUEYdGQR
	MVfl7N++QIajjTS62zlyQPWCCbpGWO7vMtChMMfuyHLUR+sc9r0SOpow0MQ8DhCUKDbUwdDzRT/
	u3/NSTTW28Yg9kBnyWxY=
X-Google-Smtp-Source: AGHT+IE2nIaQoJqirhiFnLFxrRzCiV87ncuRtIKxCJYseMFy8hjh27ajXgQ1+KuvJ5tjHFB6lVPSaw==
X-Received: by 2002:a17:906:bc49:b0:ac7:e80a:c709 with SMTP id a640c23a62f3a-ac7e80ac8b9mr655598766b.6.1744061638059;
        Mon, 07 Apr 2025 14:33:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d3d8sm806414966b.31.2025.04.07.14.33.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 14:33:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so645919166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Apr 2025 14:33:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSu76V2oEGB7WpVN5aced4rQklj9oZFEkrhTLJWuWrfgu+CKSlEIEVP7AUDdEVGUPEOvkNchzyAzY9UeL6rDa4c0kKwtc=@vger.kernel.org
X-Received: by 2002:a17:907:3d87:b0:abf:6aa4:924c with SMTP id
 a640c23a62f3a-ac7d17747cfmr1256778866b.17.1744061636768; Mon, 07 Apr 2025
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
In-Reply-To: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Apr 2025 14:33:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
X-Gm-Features: ATxdqUGKkDY0PVxsE-mkdFJ1IAX_JWpY62Qh1ZEnaMl7fepQQaa7Zys4sYl5c8g
Message-ID: <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 14:10, Mark Brown <broonie@kernel.org> wrote:
>
> Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> denials") but that commit is fairly obviously not really at fault here,
> most likely this is an issue in the plugin.  Given how disruptive having
> key configs like this failing let's disable the plugins for compile test
> builds until a fix is found.

I'm not against this, but I do want to bring up the "are the plugins
worth having at all" discussion again.

They've been a pain before. Afaik, the actual useful cases are now
done by actual real compiler support (and by clang, at that).

Who actually *uses* the gcc plugins? They just worry me in general,
and this is not the first time they have caused ICE problems.

            Linus
