Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F9BA49;
	Thu,  3 Oct 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936184; cv=none; b=XoEntN7cRDIfPqbfMOOEVMalzOdwR1MLJKZpV4AkKwEAqnRcQRXeMJYUTyCo53Htno4cJXoFmOuHwQMEyWejIwqYpTpr79XL5hj+O6dssvsZGYDSNZ9HTVbD1iAYdoPDIpefzRZVcjuZ7geyalRjhZH8dRDJDTw5XSuwj5HXbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936184; c=relaxed/simple;
	bh=hnwpRwWwsmBCRZsbq88L40GzGMEunBuLAgbTrMjgAH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyB5QwsvmOW8TWapakHnLT3fYv1EKHRgbN4E8nGeEyxKepqrTq6qO1rma/EcR8iGbj42Gb+MdDdztkruk/x81G6G71w/wSfYeiC2iUilgQNkH4vr6Fyg3FYjV2pnGI8jXCGMdT9f/w8FFVwb+R4z0foqGgZbLob5ASTUqnv8c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4936G91a022449;
	Thu, 3 Oct 2024 15:16:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4936G9da022445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 15:16:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cd548445-777c-46d7-abe3-de8e06e509ee@I-love.SAKURA.ne.jp>
Date: Thu, 3 Oct 2024 15:16:06 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/03 14:35, John Johansen wrote:
> I do understand that. The problem is that out of tree doesn't do that.
> From a distro perspective out of tree is more work, and is very problematic
> from a code signing perspective.
> 
> Code signing isn't going away, if anything its become a requirement to
> support the majority of users. Loading unsigned modules, code, even
> bpf is a problem.

Confused. If use of BPF is a problem, use of BPF-LSM is also a problem?
If one were able to implement security modules using BPF-LSM, such modules
are headache for distributors? If so, BPF based LSM modules can't be a
candidate for replacing C based LSM modules...

> 
> Sure individual users can disable secure boot etc but at the distro
> level we need to support secure boot out of the box. Out of tree code
> really just isn't compatible with this.

More we want to enforce protecting with module signing, more we need to make
whatever code built-in and run in the kernel space. Upstream-first pressure
will push whatever code for inclusion into the upstream kernel.



>> TOMOYO is one of in-tree modules that can be signed together when building
>> distribution kernels. Fedora can provide tomoyo.ko as a signed-but-unsupported
>> module (i.e. excluded from main kernel package that is supported by
>> distributors but provided as a separate package that is not supported by
>> distributors).
>>
> yes it can, it has chosen not to. As I have said before that is
> a choice/political reason, not technical. I wish I had a solution to this
> problem for you but I don't.

What does "it" referring to? Fedora has chosen not to build TOMOYO into Fedora's
vmlinux. But I haven't heard from Fedora that Fedora won't ship tomoyo.ko as a
separate package.

>                              What I can say is Tomoyo adding the ability to
> load out of tree code that isn't signed is going to force Ubuntu to do
> the same and disable it. I really don't want to do that, I would rather
> leave the choice available to our users.

How is tomoyo.ko connected to loading of out-of-tree code? If the module signing
can prevent unsigned modules from loading, where is the possibility of loading
unsigned LSM modules even if LSM hooks are exported to loadable modules?

 From module signing perspective, there will be no difference between the LSM
framework exports LSM hooks and TOMOYO exports LSM hooks. And
https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp
leaves the choice available to distro users. Why not acceptable?

By some chance..., can't module signing prevent any code (both in-tree and
out-of-tree) that is not signed from loading !?

