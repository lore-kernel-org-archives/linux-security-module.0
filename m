Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301021C5D7B;
	Thu, 10 Apr 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272021; cv=none; b=fYILRAOZgGP5y7UP9JZT7rnalxd22aTw2Xha4ZzDVNgftQ3oXmjh96eGUZG76AH1niNB3F27LdA640AgC95e5M8f6p3xue8a/2dC/LmGndH6NWNsl4dAVerAvxpAdzxjTT1mGczMBjzgZSuf1PQDyMtgStHUM3yyDytCMGwSp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272021; c=relaxed/simple;
	bh=BNs36cFblgpNUrlfgerskcnvl+4ODLGqjQaWjV2nbQk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mv/N0Iqw6tvPQ9qiWIGve4vOcN+G9LB9wLhsmmH6ct3zk0jOu/WYWTvF/1j0PUvXTsw2L3tWkW3d/ZDTrAuU1RCMQjPzH3asxjG4XWgWXFWTRfyld3uaq6HQBOS0Cv4ylfcKgXW2dskP4QqPOIEnldNMWOPacQ4WeSRdJre7C80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Hx0NLMPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcPV92j9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Hx0NLMPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcPV92j9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F114C2540229;
	Thu, 10 Apr 2025 04:00:14 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 04:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744272014;
	 x=1744358414; bh=vqd+an8KzXjGcgrrzFgvmuFuLXgqiHUn3jGJ2YEVl6E=; b=
	Hx0NLMPiXyE1YQ86SebCLF3W12WY1IioWIfq1mWquoe68p3aw/Ctw2gyCO7J1y4Y
	nf6BFz7qOTjShAo18ecvfoZ1/LCrV8ZEIbcOWWmcLqtkGOh8otNwVtBh+sN1iE65
	+N42IEp9dDn2KBXKnjrUk3g5O9RV2QStfAZWxGU7Jo7pGRLWH7SJ/whlm4rgniCC
	Yjp6PrzfU0MHV0+pYz52ED6/C1uR4EIQD0CX8KZC6ymcVnpKv4AHAO0NnVhSY5fF
	g0elQktLD7Pn7r1X/9lN19CNyZ+BtDEphyuqMND51CGbkbxeiZAEdC9G/2/8ox6a
	NgeizINB+ai+CNy67L9xaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744272014; x=
	1744358414; bh=vqd+an8KzXjGcgrrzFgvmuFuLXgqiHUn3jGJ2YEVl6E=; b=f
	cPV92j92d5IZn4lx+B99WEghiDBqzEeOqel+uV1ReDor5TexLY6BaLzYNdKH0WGZ
	v5frIPWBSghVBd26sdbvvri0TksPiQ1EA1MEgXVy/Tdfmvn7C+d+/S/EvI2JfAKy
	bSYEWQua7yDglmWGQBq2lSN4tBXjK2ZTgARwOI99QK0MuDRcbdDOrERefAkU5u6g
	qPWf8moNR1sM1z3SqOPXNxEV68elS6kwMupJv10xMX/5w0OXNo6KtMifJhMciRlP
	xFZ8ASzCg1ZrdhEz+bYadV7Kx3IUydYWz23DQDdy+3thMVCctobus66QbYGzIVvM
	7IdrnPBrRUk2hJGCmG7/Q==
X-ME-Sender: <xms:jnr3ZxRGQ9hMYMU9hy4gqbC9vI885ZxMpYJRNU_h6DxvJLzhR7r2nw>
    <xme:jnr3Z6zqAMBSavjnMhslQk92V6alM0_ij0lIvIODZkCJEXq8JnkUSFqkTbCKRWMBm
    vfc7ub9nPnx6imxaYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvefgieeugfffleekjeeiledtueduledtveej
    uedtkeevleffjefhfeehlefhfffhnecuffhomhgrihhnpehphhhrrggtkhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghk
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    vghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghn
    ihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhs
    vggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jnr3Z23LKgl9hZ6QcREDgqwpMmhfLDt6lAALKbbCP_NoKIJCosyM-w>
    <xmx:jnr3Z5D3W62L5bLVYc85RsVpiUQwOFJo2J_vLbJF9S1_XHi5k4SWLg>
    <xmx:jnr3Z6iMl8WcJZv1cwMdAPotalW6C98EFI1qolSibGqvJc1TF1y8QQ>
    <xmx:jnr3Z9pvrCW4jNtcNLIQICPw3jBIzR-q02jOyQYUSfID_ETX1mPU2g>
    <xmx:jnr3Z-41hWrlmOzfeS929v4IhapaQuO_5TJksYkBKtYuUmpaadop9ZR6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3BF582220073; Thu, 10 Apr 2025 04:00:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T00187b92ccd5616f
Date: Thu, 10 Apr 2025 09:58:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Ard Biesheuvel" <ardb@kernel.org>
Message-Id: <657fd022-4056-4f7f-aaf2-b4bf88fbcb38@app.fastmail.com>
In-Reply-To: <482D3DA9-7336-4D36-8758-4F8DB48EA8B9@kernel.org>
References: 
 <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
 <8cbe0cac-2952-47b6-9b0d-1400aec0bf25@sirena.org.uk>
 <08393aa3-05a3-4e3f-8004-f374a3ec4b7e@app.fastmail.com>
 <482D3DA9-7336-4D36-8758-4F8DB48EA8B9@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 8, 2025, at 22:37, Kees Cook wrote:
> On April 8, 2025 2:22:52 AM PDT, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> indicates that Talos 1.9.1 uses latent_entropy (but we didn't check how
>>> accurate that survey is).
>
> The early RNG for small machines remains pretty bad, so I can 
> understand wanting to keep that around. For bigger machines it's not as 
> much of a benefit.

Does "small machines" still mean those without a cycle counter
as in the 2009 article [https://phrack.org/issues/66/15#article]
or are you thinking of those that may have a working
random_get_entropy() but that remains too predictable for
add_device_randomness() because of the low frequency (e.g.
19.2 MHz on many ARMv7/v8)?

The former (ARMv5, AMD Elan, Xburst) were still common back then
but are mostly extinct now, while the latter obviously remain
in wide use.

>>Talos also uses stackleak. I also see that alpine and qubes have the
>>same two gcc plugins enabled.
>
> Yeah, stackleak has no viable alternative. It's effectively 
> init_on_free for stack. It's be nice if there were a way to do this 
> with upstream compilers (track call depth).

I guess a simplified version could in theory be done in the kernel
using _mcount without compiler help, but that would be much more
expensive if every function entry has to call it, right?

     Arnd
