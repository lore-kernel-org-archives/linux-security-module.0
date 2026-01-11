Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78613FEE
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161680; cv=none; b=XljCv9qY538vI/f9UQJoV2HOrxTa445vcSqX8MbtXbuLw6RXXE8voamlznKc+fCemm6km1GpwcXe9siAfJlxMWqnTOsmNiXagUMETNdbD8UA3PqKJO8yDQE0KSlmuj4Q5OtjzFKy3gn1o2TYKRGpqEx0e50uCn7VQXmrk44t/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161680; c=relaxed/simple;
	bh=iiVmM3c4sh15erJYZHchKd4uh+yU/C1G9LoUrE9irNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4fuVmsDhiPmrLGdaks6TCCQgE0xgcghJ8q3zhbDZJBvMeZK7GA2BTQUrcDa7+56z6fayFBvnKgdFKe/ccXxUbE3qRjV+bd9Q2DUycGNNffDec8ND1KJp4GB8ftlryDRlg/ITKjY6GNP/OGlvhmu+6bgdMU7C3gJ8MDv8tSWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOU2A1YS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOU2A1YS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso11970777a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 12:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768161677; x=1768766477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUI8XSsZZ2UoNYQsO0cmUoe3ghM1wlRdMg/slih4uxI=;
        b=hOU2A1YSs1gb44Hxl+HeU248xnAX4nh6CUsbb6O/jEvDGBfh1Y4gF4a1LcJgQQz8H/
         mTJ2JFkPiej2DgGE5uGGBery/N2dmz0CGY8uDHmrXfja0zS57xgBIzEqHYKdbFsk4eGS
         ehFGHcKXkj0obfUvJANSW/whTKLyJs8AzYqyUy9+XM6wMfK/aZnOI/lAcvTQKXpR2dsT
         2MpdAce86APHNlVzru6/A64UWYI5x/ksyMTWeY7tSxD3tLazcoQ1AuokbqIIz1y/5oNo
         jmlaZr72l65ZYMEmFEyB/BFpRMw2Fm97RVRlyIcRQWM5qjhCSdMWGLSn816gwcQ5AfFm
         KHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161677; x=1768766477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUI8XSsZZ2UoNYQsO0cmUoe3ghM1wlRdMg/slih4uxI=;
        b=iLbZoVaNrd5/yhER82NignztT8DUBZGauP/KhIumDjgsOUZZ0n466IY+1GWVBdXgFu
         ijBrgv5W8WxpmE5z96uXrBqMOO5jUfgdeDkEhYFHPlSpVehcwq7YPHYk2bdfpsc2/n8M
         OyE1eB+sZ7RQQAbA2eeGSV4g7phs5Lv2wtyKZV+WDBAwZoHkdCQzOgMrcABVltAL3eMw
         fdDG9XKO9Ik2VZOPlJqYV0cCJugR+KqGvwXlbUnjav7Vi6zdmo0UHoAmjdEf+UWDJfup
         vqzmDkmRrq55pH2eZ3TWMKlDhF04hpnxlk/IO7SfYdpzHl0ppE+dzG5CRHi+7g2afZA5
         17Yw==
X-Gm-Message-State: AOJu0YyJjJN//1/CUsuvjvH/DffYz3uJi80hHoy2OJSHnQ9oDL8QRibi
	hyLuVFcTGrP+PaC4SbasB4PXWpA9VTr4yqI9Z+qhNY5lg/pODS7SGmDC
X-Gm-Gg: AY/fxX4PCzqkWwaOpn/UvpzQMh4MPy6SafnTTBSEVE9wtaKIffBbSr6458jR+MZIaWT
	kdEfh8AsxkCPGHT4Jg6MrUxbBvH0HwHUeHVywpS2yNMH1yRXcGMgaEbkqs9c9fpKqtz5DxZ2j4h
	beeDlrkI4UsqQVZsqDG/v950NSqiGXXP7BXcVNMiT7wlb7GS1B8pb0tvlmsVpmJL442RWiVriDx
	Iu46mG12oHhOcNggLfjVeDdufPg6CScEKfCcNirRFFYoj5+ABcxJiPm46XC9jJh3DYnOuMjCPtR
	HYYSPKkztV6EyTQWbLaQ2wKmxk4E6FVv1DO0eV7mVNhC1jJEPRK5aPImbq0KcDhI9AQPriObz9m
	otG3AYLJUfxvIyEiuLRSfyrX9jI2XOSIvsLXKYMhPgzVStS7dyX2g2bRx4jGbJj6VvfjCelHdfU
	qF4m24tDe+WumgLqGqMqAr+z31QDtoL83r/arp
X-Google-Smtp-Source: AGHT+IGpLKvjHMVXpkJAJAf4e18dRk2aBrAcDfDQfV/gGzFjlrevjuSt09XlyH4YLJ1eiqJLu+vYgA==
X-Received: by 2002:a17:907:7fa7:b0:b87:7e8:e272 with SMTP id a640c23a62f3a-b8707e91290mr311814266b.39.1768161676983;
        Sun, 11 Jan 2026 12:01:16 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm1740783666b.4.2026.01.11.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:01:16 -0800 (PST)
Date: Sun, 11 Jan 2026 21:01:10 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 1/2] landlock: access_mask_subset() helper
Message-ID: <20260111.f0af186094f7@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-5-gnoack3000@gmail.com>
 <20260109.Te8xoaceiqu3@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.Te8xoaceiqu3@digikod.net>

On Fri, Jan 09, 2026 at 05:06:10PM +0100, Mickaël Salaün wrote:
> On Tue, Dec 30, 2025 at 11:39:19AM +0100, Günther Noack wrote:
> > This helper function checks whether an access_mask_t has a subset of the
> > bits enabled than another one.  This expresses the intent a bit smoother
> > in the code and does not cost us anything when it gets inlined.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  security/landlock/fs.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index fe794875ad461..b4ce03bef4b8e 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -398,6 +398,15 @@ static const struct access_masks any_fs = {
> >  	.fs = ~0,
> >  };
> >  
> > +/*
> > + * Returns true iff a has a subset of the bits of b.
> > + * It helps readability and gets inlined.
> > + */
> > +static bool access_mask_subset(access_mask_t a, access_mask_t b)
> > +{
> > +	return (a | b) == b;
> 
> I'm curious about why this switches to a binary OR instead of the
> original AND.

It is slightly more intuitive to me, but other than that, no specific reason.
(a | b) == b has the same results as (b & a) == a.

I'm not feeling strongly about it.
We can also do it the other way around if you prefer.

–Günther
