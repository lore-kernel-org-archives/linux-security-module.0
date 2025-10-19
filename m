Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A961946C8
	for <linux-security-module@vger.kernel.org>; Sun, 19 Oct 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895960; cv=none; b=hzeKwSBKm41kiCw7qh/rDLYq4P4FzobsVBzOi/51MxB2agZTeNXjslbg2RKjmFWh83EG9V5S/FSVELR+byNm96NOovmj32cVXRJWb0mXgWsm1LLntjNP8YSCKuUTHGI0TD7zhm4UoPce8Ztye8huEttgsAoG0U+wX+wLruwU4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895960; c=relaxed/simple;
	bh=E6crGrOEw9Ko2C01mk7/TfCCO1V4pl3mx4AfZU8F+8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA20CZwf2lh9mmGjoPKiSv1G5r/WR+lIdZTVoWG1ydsohIYom8rdS11mAJx1OCh2Ya3XtQ2dfl56hGziH8LB9B5F3zjoNOz+3w2qWY2W95/ZYA+HBOrRo7pa7cuN34M5p6DMs00SlsDg220uNr3dGTyntRo65wOhF3PULPxH0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=BhBwUCgo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liYjDGiZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="BhBwUCgo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liYjDGiZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAEAA14000EC;
	Sun, 19 Oct 2025 13:45:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 19 Oct 2025 13:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760895956;
	 x=1760982356; bh=mKJvXk4VtnAx+nWIuBKQrNLACWH0JBqkLC4+0rOgNmI=; b=
	BhBwUCgog8lVfXtJmH9tsq5wvDSv+arZChomV+vQyCJOoX67hOju/xxvO96cI649
	lVHlKiq6ylQ8g8Sg54PemzlHAKTypUvg4oDKgycQd9jBkiyxW6TbxW6aR7+rsFTx
	diCj+F2tXVUIwZrOGs8GK3bBzp00+ED9geyHDDHBSh8j719EeYNQl0xpokaKqARp
	t4vGhVJvgW/HZmdMwWcDHAW/xywelJmIZC5UThLv6ChPEwO7Nthn06KScad4Shbu
	hQedlyvAJqmcXKVtag/Ug72mF9lJOmY3cnkVS8GHJ4ViuSmXmw6DstSMC73twdaH
	MwavGSvI3V9O1xsAILdRCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760895956; x=
	1760982356; bh=mKJvXk4VtnAx+nWIuBKQrNLACWH0JBqkLC4+0rOgNmI=; b=l
	iYjDGiZYeH9k7TNa9mgslXYvAzSlR2wMbt7jaQ+YRFZ671ujT4D79+1kkyoh81u6
	Mwd4/arsfdXfCjlshOEJjY7QAmwI2N7aB/QxtHv5v+HPAo/PfgGnsb1dkeSvAWp3
	THOtp/7I6rFCO69fsA7vsl7oTol+YSA7Iyk/v9IWhZyFQBQPYg9znsTbWfSg8L45
	OL1qYLG+uW0o9RoplKtMKmhzjlNyGkisWny3XX0u7MMoBlnBqz1Ie+VEnBwEA9JA
	rjy0UfnfbPh4+9eEwBYsjaQu5EP3rPwDRENGlB97DeoTTU911/5FMmLEuztf325a
	v7TvRHCccfdn67ZIwc3rw==
X-ME-Sender: <xms:1CP1aFLpE3QjljPAFinuR8K0jKjFQ-chTa9ht7bwj0SF-S8VflvFTg>
    <xme:1CP1aILE4Ob8gzGetwhWD9PbM58cwbolw8fJ4EpaygTrKoIrJiJl9lrvHXoDJXu1K
    MJ9pLzY8-Por7t7CCu4zRK3deqpXaITQ4RzvTFKim2ld73EQciu>
X-ME-Received: <xmr:1CP1aCuFApDkD4G37zRSyqvu41rlksI1oHihULQAYZ8aJ7qsWKrmbuFj4UCwepvyiU5Ft30hNHWSVnps0VKqDS0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:1CP1aFRje3tADrHK9Bx3vPZ4jYTvMOwM0uVYgxQ6CQeWVafOkWrzkA>
    <xmx:1CP1aIP4d4XIVvcV9sCZ9O_20UTfPYwzDv_n5wVFc275CY7YrrZCyg>
    <xmx:1CP1aKbPtJ7UUtkfHtK_aLh5n-9vB_MgyTrBl8t5WR-LJH-B5m4YgA>
    <xmx:1CP1aCyhfu6CoV7yLy2AhUC6n5cDsDqcK4OQShT122cRwMlev1wjPw>
    <xmx:1CP1aArR0CuOIYrp7RWmi5q0EKWt0pXMx7NelMmiDzHmYA_5q2sR0yDm>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 13:45:55 -0400 (EDT)
Message-ID: <326e24ff-8887-46ff-bad9-f30a6daca351@maowtm.org>
Date: Sun, 19 Oct 2025 18:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] Implement quiet for optional accesses
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1759686613.git.m@maowtm.org>
 <d9a05ea8fe3b825087351f22c550854dcad02555.1759686613.git.m@maowtm.org>
 <20251015.sohxe1NohFei@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251015.sohxe1NohFei@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 20:09, Mickaël Salaün wrote:
