Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EB1662E7
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765040880; cv=none; b=qDes21xL3fU/z5y6Yqk5t0aGg0NylvwqAhPAsvi3W/MmptTL8m0vgYiezbcgJTiNkN9xr1f4Gml/J8YIQCQy+bmAhCX1OK4HhoqJPMudUifGFXJvKvOP3aOPv5VJJ3u2vHLBV7jC3u7gKB+wESwdI86Xn+QfLiUlvMoVIqad6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765040880; c=relaxed/simple;
	bh=LTrczH9csIKj1PNpAAQxPv0z+dAPxbOFjZbrpMghANM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRtY3ux7eXYyHL2HwNDb978S7aNRhnHhBFI+xvjNj4PkE42e0ZfRVxbnIMZDyGDG2TL43I0PQbQauXoN7oAKve0z5L04IUNfBUA6fEQH3tzqZSNnau22iAQG0ZJhBuBqNlYW1K+Q8YXl28EJJTeRCTj/qsvLIX2EMO+wpTe04ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lC93FGIZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxtzzuyd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lC93FGIZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxtzzuyd"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1A637A006E;
	Sat,  6 Dec 2025 12:07:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 06 Dec 2025 12:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765040877;
	 x=1765127277; bh=9GwQMcqdZ+mloQd1wixNFBAQT24mJYRyNU4eCwZik8Y=; b=
	lC93FGIZJR4Z0ocueiS2ZDba6su2U/TGhyhb00BWbbE/d7Tsl2kZmj/mGmfEygbI
	m9a/3CuP7OWFhTQES6bgUqjchPOYYeAlI+6WsxC8gvjNW6YzlEwtAQqbgyUrMN7c
	CQdf6+0/Jer56OE4C71UsCowc5WrmTqmqGPATYTnop2ftUQJ05xIZ26NVBAuZXVx
	RvecEFP0pu+IexW1now7U8Z+uHbUUi93xADHtFIMN8trFcI2feVSj24cxULrhamr
	Zu7MMUONgg+S1fcvvVvvWaJmlJ/ZWIpiTlFLbgcMhJgTa3n+Zf2FfcgOTSl+/HM8
	bwc946z4PrGQXo0xzpZzUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765040877; x=
	1765127277; bh=9GwQMcqdZ+mloQd1wixNFBAQT24mJYRyNU4eCwZik8Y=; b=m
	xtzzuydfMkrMj6dNQHllOJm5XaZzdW98CccEWBrKtJJbl7dEtICllcDeJsyZA10M
	wEj2FlTRGAym0t2RR/wXpNUK0PDqo/5ANAR+QZlx6VefvIydHoOBR3Rav8gAE1Gb
	sNFCzdW2ULcWOGpvmt6swS0q+F7viJXR03EBmyZh2DWNxX8nuaXdREjfvutXbW89
	nqS39gORnqDgT3Sj6t4m49iDPTHBijNcH0Keer7Pesq04mAgi5ttR0ujPLECG7Jy
	ic1vUIJCnjw2kjb2JYAfyy24WUfhmsQtXOXRIhUdOOKkgRB/ERAiMHBL3wcy5oFw
	B1gjLB5kVQ2W/8wVzFrVQ==
X-ME-Sender: <xms:7WI0abFisUlk2AO9ApzyfcZuKGmE6D5jhXrzKbzWIeVikk6kfsbYCA>
    <xme:7WI0acBMzy_MTgQqYU9aH3-BBDK0fy5dT9-43-97JKJdmFHvAxGfKyZcSTGGCM9sm
    UKhl6uaMzgYNj4u66qluN3HB4F2c0PSgy3_Cjqh8APro-U-gga9Y7k>
X-ME-Received: <xmr:7WI0aW-I-yPieNqiL-6JAmZHLlW7YCW1V64lX3SdZonwXPbLwkKhvofL3QchHSwwPopApYt46LFbvoym3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhr
    gheqnecuggftrfgrthhtvghrnheptdetteejtdefhfffhffgleeggedtvdekgfdvteduud
    duudeijeehteehveeffffhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehgnh
    horggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
    pdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhr
    tghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7WI0aQBB7jrdMOD6FXHAwyVF0vGdbZHTGG-6Lc6avJmo4wNUl1W1sg>
    <xmx:7WI0aTR8TXhE5FSRuyqNq_jP8fYPjrrIHvblT9VU6_E_rH_MNB30eg>
    <xmx:7WI0afu4tP3hrx6ImAwlkLFLLTe_V8K_jTPyUndQoqdiOlsWDSOUSQ>
    <xmx:7WI0aX27kKNLeMd4CGQRCGGD_O4CyoivIVYuSBGaiXDNyBJ0WGxHNQ>
    <xmx:7WI0acK7k3dUwwIrEe_69RaGB3MUAeCCUmgQc9ZtRZxeWplDfSwJ52Yt>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:07:56 -0500 (EST)
