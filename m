Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7217736
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771123307; cv=none; b=hjFPadOqKFQgm7KXvtE6R0NdjDAR08TRJhlpYeMZsaJEnl6uDbwtljDqgYKgOLOXLPaaiaA7Fsh/OC7vM3piDDO2DnBPJNfbz7vkh5o4o4IaVRNErB76S1GvL6Hf5nqU2rEmjgWF2F8p6M834qCE8CLK6a4BnJ7RKdJ5Ukx8yAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771123307; c=relaxed/simple;
	bh=J0SsC4fYjAm9XhEO5rSPDwh+t7XKHEi2ZFm6z9zd5vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwrOSQfASL/Z/j9yCa3IvrSlWPGC9OG39ydlRyR2RrBK3vsgr26R8hjOxZM27inDAD6xW3bA4GypZEK1Z1zJPq54bbQoXpqWhJel/fdU+Szdo2ljPoXUIJzkG8l2t8a1hg0zOywGbI4pjfSQQe7KVF+tAyY8kjSkmK3fUx84rYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=A97waEOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMpdyzsL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="A97waEOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMpdyzsL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E5CBEC025D;
	Sat, 14 Feb 2026 21:41:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 14 Feb 2026 21:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771123304;
	 x=1771209704; bh=pujW2IvAlb6JhxZ57WuIuQx4nlZuJX8wu7Lxm1hEiuU=; b=
	A97waEOdkSWbhxikgm9DwGuJl50DZ3nQpuYk7pSsxbthuU5znKFvgfGgvPdt/Ggk
	br3VzawDe5yu0ASE51xNRUArTaoXDzE1Fu9if9Ww2LJ5kxG1kIUB4JafGaIW+hps
	Q4nBH8KjoMyw1euurDUGzUO0hA7UANCp0BmXD+QV8QOFNaTqxz4A1cNMseAuSrze
	MHzqAKVo0W0QKYf3H+WvUJ1S3bg9VUiYFTrLCjgehuHM3hDrsi3JjOvfv1T7VW+6
	DxfORFwhtHYMjxr/dYsdxN12eYBn5+/XYOagD3uLDQBgPlLoRmXUFrx/0SENMNxG
	ay6My8WiN2tv+rhY+FBaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771123304; x=
	1771209704; bh=pujW2IvAlb6JhxZ57WuIuQx4nlZuJX8wu7Lxm1hEiuU=; b=u
	MpdyzsL4vd66ozlaIgUTqWGivNmOHw+qzoKLrTu8rUNgE0aAYKNxUT0aF/K5gziK
	xN2uGljmn+EElKYCdgV4x2HKdVqD82xEiWEs8sjGrVOba1G9B7DTeQniqfr0e658
	GLmE0DTwAPJIN58n1rutt/A3BUpsPlh20+LsJxYOJQU7S2ekUcLZfL3/k4zzzvFU
	/mYzkGOmosIwgnFuoKjnXQE2wuI/lM8f65gyZcvMqNAvi1DHQIkVAgaWLjKSNljA
	v16xl0ZS2RN7rNblk+eJbfcN+DBqzOd6a6uz4F89+w9F16EaAGyeGx2G9H6zBFAr
	IIKBUmloK9qptljIh9wkg==
X-ME-Sender: <xms:ZzKRad_PyM3tiMg0yJAs3Pw6YpDuMM0jPpS_1hn_hyslRmT16zCLbA>
    <xme:ZzKRaao10xChvFCqgOX4ZwslyieqCQtVBwJqtsOkHp-BPi7zGOOYMZPEZcVlXPE5C
    GmPZFyx5TclKdVg2pUZmIdsAAh8pnDmUqNHSRfWalhKdZMW9kTm4zQ>
X-ME-Received: <xmr:ZzKRaWndFScdrPzA9Pumvm4vbli6VkkUERMJv1SldbOZJhJgKtzC9BdSYXtIpD6F8_ILBSO303m1O_4vHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghnghhuihhnqdhkvghrnhgvlhesihdqlhhovhgvrdhsrghkuhhrrgdrnhgvrd
    hjphdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhn
    ohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghlje
    ejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhm
    ohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZzKRaRjdeGuPiJpBw7nHge8FhKs6b2p9wv-F-48FQyN0M1xNPQhX-w>
    <xmx:ZzKRaecN_UPNE4GrPjcD0Rm4X13xVvFQY3_XuqoiZvlhNIThA_tD2A>
    <xmx:ZzKRaRjlHVRWe36tmGGfxdS_dAPb66eC86j1BkeZ-C-jhBocWb7Y3g>
    <xmx:ZzKRaWzqIxX1C1ASWpDn3Y0gPELpnTMGtbeuWn8aZlRqj4YRmY_xhg>
    <xmx:aDKRaUBFh7WtwZYco5SAgwFT63wM5NfX5e6hE9k7ZWwbUAgVJbclDOBY>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 21:41:42 -0500 (EST)
