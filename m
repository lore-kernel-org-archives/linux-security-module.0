Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B67185E4A
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769305940; cv=none; b=NoFn8GEz557b+mmO4tJDditgRIx+F5TyNsAr2sBP68CeJ5ahRyaH+wGRiDmxOteeZ4dBMbbnD1cvz2jISLh5eD0cKQknCLVnQUI921VAJzKqlosDV5lmI6r1sWZk7SdchOWAfmYXeiXte+Yfxggekgn4zKtZb+FH+xYgx9Jnaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769305940; c=relaxed/simple;
	bh=SOzskQQDSuav7yM921KWdaxACL3y1/trhH1Ayu+akHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXxHTHpxQF4GFCfa/EyZww6KBeCtQLuYU8Z9rrD7CWhjW0DKsNJuRZNgd209Rjt3rjjwvAZeqZr+Kg05H3by7ajrOQV/e/fN/ZrCca1kcHC98dX6v7wJwmNOz3VWbLYNtm8b1lywG/L75P6FNHsRwW95Dp1MKcmTX/cTHUGDrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=l+KCPqxk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o6lNWvkv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="l+KCPqxk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6lNWvkv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F165C1D000AC;
	Sat, 24 Jan 2026 20:52:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 24 Jan 2026 20:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769305936;
	 x=1769392336; bh=iAcngLlJ/kJD+oUzXwj76SHpEcxgoXFaV8LS/MQoWYs=; b=
	l+KCPqxkqzTQhQsJglT/S69WlyjuwnApyA8s7l40fRMo7J11Xkq5flCvGATTFmvh
	bqNmAfMCLnsdNRodC9sv2uekG00oIKrBFFUxWQ0quAyY0eAv+oim16UOtytuptCU
	g2z6TiQhINKMdI5/8kKNQOvCBRI2VwHcOcn2khYmkK/Sxs/KwX26NbbICI8vjMIX
	HSL4R/VLAZfR7MsphT/g1aNs+GiYfe3GLiAS6haZVP+O73pXeEdKT+rjOsG1iDKL
	mHzw2lBSpBvhnlerYt35YjxO4q5ZpmQfPcP1G5XPwUQCRDYBxnVaocVa6Bnisv5X
	88v/foVvQZsGAf/5vojj8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769305936; x=
	1769392336; bh=iAcngLlJ/kJD+oUzXwj76SHpEcxgoXFaV8LS/MQoWYs=; b=o
	6lNWvkv0TEIjK6Hlg2neWSBp4xG3FKpyoYOaOuw/9tql6w1/bvsy+0CuihAFDbvz
	2skQ2gNPNNK/PkE2VbFKdRfO7mPx0YFKPpLF/WBDLB7vgNeXIRgBebWgplw+xLfw
	0LmwiSNV2sA6mZoymABwsAGxiZFZfJfRK4sdLKdkIGeHOTCAfoStzhKhQFfH98sf
	N8Zc+m+GcVGI9oumtVF4qp7uRDPEB9ZAT4jpcjlYIyXSpbrYJFb6+tzpa8nLE5+E
	EIZEaCX3wX1ONWjz0t3KB70cE4S+fpK/p7ZHUxnZ15hp0TZstk9BN60ZCCO2eYR/
	4Ez0mkpsaaN5UIxm7FRyg==
X-ME-Sender: <xms:T3d1aUh3pHJX-uz_g3uA11F6EsBQZv8DRQz2K_CregUnmB2PqVd7vA>
    <xme:T3d1acF0-ofBEV9pUV567ykPba5ctgezAJckoN9ckp5E2OGuUQCV0HFo2DDrRu_1h
    pxzCKj9caEWhxj-4GtQvmxj4C1g91-e20BPER3O1ETR0rOsEP_9DA>
