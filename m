Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF42D60A
	for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292787; cv=none; b=KAOr5okyn03V7j2PSyOzZb7M18MLsQR7s6aiTNpX2X9JTzyYWKTGW2oZhmI3+ARjB47yV9NndFbilDEFhYW8z6oHif08RSBN95RmqXJ8Pqm7s3jte26bekLnRClil3Up+L4ljP9gaz+FxuCOeAVIBYx4eHdiPd5/SbPXq2ddcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292787; c=relaxed/simple;
	bh=IzLdLmZsOVhygyqZD3YHCBEAjqCi2F84E0UBopOxjmw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=E1M9kxezEmRvEnimPbxxWY9h2MNsGuNPowO33axu9z4BrwGh6cAQ3gBpqQKSAYndHOW/dq6/Q91/uoWErpEdZbNTEYGhOBJsZoYdOOSXmV12fL59TeQVb2kgm9ckq8QRJDauYsxZYANC2WxmrFycYD2uL/Ac5TGZ01Ri18P3t/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bX0e47ZZ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bX0e47ZZ"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5e27eca85so215672339f.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713292784; x=1713897584; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDc/as2umO5yOV3gBttijC1OB8STXg7uxsekpXHiEoU=;
        b=bX0e47ZZj0oeaZMfc5VJ1lzgipNg6+H7gpGnpMhGv4910sMp61eWmfwI+L+CYyaeG5
         SWruTftZ6n42MZpIlMQR9qHTnKlZCJxA9+cUvAqEjd9xxzAhQfNrBkoNMM3KWsyRIqLo
         uq12KqDgU4ikddhFkB9aG8DPR1YdVM+RKBuFBX0vt8kELIJBKgWbYYlRDPPKBwaTTqi1
         avASHPL0IAgXxl+WpxF9giKjxCH1J2MIzuGTI2sdhX9U4o7CeL/JdaPxUEOHwRgS28wZ
         AB85YZa5/hsUTBRWZYZSn3QvO7aXNEhz7uZ1vTJY8BQcG3TkzGSrKe2+ke8Dl2ie5E3R
         tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713292784; x=1713897584;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDc/as2umO5yOV3gBttijC1OB8STXg7uxsekpXHiEoU=;
        b=ZS0LEkauQLnXJsIR5AIOU7ckd816GqUdPx7KISZHgyxsY0FvXGqeWMwbKwgADHi/wL
         yjoSti84BPuEuBjCIgEmYo/wtFoFHNoKXOJxTCDoTtkSkVN2jzETUA2kOZ0D3rBrT1Ev
         XEch9hDbK/cZNgQvvJ0b5mSqZ6EGmYQ7aHPjyK82GXw0bAurSzk/QZ0JXpfGAKO2Jtl9
         bP0oq90lRUG1Ey5Q7NB71MMLnUDG19ndRK5y9DuzW8jmbwulJkUrXbLZHS+W+oPUUdnb
         y40b+NZG48tv7pVKoKkBK1OO23vL4KNJLqcZP8yEDMPwqJZi2mWEVKx/bDtawW/nVrbH
         KR+A==
X-Forwarded-Encrypted: i=1; AJvYcCV60g9fTFdCx4jPAixvaENPY2OzxS+62VqMPO+ZtzUDAXPUMOA9gykyhwrr01Pu3ARo+6LPKpDZ2ScrdW6XhfW5TJZI9QBRsZ5hxxL3rO3IcGtlw+SH
X-Gm-Message-State: AOJu0YwxRwlENrdk1U5oIa0yh/Q9a8nqkqpO5NV2cL1MfgEQO96RPY47
	pcyW7J19ISx6S9QSyAseRwyZDRcMK5fgboKNHmvuhwps3jFGl1W4/5mL6fpzBQ==
X-Google-Smtp-Source: AGHT+IEaJMfAJXXS8ckHiwVn4d6kqbcwJ2mTV3WxofEHSRHnhHOkrySCakIjaRhnVZOAP/6qvsVDBg==
X-Received: by 2002:a05:6e02:188f:b0:36b:83a:557e with SMTP id o15-20020a056e02188f00b0036b083a557emr17264150ilu.17.1713292784088;
        Tue, 16 Apr 2024 11:39:44 -0700 (PDT)
Received: from localhost ([75.104.108.48])
        by smtp.gmail.com with ESMTPSA id bm6-20020a05663842c600b0047f100b70e1sm4113540jab.105.2024.04.16.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:39:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:39:37 -0400
Message-ID: <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] cipso: fix total option length computation
References: <20240416152913.1527166-2-omosnace@redhat.com>
In-Reply-To: <20240416152913.1527166-2-omosnace@redhat.com>

On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> As evident from the definition of ip_options_get(), the IP option
> IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
> the loop that walks the IP options to determine the total IP options
> length in cipso_v4_delopt() doesn't take it into account.
> 
> Fix it by recognizing the IPOPT_END value as the end of actual options.
> Also add safety checks in case the options are invalid/corrupted.
> 
> Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 8b17d83e5fde4..75b5e3c35f9bf 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  		 * from there we can determine the new total option length */
>  		iter = 0;
>  		optlen_new = 0;
> -		while (iter < opt->opt.optlen)
> -			if (opt->opt.__data[iter] != IPOPT_NOP) {
> -				iter += opt->opt.__data[iter + 1];
> -				optlen_new = iter;
> -			} else
> +		while (iter < opt->opt.optlen) {
> +			if (opt->opt.__data[iter] == IPOPT_END) {
> +				break;
> +			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
>  				iter++;
> +			} else {
> +				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
> +					iter += 2;
> +				else
> +					iter += opt->opt.__data[iter + 1];
> +				optlen_new = iter;

I worry that WARN_ON(), especially in conjunction with the one below,
could generate a lot of noise on the console and system logs, let's
be a bit more selective about what we check and report on.  Presumably
the options have already gone through a basic sanity check so there
shouldn't be anything too scary in there.

  if (opt == IPOPT_END) {
    /* ... */
  } else if (opt == IPOPT_NOP) {
    /* ... */
  } else {
    iter += opt[iter + 1];
    optlen_new = iter;
  }

> +			}
> +		}
> +		if (WARN_ON(optlen_new > opt->opt.optlen))
> +			optlen_new = opt->opt.optlen;

This is also probably not really necessary, but it bothers me less.

>  		hdr_delta = opt->opt.optlen;
>  		opt->opt.optlen = (optlen_new + 3) & ~3;
>  		hdr_delta -= opt->opt.optlen;
> -- 
> 2.44.0

--
paul-moore.com
