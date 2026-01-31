Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9B15B0EC
	for <linux-security-module@vger.kernel.org>; Sat, 31 Jan 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881709; cv=none; b=XcxjfmcUxEbENpeSJzPgnd4GGWP03cBZRhhCoXSX6uP7I2HZqYk10+r3dXuCNjF9VbKAO1EUYA9scXjLoEMU04uDIC+UhQ/O6vWmgG9SWYvlNOcEvDCq2r1hWEo5PKcWk3TBx8KbZh2kVBeYNCEWveLxlLtenTcsVUH+zRBBZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881709; c=relaxed/simple;
	bh=As7DJ1ocGfhHUMvzNJ1Hs+NrX/Cu53yLVP33BkVhLTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lgCk2lhqKEHRe7JKQgJhv5XvXY5lqnP7ZFiXvu7Mp7gY1MPfsaIHKJLRee6WpSq5wjpbXvvyKBDUr5mtY7uqkB6ulaEshfehn2v7SUTTLnbPCxaeJK2+9Gl5LurdqZxnQ5NhliCoXjmCwPnFgCZb1LOXJsORwaaKi2tzm5s7tqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=j8eGebU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZwzfOXz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="j8eGebU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZwzfOXz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F640140005E;
	Sat, 31 Jan 2026 12:48:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 31 Jan 2026 12:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769881707;
	 x=1769968107; bh=7wVe0n1n5Ngy2zZK+f4DUVX9/G5ON5Ju9D5o1T2WueU=; b=
	j8eGebU2m4R8DNXpp3JDDUBHZ9EC3H9SOKJIM7RzInz6rsWlP7c7Bea47oSyjgAH
	YAnFBM2k/SErSLaheLH+e+IFpkon+GTewNABc9z8oZ0A1ussgSfi75asrmztdBtQ
	Dw7iy/l2d1FQBeTdqYuYbJdRX52cXu62BR90xcgXf07Z4eNvz9FFBfAHmtFdIIPT
	E3TevMcpYF9r/CWvdzrAlOEJ8NpR40vUDjnIbyFv8jnsdPBZtxM9SQRI3NM4+h9m
	uejxiiTFwj8GbK9E7iR/Ld8tGKKRz1QKz93VzAvuJaHxDq8xKwjzIGZzTwmmvl4p
	dpy+yP933jX2Fznx0ngiNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769881707; x=
	1769968107; bh=7wVe0n1n5Ngy2zZK+f4DUVX9/G5ON5Ju9D5o1T2WueU=; b=f
	ZwzfOXzeaEVyBROw9087smi6TRpXSduSp3/Aj1Xe5jSOdUWYTC5s6Z9FEqKyTExG
	HPy/tu/OKa/RgCocoWlaE0M7a28Lw26lUnzhDAUNm7y5J2biE6SZEUQ6mdxjMs3H
	oJkGmi7Ol7panqkq855HxOJtN4EaQwobQjmvMDWEvyW6JWg1kV8iV2KisxqD7wXQ
	gK+em1SGhpdlRZs7fFUpL/IcTY1cL7qriO5gZBD3Z4qYW/XFSlZtPclmCOJgSWyV
	sWS3o13g21DelrsOUoGiehYkAba2blW2dNkB7tfqBDcXnVwWdvedvNS14vxvLRQW
	VyABkzmlnC/3wlPDmf5Rw==
X-ME-Sender: <xms:a0B-abo_AmUaPRHRQMP5lr5hiUl8cfkpepMaTS9jlRHuRHEqzEiRYg>
    <xme:a0B-aUs5F6GeqBCjlGp9BrqnQbgbBV_rVGwF9k8vO2hxp9Jy0u2nSvBWUkSKRjQKc
    2A9xbCp_n1drApfbUZ7GbmM72jxfkIVuoAvcZv9Ak_FRU7Rds8wnUQ>
