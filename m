Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD4314D2D
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305983; cv=none; b=peytQhIt7JR+MBar/8ivLlx7hCtXwYPti/1ae9k6yahvhWuzYJnRTa+bkDqSRXnQAGAxbYjFGNR2GWs2LQUHOQMqG8yfwzUNa82AHa1IowNjuE2uu4jC8+cXJCjLjRg7HLiXzeFPAFEJair3UAOVPvxvLW8mriF0UGYzJDH2AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305983; c=relaxed/simple;
	bh=+q9o+nqSEi9OaV0pOSVe7e6bEqTPaKhQ6FBsSFV/20E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+JgGN7QAcNvhkdkpoJ+jrr5YIriL0UGprqY2lqbux6Z6w5OpaZk1SplGL+FpfG6QfggzZsxQ8xoOmfNyUWhRFdehlj997zCmYbA+w7zjYxgXGxpvS9n0YaYXVulfBly9ira8xGNRrdY2flvzXbTCJpAUzMSm9edRS9yYb/UG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=iy4gPoGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WE6CGLtO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="iy4gPoGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WE6CGLtO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7ED867A0068;
	Thu,  1 Jan 2026 17:19:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Jan 2026 17:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767305980;
	 x=1767392380; bh=Xm+EwjT1j3sfqMjZty20J8sj1Lbel5TABZTEOTeZtDo=; b=
	iy4gPoGemAOKYvaOV1Ds5ECkIUDIwFOm7Xv9bzrrR7s2zvReuOG08qwndJQuKQ+/
	pZ6dpWwTYM+a58QYSuA9yVIcJC/zrVMLG1o42Ns0KP3WRZTs43C0GdJGBl7yqPhj
	0KkrZ+FNKTZOw3bsdKLb5XjuO1z8llSmU7ZqyL/Zxt76086O8gAEtpErrUA9LDXB
	uaHyKPyTKjhvVAL/aJO/M/tw4hXld7oVRnx2LERkD9FYQkQobcH4qMWOiTQ0T2N1
	kCAiC05ETK0yY3cWk3g8hW+Xb+7QVgmf4klonuUH/E/UrI0GezoJ+aRhpUWkIV7S
	qpDirTHPD2sbOeGdoxkA5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767305980; x=
	1767392380; bh=Xm+EwjT1j3sfqMjZty20J8sj1Lbel5TABZTEOTeZtDo=; b=W
	E6CGLtOP0U56E9oXlCTTMHn7RXnxdKjrf8m0X3coLzrHUpt+RxhrqTvau05TJ24o
	P8SSHAcD+f3BzpAU2P6yLdtO1Yi0B+6elSXNhktLybCverJ8lTgo88PZ0BiZHmPn
	z2AllbILtoUbWvOSucn9FwPGfS/ybPWPYrCRFn1CXT6Wack++YfGbcbs/4/jPP68
	EKGgItiaaiOJoPlJTElqpnSAqGV6/k2pvcZe8bwIalaML3XcTP4Esz+kUboJmLua
	GH69qwzHBOIdSgi1DOVanYIa6eI9b6LFy4KNYhXaAF9SNWPQapC5X4jdFrva8lDM
	+2nmRz37PB5E4B6DlZeJA==
X-ME-Sender: <xms:-_JWaetGGer5hLyc1zkSSPQcBLoykD12_gH70vLBNw2opKlg7rK5sg>
    <xme:-_JWaZ3SiN_ZD-sqfVt_TUwa6h2gh5NsNXz2pQI6u4Z0Tl8E3jJb2mpJ6hjX4j9Vw
    -rRh0x565zs172XhTM9sp9Uu3i0zfkvK9SJecbd8aCH_VTvNDinNg>
X-ME-Received: <xmr:-_JWaWDcJubQ75_wYqZDAjGikeuNR4soXjs6xsO5IPTkbOXRyH9rlJjqsvCnrt987En9IF6klD3WOUcMZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeefvd
    ehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfgtdefieelhfdutefgudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnoh
    grtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgr
    lhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehfrghhihhmihhtrghhvghrrgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhihsshgrrdhishdprhgtphhtthho
    pehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtoh
    hmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhho
    nhhsthgrnhhtihhnrdhmvghskhhhihguiigvsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:-_JWaXC0d7Y7RnSqsRupV9JDKy286SAIoWGv8IziqJejDVtAH-oSLg>
    <xmx:-_JWaXl-Pk0WwgJHFNHdXgD3RVWmo-FFHKfr2O-eFccuRCWmX7Bp6Q>
    <xmx:-_JWaXjbcpznSEKilvJrCVW4rXawJ7tzfyVqmGWGQl73DPlcgKBtaA>
    <xmx:-_JWaRglo6p3ROBrEGFuLSw8jJn1OgXvEV2TMY9_FegvXbjyxgpC2Q>
    <xmx:_PJWaeiu_0uge6SDGDIeCvETBRxVqE4FXNM69XTnHz71EOy81Dh4iVbe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 17:19:37 -0500 (EST)
Message-ID: <2d02eefa-bc86-4f04-b190-beed304337d4@maowtm.org>
Date: Thu, 1 Jan 2026 22:19:36 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
To: Demi Marie Obenour <demiobenour@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>
Cc: fahimitahera@gmail.com, hi@alyssa.is,
 ivanov.mikhail1@huawei-partners.com, jannh@google.com,
 konstantin.meskhidze@huawei.com, linux-security-module@vger.kernel.org,
 matthieu@buffet.re, mic@digikod.net, paul@paul-moore.com,
 samasth.norway.ananda@oracle.com
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
 <423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org>
 <22e29fd8-2f39-4a64-b08c-2f41153e3be8@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <22e29fd8-2f39-4a64-b08c-2f41153e3be8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 22:11, Demi Marie Obenour wrote:
> On 1/1/26 17:07, Tingmao Wang wrote:
> 
> (snip)
> 
>> Looking at this I guess it might also make sense for the kernel side to
>> enforce only being able to add LANDLOCK_ACCESS_FS_CONNECT_UNIX on socket
>> files (S_ISSOCK(d_backing_inode)) too in landlock_append_fs_rule?
>>
>> Also, for the sandboxer logic, maybe a better way would be having
>> LANDLOCK_ACCESS_FS_CONNECT_UNIX in ACCESS_FILE (matching the kernel code),
>> then another if(!S_ISSOCK) below this that will clear out
>> LANDLOCK_ACCESS_FS_CONNECT_UNIX if not socket.
> 
> A process might legitimately need to connect to a socket that doesn't
> exist at the time it sandboxes itself.  Therefore, I think it makes
> sense to for LANDLOCK_ACCESS_FS_CONNECT_UNIX access to a directory
> to allow LANDLOCK_ACCESS_FS_CONNECT_UNIX to any socket under that
> directory.  This matches the flexibility mount namespaces can achieve.

Right, I forgot about the fact that we also need it on dirs, apologies.

(But maybe it might still make sense to not allow this on files which are
neither a socket or a dir? (If the file later gets removed and recreated
as a socket, the rule would not apply retroactively anyway due to being
tied to the inode.))
