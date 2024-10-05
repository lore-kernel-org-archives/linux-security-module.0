Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36C748D;
	Sat,  5 Oct 2024 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728101208; cv=none; b=dMJgvG6cvaw9tQkGoQ1IksVbFtO/HifZwiShhGoRMsqVu6l7/CTwUCtq6JUN264lXxqlEInO1w/co8IcEt7On34/u1b+eMZgDMoDffdC/dgD9m1iY4qKoEaYVf5Slop9+f6P/l1Il4pc6+4VwNE0U6q10B6nW8r0S2on8NF67JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728101208; c=relaxed/simple;
	bh=6W95jvtG79ygKqTSujLlvpz+5CPGRBNi28Rh22HD9qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaVH+iR8yf0CgJdli20qud+lnjB9TjeRX2MTKQO0sY6/9590phhlFNQTbKmD2R/AeRwGDiHnOQkY9Ok+HuNKE5lfYe++QFCDAoCXRJPSWrh/XXDOMH3nUcTMyetJNlONq35KYwuLpWm+L2kBhibc5Y3E145nw6gej34gZoNXFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l5ldq920; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l5ldq920"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7B9304005D;
	Sat,  5 Oct 2024 04:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728101204;
	bh=WuBXXGtzA246CoYPmUbliP+N8JVBJ3B3vjqOZIdS8m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=l5ldq920mQ233EDxzUWVvBHzCcTjKNL6CR4quNDpJLim+pwB4J133JBHC3rM1TQ6w
	 qa0vEFop4XqNesUTR9ZhIMgcKP/5uFny7y4dLp9y1j1KwPs/8LK+3dLcZK0UDEmcJi
	 SSO2outpuDw2BKnw1da1BWK/negMmVcTJpXKnwa7ONQXxPvuCw1hq31CdEsXbjYqCi
	 MdbFpMDPGj67BbLLlRH5xVs+nPM1uaAVhtWmLrWhExapfm7PX7nYPNUNyoppliERb6
	 gklf3LkRlfWhc2vLRyuU20c8HSneNvC/SH9hmWw/mjrdHr3BXX40p4N5RfxwxlUD7/
	 6RV/svc8s4Wpw==
Message-ID: <c32eea69-b822-49fc-a078-1f1b2dea124d@canonical.com>
Date: Fri, 4 Oct 2024 21:06:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
 <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
 <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
 <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
 <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com>
 <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp>
 <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
 <cd548445-777c-46d7-abe3-de8e06e509ee@I-love.SAKURA.ne.jp>
 <e9676c43-7c80-4083-bbfd-1b490ab74622@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <e9676c43-7c80-4083-bbfd-1b490ab74622@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 05:59, Tetsuo Handa wrote:
> On 2024/10/03 15:16, Tetsuo Handa wrote:
>>>> TOMOYO is one of in-tree modules that can be signed together when building
>>>> distribution kernels. Fedora can provide tomoyo.ko as a signed-but-unsupported
>>>> module (i.e. excluded from main kernel package that is supported by
>>>> distributors but provided as a separate package that is not supported by
>>>> distributors).
>>>>
>>> yes it can, it has chosen not to. As I have said before that is
>>> a choice/political reason, not technical. I wish I had a solution to this
>>> problem for you but I don't.
>>
>> What does "it" referring to? Fedora has chosen not to build TOMOYO into Fedora's
>> vmlinux. But I haven't heard from Fedora that Fedora won't ship tomoyo.ko as a
>> separate package.
> 
> Currently, a Linux distributor is an entity that provides kernel program and
> userspace program. But as the kernel code signing getting more important,
> the role of a Linux distributor regarding the kernel program might change as
> below?
> 
> Currently, people expect that "distributor takes care of handling all bugs
> that happens with kernel code built by that distributor". Due to bandwidth
> problem, distributor needs to disable kernel code which that distributor cannot
> take care of bugs. My understanding is that some distributors started providing
> separated kernel packages; the kernel package which that distributor can take
> care of bugs and the kernel package which that distributor cannot take care of
> bugs. The tomoyo.ko change is intended for being included in the latter package
> if that distributor cannot include in the former package.
> 
honestly its easier to just build a separate kernel package with tomoyo builtin.
Module packages can be done, but they are a pita.

> Since distributor needs to sign kernel code, I think this separation is becoming
> more inevitable. That is, people might need to change their expectation to that
> "distributor takes care of handling bugs that happens with kernel code in the
> former package, and somebody takes care of handling bugs that happens with kernel
> code in the latter package", and distributor's role is to compile as many kernel
> code as possible and sign all compiled kernel code so that the kernel code is
> compiled and shipped (and not tampered) by known entities; something like SSL
> certificates providers.
> 
Sure. Distribution already tell users they aren't using supported stuff. Ubuntu
builds in selinux, tomoyo, smack. We get a bug we tell them it is community
supported.

That has some overhead, but really not that much more than responding to the
bugs where users ask for feature X to be enabled. Or how to build a kernel with
feature X, ...

Ubuntu made a different decision than fedora around how best to support users.
I am not going to argue its right or wrong, just different. Again getting a
distro to change a config/stance is a political problem, not technical.

