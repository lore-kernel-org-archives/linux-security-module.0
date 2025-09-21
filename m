Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62017A305
	for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498753; cv=none; b=u5ctocwH9V4alNTqC/GQ5w+JEo85A9aIKRNoo6unuPCcKqDDOtujrCdmU7iNe10OsapwClpwGIx7Efb3yY2c/lHnAVvhr+r1NNyDjdPK7xGkFaYW75OmGY47RAQdMyrTdIp1lSH7kD4hMTvbwXRkrE7dIklqosF6+M2VZIrZ5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498753; c=relaxed/simple;
	bh=c8nMXpnYoqGRk0YctJf9lK2TzUEgktcPoy4Qs03dSH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLBQn+OVUia17gYxT3AAxb1l7v4WfJSRPNJcuPmLUPDZMbq83JpGguUtO+QKMxtaFJ/wEyK5wzbDQsGCFbNOFQfF5DdfU2lRVOt6HPFC9Cfd+GyM49O3G7TlavdXRQET40n3zax0p+OqqaXC3VP+kMuS3nwOsFGk7AkqUZTYwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jNmgDqPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnH1Bd47; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jNmgDqPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnH1Bd47"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A6C71400074;
	Sun, 21 Sep 2025 19:52:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 21 Sep 2025 19:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758498750;
	 x=1758585150; bh=svWRM9nlhOOUKZiOFxzQo1Ca4V5VpTQupz0BWbh9MIQ=; b=
	jNmgDqPsUnrIwhoSDG5OXrN3udlLVKKw1eT+Ivcb3VOc3CMqGTg2XqOqsNrNaRsL
	zkfeBR3rD8f/VHSOKblXHhu1QLwRTb9rTGbABG9cR74+WNrgQwSLf+xLmRxTqHKT
	Nu3CZx1JveSsfjB3t5/ja2Fk0DSb8zMKNrIDHeK9atNH9Bp4F1pqIbT2AWUbz2XY
	lr+1oUo9cXf+T0c6SUii6HAUn1ULmXOrtK0hcOLfYNxhryDCzB7vgk2NvW9DekBi
	xnt4YokgselwkJDxZQ6m/lN/Z/sdnHjgz5tC40LQ32WJ4hlbQLbscS3w3F6IbFGv
	HuWyd6Pvo2NuqGMIxKbl1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758498750; x=
	1758585150; bh=svWRM9nlhOOUKZiOFxzQo1Ca4V5VpTQupz0BWbh9MIQ=; b=K
	nH1Bd47hK7qyKCixqEkE1x07UUWlF2WHhIt+PkoFR18wdlSzhoAaaKuohGVLEND6
	1C50Z9gb/7ADv4TphFwQCA1vdXVJqoF7FQUHJPWVEp+WDSIi4iVCmzqRcaRcZnph
	erFd9rF3VwEzaXqNuRnox3X0VvyhxVjsSg8E8u5zr5BC6avbEHzwe3aKzSew1/ZZ
	fyqIkZaIxCaOkqX4+AxjujcIhgqd3RgC0h+ihJKGuIERub2CyQEZ91mQjnnU3J6+
	8dRGphaKl3TUai9MJWNUTsAaw+QPyESd8s9dS9EJZtG3A+JONI1wXblp3bqkvm1N
	fTIlf8Ccvv/aPfVkBsXtQ==
X-ME-Sender: <xms:vY_QaKz5jD0lAXOCoEP-y8nFhpM4SeGLSr7OLfiiTIdRhOBdXmFrzA>
    <xme:vY_QaA3k0J1MERlAZ93ESzaP29ZFDOJIj5KKnn6_tmXXhy9XLZaEAe0OVK528SM4f
    KiueNtKXofmHrKiWe0>
X-ME-Received: <xmr:vY_QaI7V8DkFDxsXBFFWGrn_2uSGs394hfrK0qQodCd5XHXG7bsWbI5JUW4ZNRV7bybWdjMX-C4kZQE2_EFbLxZr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieefgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vY_QaDW3kbvN8Atv7h0M_lmXTA1HgfvAgKglFmILeULw2LQNM0_HCw>
    <xmx:vY_QaHDtFvGQ2easvTydfqItfliH7NxIpaYIUuVBpnKBbmscPPvNMA>
    <xmx:vY_QaC7MQMulFQWKG-iNGqYMFrqroxWKEs0mhJY3Wk6e8SnzAC0u_g>
    <xmx:vY_QaCwqnfu_q9L0vkQJCr8tipfS9Nt4V3yCkIQxcHj0V824hNn-FQ>
    <xmx:vo_QaEJipYPqdy506uYmaj_t29pKtqNyd6gwaaB1hGZBeetFk-vu4W6E>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 19:52:29 -0400 (EDT)
Message-ID: <deb35849-1e5a-40f6-9819-de0be36b39da@maowtm.org>
Date: Mon, 22 Sep 2025 00:52:28 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] landlock/access: Improve explanation on the
 deny_masks_t
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1757376311.git.m@maowtm.org>
 <9253127a0386f53f84897f62a2beaa5aa5959360.1757376311.git.m@maowtm.org>
 <20250919.loh1Oor4busa@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250919.loh1Oor4busa@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/25 17:04, Mickaël Salaün wrote:
> Looks good, I'll take it.

Thanks, will skip this in the next version.

> 
> On Tue, Sep 09, 2025 at 01:06:39AM +0100, Tingmao Wang wrote:
>> Not really related to this series, but just something which took me a
>> while to realize, and would probably be helpful as a comment.
> 
> Please just describe the change in the main commit message and move this
> kind of explanation bellow a "---", just after your SoB.  This is useful
> for review and avoid unrelated information when picking a patch out of
> this context.

Got it :)
> 
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>  security/landlock/access.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/landlock/access.h b/security/landlock/access.h
>> index 7961c6630a2d..5e2285575479 100644
>> --- a/security/landlock/access.h
>> +++ b/security/landlock/access.h
>> @@ -67,8 +67,10 @@ typedef u16 layer_mask_t;
>>  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
>>  
>>  /*
>> - * Tracks domains responsible of a denied access.  This is required to avoid
>> - * storing in each object the full layer_masks[] required by update_request().
>> + * Tracks domains responsible of a denied access, stored in the form of
>> + * two 4-bit layer numbers packed into a byte (one for each optional
>> + * access).  This is required to avoid storing in each object the full
>> + * layer_masks[] required by update_request().
>>   */
>>  typedef u8 deny_masks_t;
>>  
>> -- 
>> 2.51.0
>>
>>

