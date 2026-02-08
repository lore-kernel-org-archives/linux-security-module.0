Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B505FDA7
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770583709; cv=none; b=Ra5ukBPqBgYIAlHZrTie7HOzMAWhuEqCx2b5xDcalWAJ0s87XL5JbhNy/6H+25FN1KCKxw4alZFkJuOj6/ZIHeijqDDYUzhnqCoYopsJFICSXIHk9CYHpF8994Ra2hb9gHcsjrElZPx/7uwQGWW5oDO1OmzRDRaK+GO+NA/TGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770583709; c=relaxed/simple;
	bh=t8e2u/E0Z/frbJIk4691HMYMuZR+QnvNAEnClFwugbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev6/1zlU+uH3T+xSIzp7Z95DJJXzq6fRby61+pT6szJjCihM3gnnbzCz2fGPoEQZReI3mHzAWogwcxt34k+83bT3u6EWfKdroNW178It4NI1CWVwTDixwxgFcyX55jLpg/g+bcJZdN85UEDUYukezpzRAalrAIkNLwbF5uzy3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=kp+TnpT4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOQ/cMoJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="kp+TnpT4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOQ/cMoJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44F9C14000F4;
	Sun,  8 Feb 2026 15:48:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 08 Feb 2026 15:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770583707;
	 x=1770670107; bh=yTRNqY/hh3SNntf2sIWEdvF3I4RDBWHde6AGKlb9w/w=; b=
	kp+TnpT4Fx+V9bMbNgYnjZcnAu6B0eP68DersWr/AqQ8KEVCK04DM1kMLNQ0sQsz
	pSFAyG1LiuXflNRdkMvYMRjVZVfn277vsQnjAcDbKi+FPJdEpNGHi7aa1rRvTuhw
	Ov8oBMllxYyFdR6FsiZEZpXCbxA3MCDOgb03zaBtYdln6l+Iw9j2vtWbqrwY4SiT
	Gdc2BPRj+rri3XUaTOc1WuXKen+IBT7dAHdtPWgK/pQexPaE7DkQaTa/jbA/r+8T
	6kqapzxpaB0Z0rzJgE20wlOJbBjY2awkEVR2OlQJLeYPrPfB1IWX87QRPsW3vsov
	vBCfD5ZAM81GnVfaG94jRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770583707; x=
	1770670107; bh=yTRNqY/hh3SNntf2sIWEdvF3I4RDBWHde6AGKlb9w/w=; b=H
	OQ/cMoJfohS1c2lqrYL8ZHlctmoa8qdMuT+elXnQN0Emo6IG+vk5zBydYVlB+BGG
	iUoAROfnzQZ2MJlFr1x3DdlGu1+OemHJvpHMBSUu3cseJkK5Hp+3llRoK44ZcKlQ
	Uefi84MsQwVBbtXua8mkUjPowNcwfSNOvsASuLcJQk7UBdVs6A075hGDSzFtuooa
	VVM0zouiZT6wuWJIqQYS2a4nKEZpScycAXc1OIr3jrAnUG1xfXLUcjAHG7pywwj5
	gbSzjLANwgkScayAXmfMAAWRU4h1VnG4PFmzIo4D/Dz6EHJWDBg/pJp341jfRkKU
	5X/Z2AQbYahXw6K6iHkfQ==
X-ME-Sender: <xms:mvaIacQ1w9X3BP4a2gkv3sHlgpWKKf-HPvm9y6CQxVX0KwHJCEAcOg>
    <xme:mvaIaVlnTaxqMtOydP-qsjL7h21g5YjaE734EJS1mDmMyavIapJsv1kwSI9HqUoFQ
    wYyTU59lMT3RymdpEQpFyl1R2lhsZ17L4xBuB9THvo9fOGXMST2inY>