X-ME-Received: <xmr:T3d1aSTaAX6HnuSy_4dMzMWRNvj1Yp92-592zqIUhUUb3PuZTRaEp6LiPXp3DU1Kk_V1MyFkUtqm_t4qag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgnhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhopehmihgtse
    guihhgihhkohgurdhnvghtpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhm
    ohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehuthhilhhith
    ihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhgrshhthhdrnhho
    rhifrgihrdgrnhgrnhgurgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepmhgrthhthh
    hivghusegsuhhffhgvthdrrhgvpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrihhl
    udeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhopehkohhnshhtrg
    hnthhinhdrmhgvshhkhhhiugiivgeshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:T3d1aRxX3xaeqZdn5N1qBeTa2yA_na3ffQfwwnPivmQxBwV-t-c30g>
    <xmx:T3d1aWfNaSPh6FmRvDFpp7Jjk7pjq_CurkaDKwKKnmo4uLHXSkV3aw>
    <xmx:T3d1acP8QrA1-s5BvoMEq55RQDbdyxmSt7DexY80uXl3HK6CXo1ccw>
    <xmx:T3d1aZshJNxNXs_CDqg_10O-yyf3IgaXtAPzmTp0bsWcm9edCUH0cA>
    <xmx:UHd1aRXGbzQS35vs6WCd8CSdgfaMOjUgMiwAixtfeEkwhWFL9qsnrB7Q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 20:52:14 -0500 (EST)
Message-ID: <0dbce93f-7890-421d-be53-1898a6ff919d@maowtm.org>
Date: Sun, 25 Jan 2026 01:52:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Justin Suess
 <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251230103917.10549-7-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/30/25 10:39, Günther Noack wrote:
> [...]
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index c52d079cdb77b..650bd7f5cb6be 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> [...]
> -static size_t
> -get_layer_from_deny_masks(access_mask_t *const access_request,
> -			  const access_mask_t all_existing_optional_access,
> -			  const deny_masks_t deny_masks)
> +/*
> + * get_layer_from_fs_deny_masks - get the layer which denied the access request
> + *
> + * As a side effect, stores the denied access rights from that layer(!) in
> + * *access_request.
> + */
> +static size_t get_layer_from_fs_deny_masks(access_mask_t *const access_request,
> +					   const deny_masks_t deny_masks)
>  {
> -	const unsigned long access_opt = all_existing_optional_access;
> -	const unsigned long access_req = *access_request;
> -	access_mask_t missing = 0;
> +	const access_mask_t access_req = *access_request;
>  	size_t youngest_layer = 0;
> -	size_t access_index = 0;
> -	unsigned long access_bit;
> +	access_mask_t missing = 0;
>  
> -	/* This will require change with new object types. */
> -	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
> +	WARN_ON_ONCE((access_req | _LANDLOCK_ACCESS_FS_OPTIONAL) !=
> +		     _LANDLOCK_ACCESS_FS_OPTIONAL);
>  
> -	for_each_set_bit(access_bit, &access_opt,
> -			 BITS_PER_TYPE(access_mask_t)) {
> -		if (access_req & BIT(access_bit)) {
> -			const size_t layer =
> -				(deny_masks >> (access_index * 4)) &
> -				(LANDLOCK_MAX_NUM_LAYERS - 1);
> +	if (access_req & LANDLOCK_ACCESS_FS_TRUNCATE) {
> +		size_t layer = deny_masks & 0x0f;
>  
> -			if (layer > youngest_layer) {
> -				youngest_layer = layer;
> -				missing = BIT(access_bit);
> -			} else if (layer == youngest_layer) {
> -				missing |= BIT(access_bit);
> -			}
> -		}
> -		access_index++;
> +		missing |= LANDLOCK_ACCESS_FS_TRUNCATE;
> +		youngest_layer = max(youngest_layer, layer);
>  	}
> +	if (access_req & LANDLOCK_ACCESS_FS_IOCTL_DEV) {
> +		size_t layer = (deny_masks & 0xf0) >> 4;
>  
> +		if (layer > youngest_layer)
> +			missing = 0;
> +
> +		missing |= LANDLOCK_ACCESS_FS_IOCTL_DEV;

I think this should be under a `if (layer == youngest_layer)`. If layer <
youngest_layer, because *access_request is only supposed to contain the
missing access from the youngest denying layer, this would be incorrect.
Although I think it probably won't make a difference in practice right now
since we don't currently have any access request that has truncate and
ioctl at the same time.

> +		youngest_layer = max(youngest_layer, layer);
> +	}
>  	*access_request = missing;
>  	return youngest_layer;
>  }
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
>  
> -static void test_get_layer_from_deny_masks(struct kunit *const test)
> +static void test_get_layer_from_fs_deny_masks(struct kunit *const test)
>  {
>  	deny_masks_t deny_mask;
>  	access_mask_t access;
> [...]
