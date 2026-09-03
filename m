Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7A37C909
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413821; cv=none; b=m5PqAxIH9QB4Cd4prGYhXpzs3WMBbOXR5cwUjt4DbNmM5F8BgJjif4JeTYmHQKLcujzy4XarHI9KcZUx9rHM9JMDHs2oavzendr3XMxWOlxsZc5Z5RlY7CJUwccBLkwOyHwbz+jfNLXvnRVyR0Yc72Ywx1DViTTHfrLF7wPBqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413821; c=relaxed/simple;
	bh=PK8h2Qhb8w0psiZtjT30OxK5ZdXMs+MXu0UGCnkZKtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5k9zNU/iZ2g1nFSbX8MtyOmEwSVIIPsS5AdyjidWBka/YgnpzqTNLkH3t79INiNx0jVoqnqNTFLApKdRNKgokdk+ZIrvZtnAId19UbzjW9v6sWHlZoJgM1xQQaahxPnPkatzyae6NBhr2WVtw3Kmv8by5ht7a075AgGeaRX+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dWm6RHvE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dWm6RHvE"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C4CC3F8B2
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788413817;
	bh=4ovXtS9Z1Hg+r1ECf/l05eveZaTg6lE74jTKbQxW7Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=dWm6RHvEXbOsN7qZ0Mojp78n1jOx73GNbEz5dgNBw1OPIB6Us8azukk14V2fBrMMw
	 LwURg6CniD76gxXVUgh68ItP1YPwYWoUhHo9UlArcF58MELcGisE/9HWVrJsvdlidU
	 fupq4KpdYBaQTi24W3DSbqzHMmjNySD6f0AWG4Up9/8q+Jv9AJgEHCyKmkFa2BWWbp
	 w8jNa2x/N7SdV+ll8qvwtEyBaC+Hjx6ZfcvQa79b5A7vi6CM42mrfcecmqne7cVsQN
	 uKqCCVRY5VagwqpbRqlb88L3+2yS2VUPKiczGDE17aNnwXJ3qxRidD9KJIen+qTT/b
	 AnL5wLSyZ21RpZdmVYkmU3rsZIVYhnYsexkIwfs0LP53ecqPqXuQPoHTHEEWTU9vsx
	 KWazNoWC9AYt0iWnvqcBMGY+eRoJG2zfRYL9y+9QNAFWAZA2R07YHrx1mQNt4wNZTx
	 +yuuESO802V8HDpWb9xurLyR3eWZOs3pO9SG27Yisq5pvSXUHVsdFwk1Btq6DaJO/F
	 RQ99Uj8lad0SA5qeYkWHcweVoilpWcvRy1Oq/6oGya04pG9dI9scyWO3KpqvjWJTwP
	 H9CROwDZsjwSeJ81JuIJvnyed/7njGodqoz8rql88tQcmyIeZrH8rwYH3aH6iyd2Qc
	 t4qnoZt9NSbN9pNZ+nYNsJUo=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3415193a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 22:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788413816; x=1789018616;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ovXtS9Z1Hg+r1ECf/l05eveZaTg6lE74jTKbQxW7Is=;
        b=UFjXPBik6Y6n4nnGbylZ0uKfDMgPioG7ATWxDJXCBxEaFDTR35cChe7jvoEuvvdXeC
         4BLZNYhQlo2CIsYczzsGKRAFpgvPCuEl1xpo1wsHWB9/xwRrBUIVfIyGVLQcPLcZPf1E
         dLGrFwn6wXjfi+MM6ZfMzx5IAh5fcYO+/8QI2UZFydSAUr3tNRq4FYsB4hu5skFrxB/k
         SeHX16xfPUUNrVYEDTnW79XhDBKDDiqLU4xJ6mYmgSb7kyFe6J+P06m5+9RW8w5AIkDS
         pBe52/N/NZPxnn58ykTTBg3uRuwGT34TbJRACbkNdHjWs+R9YBXSIlJThm0tlEDACZI4
         DBYw==
