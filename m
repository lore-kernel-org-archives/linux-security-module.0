Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73293200CB;
	Sat,  5 Oct 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728102255; cv=none; b=KY5P0AdD2gXeAyorm/iN8At886UqFjAbCbfOrLKfT00AK5ZNXPh2APRR3GX4B0+RoOFdaE7QSvSgnoBEOhZ4dCzqoscSNE+LcLL9WXhjlkhtNpd7tMJfWcoolaBuz2bSfzLL3x3oRAro99zhH+wTvXQoKGr+mIqOWFjE6T69n/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728102255; c=relaxed/simple;
	bh=YsergRmHFQilCEI6qn2M3lnz58jtyPZPc5nniGgaSAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3LCOeououINBRiwyKKqRQPgnHniw7sS3uNpDd9kBby+Aioqjc1krZam0Vz6w06EI8DkebaqHv+nV+rSN3kZPQmXILbK0p4RMkqhYZ3mWRtREsLcPI7WKMqnBAyHSP49FhAHSH68FmI/NcyqsXQ8ZqqM0AaAwqUSsaUhhNuMlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vRYqRPVF; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vRYqRPVF"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C84753F1FF;
	Sat,  5 Oct 2024 04:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728102250;
	bh=v/XuaxcWn4H85elN3kUtvxavOUtvjkThM6tHpaGInYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vRYqRPVFzV6hDb66ctnAG2E5+cpzlmiDE0y18R3q36MjnlXitakJs56zNN2tJ71dk
	 1QKGVkQTwgjFiMJIfiPABqmuHiDpWc5w8cE0bPXM/MuG6EbE2ydIgZK0/Q32H5mc44
	 hKM33IE4XnMWoPJLR/8JPbqYtRkozJJLW99FQcgfrlK5QC97mlP1dyYXlB35El5MI/
	 zgI1kcRnTgAi8NMPt2/siZVgCcCVcohianuVnFoCfFhVcOkFIQILOuyE3eCoyEteV5
	 1topru8crEtovPttdCWProDCylvQkdL3FAasUUL4NV6J/nEAL9F564AAfV4CrIGs9B
	 9QE90kf+DBFmA==
Message-ID: <1c686d2b-6b24-46b9-a439-5b696108d88e@canonical.com>
Date: Fri, 4 Oct 2024 21:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Paul Moore <paul@paul-moore.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org
References: <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
 <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
 <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
 <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
 <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com>
 <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp>
 <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
 <20241003153908.GA3267@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20241003153908.GA3267@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 08:39, Dr. Greg wrote:
> On Wed, Oct 02, 2024 at 10:35:27PM -0700, John Johansen wrote:
> 
> Good morning, I hope the day is going well for everyone.
> 
>> On 10/2/24 21:26, Tetsuo Handa wrote:
>>> On 2024/10/03 11:45, John Johansen wrote:
>>>>> But due to above-mentioned realities, your assertion no longer stands.
>>>>> Kernel source itself might be open, but private keys cannot be open.
>>>>> The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
>>>>> negative impact on the user side, which cannot be a viable solution).
>>>>>
>>>>>
>>>> Yes, and this is an intentional choice on the base of the distro about
>>>> what they support and what is required to meet contractual obligations.
>>>
>>> The reason Fedora cannot enable TOMOYO is lack of bandwidth.
> 
>> which is sadly a very valid argument. Coming from the distro side of
>> things it is a very real problem. I tend to advocate for giving the
>> user choice where we can but there is more than one occasion where
>> Ubuntu has had to declare bug bankruptcy on outstanding kernel bugs
>> because the backlog was impossible to handle.
> 
> Understand the concept of lack of bandwidth.
> 
> Had a 40 hour week in as of 0800 yesterday morning and the end of the
> week isn't even remotely in sight.

yeah I know that one all too well, I hit 40 hours some time Wednesday
morning.

