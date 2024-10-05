Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73F1C6B2;
	Sat,  5 Oct 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728100758; cv=none; b=ECHfwn43NROc/wblSxJazSfCIZUStDnTQLURJeWvo2HiKXlP6supYSAZAzasp8bHaHVF4tuGpfvUb3g8Ee1sGGCTWCTnqYSLWR4m7qHoFNPlzwIDdcJ1TXEF6jYPq6Uj8PRjbOguE9ooHpJcFnpo89DjFjvz630qO8b7E323W7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728100758; c=relaxed/simple;
	bh=3O1st7a2JUYhkREVq6zPbi+4RL7lqMmqLzPpnZ0q5k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmu0i6hzvaUFbf6lRX6LggEdJE0TVnD1LDDkCm5t25p9St3p7tyynU1If5/8NqoHfavfCnmhWtr36Kr5tPzvIEvCZ7McH+OlWl75p2Svu6rxQXfQy9kG2c2rRMDr000ju6i74eQzDTAbX8dNdbRvtSM+w8xRrEsWQ22O1+wOof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=B+pqqyCt; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="B+pqqyCt"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 399633F1E6;
	Sat,  5 Oct 2024 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728100753;
	bh=Vk3HsdhF+YB2WK8ojIePESCSq0zj2fOyJodL9lVyaxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=B+pqqyCtaCDN4f4UOgsoz2zt+e3bwRT826DNPsPSSlWQzPJTVcO4GpKmNNImo4NAz
	 sRl3W9xwh4ml0SNb5tqQ3LMyiqaKjxGyprKbAT4R159dxfzz8O/1XwIcI8MIhLzyjt
	 Oazd5DeIrfbscLKCn2S2Dnh4LMqkRx2hh0s46q8tfqG2KevupNVQmRam7Fw3S179gH
	 kfPz+fPrfsNT6xRWonXDt4XGtMV9LM92sDvEKzyJs8Lp/8LgOKuPnWbi49v9DkOj7K
	 MRtpowKrJWrDTAHridk06sySMXMKh37nflgtgbNcPop17KS1EyEwKkh/moVV34JZJg
	 FFqV6QWfAD1JA==
Message-ID: <a0de84de-8c20-46b9-ba61-44d35e7cdc58@canonical.com>
Date: Fri, 4 Oct 2024 20:59:10 -0700
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
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <cd548445-777c-46d7-abe3-de8e06e509ee@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 23:16, Tetsuo Handa wrote:
> On 2024/10/03 14:35, John Johansen wrote:
>> I do understand that. The problem is that out of tree doesn't do that.
>>  From a distro perspective out of tree is more work, and is very problematic
>> from a code signing perspective.
>>
>> Code signing isn't going away, if anything its become a requirement to
>> support the majority of users. Loading unsigned modules, code, even
>> bpf is a problem.
> 
> Confused. If use of BPF is a problem, use of BPF-LSM is also a problem?

yes it is. Pressures being what they are, it is enabled for some of our
kernels. Signed BPF would be required to get it available every where.

> If one were able to implement security modules using BPF-LSM, such modules
> are headache for distributors? If so, BPF based LSM modules can't be a
> candidate for replacing C based LSM modules...
> 

I have never argued they were. But they are currently the only solution for
out of tree LSM modules if you don't want to rebuild the kernel.

>>
>> Sure individual users can disable secure boot etc but at the distro
>> level we need to support secure boot out of the box. Out of tree code
>> really just isn't compatible with this.
> 
> More we want to enforce protecting with module signing, more we need to make
> whatever code built-in and run in the kernel space. Upstream-first pressure
> will push whatever code for inclusion into the upstream kernel.
> 
> 
> 
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
> 
yeah fedora/RHEL, they don't build apparmor either. And I do not believe that
building tomoyo.ko will get them to ship it in a separate package. That separate
package is more work than a builtin tomoyo and the kernel memory savings are
minimal.

With KP's performance patch the performance overhead of a builtin tomoyo is
negligible.

>>                               What I can say is Tomoyo adding the ability to
>> load out of tree code that isn't signed is going to force Ubuntu to do
>> the same and disable it. I really don't want to do that, I would rather
>> leave the choice available to our users.
> 
> How is tomoyo.ko connected to loading of out-of-tree code? If the module signing
> can prevent unsigned modules from loading, where is the possibility of loading
> unsigned LSM modules even if LSM hooks are exported to loadable modules?
> 

sorry was tired and in rush, and dumping in the other worries I have here. Exporting
symbols itself has nothing to do with module signing. However as Kees pointed
out in another email it does become an attack target.

The other one is I don't believe tomoyo,ko is going to get built as part of
the fedora/RH infrastructure. Which means module signing will block it. You went
for a "technical" solution on the symbols export, by-passing the community.
What is the next technical solution to get around module signing. Over the top,
paranoid, maybe. Do I think its highly unlikely, yes, but it became a worry as
soon as you pushed this patchset.

>   From module signing perspective, there will be no difference between the LSM
> framework exports LSM hooks and TOMOYO exports LSM hooks. And
> https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp
> leaves the choice available to distro users. Why not acceptable?
> 
> By some chance..., can't module signing prevent any code (both in-tree and
> out-of-tree) that is not signed from loading !?
> 
as long as it goes through the module infrastructure sure.

