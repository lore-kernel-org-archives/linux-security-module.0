Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF538889D
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346755; cv=none; b=Hmj4EgG1N2dWARnPJyfGpM8ZyE/RUo3jSqU5LvaMVxzaEI0r3Iiir3b+ITUEqZspBNyofE4wC8aDF9nvzZ7tCdiM8Be/nzIGhngFIqrOK0QxwACRNBkx9rIjg4WsAZ+nnjzOfCfeJ3QqccegKvpoxgyQAteXve+JVbaa6uGe03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346755; c=relaxed/simple;
	bh=4Y/FDP1e7bxdDeHGuN5P0D3QfKgVVo+rkCesD7OO9lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kURf5tAj3uSjTqScQ/n2HJ9pXMJps8vjHsTquJdSIEZuP+/ETHL4Qn2281hYw6UHiCu6G3qKN3eL5uZVP0NC236J54dYEx390b4Lp2aP6Ed9B/vDtOE0zmuSuYMO+J7TMf88lzmFCoD29B7PqXRZ30aws6JJXcwdsEidCXZMD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PinRGR5h; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="PinRGR5h"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1DC113F125
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786346750;
	bh=t8IdzWtRTWVg05WPT4v+oQ2Ga/sIsJXRhDMGgcPqO80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PinRGR5hLan5nUq/hwk9geIngF4Ry4K4T5JbZKuDOSyasNcBPnMEm6uTFCZNkvTGP
	 o+3YWQVaXnvc+d9lPgciMmP/tp7afdHKvabENqH/xB4HOlDKH6/BqeIUy6YBvHc74t
	 yoh97f9jIxmThTtpD2gl6WOK0zhUTpg5lxLzcoDYXSxRCwNz+G0a3Z/BhMsHy7Jl36
	 Dc2W274aCJgp2A62BO3N7BT7tdAIxxsFLUbPVycsVGRug486MPjC4m1/IjXWJAgSqY
	 T0IWR3C7xa47QI46r75HXl02YZv9p16wyab2ynBremgdiJiX1JXxad+gcEpjlErKCx
	 uD+tZgR5DL1m+BQSGWvzddZIMOfF7PXK2FVTfbFq3PyaDw8lTbpFXzqUcT+kKbJHVj
	 paWzVAoXkGLXJbdyWBEGTvgJ5Nh/hK0xUpuNV+zUkyVcE81w1yS6TgR1S5m5LHCO/1
	 cgQBjewpwHMd39ZaRyKyqs3Gs8+XQ6sido8I9XajjDuOgYzFUnnfLU/o+vrSUwskZq
	 KD46SODPWcgtwfFSabh5qU0RL9D0DMlUDFBu+mVeVSz+E3bJsd2eBc+SfsaiDWlupO
	 MhNidpccrinIo7ysPvvVp1lAO6jQpluR4twcctk/juYHvOJ1l3VXuQ9871sU85XvTt
	 5EsTz2MTyEVLDX+u2DWq9br4=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so2169841a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 00:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786346748; x=1786951548;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t8IdzWtRTWVg05WPT4v+oQ2Ga/sIsJXRhDMGgcPqO80=;
        b=RF+oQ1UfkbEExfByQdVFFrMnQCMtSrPIpbaq41BIN5fRitGk5VGiHthBTCQ98v9DP/
         9ue2hQWyVnvym7U5YUntjv23D6FczFnmewzVaVJcktkrw2tf6+CM6q02SFJHXG49G6RH
         Bji8JtjN9tXSVHBz0FManKQtKlNNaDWvB4Gm9WDXxnjwBSPkp0QR7MO9BHV4cM2lOsAK
         JeNtpGNLJRC0nEF6bMUVQfIakSPtZopFHrg7Lq4n6PtdfrLcFl5tpUzOEcbSC9C43jPS
         od2gYONsDmIUirO6rGbDdZp7U139FPdMaN7NvtF++/IHUSpTx1cM/I3wQ72iOpMpfAsz
         Nvfw==
X-Forwarded-Encrypted: i=1; AHgh+RqqgrOR9tfqvPztmwPWFvEQ9rFecgu4Nbi94m3EAflG/Z4ebJO3dmmFDVyIjDrLIDD34wuEFGOY9q9YSsZGBDcAnX+WWfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxur7CunJJcYKUDft0Aq77WB5t6atHjiqz4PwdQ2KZOYiRLLZ4t
	jTK2nWalvRmGabny7XhSwYIMojlsxptLZvqcKNbKdrE2QTdYvLzkzE5FW36i99kKVIy7PHhpt8p
	yCPexv+1QurjPd/gabhKq3iH8iN1rfNrQcHkiFPcCXJoqa57vTMB6/QlEEMsHRWT3SWWdt4A7yk
	BzzZsYmVdPv68XnNSAUg==
