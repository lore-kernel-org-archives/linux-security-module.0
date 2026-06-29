Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91D37C0FA
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2026 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707976; cv=none; b=gMwHoKy1p/nVMhMxkXOpwNH8/p9OX4fbUXREsUAwLD+I3DcihEeRFOeWtfd+IZceDK67nBt/5AclCVOwPn9TgquBpJK5yN4cq7g3hje36b5r1R8N6tRjuC9+Ueaf9zLzi8YWLrO3LN2eJOYgIjG8ZWeD6zBx4EVH0p7WnfH+5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707976; c=relaxed/simple;
	bh=1eU+2bDqdzNluinyylphYvQVh/IYBb3LxR6xoSyK7UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8TuXyCj+dwVL9DqwXs9C66DQ69za4qAH7AKdcOtUPZk/zw6Gpi8EDVNwHaJSTshKGoFDVOE2oIoCh9jT1FIRSZaJjDoocHUph3cpS9Kaxo/J1KpwurVcRlftwqpAMtsmm9q66lu0iHZQEIHQAu75wEcj13fr87Dmhsh9WUUrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hn+E1MsJ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hn+E1MsJ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c99ccb1afso2693799eec.1
        for <linux-security-module@vger.kernel.org>; Sun, 28 Jun 2026 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782707973; x=1783312773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=hn+E1MsJrcDHw4L7JMBDRGaEVWJGa0ETOsmQqVkAezoHqRNCzAOGRuGGIvFIzzgKAj
         5WbmJiHasrXBsw2nHoHF1trp0cS9knpAh085FbvxF1XlG/DPaHrEmcR5qOONpWipekTI
         b2pmR3DACgvrHz+t5K24F1Klul23PedHMKZDFVxRkjraR01Q2lZwnkB4VEOAS38x302C
         RZiSAD2L8UPyAhNhq9GeEbgcAxM6bpc8M18GprrNeMR9TQXwcNyYWNbEZe2Iplh0nXwf
         JkyvAD/bQHrPjowwEaqS8/fiHVxRV9+9F+3y+wWGAbHlMLR/ZbracNqgYEj3tkzGnPPZ
         Cm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782707973; x=1783312773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=d8uRDLQyQh7WcU8HMrZYs4UHGRmPXTfIR6SOZVoW8u1AsR5sLPRIJtPosv4v36GEsh
         LL+dPVRdrulcSAJlVJzKMcZMUdyb9aye1+sROHBqohpnhQAbNwL0IeBIq2uUWNA200S3
         jltMvRuTycSjSgsRpcftIcVyrC/fD3XI1tT6ocTVer38M24rk5hKGPc9eR4UsyfAgClQ
         nu/oey8mPZnGptPHthH4GaQ2MDHWiVpMUqhQiefxiE5UHMW273xhCOLU0d2lPXQriEV5
         4RutTUBbNeVHoIv3ynAireKrp6SRLlnjFjDGXyJzNhkDqGe+ThGf/qHPybHFeUp/KMf6
         BPkA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0PDbwmvWzQo5Xs4J6xERonx++710jQ7SLexuDTci1d4U7NPTWgaDPcsfDSVWfi+OXJUIWwdK2tZdmkhuSAOmBzybnCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYX6Krf+lTnd1vBAUfuMtBkeFccV0amNXptywh4ivq5GZl1f0
	WQ9cIwbUUTLHAOTZTD0DjjgdbmmSlXPcMV74TTgHtgKMeA1Lb6NpyDSw1/ucbq2cGVM=
X-Gm-Gg: AfdE7ckLCvXb2CsqItyfIaBp8rr1WnGTYLJHwTEGhDCBJ1gp2CBggnAVIaRZON3bI8f
	f7iRAsPWf2xeYfE5gSwa5LEeEQXIrHAfe8AXVVLUH7TWhSVeivZCjEqJrkK9ojN0pooyRJ0pv+5
	lwbbg4dlAHuxwCGnH6Rvck0Xq7D7Xdpy2l4EvMtV97YdyLXKsf45Nz/jqH02zE0XVx2u1tmKkYm
	KbRTnLfO/ZOVTIZnypvV/7Gy3OMYmHAaCP19gJ+ZULAmz2EJkzuqUkBjJxNfVlyUlvwZYTy4TjV
	i7eRsQxrjtSM9mP/4b44adwugjlXO4EmbnGcsjGLKN2Z2Cv7Nj1HR+ZB9YRs/tfGIBqXW8Lp1XL
	yLy4zZqz87Jsua92O7XNGcVbOWYn94Q62m2wQwynMpGhNoRYrMX+b8iXOsvGtKWMHRlr1Z2EAEm
	OmE9FgZuVG2/nt
X-Received: by 2002:a05:7300:5341:b0:307:d4e7:b177 with SMTP id 5a478bee46e88-30c84f3cb8emr16773092eec.16.1782707972936;
        Sun, 28 Jun 2026 21:39:32 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30cac1b9751sm23319860eec.3.2026.06.28.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:39:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:09:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Trevor Chan <trev@trevrosa.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	ojeda@kernel.org, a.hindborg@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	m.wilczynski@samsung.com, boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk, 
	daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, 
	lossin@kernel.org, acourbot@nvidia.com, markus.probst@posteo.de, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, ljs@kernel.org, 
	liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Message-ID: <xak7wil2w2wdnmkfh4e4ijhlgnudzuh5y3ltlo72454e52tocv@434kdjz2eupv>
References: <20260628100731.64885-1-trev@trevrosa.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>

On 28-06-26, 18:07, Trevor Chan wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 62e44676125d..84802f22b652 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -1043,9 +1043,9 @@ unsafe impl Sync for OPP {}
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
>  unsafe impl AlwaysRefCounted for OPP {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +        unsafe { bindings::dev_pm_opp_get(obj.0.get()) };
>      }
>  
>      #[inline]

For OPP:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