Message-ID: <cc3e131f-f9a3-417b-9267-907b45083dc3@maowtm.org>
Date: Sun, 15 Feb 2026 02:41:41 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>,
 linux-security-module <linux-security-module@vger.kernel.org>
References: <cover.1741047969.git.m@maowtm.org>
 <5d683299-fc53-4763-be49-9a91325a832c@I-love.SAKURA.ne.jp>
 <5cff3b2b-998d-4dbe-897d-7622d07f6791@maowtm.org>
 <898462aa-8e5e-47ed-9a76-69e4acfbab07@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <898462aa-8e5e-47ed-9a76-69e4acfbab07@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 10:43, Tetsuo Handa wrote:
> Hello.
>
> On 2025/03/24 10:58, Tingmao Wang wrote:
>> Hi Tetsuo,
>>
>> Thanks for commenting on this RFC and thanks for mentioning TOMOYO - I wasn't
>> aware that another LSM has a similar permission prompting mechanism already
>> (and in fact, I only recently found out AppArmor / Ubuntu has also built
>> something like this [1], although AFAIK it's not upstream'd to mainland Linux,
>> and the current implementation may be somewhat coupled with Snap?), and this
>> is valuable and interesting for me to know :)
>
> I mentioned TOMOYO as an example of how to implement a supervisor feature, for
> there is a pitfall when involving userspace. What is important for implementing
> a supervisor feature is how to avoid deadlocks, for userspace might unexpectedly
> pause due to page fault events. If the supervisor process is blocked due to a
> page fault event, the process which is requesting some access is also blocked.
>
> [...]
>
> For landlock, I guess you assume that the supervisor process is not blocked
> (because landlock is intended for subset of userspace processes), but what if
> the supervisor process tries something that will be blocked by landlock
> (e.g. spawning a userspace program in landlock-controlled environment) ?
> Is there a guarantee that the supervisor process can never request something
> that will be blocked by landlock itself (or other security modules that are
> active) ?

Thanks for raising this and apologies that I missed to reply at the time.
I'm revisiting the supervisor series and these are good points.

For page fault events specifically, I don't think Landlock controls
anything involved in the reading back or writeout of pages (file accesses
are granted or denied at open() time, and as far as I'm aware, page faults
cannot _naturally_ lead to creation of new files or re-opening files), and
so if a supervisor is blocked on a page fault, my claim is that it will
never be due to Landlock itself (And I think perhaps the same is true for
TOMOYO as well - it doesn't look like TOMOYO has any access rights that
can directly be in the path of anything a page fault would need to do
either).  One can presumably set up a situation where, for example, a page
fault in a Landlock supervisor results in a userfaultfd event that needs
to, for some reason, be handled by a process confined by that supervisor,
but this seems unlikely.

Also, for Landlock, the supervisor can only control its "descendants" (but
there is some edge case here - see below).  If a supervisor gets blocked
in Landlock, it will be some parent supervisor above it that needs to
respond, so usually there can't actually be a deadlock from waiting on
Landlock requests (Landlock domains form a tree).

However, if for some reason the supervisor tries to landlock_restrict_self()
itself (i.e. not within a fork), passing in a Landlock ruleset with itself
being the supervisor, such deadlock can happen.  We should probably
disallow landlock_restrict_self() with a process being its own supervisor,
as it doesn't make much sense, doesn't provide security, and can lead to
deadlocks like you mentioned.

Another thing that might happen is if a Landlock supervisor is blocked in
some other LSM (such as TOMOYO), and that LSM requires a reply from a
child process of that supervisor, and that child is blocked in Landlock
waiting for the original supervisor to respond.  I don't have a solution
for this, but this also seems like an unlikely situation that will just
require manual intervention (e.g. killing the supervisor process, which
will then deny the Landlock access request in the child, unblocking it).

Kind regards,
Tingmao