X-Gm-Gg: AR+sD13/ExeCMoD/IlEmESbMf8+KGAJlf11n640uNeFVzg8hgzWdgjomnN8AWh7iCWw
	hKCMJVbBDW9tFVEHartOmdjKeBP8A28/FttR2DoZRIwq6d6bRNEW3Hwt2I8vR9v2tpzdk5q4iHk
	6LgKkd0pWrZ0uaaox/8jCJSaR655IMnzCjNUo97vNKk42uPxIMGPKyaHG8TJTvA3fAHu8gPxWUP
	IOl27PshMHxigA3iev3H9ZDf2n+0g0yf7se2Xv4T07WhfIz58LOR5rTMEFX0vvMEZF10VWPmLp2
	A58LYSGAKpnzRQ70m62xk5pOaSqVk4neK3b4R5GmvFs0vMScxctRNQ6A7jKj4nMzBOD4toA5j7M
	haSofgNlwyTRFpLyY7B39/ssP/lDmOWePn0DFvbpAL2vJbv9iTXi+
X-Received: by 2002:a17:90b:4d84:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3903c5dfd9amr38601096a91.18.1786346748474;
        Mon, 10 Aug 2026 00:25:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4d84:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3903c5dfd9amr38601052a91.18.1786346748021;
        Mon, 10 Aug 2026 00:25:48 -0700 (PDT)
Received: from [192.168.50.156] (S01061056118100b4.lb.shawcable.net. [96.51.42.105])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39085de9c0fsm14196233a91.5.2026.08.10.00.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 00:25:47 -0700 (PDT)
Message-ID: <4adced66-5459-4df5-987b-bb9b08c23b08@canonical.com>
Date: Mon, 10 Aug 2026 00:25:46 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix integer overflow in verify_tags() bounds
 check
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20260809142947.548440-1-fabrice.derepas@canonical.com>
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
In-Reply-To: <20260809142947.548440-1-fabrice.derepas@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 07:29, Fabrice Derepas wrote:
> verify_tags() validates the tagset table unpacked from a policy blob.
> For each set it reads a count and checks that advancing the index by
> that count stays inside sets.table[]:
> 
> 	u32 cnt = tags->sets.table[i];
> 
> 	if (i+cnt >= tags->sets.size) {
> 
> i, cnt and sets.size are all u32, so i+cnt is evaluated modulo 2^32.
> sets.table[] is filled by unpack_tagsets() with aa_unpack_u32(), so
> every entry is a raw unbounded 32-bit word taken from the policy blob,
> and verify_tags() is the function that is supposed to validate it.  A
> count close to U32_MAX makes the sum wrap to a small value, the guard
> passes, and the inner loop then walks sets.table[++i] past the end of
> the kcalloc(size, sizeof(u32)) allocation.
> 
> Note that sets.size is bounded by 65535, because unpack_tagsets() reads
> it with aa_unpack_array() as a u16, so the wrap cannot be reached by
> growing the table; it is reached purely through the attacker-supplied
> count.
> 
> With sets.size = 2 and sets.table = { 0, 0xffffffff }:
> 
>    i = 0: cnt = 0, guard 0 + 0 >= 2 is false, inner loop does not run
>    i = 1: cnt = 0xffffffff, guard (1 + 0xffffffff) mod 2^32 == 0 >= 2 is
>           false, so the guard is bypassed and the inner loop reads
>           sets.table[2] -- one element past a two element allocation
> 
> The walk continues until an out-of-bounds value happens to be >=
> hdrs.size or the access faults, so a crafted policy yields an
> out-of-bounds read on the policy load path
> (aa_replace_profiles -> aa_unpack -> unpack_policydb -> unpack_tags ->
> verify_tags).  unpack_tags() runs before the perms and DFA tables are
> unpacked, so no other table needs to be well formed to reach it.
> 
> Policy load is gated by aa_may_manage_policy(), which checks
> CAP_MAC_ADMIN relative to the subject's own user namespace rather than
> the init user namespace, so with the default
> unprivileged_userns_apparmor_policy=1 the path is reachable from an
> unprivileged task in a matched-level nested namespace, not only by a
> globally privileged one.
> 
> Perform the addition in u64 so that it cannot wrap, restoring the
> intended i + cnt < sets.size guarantee.
> 
> Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/policy_unpack.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index d9dcff1..15b5e92 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -730,7 +730,7 @@ static bool verify_tags(struct aa_tags_struct *tags, const char **info)
>   		/* count followed by count indexes into hdrs */
>   		u32 cnt = tags->sets.table[i];
>   
> -		if (i+cnt >= tags->sets.size) {
> +		if ((u64)i + cnt >= tags->sets.size) {
>   			AA_DEBUG(DEBUG_UNPACK,
>   				 "tagset too large %d+%d > sets.table[%d]",
>   				 i, cnt, tags->sets.size);