> [...]
> On Sun, Oct 05, 2025 at 06:55:29PM +0100, Tingmao Wang wrote:
>> [..]
>> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
>> index a647b68e8d06..0f611ad516be 100644
>> --- a/security/landlock/domain.c
>> +++ b/security/landlock/domain.c
>> @@ -212,6 +212,29 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
>>  	return deny_masks;
>>  }
>>  
> 
> Just using u8 is confusing.  Please document what is the "type" of the
> returned value, and use a dedicated typedef instead of u8 (see my other
> comment about static_assert).  This typedef should probably be named
> optional_access_t and have a size less or equal to access_t's one.
> 
>> +u8 landlock_get_quiet_optional_accesses(
>> +	const access_mask_t all_existing_optional_access,
>> +	const deny_masks_t deny_masks,
>> +	const struct collected_rule_flags rule_flags)
>> +{
>> +	const unsigned long access_opt = all_existing_optional_access;
>> +	size_t access_index = 0;
>> +	unsigned long access_bit;
>> +	u8 quiet_optional_accesses = 0;
> 
> As for deny_masks_t, we should define an "optional_access_t" type with
> appropriate safeguard to guarantee that it can always hold all optional
> access rights (see static_assert for deny_masks_t in access.h).
> 
> We should also copy the WARN_ON_ONCE() check from
> get_layer_from_deny_masks().

I don't see how that WARN_ON_ONCE is applicable here since we're no longer
dealing with the `optional_access`...  Can you clarify?

> 
>> [...]
>> @@ -80,13 +88,24 @@ struct landlock_file_security {
>>  	struct landlock_cred_security fown_subject;
>>  };
>>  
>> -#ifdef CONFIG_AUDIT
>> +static void build_check_file_security(void)
> 
> You can move this function to fs.c and call it in
> hook_file_alloc_security() instead.
> 
>> +{
>> +	const struct landlock_file_security file_sec = {
>> +		.quiet_optional_accesses = ~0,
>> +		.fown_layer = ~0,
>> +	};
>> +
>> +	/*
>> +	 * Make sure quiet_optional_accesses has enough bits to cover all
>> +	 * optional accesses
>> +	 */
>> +	BUILD_BUG_ON(__const_hweight8(file_sec.quiet_optional_accesses) <
> 
> We should be able to use HWEIGHT() instead.

I tried it and unfortunately it doesn't seem to work :(

	security/landlock/fs.c: In function ‘build_check_file_security’:
	./include/linux/compiler.h:201:82: error: expression in static assertion is not constant
	  201 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
	      |                                                                                  ^~~~
	././include/linux/compiler_types.h:577:23: note: in definition of macro ‘__compiletime_assert’
	  577 |                 if (!(condition))                                       \
	      |                       ^~~~~~~~~
	././include/linux/compiler_types.h:597:9: note: in expansion of macro ‘_compiletime_assert’
	  597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
	      |         ^~~~~~~~~~~~~~~~~~~
	./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
	   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
	      |                                     ^~~~~~~~~~~~~~~~~~
	./include/linux/build_bug.h:50:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
	   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
	      |         ^~~~~~~~~~~~~~~~
	security/landlock/fs.c:1769:9: note: in expansion of macro ‘BUILD_BUG_ON’
	 1769 |         BUILD_BUG_ON(HWEIGHT(file_sec.quiet_optional_accesses) <
	      |         ^~~~~~~~~~~~
	./include/linux/build_bug.h:17:9: note: in expansion of macro ‘__BUILD_BUG_ON_ZERO_MSG’
	   17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
	      |         ^~~~~~~~~~~~~~~~~~~~~~~
	./include/asm-generic/bitops/const_hweight.h:37:23: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
	   37 | #define HWEIGHT64(w) (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_hweight64(w))
	      |                       ^~~~~~~~~~~~~~~~~
	./include/asm-generic/bitops/const_hweight.h:42:22: note: in expansion of macro ‘HWEIGHT64’
	   42 | #define HWEIGHT(w)   HWEIGHT64((u64)w)
	      |                      ^~~~~~~~~
	security/landlock/fs.c:1769:22: note: in expansion of macro ‘HWEIGHT’
	 1769 |         BUILD_BUG_ON(HWEIGHT(file_sec.quiet_optional_accesses) <
	      |                      ^~~~~~~

> 
>> +		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
>> +	/* Makes sure all layers can be identified. */
>> +	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
>> +}
>>  
>> -/* Makes sure all layers can be identified. */
>> -/* clang-format off */
>> -static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
>> -	      LANDLOCK_MAX_NUM_LAYERS);
>> -/* clang-format off */
>> +#ifdef CONFIG_AUDIT
>>  
>>  #endif /* CONFIG_AUDIT */
>>  
>> @@ -107,6 +126,7 @@ struct landlock_superblock_security {
>>  static inline struct landlock_file_security *
>>  landlock_file(const struct file *const file)
>>  {
>> +	build_check_file_security();
>>  	return file->f_security + landlock_blob_sizes.lbs_file;
>>  }
>>  
>> -- 
>> 2.51.0
