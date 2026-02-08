Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EF1E2614
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770519436; cv=none; b=Q2atF27QGXGFwQ9LNOl7kOgJG0P2nneXapWH9n5znOkZ6wakKI985dnuEVOw0Q/r2rRl2dWvsRkOMWVJNjx/2LVNpocRtQC6VW8JaTHLTxcdYcQOLUSYpTAeCTMv/rtkb61wCl4zLb15UwSBQ1tYEaWfqgZpSQDctTGaf+0MOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770519436; c=relaxed/simple;
	bh=TM/L05LLeSv33qtTyJEiN3pwj1iqtm1uuaXKX61B0+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snkYMobbtzde6eC1Ez9aUjN3tDrd/zjCBQD0O5ZvVArZVGoam2D0DzI/V7fnhuRlqa0j+AvUhpdE7S+Xh2v1WfmcY/z7elFIUNeCbo85E2G8LdGhNBkzIJZrN2vJDtRvpMRBdAMhnNw9PB53tiDQtTbs4sauJqLF/bAPiVlJzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=GjUcE0h4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrSAJker; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="GjUcE0h4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrSAJker"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 14FCD1D00072;
	Sat,  7 Feb 2026 21:57:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Feb 2026 21:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770519434;
	 x=1770605834; bh=QpLyoRRJ6JVL8dk2rZHCo6qPonf4yaERN1Wy1xY4vmI=; b=
	GjUcE0h4Wz04LUUrK9RSlk/URgZcT2AEyT+KBkYNLScEbJLTlmx5KiKXjNnyU3SV
	274mmutrpl9VgSnUjW240c3Fbm00CbNiV967xBngoUdNyRB1cxjx6rzrSVKZEanE
	XFG3xntREOrYN8iuURShgfg1ZFm6W4Svq2MJfJRLhrhtTrzXjO/68wRcpyEaNxN7
	jdhdBTdUwXp1hkggT+GDnaRikWR2KZjj5z1ewPBwLB/ncMeSF373KYe0w/QMqc/v
	o5kgMG36ciNBnnlK3XIGfrZcH3dIy42HieVfjlcQ4R5gx5ZNut4l8YG4/9MJ96kL
	yyGl/FKnlfJooyEtF0k7iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770519434; x=
	1770605834; bh=QpLyoRRJ6JVL8dk2rZHCo6qPonf4yaERN1Wy1xY4vmI=; b=D
	rSAJkersqeMUSxTwSpXOFSe4p3R7cATCYhyc1u3L7c9ajMy+bGxYFhOiXt+of3JS
	JEyViLhDAPWTvI8Gsug2UEifQpLBmuJJd+CSFqdgrw4n5YxToMSW4ux6yTNp85w+
	ACxNBrmNnBaDY/zWy1jlAt+eBsX1MV/sADh39famJ8WAZCSw8AoFZotLWmjpJxi4
	URYxD3gcpj16BnBglOBA9XOXsOf8XjI1oxgPrnyo/PaTt6ZGAiVB3JKa3n2MUTIc
	GelRFixcfpc5ufkEsT3WG7xTaQb2iYv+Zqj2GToRYhq8RMb6XkP0JRGZGtfYmYLQ
	3zb4SB3B8HGYOvpndnufw==
X-ME-Sender: <xms:ifuHaVWpWg4vUycjQimY-hk9mo3aSR5Q1Hfjr1TFKZ7BmU3gtFw30g>
    <xme:ifuHaRbiSR6ISwfTiKXNyBepWTQk909J3ye4W9uj0G49P4bmYj-os_c4Pvpth5wZN
    SJgCwfYYTP5ZLtV9QDNktWAWn1cBZ-3SlxJzXUNODW8nUpdnp75Ampx>
X-ME-Received: <xmr:ifuHacxALo-FIIPXVBF6OX5v9z62RKDl0v5wkV5KCOGxtbLUQwDLBkWfB4ZU4ESDdEDpDnj0WccPOw11fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkheftd
    dttdesghhmrghilhdrtghomhdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprh
    gtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepjhho
    hhhnrdhjohhhrghnshgvnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopeguvg
    hmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihshhs
    rgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ifuHaR0cp1szzfPMQccHanxsJw3MHs2mXrtpGjiVVTMD072Uztw_Eg>
    <xmx:ifuHadmcr4C9wmCV7YjiCo5xkepblGMD3Y__FsYMdIeN1RcmrZ7afg>
    <xmx:ifuHaQ-Qu4IDVcZJu2NyoiTAcW5JABkk0evTYzfdZQl_F6-X7X0x3w>
    <xmx:ifuHaTLetsbv31hYvVWc6Ba-3nR3VfHD84XYccooPvuSU7MHbcHBBQ>
    <xmx:ivuHadvEaKGBd7zQjGex9AYcN2ZsNeecHwfbv2SeeflJ_j3XCWts8N8D>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 21:57:11 -0500 (EST)
Message-ID: <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>
Date: Sun, 8 Feb 2026 02:57:10 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>,
 John Johansen <john.johansen@canonical.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 Matthieu Buffet <matthieu@buffet.re>, linux-security-module@vger.kernel.org
References: <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com> <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org> <20260205.Kiech3gupee1@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260205.Kiech3gupee1@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/5/26 10:27, Mickaël Salaün wrote:
> On Thu, Feb 05, 2026 at 09:02:19AM +0100, Günther Noack wrote:
>> [...]
>>
>> The implementation of this approach would be that we would have to
>> join the functionality from the scoped and FS-based patch set, but
>> without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
>> the UAPI.
>
> Right, this looks good to me.  We'll need to sync both patch series and
> remove the scope flag from UAPI.  I'll let you and Tingmao work together
> for the next series.  The "IPC scoping" documentation section should
> mention LANDLOCK_ACCESS_FS_RESOLVE_UNIX even if it's not a scope flag.

This sounds good to me.  I'm not sure how much code we can reuse out of
the existing LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patchset - but I think
the selftest patches could still largely be useful (after changing e.g.
create_scoped_domain() to use the RESOLVE_UNIX fs access instead of the
scope bit for pathname sockets).  The fs-based rules (i.e. "exceptions")
can then be tested separately from the scope tests (and would also check
for things like path being different across mount namespaces etc).

Günther, feel free to take anything out of the existing scope series, if
you feel it would be useful.  Also let me know if you would like me to
help with any part of the RESOLVE_UNIX series if you feel that would be
useful (but you don't have to if not).
