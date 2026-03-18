Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392533E348
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815477; cv=none; b=AGXjb2MaiJzKVsBrwdu8+RprJhg1yapObADaBHkt8r7PctnbycHPH1p6PwM5J0stAPzHFtjadSvHSEt4tcHJAyD3F7BIZK7yfuBq0pcoD++IqtgH4HcwozVFbJ0N74oRabQdyY0bqrAuKwwIVcOKTglQsEymyyh+ThHszjsSxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815477; c=relaxed/simple;
	bh=Mq1QDxYheorRC5IJIPOGsVMsmBNaV4k5SGC3026w0R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCJ8p9+9jpkM1eTlOgBQqVXvrZ39Aju4Sabeyqn5WuPZXfKZl3JxjxyzpAsPXA+zfVLwruJPPxmnHSb8m06JNtQucEMgdsHf82ye/Cd6dj2IH2VCFG84TREDYeC2btqr9wiASJA7u2AQs2RNQEHuV88R6UnFpD/701+LzfFMPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UYzNtTjr; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UYzNtTjr"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C36233FBAD
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815474;
	bh=Lie/EmS0JfR2VxP0UhRSLkUp3VDngWeG1TYrbxldO00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=UYzNtTjrafmPhEVbisMLZpK2bJJEjnbzUTjgy3HiV3Xhvg5FRMpJP2/HBWtaVDk9U
	 TxRkxW3TrNM8RqsJOHeYGC8Vlgso8u3N3JAeDaKZ28ONYWZKqXTe4GePjQYpIfquhO
	 51eGekUndMfTHHeLiQOhZgQPt1pFZ+S47lCuD3g4eDnYpv3yi4JVvb9HJ5pPU2MgNA
	 YhHuAPvCKjST3RPjSmdvMjsvNGuxz/zW8zKHuLGl/x/tuSudV7dSnWD4U743QxRbfR
	 cC9AZiDmS0EKbKMMPX1FmNxocJkp7zPGLTkG2+m7bHR+rwbvcWXCRohgtVBna7dFRb
	 HLXILxBC+wd2TJNZcKiKcBmk5AXZcmW11ru+UhRSs+U2L9+8Ykw8to/5w7sK7m5cu7
	 gT1PkGGFmVDI5pfKt/Fe8yw6rc1YzxQNmADntwv2E+A8smXuCiJF22caHcymJA7xzB
	 fXkg4ga/jmfhOCRuC5mfqhJ27fg2AUotRPVYVAnprcOzbfF/as1OB0S9JIQ5p0VOpI
	 UIBUIi9jgD08LkwILC27sh+wMq8jDX6h/Sr6aP2m10Nh43F34Da8IYrQm5HF09RIc2
	 Eksrfxv9DasXBnRByIWeKgK1ws2BnkWO0s7C9Asd7sMrKgps8W2VBvh8OEM5s82NFU
	 396TaDfehnEluZM/0alqPSZY=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso34450500a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815473; x=1774420273;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lie/EmS0JfR2VxP0UhRSLkUp3VDngWeG1TYrbxldO00=;
        b=SVukRIazDo3WxlHNgCYQXNXcGOowLsvwwr09AD7iDzyySEIITOCpHdsJ3mEzUVPM9Q
         VyZe58F+TAaDEPB7pAnrF1zzD8m/9xN1UjQK+KaBS8ex1Q5/dj5lzcjMGqhANmseTpkv
         zoCa+GuEC8TLpu8xT6cHt+es54D6TzeEtEOw6YHTsJuRzkLPgzSXk/Wr70uOu8IX0JJK
         HFr4DSqkomi/GyLyZRqjEUrWa54S2KEFct/NeAkOxUJ7J34BCh6axXpGRNQhxLBg8wJP
         n+XaBXxQBHTVOJ1+wB6fzr91HezBt+lBM6/dwZREqU47SYkG42Ql8YKMMV0+aGNDlav6
         Ax3g==
X-Forwarded-Encrypted: i=1; AJvYcCWIqwYwgQmd7f6ZlLwnuhzfnFOAruoVOdxUdsJmoUp0WLVwwXnC7NXlT7HDTWMlVhP0zNMiVbs5JEw/dft83Nw6zm/3Emk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0LzJ2cJ5FEQcbTzrduy2PILlM4/7krCGMFX8RYWCfn9P8ClE
	yEwHLu5a0e7AnTgZ6loGR/vREjoWhoYkkanh0CTRP8icWYA+kLWeD3g4Oaa/O5r+Ix32QbXOGnp
	pgQDBNgVHIrT0ZYQ++sRM2DwhvbRmcCf0Zs0fx5DLOfEfpkqSXgSrDRbo6Dm6Qnu6SXC+LxFd4V
	0GGFwwta9fr2OzmITWPzhEAzu2aQ==
X-Gm-Gg: ATEYQzx2wMng2FqKRJt+GjfNTjvbM6+Bjq0nMrtgZ2wjZoCKCHwgq0bX/qda7+RlXvx
	CdxEfvZOrPI8fxag9Y7IL+kVr8vrGsi9Q219e7Zns6XdhyDMzMN+2I6zPgFqR9u+LPinFRYZ+VY
	vXMK2zfBA/XvhzUPMi8B7aa+lmwrtqK+onAxhNmkVSIlCar0vN/y9nIATvGzEbP4p1j6JQCZODm
	6irSBA0bzAgWZ7XR+u6+SssT2aygjKUn1xlHFKpI+SvPUS8zk+ykcbehyl/z9+6g5bwy1ZWO9SS
	PVPQGzvV8fs9wbNkA/Kvk+EA54e1ruTXocolNQyZPgEFaGO8lgDcfttNmS0iv5DTiF3TfWATEIO
	8mCKSBcQk1As8bUbmoCpzW/8lfATh+BI8oLgOEg==
X-Received: by 2002:a05:6a00:ae07:b0:829:88e7:c8a0 with SMTP id d2e1a72fcca58-82a6ac7ac4dmr1663030b3a.12.1773815473313;
        Tue, 17 Mar 2026 23:31:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:ae07:b0:829:88e7:c8a0 with SMTP id d2e1a72fcca58-82a6ac7ac4dmr1663007b3a.12.1773815472904;
        Tue, 17 Mar 2026 23:31:12 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6bbb390csm1528078b3a.29.2026.03.17.23.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:31:12 -0700 (PDT)
Message-ID: <9eb5a521-9a1b-48fa-a49b-5c8096b873e1@canonical.com>
Date: Tue, 17 Mar 2026 23:31:11 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with
 kmemdup_nul in do_setattr
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309224150.84575-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260309224150.84575-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 15:41, Thorsten Blum wrote:
> Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
> a manual NUL termination.  No functional changes.
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

sorry this got lost in the mess of the last month, this has
now been pulled into my tree


> ---
>   security/apparmor/lsm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..49aa6ad68838 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
>   
>   	/* AppArmor requires that the buffer must be null terminated atm */
>   	if (args[size - 1] != '\0') {
> -		/* null terminate */
> -		largs = args = kmalloc(size + 1, GFP_KERNEL);
> +		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
>   		if (!args)
>   			return -ENOMEM;
> -		memcpy(args, value, size);
> -		args[size] = '\0';
>   	}
>   
>   	error = -EINVAL;

