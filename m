Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099702288CB
	for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764658; cv=none; b=pXDrdEAnx88ilJbb9T1zjsrqCfJbnMWOA6WUyWxuRMkU1MCLdt3LTAqt/Nkd88BwCz7EVtPQeygZmwqj6ndGbzeeoOTP5TiPLrGmLM3hOkm3EPYJYcswNgxcwlCqlRwrd2JDap1w3MyhAv6FCCkJ8pCWeDZ8CXlBNL0pgbVcWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764658; c=relaxed/simple;
	bh=3/GZ9NBzTd5IHqG7cl0sPpOFpf06ERzklsy67cpYPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWQfSQ2unNgT4XZ3oda8UpTI8GstngFFcMSWlxGM6288v2jJi9dfZkTGuAyY9TF+WeLEPFbYAtFKRmbO48qTECBr3CGRBsUP6I92+xSQBjTZ01MOdBOas/OQVnHYxwCKCFNitz93JHGM2HBgivZBJY/qfqXOcCZbPVRxtkeilEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBhR2Tyo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBhR2Tyo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso3171615e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770764655; x=1771369455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PWTFGKfCLdKtEfJkYntBGZoHOl0ouI8SBj5Paa8dlU=;
        b=nBhR2TyoT7p9iOdn765sNe1Mowdjtm0uI/m7outSzHq/yajYbMaK81daibdKJm8toq
         z66Fm0tbWXmT3z/ByJ0aSI2n31dpLe/Ev/q3FNc/dO53E80lvgV1W2wgCCz9H1iAQSFM
         DeJ02JP4IrEULijXcYcB5p/kO+KBE1w2rtlCtaiFJg+KNiZMrLdYfkD2MSykFT6OmIJv
         91YoTqxuR6msCKX57cbnEO2jHjrL+vWy4FdTaJKKsjCSjV2Uls2reaJUHy20VajRSV8R
         0lxbeiaeGLXwFJJ2X0bYZ0TH7gtGtV1NycIV6Z/E7AbjYjgkXWQUo1pNg2xKYWlNx6J4
         BKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770764655; x=1771369455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PWTFGKfCLdKtEfJkYntBGZoHOl0ouI8SBj5Paa8dlU=;
        b=E7DW+cZgoyB1bcW3AWFnluucZdSCaU8ysUXCpYXC3AYQaDzi+alXLVSOauINPctPma
         9/lpaZrSLIprxJhKp7kLHDNpeRwSaUYyGnLll0Hje1FnsxmVDooB/uCsKoYImqglY3H/
         fr24ZaAPzW3Zb/xJyWeq5YMFKEzMDeoJ4JFEUG5a/sRjuW064dE5uIeBaNtLcL90HJWC
         Jr0V/mihiBjCOt+cvfWlE90t5s+fmS5qMfHoVKEgNT6xrYKKk2135AkS33pUiwtkZqlV
         sF6fBQb+M5giy4rW7KEvECBrP+wivzgetAfkE83g0f55/vRXIh0sSF65M9eEQJlSinw7
         YzGg==
X-Forwarded-Encrypted: i=1; AJvYcCVAPKvSr5taKkM6/mg73jn4JAPFxjpMHV/BCNuMhGsn6SO0qgXQC3gjCugSNoTP9BFQ+LPabiSxUjB194jDrjrla966vio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvSWaYZ0KQwwhgdaQ6jNkDZQtKeDW+ihZhvO9iha2/NXDxfVQ
	gQXlo97sn0HPKhmI4qFNaYBscYlulCFkP+4Ku4owQJA0bGCIyk0/ET8x
X-Gm-Gg: AZuq6aIF479JFMiFDXthn7stw4GN/5YydRE/SbgyRd0EJqse1wKe4VeazWGqDtAVxdb
	7+yM+9aOr30MrnRyRIplGPFkrE3bCje0jVHnQ+ACnasWJGjfbwMYHHROk5q0M9Nv1Foav3L9aox
	YSHkyut3o2pjp7gIjlBjXh4Keg9eq6NW5YHh5bw21KWXW694+YNCrOHUzjO0SWxTgB/lZ1ZjFEy
	JX+2V9vDokEvXOrRwx8o4Z9zEab4QKTQZeFGh4eBxpPkC1qXyUp1KSzvQP6dKs4gJAOUiNAgQCn
	jqEC70+vgpc5V1XjeGdVbz5IJSaC38nWv5zTNvOj6RgJZxMcV4VIDCP7ZZbcHTgBtOlH2XK58oo
	Ig+iX37ccq1CM5q+3lwlLTjEDo/p12U0OfLzwpVm+YL3+1iWfVDNjc06UrfbPAi15uNBlA4QE50
	+sIbGHfaLgDN2zRf3O08Za4wM9S9PcF/QDyWXybUOVX0HSaspR
X-Received: by 2002:a05:600c:548f:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-483505451c0mr55269645e9.13.1770764655050;
        Tue, 10 Feb 2026 15:04:15 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm140814575e9.1.2026.02.10.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:04:14 -0800 (PST)
Date: Wed, 11 Feb 2026 00:04:13 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v4 2/6] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260210.9d416a5f954e@gnoack.org>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-3-gnoack3000@gmail.com>
 <aYm1RWtV6Af-zEHf@google.com>
 <c060c613-146e-49eb-b9d8-da28cbb680f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c060c613-146e-49eb-b9d8-da28cbb680f7@gmail.com>

On Mon, Feb 09, 2026 at 08:11:18AM -0500, Justin Suess wrote:
> On 2/9/26 05:21, Günther Noack wrote:
> > On Mon, Feb 09, 2026 at 12:10:12AM +0100, Günther Noack wrote:
> >> +	/* Lookup for the purpose of saving coredumps is OK. */
> >> +	if (flags & SOCK_COREDUMP)
> >> +		return 0;
> if (unlikely(flags & SOCK_COREDUMP))
>     return 0;

Done.


> >> +
> >> +	/* Only stream, dgram and seqpacket sockets are restricted. */
> >> +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
> >> +		return 0;
> if (unlikely(type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET))
>     return 0;

Not applicable any more, as I dropped the check per Mickaël's review
in the adjacent mail (I do not think it makes a big difference either
way, TBH.)

–Günther
