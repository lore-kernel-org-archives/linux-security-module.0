Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2BC148823;
	Thu,  3 Oct 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960383; cv=none; b=cBX+32kJKx/yqiNKCo8jD2fQwpL6Ymdjz+2DlRpc4dKUPWXQ8ASRQ4RDPadDrDp42Xhetd1saSKfMNeNIXMtRVoVOhc7+HlBZHif70XCszUPxMZNW86fXy6m5X1byUMvCXDnT9YvUesN/xcnf0TJNoENf4rF+6az5KeWKiEFmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960383; c=relaxed/simple;
	bh=jD50ALunP3qnjque+G5mTwh6IDVgzJvC28NQjWJJWAA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VBe6l4HvoYFjo6wvBvWxR3lpOFbBtrqhSC2MGNMtdU0OxHswPgKlhvWG3wwNNzJ8bmWGZLii1j1w2u/354QoICVoklUyvJNJ6zUGNtLRzUVfU4zQ8gfyn8oV4G2biGdKw0WCycDEf3fqW8V2vJElopucATJOh8b8HJl/Ai+rFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 493CxT3I066553;
	Thu, 3 Oct 2024 21:59:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 493CxS3D066550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 21:59:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e9676c43-7c80-4083-bbfd-1b490ab74622@I-love.SAKURA.ne.jp>
Date: Thu, 3 Oct 2024 21:59:25 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: John Johansen <john.johansen@canonical.com>,
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
Content-Language: en-US
In-Reply-To: <cd548445-777c-46d7-abe3-de8e06e509ee@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/03 15:16, Tetsuo Handa wrote:
>>> TOMOYO is one of in-tree modules that can be signed together when building
>>> distribution kernels. Fedora can provide tomoyo.ko as a signed-but-unsupported
>>> module (i.e. excluded from main kernel package that is supported by
>>> distributors but provided as a separate package that is not supported by
>>> distributors).
>>>
>> yes it can, it has chosen not to. As I have said before that is
>> a choice/political reason, not technical. I wish I had a solution to this
>> problem for you but I don't.
> 
> What does "it" referring to? Fedora has chosen not to build TOMOYO into Fedora's
> vmlinux. But I haven't heard from Fedora that Fedora won't ship tomoyo.ko as a
> separate package.

Currently, a Linux distributor is an entity that provides kernel program and
userspace program. But as the kernel code signing getting more important,
the role of a Linux distributor regarding the kernel program might change as
below?

Currently, people expect that "distributor takes care of handling all bugs
that happens with kernel code built by that distributor". Due to bandwidth
problem, distributor needs to disable kernel code which that distributor cannot
take care of bugs. My understanding is that some distributors started providing
separated kernel packages; the kernel package which that distributor can take
care of bugs and the kernel package which that distributor cannot take care of
bugs. The tomoyo.ko change is intended for being included in the latter package
if that distributor cannot include in the former package.

Since distributor needs to sign kernel code, I think this separation is becoming
more inevitable. That is, people might need to change their expectation to that
"distributor takes care of handling bugs that happens with kernel code in the
former package, and somebody takes care of handling bugs that happens with kernel
code in the latter package", and distributor's role is to compile as many kernel
code as possible and sign all compiled kernel code so that the kernel code is
compiled and shipped (and not tampered) by known entities; something like SSL
certificates providers.