X-Forwarded-Encrypted: i=1; AKwUvBx/A9hFZa/iNHy3aTWMi6dx+5bAj0fnfAlBPSRvC1EcAzevccHhxQE40/98Hfnb4CDIwcoL/WMbJmD0JACW5Y80lsY0Lgw=@vger.kernel.org
X-Gm-Message-State: AFuF++kb9wmmRbkZgDM7ViaD6tf3zMXAw4UrLPZmH2LjaBqg1Ac1dsB0
	HH3M5XSbQqzJZ71pr7Hxk8zoDq8rV5QxsoPVskF6BN6Jr+YsdbW/SnKXLENv+hv9EiNCEr/pbfi
	zYPX1lbxkEUKfcBSBYc7rrLB55xKJBhNDABbHIAnnEdcguvNt31yKZvXjx6uo8GIM5ppIWtsk0C
	YjYZ/TRH2vBXD4qeYmqg==
X-Gm-Gg: AYBFou0uZqQtEl6t8kK0WqNewNBK2nPPGTbOBgRV2tEgaAPWE/ntyg1mw31OCcRr01E
	NcxvsTU5fxX5g3wkHsyor8lf2TD8cXRzkjegcXCoYbOaNpN+zh/aZL4bh2xVZ7lm3Rc5f4gmSZ8
	u7qr3TEOdZQh7yCAEkBFjEV1fXoj7gQSzK/nmDQWkDrVe418FgcBNrZZJI/V/x5Tq81Hzb9Th0l
	SEnP6P+Ujau6nUtwR+EWitVHpTVsreUcSiZMS9Li9ItSiariMogeCzrilrNDho+tO992BNJZjzn
	K+N+3kGdmUwzew8ALruvq18w+jR7AYKQeZybM776WIKO56U3ISwdpU/EAn+mWxC+8x3IXpkXfMv
	I7YcGiffh0dB9PpE=
X-Received: by 2002:a17:90b:3b52:b0:396:d28e:bd8 with SMTP id 98e67ed59e1d1-39aedf61001mr14085093a91.3.1788413815803;
        Wed, 02 Sep 2026 22:36:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3b52:b0:396:d28e:bd8 with SMTP id 98e67ed59e1d1-39aedf61001mr14085051a91.3.1788413815324;
        Wed, 02 Sep 2026 22:36:55 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39b087b59a0sm3017681a91.17.2026.09.02.22.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 22:36:54 -0700 (PDT)
Message-ID: <4b9fe55f-090e-4e82-b48b-61b2790335e6@canonical.com>
Date: Wed, 2 Sep 2026 22:36:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] LSM: Implement x array functions for secmarks
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
 phil@nwl.cc
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-3-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20260902220150.18586-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 15:01, Casey Schaufler wrote:
> Implement, but don't use (yet) the functions required to use
> xarray indexes in secmarks.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

minor nit below