> 
>>> You've just said "Bandwidth is a very real issue". Thus, I need a solution
>>> that can solve the bandwidth problem. The question is how we can control
>>> division of role (share the workload) in a secure manner.
> 
>> I do understand that. The problem is that out of tree doesn't do that.
>>  From a distro perspective out of tree is more work, and is very problematic
>> from a code signing perspective.
>>
>> Code signing isn't going away, if anything its become a requirement to
>> support the majority of users. Loading unsigned modules, code, even
>> bpf is a problem.
>>
>> Sure individual users can disable secure boot etc but at the distro
>> level we need to support secure boot out of the box. Out of tree code
>> really just isn't compatible with this.
> 
> Not relevant right now but I do remember, personally at a conference,
> Stallman railing on about the threat of signed code and what it
> represents with respect to software and device freedom.
> 
> And here we are....
> 
>>>> Users are still free to build their own kernels they just don't get
>>>> support or certification when using them.
>>>
>>> Nobody can provide bandwidth (or infrastructure) for supporting their
>>> locally built kernels.
> 
>> right
> 
>>>>                                            Stopping the load of out of
>>>> tree modules that aren't signed is in general good security policy.
>>>
>>> Yes, distributors can prevent load of out-of-tree modules that aren't
>>> signed. That is good for security. But building kernels locally cannot
>>> utilize signed modules functionality. Also,
> 
>> true. that is a limitation of the cryptography that is being used, and
>> I don't see a way to fix that
> 
>>>> Let me be explicitly clear. If Tomoyo is by-passing module signing, and
>>>> exporting the LSM interface to loadable modules Ubuntu will be forced
>>>> to disable Tomoyo.
>>>
>>> TOMOYO is one of in-tree modules that can be signed together when building
>>> distribution kernels. Fedora can provide tomoyo.ko as a
>>> signed-but-unsupported
>>> module (i.e. excluded from main kernel package that is supported by
>>> distributors but provided as a separate package that is not supported by
>>> distributors).
> 
>> yes it can, it has chosen not to. As I have said before that is a
>> choice/political reason, not technical. I wish I had a solution to
>> this problem for you but I don't. What I can say is Tomoyo adding
>> the ability to load out of tree code that isn't signed is going to
>> force Ubuntu to do the same and disable it. I really don't want to
>> do that, I would rather leave the choice available to our users.
>>
>> It may be a trade-off worth making for you/Tomoyo if it fixed your
>> problem with RHEL/Fedora but I don't see it fixing that problem
>> either.
> 
> Not much bandwidth for the rest of the day but I wanted to get this
> question/issue out to get some feedback for later tonight,
> particularly from your perspective John.
> 
> We saw these issues coming about four years ago, which is why we
> decided to take a deep breath and bring TSEM out of private use to a
> wider audience, it isn't a 'pet project' as it has been referred to.
> Not sure we would do that again but that is an issue for another day.
> 
> TSEM is based on the notion of having a generic modeling architecture
> for the LSM.  I know that Casey bristles at the notion of us saying
> 'model', but we can prosecute that argument in intimate detail at
> another time.
> 
> We would best characterize TSEM as a 'swiss army knife' for
> interpreting kernel security events.  You can run the event
> interpretation in the kernel, in userspace, in a hardware device or up
> in the cloud.
> 
> After watching Tetsuo's concerns over the last year we dropped the
> loadable module support into TSEM for the V4 release:
> 
> https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t
> 
> This offers the ability to run the interpretation model via code
> implemented in a loadable module.  BPF is also an option but we are
> keeping things simple at this point.
> 
> So we use the standard loadable module architecture.  We offer the
> ability to lock further model loads or unloads after a set of models
> have been loaded and the option to completely disable any loadable
> models at boot, independent of the general kernel loadable module
> state.
> 
> It doesn't fully fix Tetsuo's problem, given that a distribution could
> compile out TSEM, just like it compiles out Tomoyo, I think we all
> agree there is no fix to that problem.  However, if the security bigs
> like CrowdStrike, PaloAlto and others, understand that it allows EDR
> telemetry and surveillance to be implemented on Linux without having
> to install a high privilege or kernel based agent, it makes not having
> it in the kernel less attractive.
> 
> Just for the sake of advancing these conversations, we are throwing
> some bandwidth into implementing Tomoyo as a TSEM loadable module to
> get some further insight on the tractability of something like this.
> 
> With your distributor hat on does an architecture like this offend
> your security sensibilities?
> 
> Like it or agree with it, we seem to be standing at a reasonably
> important inflection point for Linux, conversations probably suitable
> for a 'Summit' type event.
> 
> Will look forward to your thoughts.
> 
honestly it worries me, but that is more a vague general worry about
any generic architecture that you can build on top of. Take BPF, it
has a whole host of issues, that make it very challenging, like
spectre gadgets, and getting its verifier correct for everything.
There is a lot of complexity there making it a challenge to evaluate.

I really need to dig into the details of TSEM before I can give a better
response.




> Have a good day.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project

