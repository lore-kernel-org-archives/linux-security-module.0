Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D9F30AAAF
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767306859; cv=none; b=DoQnYlkcMJhwefeJbEjaB7ozQlbRYQdzdcUXAiN5sagNOPNMaB1ou8MUirMRDttWr+OhJE9b38H9hBtffMQVcmS9xTYl0AMOLvCKeXZKUtuKl6hWKPlk158IdcMfjWZfKl0fzGfJ4aNBDoWdbuBnBw/317T91YEWxhSwtV0pgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767306859; c=relaxed/simple;
	bh=LY7/VG/CDjy7Tz6KpKtZjhfPwO8dt7Og/o6L3NVKfWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/91t3HVEr1cXncvoi3/ZOiIwYd55xwkXAF/iLQQCorOIG6wVVcfL8tgLU7ecm83ulhpbicWBn8Nqc9nDC18xqacV0KwkTpdgHpSAP+dHhguBH0967X9XjGTjlKt1icETyi+uutC3MEqjMn8mTRzqpx/wGWgShmDuvEpXBLz+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=eYiafCgN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHtTmRRD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="eYiafCgN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHtTmRRD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 834C81D000B8;
	Thu,  1 Jan 2026 17:34:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 01 Jan 2026 17:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767306856;
	 x=1767393256; bh=b+5G5t+mggDJx1IvYXy6Qe+zv7slMjGiVirSLsU4m0s=; b=
	eYiafCgNIR+aDQofFqQvYZzF6nSSV04n0jCx8K6HPMYJwN/4j65DZLts78GgLKMq
	sobWU87yKwMB1KUaZV/UuTVQOLJVVxDmK/PeOfE8QtNQbHo0G8cfBSQ61H40ChmP
	pftJZFJ7lR7uYtx75RultjMW/J4pHCNzn8jDuCDRVWD0mOYW6VUGqbOPoQiu7wRT
	4cfEMgi01l1rNTlqldIyGmy/G3TmPbvguvJw92Wpi6o65BqB1T5Z6rjYQLv6ejtt
	DMUw6RhQnzDBVO71fD2FIWie0MPEsToC9074FXLg4EAnquZ4149Xx9ZlXX9xYCa0
	MLZSEzJBnp6hAOjnUHISfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767306856; x=
	1767393256; bh=b+5G5t+mggDJx1IvYXy6Qe+zv7slMjGiVirSLsU4m0s=; b=t
	HtTmRRDM3QaDFiwH58E7bZmrjY/4r5pkujS++mE8zWtsJpWTPs1YRqH7Tl+IRC5b
	QbksqEJmpX3sqjqfW7ORbDtr4QrDe2C0Xaq8k+4ERzEE5KhdlByQJiBj4/uBSKOW
	suB9/jSgTR1Xhkvuaw3PNNG8VbLnq8fl80zFTVNtm4vdEncN2JdJoMRuLplyhKLY
	Y5TgmcLUdUeJU2ZnaZUyVSx91N5WdbW+BvLJrfYg7NWCURmpgjCjw+hatqamcpjb
	baNe6xqthsXftuTkaSvwIbhhkVlZshKHtd1kdmShfBwcA4QMdrx03gd71loxQwaI
	xM4O1S+8Tdov/8A3q4ltg==
X-ME-Sender: <xms:Z_ZWaebprOsNnp1iQlZzlDzC0qCoYeo8Agi2TUPdJAei6xXZBBacCQ>
    <xme:Z_ZWaXy5NhnTVL84o3wbWAd1U0GlrZfPigUsjBnqo8pTlMTK4b5NW8im7Ohb1ySjh
    4Yb3DivqVtxchWfFPaU2Ei_10wEfMvFiUq3ox1cOGsUAPM1Aun4UUc>
X-ME-Received: <xmr:Z_ZWaVODMuqzuoV8WSlO0tFOvPxshGRj4aVPk1iLF7K1bstP6xz7SBX2WSQk3RlZHBknVeEt8kkgS8QHrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekieellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedvue
    efudetkefhfeevgeekueehudegiedtleejheehieetfeelfedvleeggeelteenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdp
    nhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvg
    hmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghkfedt
    tddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvth
    dprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrmhgrshhthhdrnhhorhifrgihrdgrnhgrnhgurgesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtohepmhgrthhthhhivghusegsuhhffhgvthdrrhgvpdhrtghpthht
    ohepihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtg
    homh
X-ME-Proxy: <xmx:Z_ZWaecbcIn8rvq4cs3pfryafoFRHUYetoEkraNk9qYQNqPX-Xcx3g>
    <xmx:Z_ZWaSR2q-H1P02DpNI2GxXeQCgRNObF91PNaUWkt9XHQt-s6L4rpQ>
    <xmx:Z_ZWaUfx_1DhPq-8PeS8hV5y2Dccosgk0X9B_tthFxYBGaU8r854KQ>
    <xmx:Z_ZWaTtoIemn2x3UROnN9Dr-YlQVqZOb44EOkKxvmP9S6lYtnQJpxQ>
    <xmx:aPZWaSdDn1j3dgKwvTKPzN18eL6W5tE3AtfdGLLE3wfjiAL5zA4tdHJG>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 17:34:13 -0500 (EST)
Message-ID: <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
Date: Thu, 1 Jan 2026 22:34:12 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 22:14, Demi Marie Obenour wrote:
> [...]
> Does this leave directory traversal as the only missing Landlock
> filesystem access control?  Ideally Landlock could provide the same
> isolation from the filesystem that mount namespaces do.

I think that level of isolation would require path walk control - see:
https://github.com/landlock-lsm/linux/issues/9

(Landlock also doesn't currently control some metadata operations - see
the warning at the end of the "Filesystem flags" section in [1])

[1]: https://docs.kernel.org/6.18/userspace-api/landlock.html#filesystem-flags
