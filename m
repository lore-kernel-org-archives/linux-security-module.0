Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188819E968
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987837; cv=none; b=iMZ+66pMZXMgkcf1vtL3EpxPY6uH4a8naRVWi9sk8P38boXmgwlqD0rmBz5Aq8a74Gy26R+VTiPV1BysZksaC/0gUMv/eNvvvgwFREta9Sdo9VX9gi1WPX/YrR2XtJ/FeBbSWg395FkcFhy8xQT4ZhXcF2c7uSn8CNyBPcymbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987837; c=relaxed/simple;
	bh=jiYVZbGhzRTDrn5zSw/VZDsV2L3e+qahjATfG8AJLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPi+I+iHIuPV6HEVz+fZixUQlwYrI33LA7yHQGYBiAGOhZHrdAWgXF2td7wnk3KpsbqYCkFZIcaJj6UlshZjuPBiJD84Ndzc309TJWlV/Lcrg2Gg7J9Ahy+52X5pa+xHlnxpaQfm+U1dNo9l9MAHSHK/BXsFarCkAjufQ2m6LCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=t8fKRyV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHJ2C9Va; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="t8fKRyV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHJ2C9Va"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B23871D00182;
	Sat, 27 Sep 2025 11:43:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 27 Sep 2025 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758987833;
	 x=1759074233; bh=riIiti5JRr/cUlls3gbXy3hCUYTVjs+qJIp38v/DYSA=; b=
	t8fKRyV4KR+2XBrwU3In/L6SmxReSJlen/sBRZBtai4uSzEuJkJghopHA7EuNlJx
	acfYLpttlac14KOaB+JIthjVssSimueALwwrmrhawYM8LlV9CNdzg3pGujerkN+A
	N01crvO0pwLMudSDAAPRx3j7In0XZ80isCeK9yWTH/zhMlZaeSuIlb6L+5idf/zo
	2phBnubhfOzn6Jbl6swsxQOyebRiq7yYDiqydYvqVJJOEobFNC+AhCVQgxlZQnO7
	HZ4qU9bOK4V1bxY01JGxzbHnWeFh+6t+4I2PcCAS6nkeri59MBTP9f/M0Mh+hg73
	57YuDSnBJk4X41L5sGok1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758987833; x=
	1759074233; bh=riIiti5JRr/cUlls3gbXy3hCUYTVjs+qJIp38v/DYSA=; b=I
	HJ2C9VaPgrEfm1Ob7F78rjeStkjztVSZzdcChJOTZUbr+s5N/f2vW1nQC5pEqCPn
	oG/3G3r5RnPE2JMicIAsf9S8er2XERjBLHaTrM2xtqDYnkUbHSA3/m17y3VYqRX8
	SDBK8GkNUJVdYgpZdwCmrzrOLLcHHT/sg1n8gUs4dgK1iv1Bt8pIKGAALalGg5bk
	U5+Q0qEwwMH8s9cenAkowVV687hFvfAxfBvjxgTALl1yUVbolXgzCKxjtdl2AqcP
	HL9mulLcTpetJ2mP7LjAvxPLRyX5j+Ye+HqHey7YgQq5kiqq7E4iaUc1ZTPfj/LG
	CL5fcDVs1v899KYYgL+cA==
X-ME-Sender: <xms:OQbYaDB6rESykWLlV54pPG5iFELrM8SfBF80cGZHqEZpAi68fWWOIw>
    <xme:OQbYaAjnpdpLVQI2aPivTAuqoDgJR3GfjBKAuf2Rt4NWD_MxGUIDU65HhiuRDfkfC
    mNI1OurjNPd-lefBLPBEgA8jTV2rjhPOcQKFsB5gIA5KtWPXs2Tyi0>
X-ME-Received: <xmr:OQbYaDmcfn-ZRjNWJxuaOG2c4mYZSEW1i1YXLdi0PCmYdX7zWmC5Kc15a0HhQ2nuIw1yFDcI_g78ARYAzHSl2cg7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:OQbYaErI71TP8oXcen5NSHLCZ_sAwyJY8rQpRgatM6bkI6Rx64-4iw>
    <xmx:OQbYaEH5gxX2FWDPCHwoJ4_zCBOO6ES_B5pOro0HmwOqRquqFA3vKA>
    <xmx:OQbYaIzUoy_4phqywZov6hrRGjP01zoWQechXPBlAjbFh-aDS_VAew>
    <xmx:OQbYaBpbslpX894nz5La7cZJ6Mx4k5TKGebkcY4EL_Kfx9v_TX5cHw>
    <xmx:OQbYaLgJGSRoqMZ-3KjQZK5hFPtasifoF-Lc5uviWj9eAUZ2GJhWyEN0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 11:43:51 -0400 (EDT)
Message-ID: <090e272e-64b4-4c56-9928-0e0be0288e64@maowtm.org>
Date: Sat, 27 Sep 2025 16:43:50 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1757376311.git.m@maowtm.org>
 <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
 <20250919.oanahnoon2Za@digikod.net>
 <a43a9985-cf62-482b-9a2d-fce463ca69b0@maowtm.org>
 <20250924.wu8Ieku8aiph@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250924.wu8Ieku8aiph@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/25 10:20, Mickaël Salaün wrote:
> On Mon, Sep 22, 2025 at 12:52:19AM +0100, Tingmao Wang wrote:
>> [...]
>> "accumulative".  Therefore if this (different "quietness" for different
>> access bits) becomes a strong need, we should probably consider some way
>> of implementing it, rather than expecting a sandboxer to do this two-layer
>> hack.  (But implementing this does have the potential to result in needing
>> to have a (number of access bits) x (number of layers) matrix...)
> 
> Yes, that will indeed increase the size of rules, which is why I'm not
> sure if it worth it.

In addition to the size of each rule, another concern is that we would
need another layer_mask_t[LANDLOCK_NUM_ACCESS_FS] matrix on the stack in
order to correctly accumulate quiet bits when multiple access bits are
requested, and the quiet bits are only set on some of them / spread out
between different objects.  For example, for this 1 layer domain:

/         quiet: r
  /etc    quiet: w

request: /etc/file rw
    # This should not audit log, but if we only keep one accumulated bit
    # per layer, we would not be able to tell that all access bits are
    # eventually "covered" by quiet flags.

The alternative approach you suggested below would get rid of this
situation as well.

> 
> The alternative I was thinking about is to only increase the size of
> struct landlock_ruleset (which would be negligible) to include sets of
> quiet access rights.  A request to such access right *on* a quiet object
> would never be logged.  I think this approach is flexible enough and
> doesn't increase much the complexity.  This would also be useful to not
> log access rights that don't have associated rules (e.g. scopes), and
> then no identified objects.  To avoid the kind of hack you pointed out,
> this feature should probably be part of this patch series though.  What
> do you think?

This seems reasonable to me, especially if we don't think that having
separate quiet access bit controls for each object would be a common need.
Although if for some reason such control is needed, one might still be
tempted to use the kind of two layer hack I mentioned.  Maybe some program
would like to quiet reads globally but only quiet writes to /run...?

But maybe later on when we get to have supervised domains, the supervisor
can tell Landlock whether to audit log or not for individual denied
requests, or do such logging itself, therefore offering fine-grained
control without hacks, and could potentially be more flexible e.g. only
log once per request per process, etc.

I think the most obvious way to implement this is to add a field to struct
landlock_ruleset_attr, and landlock_create_ruleset would use the passed in
size to determine if the quiet access bits field should be read or not?

Also, do we want to consider calling this something else instead, like
"suppress_audit"?
