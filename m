Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7026264A98;
	Tue,  8 Apr 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104202; cv=none; b=frJVJKQrx0/vricWnABDKWclR/qP/Q28y9fX2yxK5jV0ztslEmdB9U0+Djw4mZCrDOwTmSkupsdgtoFHAjxmYJo9JhaRI2Vom3K2yBwZGH1zqi5itv91dbPIYmURSNTnZvhjd2mqsPtKe+wrhjTFznOASBQjgWx6P6pIEyFYbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104202; c=relaxed/simple;
	bh=TmR/0z7qOdbQJh5BzlGPXNobyhBL1J7fuSAD4uQxkQg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cht8ubE69+2Dgcfl3ZnY9ViMbk0AGwqYTI7rEocIcwEjT1itC5jMNbVNXoF+nD7q0WoLUae6UCaf9dBbtTRGX04bpjZrT82qqL8mfChKUOaaOGSz4aeqeEXtNxYj97Gr/YYpo8vx5osfGPkbC+6D4wRmUvU6Q5BxgWjOXgSvozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YUGrFE6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEls9xHu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YUGrFE6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEls9xHu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ABE26138014C;
	Tue,  8 Apr 2025 05:23:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 05:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744104198;
	 x=1744190598; bh=lkUJ8TgO3ooNDZY0G1GBRHyyAS9TWfqRd6Szv2PjLyo=; b=
	YUGrFE6cju58jVKO1KkDFmeuF2owX0fjBHC/bhbeghn2yC1UOqCLnnstPyEoT4G6
	JuJr1RKyrN4CNwkjZX50i38xy1jIy4TQHJlMaoDYpfEWB7luuNFiJH0+JwPV+6hw
	ZnW6lRTqBE+j58EgoWN9euADHwazBdujrDG9pj0BE3taz+9tiv8X1Qk1WXibAox2
	4s7+jibrdjobG3HbxL8eHM5b9m4hrPx6uUzTlnbGiIkI55iUbEdD58IzZFU2Scr4
	BNPSXbzx6SWvJVXkSUbYuVIA2yuop/022o0P+OEj0SQV7Es98fLHH+hR9D44edOg
	dv/x1gJ0/9WX+Mo6Njc8AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744104198; x=
	1744190598; bh=lkUJ8TgO3ooNDZY0G1GBRHyyAS9TWfqRd6Szv2PjLyo=; b=e
	Els9xHuDDQlhi4oUB0+qIo3rwL5nqnHZGhlihMthRVVB97orxMZHS06o/IrOMd3t
	K5DVb8vKzK1yMYyY7bbJuh9yG1yCZxT/QXMj0NSlQ7jBez2f03xBhJRP6wMfGOYe
	Iryqdyzz1/zR7CVlYSJnEjFGeBpfOBEJbSlpDVXMfZ51n4ICzgyyDb++96g94Bac
	MB+/DF9PGsjG8rVPx9MIitWwut4PmOtti6PQr6XmLT/9YheX7n6VMREDStZ4Shz8
	vlQtYq4CBLKpTBmzd1HhAQYrboMg+bAR6cAYYaM3vZqLBWcQ1Db+D4ZUPeY2epKL
	r9oRmI86ZOaFyLMZgo1cg==
X-ME-Sender: <xms:Buv0Z5v3mg_Qnws88A6GcwiDfTbx7q8IqN-Y1CtY0qiNaH4YnwZ3pA>
    <xme:Buv0ZyfLStQtYduitttDbT2YpDRTTT_tOYhDgbl3PHAqd8eGV06rtyknrLB7tSeCY
    hwYipnAXPRQGkLPtOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepgefgjedujedvieejgeelgfdthfduffeiteef
    udeghfffkeejfeehtdejfeejteefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
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
X-ME-Proxy: <xmx:Buv0Z8zhsacruqlaxm7DRqwQQx4uXWDDUbpvm-dTIL5Yy8Vwuf3HBw>
    <xmx:Buv0ZwPYjYwGPS9TI7cT90g_ucXLe9nPwY_6QUImVsVFp5PfjKu7Ig>
    <xmx:Buv0Z59vf0FKcY21Y5ouQRC8r9kYlwKoa5Sl7VfMyPtQoxeWwqDltQ>
    <xmx:Buv0ZwX9BauKZWKsQ-5FTelze0y59_NhGPB8QF6kCJ7zt9mQE6oazQ>
    <xmx:Buv0Z9VvkNJgs0Fjx7WLD-pvnqWQd3rSvCTTjTPvuw8RbF20YsvkK-gH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12EBB2220073; Tue,  8 Apr 2025 05:23:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T00187b92ccd5616f
Date: Tue, 08 Apr 2025 11:22:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Kees Cook" <kees@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Ard Biesheuvel" <ardb@kernel.org>
Message-Id: <08393aa3-05a3-4e3f-8004-f374a3ec4b7e@app.fastmail.com>
In-Reply-To: <8cbe0cac-2952-47b6-9b0d-1400aec0bf25@sirena.org.uk>
References: 
 <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
 <8cbe0cac-2952-47b6-9b0d-1400aec0bf25@sirena.org.uk>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 8, 2025, at 00:02, Mark Brown wrote:
> On Mon, Apr 07, 2025 at 02:33:40PM -0700, Linus Torvalds wrote:
>> On Mon, 7 Apr 2025 at 14:10, Mark Brown <broonie@kernel.org> wrote:
>
>> > Arnd bisected this to c56f649646ec ("landlock: Log mount-related
>> > denials") but that commit is fairly obviously not really at fault here,
>> > most likely this is an issue in the plugin.  Given how disruptive having
>> > key configs like this failing let's disable the plugins for compile test
>> > builds until a fix is found.
>
>> I'm not against this, but I do want to bring up the "are the plugins
>> worth having at all" discussion again.
>
>> They've been a pain before. Afaik, the actual useful cases are now
>> done by actual real compiler support (and by clang, at that).
>
>> Who actually *uses* the gcc plugins? They just worry me in general,
>> and this is not the first time they have caused ICE problems.
>
> There was a bit of discussion of that on IRC which didn't summon up huge
> enthusiasm for them.  Arnd noted that:
>
>     https://github.com/nyrahul/linux-kernel-configs
>
> indicates that Talos 1.9.1 uses latent_entropy (but we didn't check how
> accurate that survey is).

Talos also uses stackleak. I also see that alpine and qubes have the
same two gcc plugins enabled.

On the other hand none of the other 60 distros on that list use any
plugins, and most of those kernels appear to be built with a compiler
that doesn't support plugins. A few notable ones (Arch, Fedora
CoreOS 35, RHEL 9) in the list have CONFIG_GCC_PLUGINS=y but then
don't enable any of them.

>  He also noted that GCC_PLUGIN_SANCOV is
> obsolete as of GCC 6 (!) and both CC_HAVE_STACKPROTECTOR_TLS and
> GCC_PLUGIN_STRUCTLEAK_BYREF_ALL as of GCC 12, Ard indicated he wasn't
> worried about loosing CC_HAVE_STACKPROTECTOR_TLS.

I've drafted patches to remove these three now: even if we're
only moving from gcc-5 to gcc-8 as the minimum supported version,
I don't think there is much intersection between users of those
plugins and those that are stuck on gcc-11 or earlier.

      Arnd
