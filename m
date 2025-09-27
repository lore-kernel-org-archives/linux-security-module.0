Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C715855E
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759014725; cv=none; b=fVWdabWjHDkzBUT/kSrrsbADRA3vAC0dDU0Tj3sw5sB8muzo7Ufsids0FfT5ACw0KYaJ/PgqBU4HVYHkx0enCs3+C8m3is3UnbWqNyWa5a3YcnmBVbCEGH9uhxrBZE9Cla1JWiyzZBiOZMXUqe+LUuKTbKS2Ma6GSXXKUwyt6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759014725; c=relaxed/simple;
	bh=PeLwnzmWhWZkAEvRAaXN1Kaakx3gkccxz+haY3sJGdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6iwcYbByXLv4rPmLUbWyzSn2szMvq+/3nZPIQsveWPgPrDpaY12JwUtSqnbKlTcHxQhKR2Za+Fsihu9soSevIUl1oR7ZAdaagBJP9FRg1y1V2gPn0tJU1qzVdfyOpDeiA3M72VQ/aL4pgT5U1iXa050Cvkj2mkuCjoiqAbt5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SYy/t3VT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wW9EanN1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SYy/t3VT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wW9EanN1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C6B41D0006F;
	Sat, 27 Sep 2025 19:12:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 27 Sep 2025 19:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759014723;
	 x=1759101123; bh=PWAkhMvdhEdQhDMZBhrxc2z8ozeE3hjEFw5XYd3wRJ0=; b=
	SYy/t3VTdxiHQgat02lU2ah0PcK9qtZSREP4gYg0g68LjN4hy2zIwB5auvS4wCU+
	Hcdowd2UzX602Urts7+PaWMme3DaGvX0TgOl6148cefeaDKbJgbTgQvXrxHEBCdI
	W/EGnd9XY1cd2V5lgSOmb+gRqPSQbdZOngT/DAIx3R71mD5AzyJcTIFhYiOAqrjI
	pi2Cbp+RGaoksICQjQxUyUTirzbN7lwnWR/yq4IFKAM861UmvzkaUiApWZqg6mWt
	0imN6lbstOIezIgSz3FteOmpYC4JajnVl3cll2y7dkhyhza7o3yQMbvMySfEWdj3
	MindQvDlxg1hcSsRtYhJFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759014723; x=
	1759101123; bh=PWAkhMvdhEdQhDMZBhrxc2z8ozeE3hjEFw5XYd3wRJ0=; b=w
	W9EanN1tw0oRiwnpwhSAwbWcrtTQbN8LOBpdBBB9KNam1+rxAZizCWHVcApdO+AO
	qxjAUeujMo8yWN2CPTFKtKnOuNO6gMhpGt5zymRWSJefETmEpvtOdIDMHaxvtc7f
	5Mgz12BTiEZiLFJuJpymLy8gHK3hbUM5TJz0kaaVfNcNebUJKF+LidZ4H79qOJZx
	wj2b2yQFCjR1PBhEQ8sOBDJ/AesYPloBlbwlhj9l6iqIUtu9CvwgCie/RPrsPfjt
	qIlZGxjy2guUKWA/Oo0UQrHFd3cHiY9iNuwz7ludjBMsHhfCvDOOln591tARb3tA
	+MFMCEBMkCR2mWQMLmtQQ==
X-ME-Sender: <xms:Qm_YaO1rot5xzPvD7QS7EPr9U8-Urt1QB5qY3c1TnAh0C6TEFwNbFA>
    <xme:Qm_YaIGiyR-3ksz8P2ZMdwyg6YXmV6zv4o7y5kaKywRt59GId1onmIpHadORVGXsJ
    G2a0QfHJav3HnL0yAUuViHuwcXh3IufsPT-JNovNrUBu1hnP7MOdQ>
X-ME-Received: <xmr:Qm_YaL4ksMv2Zurfr45VtOAALjg9_5MjnL6O78NlwF-CPHdbGhh3lSmiHBFmYcx-efwWdtlIN4kQVyBJndY9Gn2v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeehfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Qm_YaOtmSnd5p75nIQxxz3y8j-P973jGnxkL76-RqwFn61DXC-gWkQ>
    <xmx:Qm_YaM4pCvugoYrcFDq1tsKiEOMj_cSm7NMEFDet4XGKkCTPo5Dcbw>
    <xmx:Qm_YaJUuYYHPj48lun4baSwPvtHTbC-Y7S1Dguh5x4uHCQTlced9tg>
    <xmx:Qm_YaO_GgRXAwR3KEvAr1vEdlLerMPmYrXuJNYYm6flvT7lY_YkL6Q>
    <xmx:Q2_YaK0ZX7gNVi7ebOvOWoL0xRs0V4hz8pgZYblwRamIFlTJ3hQlRd0D>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 19:12:01 -0400 (EDT)
Message-ID: <ea125506-fb53-4d04-906b-dd08aa0b836c@maowtm.org>
Date: Sun, 28 Sep 2025 00:12:00 +0100
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
 <090e272e-64b4-4c56-9928-0e0be0288e64@maowtm.org>
 <20250927.ivat2tho0Uom@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250927.ivat2tho0Uom@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/27/25 20:00, Mickaël Salaün wrote:
> On Sat, Sep 27, 2025 at 04:43:50PM +0100, Tingmao Wang wrote:
>> [..]
>>
>> Also, do we want to consider calling this something else instead, like
>> "suppress_audit"?
> 
> Quiet is simpler (similar to the LANDLOCK_RESTRICT_SELF_LOG_* flags) and
> if we get other ways to log actions this will also be used.  For the
> supervisor case, that would be useful to not forward a request to the
> supervisor.  The *_LOG_* flags could be used the same way too (even if
> "LOG" may be a subset of the supervisor capabilities).  Do you think
> that would be OK?  Dedicated flags would be more flexible but also a bit
> more complex.  Is it worth it?  In any case, the semantic and need
> should be quite similar.

I don't think we need a dedicated flag, I was just wondering if "QUIET" is
the right name, but I guess I don't have a better suggestion either.  On
second thought SUPPRESS_AUDIT would no longer be accurate if we later use
it to control supervisor forwarding (it would be doing more than just
suppressing audit logs).
