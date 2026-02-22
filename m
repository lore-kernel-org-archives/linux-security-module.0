Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8086495E5
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783470; cv=none; b=YGgT3+Q4n5zPJTrZkEWfjAUn8rgsH2ClEDgObeVEDOqN4OXVllVKbyrbHkhDhvDUA8YkbBp54X8EYIV1wGaVjMCO/4bl4DnFPPRmL1LnNHuF81cELT/y0aUCMYjGKBaj8k4ZJqyA6Cdqlwe/XbPXA+JuKPKhjwZx2yeWKJw8GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783470; c=relaxed/simple;
	bh=8eIovSrf5/XnLDmSdrK0ZsM1zj5p3faH8AKHJ1jeX9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mZrJ1WFnhofKOYVECivYXzz7SN5q7K4nvcBRj09Nla1b4qcUNsWhB3+/Kxu+XBAdNd84rgIp64Nns5ZCMDA797LvAAsqXaT5baEggg3ZBUsg2RbIeBy+4h6tg4JhXOa0H5RXuSL22rOuP0MBba2WnMNl39XvJY02O4FosSrYiV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hlh/J+bl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiLcfkht; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hlh/J+bl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiLcfkht"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B778F1D00056;
	Sun, 22 Feb 2026 13:04:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 22 Feb 2026 13:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771783467;
	 x=1771869867; bh=FOWWQFNcCKVeu3KIMQbTsnTbbyku2ZPjH/bJMpEEl5A=; b=
	hlh/J+bls7LyzzUP/A/WRPllV+HGRApyVFUEXnhepVrBqjYkNe2M+js7PGJEtwyK
	dO6X/zJeOKCJGgc1kGRi4bvlcHpI+o+fyh6HQKdY7sN/YK38AOA7gHbBe22Eka1T
	BSxdhEA26lsFOYbylYEILlK9as0jmWHTIeuhz+JbpN3HKL7Xoln035WUaxjZ81vb
	chHXgJrKfRFfl4UyfJ+6XP8pKt9UNCCbcQS1YTDjZgAq1slBFBoQC/Sjm+OlqJJL
	c7MqfVvSOQVkmZ4KRvsLWZfSK/fBon6A8fQPl3ZJRWBskXaCatztFPSYikhBqbvQ
	50YidWcMlGPKouOgGPX3qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771783467; x=
	1771869867; bh=FOWWQFNcCKVeu3KIMQbTsnTbbyku2ZPjH/bJMpEEl5A=; b=S
	iLcfkhtNaikf5jaiSLtSMRTY2FNTeYtyiFQ1so0Pc/Sd0pBO0tzioOoP3uWsHf0P
	vdQ+0QCG8HLWICq2z8UsvS7ZAb46YFCECtCSsmUKDJmL/VYH9wFjNsCqo0QoO2lo
	cOXhJ+MAebLe62GG4VGgGFFlUhgV/yAdVDO8Ec9BYCOBFQwkFsOvB5e7N5Iok4Gt
	41JM7M8q+etXZDhOeqwliGf9PmKqTZbYkl9WllLz1xIj9Y09IPd2kkxZRUH11E0k
	COzvw5TrI0hgt4wKaq/e4QgEil27ScdYEUYoKfevzqkEdoWU+dmRv+MA4TPnMfQ9
	uqzUP03ajJOa7STqUS9kQ==
X-ME-Sender: <xms:K0WbafMnjyjIxiZzQlr5P1HFn2Q9fB8FYVv9MaPF8Zn-ovIpib0XBA>
    <xme:K0WbaQ8VC9TulmQYDuH7EX72tJv5obuFZU0j0uqSB6jw-7N95Lbk-vgiDxEc1RceK
    VGP_6Y1XWa4UhtuiB1PdybYy4aFyfDyJBP1afwXGrnBOJYFreaAr_M>
X-ME-Received: <xmr:K0WbaTR_YRc2AoNINkgZyYAdXZ5bLK6gTx8m78vnP3-KVzXL3c52UgdyN_Z_ZEJfLLEM8Ny27mYKiwViwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepge
    fhuddvffeftdffhfefheduvdduieevffdthffhiedvfeffieegueeiuefhueegnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K0WbaSnv28Ec79p1UxfcKsZNmMNCYdHcXtWV3JjcELQCR3TP4dzHqg>
    <xmx:K0WbaTTgkNh-9pZOdGIPjlvdSVTTKAol1_Wx9MQAf9CcFWrYmMZbHQ>
    <xmx:K0WbaQN8pHUClvlCJnnhZt9mS5LhHYm5pwo-eqkMMVsBp6uHK7AXHQ>
    <xmx:K0WbacWSIlO0JLKegxEsrju1myg9BblFRrzDVI7c_RiJtukHCirODw>
    <xmx:K0WbaWwudAOOunJJ197lnARvoR_XCz9ku_O098Swz1D5t-LIAp5t-VIS>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 13:04:26 -0500 (EST)
Message-ID: <e42eea1e-45b7-468a-ae99-f47f0d1a14a8@maowtm.org>
Date: Sun, 22 Feb 2026 18:04:25 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Landlock: mutable domains (and supervisor notification uAPI
 options)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Justin Suess <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org
References: <6981cdab-dcff-47fc-a236-1890f9bc9c55@maowtm.org>
Content-Language: en-US
In-Reply-To: <6981cdab-dcff-47fc-a236-1890f9bc9c55@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/26 02:54, Tingmao Wang wrote:
> PoC code used in the above videos are largely generated, somewhat buggy,
> and unreviewed, but they are available:
>
> - mutable domains:
>     https://github.com/micromaomao/linux-dev/pull/26/changes
> - supervisor notification:
>     https://github.com/micromaomao/linux-dev/pull/27/changes

btw, on second thought I should have clarified that I don't expect anyone
to review any of the code here.  Those were done purely to ensure that the
design I'm asking for review here actually works, and I'm open to any
changes.