X-ME-Received: <xmr:mvaIaVMwLCTGjs1unLqtj2BYYIH4IeYVl1Gl1uGO0RuBXJNuDVu2u6tZT62jjVoYlE211-HiwESvx-IdeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitg
    esughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprh
    gtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepjhho
    hhhnrdhjohhhrghnshgvnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopeguvg
    hmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhisegrlhihshhs
    rgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:mvaIaZhibdPXfR2t29h-H3s_8Pj5pNt-77htDLK7eJP-_bSPEVPG6A>
    <xmx:mvaIaTgh0kaM68NOo69jnd1BsLCeYelfTxF3TBM4l3CUccKhlLKWCQ>
    <xmx:mvaIaYJG70t9buHtaM7uOQ9LXHbDHJuW4cu2IBUbGtxswp4cB5ssQQ>
    <xmx:mvaIaSnfqtO-UbKt1zDPK3r_Hn4GQAPp1CJaFuDId6wFQl-JXSbGrA>
    <xmx:m_aIacK7CEEeMVw-lhNWhJLYIjYnWDfXm3eHHhyndabei17CNUsMrhmD>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 15:48:24 -0500 (EST)
Message-ID: <c33926c5-3c7a-40d8-b910-ac99b43576ff@maowtm.org>
Date: Sun, 8 Feb 2026 20:48:22 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>,
 John Johansen <john.johansen@canonical.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 Matthieu Buffet <matthieu@buffet.re>, linux-security-module@vger.kernel.org
References: <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com> <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org> <20260205.Kiech3gupee1@digikod.net>
 <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>
 <20260208.4600394b9da7@gnoack.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260208.4600394b9da7@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/26 20:37, Günther Noack wrote:
> On Sun, Feb 08, 2026 at 02:57:10AM +0000, Tingmao Wang wrote:
>> On 2/5/26 10:27, Mickaël Salaün wrote:
>>> On Thu, Feb 05, 2026 at 09:02:19AM +0100, Günther Noack wrote:
>>>> [...]
>>>>
>>>> The implementation of this approach would be that we would have to
>>>> join the functionality from the scoped and FS-based patch set, but
>>>> without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
>>>> the UAPI.
>>>
>>> Right, this looks good to me.  We'll need to sync both patch series and
>>> remove the scope flag from UAPI.  I'll let you and Tingmao work together
>>> for the next series.  The "IPC scoping" documentation section should
>>> mention LANDLOCK_ACCESS_FS_RESOLVE_UNIX even if it's not a scope flag.
>>
>> This sounds good to me.  I'm not sure how much code we can reuse out of
>> the existing LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patchset - but I think
>> the selftest patches could still largely be useful (after changing e.g.
>> create_scoped_domain() to use the RESOLVE_UNIX fs access instead of the
>> scope bit for pathname sockets).  The fs-based rules (i.e. "exceptions")
>> can then be tested separately from the scope tests (and would also check
>> for things like path being different across mount namespaces etc).
>>
>> Günther, feel free to take anything out of the existing scope series, if
>> you feel it would be useful.  Also let me know if you would like me to
>> help with any part of the RESOLVE_UNIX series if you feel that would be
>> useful (but you don't have to if not).
>
> Thank you, Tingmao!
>
> So far, the selftests that I already had in fs_test.c were
> straightforward to extend so that they cover the new cases.  I had a
> look at your patch set, but found the scoping tests difficult to port
> to fs_test.c

I was thinking that the tests in scoped_abstract_unix_test.c could be
extended to test scoping of pathname UNIX sockets as well (otherwise
wouldn't you have to write another instance of the scoped_domains test
based on scoped_base_variants.h, whether you put it in fs_test.c or
somewhere else?)

And if you think that is sensible, then I'm hoping that patch 4,5,6 of the
series would be mostly useful.  But it's up to you :)

> , but I'll double check that we don't miss anything.
> Either way, I'll make sure that you'll get appropriate credit for
> it. :)

Thanks!

Tingmao

> ...
