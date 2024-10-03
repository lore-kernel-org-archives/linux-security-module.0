Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5111946B;
	Thu,  3 Oct 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922606; cv=none; b=DYfN4fP93SSzGQIVYxK/YaZeSQq30uJALiQ2qAGRU7tHkqRkwF7SLw0GubadGNtIajZS26MxUz5XxT8ALy4SFNhrvG+WfmdNKlSwL7IBrJMEK/SCXVCPCPAHToc9p3ziqeJ7S7mojzgjMjPixsUVYo1FYwZVmGuljpx2P9p8om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922606; c=relaxed/simple;
	bh=OBVD0SdSnenE0cYFBAHj7O5jQZCxW1uQC1fX2O1dsx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4b+Ssm0k0Z5cPQ5aLIfK9xiPFT5whIeqicH4SFdr3zeEeEf07N73JjSDMv1X7F6fc+XnnDY5NWfbVJRsO1KVcRIHh8xKm6h0NhadGGll+ZLObqPoq7sMaccSPEAsplZo7sJyhsrP4bJxBz2Ehtgx05EIiLz51Al+vFlaojvFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HHpQEyhe; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HHpQEyhe"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1E59B3F0A2;
	Thu,  3 Oct 2024 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727922273;
	bh=mtyQjOvT8/r8gFzn/EvPMn1Xb4KwpJCT08Zknko2doc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=HHpQEyheO8GJXMx+am6bgd9e4ThJcGILN/4//A1OTwjzXrF2Hm15NddIW0bFGRNpH
	 vtOC7gbU8RAcW0AG2pN/uRnVZq0xqvMC4U/Eth3QTG5q9kSvj5mAlo0tNuXKrjKkDK
	 u3UBA1MfC9RPkN6b1uxl31mV1nmSxf9YO0KIimPqyLOakyW8kwqjhG+GjoOC4onsMg
	 OPxAJb3Z7oew4sfex7cGIKVaRv8ZMsXlR3E2bapP/BrpD9Q68xVKnbYkmDBVleaOQh
	 NADUcKhWr2uWQ9P6FiTGlblN447HNavsmpgPo0Syyz6GVKgvfOegPILoCdShUqZZwZ
	 CQTLRUzMM4Xnw==
Message-ID: <8c04f325-4a5b-4187-a108-791a2a2939eb@canonical.com>
Date: Wed, 2 Oct 2024 19:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Paul Moore <paul@paul-moore.com>, "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com>
 <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 07:35, Paul Moore wrote:
> On Wed, Oct 2, 2024 at 6:38 AM Dr. Greg <greg@enjellic.com> wrote:
>> On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
>>> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
>>>>
>>>> Linus, it's unclear if you're still following this thread after the
>>>> pull, but can you provide a little insight on your thoughts here?
>>
>>> I absolutely hate the whole "security people keep arguing", and I
>>> cannot personally find it in myself to care about tomoyo.  I don't
>>> even know where it is used - certainly not in Fedora, which is the
>>> only distro I can check quickly.
>>>
>>> If the consensus is that we should revert, I'll happily revert. This
>>> was all inside of the tomoyo subdirectory, so I didn't see it as
>>> some kind of sidestepping, and treated the pull request as a regular
>>> "another odd security subsystem update".
>>
>> I see that Paul Moore has further responded with commentary about the
>> 'LSM community' responding to this issue.  I wanted, on behalf of our
>> project and in support of Tetsuo's concerns, to register directly with
>> you a sense of jaded skepticism about the notion of a community
>> response.
>>
>> Fixing Tetsuo's issue, at least to the extent it can be fixed,
>> requires technical improvements in the Linux security architecture.
>> Currently, potential technical improvements in this venue are
>> struggling to receive any kind of acknowledgement or review, to the
>> ultimate detriment of enhancements that Linux should be bringing
>> forward to address, not only this issue, but the security industry
>> writ-large.
> 
> I've believe the LSM developer community is interesting in that it is
> much smaller than many other kernel subsystems, despite the
> substantial technical scope when one considers the LSM's reach within
> the kernel.  This brings about a number of challenges, the largest
> being that reviewing ideas, documents, and code changes takes time.
> Everyone always wants their personal patchset to land "right now!",
> but it's important that the changes are given the proper review and
> testing.  You don't have to look any further than the recent static
> call changes to see a perfect example of how overly aggressive
> attitudes toward merging would have resulted in a number of real world
> failures.  I agree that a quicker pace would be nice, but I'm not
> willing to trade off reliability or correctness so people's favorite
> feature can land in Linus' tree a bit quicker.
> 
> Independent of everything above, it is important to note that the pace
> of changes in the LSM framework over the past two years has increased
> significantly.  Even ignoring some of the administrative improvements,
> e.g. process documentation, since 2022 the LSM community has been
> merging code at a pace much higher than we've seen during the entirety
> of the "git age":
> 
> [NOTE: using 'security/security.c' to be representative of LSM
> framework specific changes seems reasonable for a quick metric]
> 
> # previous two years (reference)
> % git log --after="2022" --before="2024" \
>    --oneline security/security.c | wc -l
> 141
> 
> % git log --after="2020" --before="2022" ...
> 50
> % git log --after="2018" --before="2020" ...
> 82
> % git log --after="2016" --before="2018" ...
> 43
> % git log --after="2014" --before="2016" ...
> 47
> % git log --after="2012" --before="2014" ...
> 25
> % git log --after="2010" --before="2012" ...
> 62
> % git log --after="2008" --before="2010" ...
> 56
> % git log --after="2006" --before="2008" ...
> 36
> % git log --after="2004" --before="2006" ...
> 4
> % git log --after="2002" --before="2004" ...
> 0
> 
>> We have made multiple submissions of technology, that can at least
>> positively impact Tetsuo's concerns, and in the process perhaps
>> improve the opportunity for security innovation in Linux.  After 20
>> months of doing so we have yet to receive anything that would resemble
>> substantive technical review [1].
> 
> I disagree.  I've personally reviewed two of your LSM revisions,
> providing feedback on both.  Unfortunately both times I've not made it
> past the documentation as there have been rather significant issues
> which I didn't believe were properly addressed from one revision to
> the next.  From what I've seen on the mailing list, others have
> identified similarly serious concerns which in my opinion have not
> received adequate responses.
> 
> The TSEM LSM is still queued for review, but based on prior reviews it
> currently sits at a lower priority.  I realize this is frustrating,
> but I have to prioritize work based on impact and perceived quality.
> 
Bandwidth is a very real issue. TSEM is also on my to review list, but
finding making the time to make it through the full set has so far
been impossible.

Heck I am weeks behind on the apparmor list, and I have apparmor patches
to send that I haven't been able to get time to do.