Message-ID: <fb6c34d9-0cce-4293-bc99-93d072d5c2b6@maowtm.org>
Date: Sat, 6 Dec 2025 17:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack@google.com, jack@suse.cz, linux-security-module@vger.kernel.org,
 mic@digikod.net, xandfury@gmail.com
References: <c314e302-d4ca-4a39-81ba-d4a1e21b9391@maowtm.org>
 <20251206152611.442312-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251206152611.442312-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/25 15:26, Justin Suess wrote:
> Thank you for the review.
>
> I agree with the bind mount limitations for this flag. I think it's
> reasonable to expect the sandboxer to provide protections for pre-
> existing bind mounts as opposed to the kernel.
>
> This limitation is a tradeoff between safety and complexity.
>
> I looked into doing in automatically, and it ends up being sort of a
> mess, and you end up having to iterate through the bind mounts, and I
> suspect it would be a major performance hit, especially if we have to
> account for changes outside the sandbox after the policy is already
> enforced.
>
> We can note this limitation in the docs.
>
>> On 11/26/25 12:20, Justin Suess wrote:
>>> Implements a flag to prevent access grant inheritance within the filesys
> tem hierarchy

Minor nit but please try not to wrap lines this way, as when the text is
colored / indented by quote level, it makes it seem like you're adding a
reply.

> [...]
>>> @@ -1232,6 +1656,121 @@ static bool collect_domain_accesses(
>>>  	return ret;
>>>  }
>>>
>>> +/**
>>> + * collect_topology_sealed_layers - collect layers sealed against topol
> ogy changes
>>> + * @domain: Ruleset to consult.
>>> + * @dentry: Starting dentry for the upward walk.
>>> + * @override_layers: Optional out parameter filled with layers that are
>>> + *                   present on ancestors but considered overrides (not
>>> + *                   sealing the topology for descendants).
>>> + *
>>> + * Walk upwards from @dentry and return a mask of layers where either t
> he
>>> + * visited dentry contains a no_inherit rule or ancestors were previous
> ly
>>> + * marked as having a descendant with no_inherit.  @override_layers, if
>  not
>>> + * NULL, is filled with layers that would normally be overridden by mor
> e
>>> + * specific descendant rules.
>>> + *
>>> + * Returns a layer mask where set bits indicate layers that are "sealed
> "
>>> + * (topology changes like rename/rmdir are denied) for the subtree root
> ed at
>>> + * @dentry.
>>> + *
>>> + * Useful for LANDLOCK_ADD_RULE_NO_INHERIT parent directory enforcement
>  to ensure
>>> + * that topology changes do not violate the no_inherit constraints.
>>> + */
>>> +static layer_mask_t
>>> +collect_topology_sealed_layers(const struct landlock_ruleset *const dom
> ain,
>>> +			       struct dentry *dentry,
>>> +			       layer_mask_t *const override_layers)
>>> +{
>>> +	struct dentry *cursor, *parent;
>>> +	bool include_descendants = true;
>>> +	layer_mask_t sealed_layers = 0;
>>> +
>>> +	if (override_layers)
>>> +		*override_layers = 0;
>>> +
>>> +	if (!domain || !dentry || d_is_negative(dentry))
>>> +		return 0;
>>> +
>>> +	cursor = dget(dentry);
>>> +	while (cursor) {
>>> +		const struct landlock_rule *rule;
>>> +		u32 layer_index;
>>> +
>>> +		rule = find_rule(domain, cursor);
>>> +		if (rule) {
>>> +			for (layer_index = 0; layer_index < rule->num_layer
> s;
>>> +			     layer_index++) {
>>> +				const struct landlock_layer *layer =
>>> +					&rule->layers[layer_index];
>>> +				const int level = layer->level ? layer->lev
> el :
>>> +								 layer_inde
> x + 1;
>> Wouldn't layer->level always be >= 1 here?  Using layer_index doesn't mak
> e
>> sense since layer_index is just the index that the struct landlock_layer
>> happened to be in that rule's array.
>
> Hmm good catch. I was replicating logic from other places while sometimes not realizing
> exactly why the code is doing what it does and didn't make that realization. Seems to work
> fine and pass after I fixed it in my working tree so it will be in the next version.

Well actually this function would become unused after removing the "Apply
descendant no-inherit masking" code above.

> [...]
>
> Thank you for the review of the patch. Trimming the code was very
> satisfying. I see that the disconnected directory handling was
> simplified in linux-next, which is gonna make things easier but also
> make rebasing require some more careful attention. I assume your next
> patch series for LANDLOCK_ADD_RULE_QUIET is going to be rebased off
> those disconnected directory changes as well.
>
> I'll implement these fixes in my working tree and be ready when you drop
> your next version to do a rebase on top of your series again. If you
> have a base commit SHA you could give me that you are building your next
> patch series version on top of already, that would be helpful.

Will send v6 now, but you can also take it from
https://github.com/micromaomao/linux-dev/tree/landlock-quiet-flag :)