X-ME-Received: <xmr:a0B-aeaEDeNQqAa8jHMbiXXI0RHpYRUwwjjbz1stqG_lEwdsUuhVgY9WjwRHNgibcKKn6GhpK1G0bYYlOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepje
    efgfeghfejuefhheeigedvteetudeiudefvefhhefggfffhfetudefteevudffnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnh
    gvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhi
    hsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehuth
    hilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    shgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a0B-abZXGT-zbOJLLu9CiS_9SsGl7Bng9sfq6bNKGe4vEQGCYSmwNw>
    <xmx:a0B-aflqnnqrLhMQ4tn33I2IZzSXleAmLEqaZkbafU8k3n3yo51eMQ>
    <xmx:a0B-ae0_0_UeRPKEuPjR5tmV9KSWzyb0vrS6JxnknnMIEcU4MTwXhQ>
    <xmx:a0B-aX12oG2UuFr2R2riM0t0BqxQicycv1I97W9PH1k7_eCRtXV5xQ>
    <xmx:a0B-aSGSLDjiQmgB5ThNhJ2OdUmJDMLL-W7TqrWGJuNGwymKQvtiUINr>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 12:48:26 -0500 (EST)
Message-ID: <5a2e3aad-0eaf-4964-9629-333b36a05ae6@maowtm.org>
Date: Sat, 31 Jan 2026 17:48:24 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 3/6] samples/landlock: Support
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <5e9ac4104e5f70cdf250a3dea9a553a65a36fff9.1767115163.git.m@maowtm.org>
 <20260129.Hizei3ea8eew@digikod.net>
Content-Language: en-US
In-Reply-To: <20260129.Hizei3ea8eew@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/29/26 21:27, Mickaël Salaün wrote:
> We should have a (potentially small) description of what this patch
> does, even if it's a bit redundant with the subject.
>
>
> On Tue, Dec 30, 2025 at 05:20:21PM +0000, Tingmao Wang wrote:
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>
>> I've decided to use "u" as the character to control this scope bit since
>> it stands for (normal) Unix sockets.  Imo using "p" or "n" would make it less
>> clear / memorable.  Open to suggestions.
>
> Looks good to me.
>
>>
>> Also, open to suggestion whether socket scoping (pathname and abstract)
>> should be enabled by default, if LL_SCOPED is not set.  This would break
>> backward compatibility, but maybe we shouldn't guarentee backward
>> compatibility of this sandboxer in the first place, and almost all cases
>> of Landlock usage would want socket scoping.
>
> I agree that this example could have better defaults, but this should be
> done with a standalone patch series.  An important point to keep in mind
> is that this example is used by developers (e.g. potential copy/paste),
> so we need to be careful to not encourage them to create code which is
> backward incompatible.  I think the best way to do it is to request a
> default behavior for a specific Landlock ABI version (e.g. with a new
> parameter).

Just to make sure we're on the same page, I was only talking about whether
we keep the behavior of the sandboxer "backward compatible" (i.e. if
someone ran a program that relied on accessing UNIX sockets of more
privileged programs, if we make the sandboxer start enforcing socket
scoping by default, their program would stop working under this
sandboxer), I was not suggesting that we do something which will cause the
sandboxer itself to no longer work on older kernels.

But on second thought, the sandboxer is already not designed to be relied
upon to always behave the same way after an update, since the user don't
get to choose which handled access rights are added to the ruleset.  With
new bits added to either ACCESS_FS_ROUGHLY_READ or
ACCESS_FS_ROUGHLY_WRITE, the policy effectively gets more restrictive
automatically.  For example, once Günther's patch [1] that adds
LANDLOCK_ACCESS_FS_RESOLVE_UNIX is merged, the sandboxer will effectively
starts restricting pathname UNIX sockets "by default" anyway (under any
dirs not listed in LL_FS_RW).  So maybe we don't need to think too hard
about this.

[1]: https://lore.kernel.org/all/20260119203457.97676-6-gnoack3000@gmail.com/