> ---
>   include/linux/lsm_secxa.h |  19 ++++---
>   security/Makefile         |   1 +
>   security/lsm_secxa.c      | 109 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 121 insertions(+), 8 deletions(-)
>   create mode 100644 security/lsm_secxa.c
> 
> diff --git a/include/linux/lsm_secxa.h b/include/linux/lsm_secxa.h
> index 926257d4730c..84b06c093460 100644
> --- a/include/linux/lsm_secxa.h
> +++ b/include/linux/lsm_secxa.h
> @@ -7,19 +7,22 @@
>   #ifndef __LINUX_LSM_SECXA_H
>   #define __LINUX_LSM_SECXA_H
>   
> -#ifdef CONFIG_NETWORK_SECMARK
> +#ifdef CONFIG_SECURITY
>   
> -#include <linux/security.h>
> -#include <linux/skbuff.h>
> +struct lsm_prop;
>   
> -static inline void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
> -{
> -	skb->secmark = secxa;
> -}
> -#else /* CONFIG_NETWORK_SECMARK */
> +int secxa_from_lsmprop(struct lsm_prop *prop, u32 *secxa);
> +int secxa_get_lsmprop(struct lsm_prop **pro, u32 secxa);
> +
> +#endif /* CONFIG_SECURITY */
> +
> +#ifdef CONFIG_NETWORK_SECMARK
>   
>   struct sk_buff;
>   
> +void secxa_set_secmark(struct sk_buff *skb, u32 secxa);
> +#else /* CONFIG_NETWORK_SECMARK */
> +
>   static inline void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
>   {
>   }
> diff --git a/security/Makefile b/security/Makefile
> index 4601230ba442..e93be00bb6ae 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_KEYS)			+= keys/
>   # always enable default capabilities
>   obj-y					+= commoncap.o
>   obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
> +obj-$(CONFIG_NETWORK_SECMARK)		+= lsm_secxa.o
>   obj-$(CONFIG_MMU)			+= min_addr.o
>   
>   # Object file lists
> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> new file mode 100644
> index 000000000000..ccbe78095d70
> --- /dev/null
> +++ b/security/lsm_secxa.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Implement functions supporting an x array for LSM properties.
> + *
> + * Copyright (C) 2026 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +#define pr_fmt(fmt) "secxa: "fmt
> +
> +#include <linux/xarray.h>
> +#include <linux/export.h>
> +#include <linux/security.h>
> +#include <linux/lsm_secxa.h>
> +#include <linux/skbuff.h>
> +
> +/*
> + * An Xarray of lsm_prop structures.
> + */
> +struct xarray secxa_xa;
> +
> +/**
> + * secxa_init - initialize the xarry of lsm_prop structures.
> + */
> +static int __init secxa_init(void)
> +{
> +	xa_init_flags(&secxa_xa, XA_FLAGS_ALLOC1 | XA_FLAGS_LOCK_BH);
> +
> +	return 0;
> +}
> +core_initcall(secxa_init);
> +
> +/**
> + * secxa_get_lsmprop - get the lsm_prop associated with a secxa
> + * @pro: destination for the lsm_prop pointer
> + * @secxa: index to look up
> + *
> + * Find the lsm_prop associated with @secxa and place a pointer
> + * to it in @pro.
> + *
> + * Returns 0, or -EINVAL if the mapping can't be found.
> + */
> +int secxa_get_lsmprop(struct lsm_prop **pro, u32 secxa)
> +{
> +	struct lsm_prop *lp;
> +
> +	if (!secxa)
> +		return -EINVAL;
> +
> +	lp = xa_load(&secxa_xa, secxa);
> +	if (!lp)
> +		return -EINVAL;
> +
> +	*pro = lp;
> +	return 0;
> +}
> +EXPORT_SYMBOL(secxa_get_lsmprop);
> +
> +/**
> + * secxa_from_lsmprop - get the secxa associated with a lsm_prop
> + * @prop: lsm_prop pointer
> + * @secxa: result
> + *
> + * Find the secxa associated with @prop. If there is none, create it.
> + *
> + * Returns 0, or an error if the mapping cannot be created
> + */
> +int secxa_from_lsmprop(struct lsm_prop *prop, u32 *secxa)
> +{
> +	struct lsm_prop *lp;
> +	unsigned long il;
> +	u32 index = 0;
> +	int rc;
> +
> +	xa_for_each(&secxa_xa, il, lp) {
> +		if (!memcmp(prop, lp, sizeof(*prop))) {
> +			*secxa = il;
this needs an explicit cast to (u32) to avoid some warnings
on some architecture + warning flags combinations

> +			return 0;
> +		}
> +	}
> +
> +	lp = kzalloc(sizeof(*lp), GFP_ATOMIC);
> +	if (!lp)
> +		return -ENOMEM;
> +	*lp = *prop;
> +
> +	rc = xa_alloc_bh(&secxa_xa, &index, lp, xa_limit_31b, GFP_ATOMIC);
> +	if (rc) {
> +		kfree(lp);
> +		return -EINVAL;
> +	}
> +
> +	*secxa = index;
> +	return 0;
> +}
> +EXPORT_SYMBOL(secxa_from_lsmprop);
> +
> +/**
> + * secxa_set_secmark - add LSM information to a secmark
> + * @skb: buffer with the secmark
> + * @secxa: index of the information to add
> + *
> + * If the secmark in @skb is not set, set it to @secxa.
> + */
> +void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
> +{
> +	if (!skb->secmark)
> +		skb->secmark = secxa;
> +}
> +EXPORT_SYMBOL(secxa_set_secmark);

