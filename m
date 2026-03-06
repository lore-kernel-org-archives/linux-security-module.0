Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5E375F6D
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782764; cv=none; b=rWaHSZOXdDFmeWcP23fgUpdm1ZhnOcV+RNpcaysLR0W2kZz1DQia7um8kJtfkMrkOkQKvxpSRQj24Au2A6JHR2Djz01TrCWotWImKQx1GwwfIJ/T8N3OAjbHzcJzpxBjtYtwDW6gIJHjNf+NXeDEZ3jC0s4XaW60IZa3p1MU8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782764; c=relaxed/simple;
	bh=LsiaEhFEbUFcr4xQJsjYpjqGak+SHaciMtabg7FyFkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hupsWnk4TcSsRezOy/WmHSBJhckOwPB+2fEm3UyD+TLdqrKwCibNK3QyYrVG2WeQZIMUE1qP6ZqA1nEbsTBIc8laVqJ7AxFOLcyZBl+S9o90aEaXp57baeLhB5NgvjHO1uKBOSlXy49sdhhfRRSPlOGGOJvDDx3ba06cOGFlLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2vfLigH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2vfLigH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c4bde55cso2165314f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772782755; x=1773387555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VU7aFuzXhy/96p+GZGAPRF1MRq2ObV6C4oedM2dkoeI=;
        b=Y2vfLigHX8vcahJ9hcP9asRAyNCmK9X6gAB0PZycVig5J9rB8eSd1Z8buJdMRow2+N
         77HMi8XuSjKLwAQdcRLvlhtzylZ+ybi0CSfXFsh3Qny2ccUV+j5zT16JMzkPFpeTz404
         fNu2GD5RUjeWIcBpIB3s+xAwasSnqJkEHFjEACol7gYcv+dvvMNVgcbqqmG4uZRe/+NW
         Irj8ZN1gOWliPdGDVfoTqNYk77WkIwcB9T6J3raC2EgzSU/ml7QzZw+3oUgxMAHpL8BC
         z2zc8aTqU1p0IeOYB71Q/d0lvPQQFWvQ/faSlHhMEN/CMmi+m01ucvfHpw6/M4GOTw51
         nt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772782755; x=1773387555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU7aFuzXhy/96p+GZGAPRF1MRq2ObV6C4oedM2dkoeI=;
        b=lI1zK141/Us/o+XD8zv7ayTYhKZls19QC+/MKwN2Q/HYArZQ5J6BYUd/kf65JZbshX
         LLhrg5otcgODrp1Ng27wFb1eZBfi3FtEwi0AKsB81Hho1K6JrsULrB800noeWWxqvuyk
         uQn4kaflAhoFBdpdXoKngCJwy6Oogmb3M9GS8OKhN/Ec0QxMKWjZlOdFVs6bliO0qJdS
         iJGtlu5DUfzBWr2X9b8XVR1YKnjS2kUQ8JoeWvifwaogf0/5Ws4jIKIUj4amo4UCzkkG
         Q+QrbTqdZCdcXSojKDObGxfp4bPsbhF627MIOAAWeoPNz9P8lcx5T70h5A7C5TeaW0RT
         JbfA==
X-Gm-Message-State: AOJu0YziHI3PVvxdML9aSPC3E7dEVKyzTaA4/JjwvkftUBMcrGsIGpnq
	R3KgQVS9zytd0N50NcFwp8z3e8HIJ/tHUuZAV+iX7ZjUddiYSeXYOScY
X-Gm-Gg: ATEYQzw6YV4XfZogLkPdnUCxIj2fJf4+QECdw7c7rhpAwkWyvIy6M1t1vxuLNEmbTs9
	+vtEYeLEwvMhIqq8CBMGDqEideas+IpzKpE5mb/rrEOB6waqqLMQFU9v9Nn+cPw6uy5yE6uHA22
	igPFkxrNBbhSIGX8QNl2dCd3sFTeqlhZtEpNNc03S4bpHKEPvd6sPC2EeOsBg6y8x3AUXRRWE2t
	U4dkj1ysvZsMarHKp4nXyug69CXxiXFrplVOgUP+XvKN4Ye8154rk2+SD2iAftZB+bHj6hwFGQl
	1pGipUiJUCF5LzFJ/zgFvMy1pbX894cDS3Lm1y9ASArjbHkKIeb5BT+nycSNwdzYLlsufh1cH+M
	ou3ChuewSr/uyPyOJfBwLOGFC3R7fxE8qY3Zi2d/4XWTXbGaRbiHq2H2LE1DQRMpm+SnaAhll2W
	pUhr17waI3L7R433TN+9teqlrgOrLP+FPiXY6opWdnzdzV+9xS
X-Received: by 2002:a05:600c:8b0d:b0:483:c490:8ed with SMTP id 5b1f17b1804b1-48526982c54mr14183005e9.32.1772782754581;
        Thu, 05 Mar 2026 23:39:14 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b7571sm15861015e9.13.2026.03.05.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:39:13 -0800 (PST)
Date: Fri, 6 Mar 2026 08:39:12 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH] landlock: Clarify LANDLOCK_RULE_PATH_BENEATH properties
 in documentation
Message-ID: <20260306.e20a5eb9ecf5@gnoack.org>
References: <20260305151507.2563776-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305151507.2563776-1-utilityemal77@gmail.com>

On Thu, Mar 05, 2026 at 10:15:07AM -0500, Justin Suess wrote:
> Add paragraph to Landlock userspace documentation clarifying the strictly
> cumulative property of access rights with respect to the file hierarchy.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39..d02036bb2893 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -173,6 +173,17 @@ this file descriptor.
>          return 1;
>      }
>  
> +The effective access rights for a path are the union of the access rights on
> +the path and all its parents.  For instance, in this example, ``/usr/bin/grep``
> +inherits rights granted on ``/usr``, in addition to any rights we choose to
> +grant on ``/usr/bin`` and ``/usr/bin/grep``.  Because
> +``LANDLOCK_RULE_PATH_BENEATH`` rights are cumulative, they can only increase
> +down the file hierarchy. Therefore, child paths cannot have fewer effective
> +access rights than their parents. This cumulative behavior is a key property of
> +``LANDLOCK_RULE_PATH_BENEATH`` and requires careful ruleset design to minimize
> +granted accesses.  Please see the :ref:`Good practices` section for more
> +details.
> +
>  It may also be required to create rules following the same logic as explained
>  for the ruleset creation, by filtering access rights according to the Landlock
>  ABI version.  In this example, this is not required because all of the requested
> 
> base-commit: f300a1c3a8ae4abca60913b4d26c405a905e4702
> prerequisite-patch-id: 2b17c4f0b741a703f61294989a53677de0b1a54d
> -- 
> 2.51.0
> 

Thanks! I think this is a good addition to the docs in this place. 👍

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther
