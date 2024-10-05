Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74F12B73;
	Sat,  5 Oct 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728103057; cv=none; b=maqIml41AQmt+O/uXY2edLwvbwlr+nqx4jTFYXVqBHFOFOomk2mXVVrcMLskHxPAV4D/xGz+OTMUIrsUV9saqv6c7hk27m3mY6S92rpD6+YCahU8xucBuPNaxA/BrvuJ9yG+LGeLWHrB2IgjH3Q89Z2adLUludzUEzhQ28omtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728103057; c=relaxed/simple;
	bh=hc9qOl15neqqclLo6WFJcgxdepJlSNDq++eYDY+iDsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhLhxW3Qy2w+DxLImjhRIS738CtBnV2htYZZQTIVsecSb1GUpIa8vdocPfSwMumKZTjZ6lI6DBCHcW/RriOtUX/zuR75xwWzTiIppYZI32hOZX2SeKyyAE2JyRp2AjGZ2gYNlFxo8tWatVM1jLCvzb1+CtSO4ExQ9DS33gE3HqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZMv59UFV; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZMv59UFV"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BACCA3F76A;
	Sat,  5 Oct 2024 04:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728103052;
	bh=qYiPk7+hOLqDjJL5rh0Du53jcdgrTYwXqyoMUSj1tNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZMv59UFVTZqN2EYrTNO5DNlCEo4CwY3i4Pq1X4/1DRzYNK7n3Ne7+5OnQZlIVtCRD
	 vdgOxlSkUPSRSpUzRRpCO0rfBoFTigcyRxDhmFtMHP8U1sqJsnJ6LnSMCR0LBvl+0q
	 o5mnX577yvEVXH2cZdYPX6RGmonSe5KuzG+6j4K4iwmIxhrLvieMrPA9JrDkAdGIge
	 O3kwz6UmGs4PbW9ZKKZoQEQfqSTONdLBhNK0Kd8Hy+6pcFoyeztGGvLZojp/+q0oFN
	 y+Tr1hlPpf7Vo49exdY9v7Wcy/zGzbvTiXDYmKMpODjq7eyWFoX8/lm5i2YANfcG2R
	 YSkY5Cy+nwqug==
Message-ID: <83a32e86-cdc2-4068-b830-b54aaea1e01a@canonical.com>
Date: Fri, 4 Oct 2024 21:37:28 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com>
 <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
 <20241003154336.GB3267@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20241003154336.GB3267@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 08:43, Dr. Greg wrote:
> On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> 
>> On 10/2/24 03:38, Dr. Greg wrote:
>>> On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
>>>
>>> Good morning Linus, I hope the week is going well for you.
>>>
>>> Some reflections, for the record, on this issue.
>>>
>>>> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
>>>>>
>>>>> Linus, it's unclear if you're still following this thread after the
>>>>> pull, but can you provide a little insight on your thoughts here?
>>>
>>>> I absolutely hate the whole "security people keep arguing", and I
>>>> cannot personally find it in myself to care about tomoyo.  I don't
>>>> even know where it is used - certainly not in Fedora, which is the
>>>> only distro I can check quickly.
>>>>
>>>> If the consensus is that we should revert, I'll happily revert. This
>>>> was all inside of the tomoyo subdirectory, so I didn't see it as
>>>> some kind of sidestepping, and treated the pull request as a regular
>>>> "another odd security subsystem update".
>>>
>>> I see that Paul Moore has further responded with commentary about the
>>> 'LSM community' responding to this issue.  I wanted, on behalf of our
>>> project and in support of Tetsuo's concerns, to register directly with
>>> you a sense of jaded skepticism about the notion of a community
>>> response.
>>>
>>> Fixing Tetsuo's issue, at least to the extent it can be fixed,
>>> requires technical improvements in the Linux security architecture.
> 
>> yes and that is correct place to do it. Doing it within a single
>> LSM is very much the wrong approach
> 
> Just going out the door and saw this e-mail
> 
> Your e-mail crossed with one I just sent over in the kernel code
> loading side of this thread/debate.
> 
> Will look forward to seeing your thoughts there.
> 
This one is a hard problem. I don't have a good solution. We are
pushing up against lots of constraints: performance (see KP's patch),
the need to get rid of/reduce use of indirect branches because of
spectre (again performance but also brittleness), the desire to
make the LSM less of a target for kernel compromises (ro after init).
The need for code signing and integrity. The need for common interfaces
(LSM syscalls), to avoid the interface sins of the past.

This makes loadable LSMs troublesome at best and I concede maybe
impossible politically.

I am not entirely opposed to the approach that Tetsuo took. Its
interesting, and I wouldn't have minded it being explored more as a way
to extend the LSM, but as part of the LSM, not in crammed into an
individual LSM.

The performance hit for its use I am willing to accept because,
it only happens if it is enabled. So it would be easy to build it
in and just not enable it by default.

It would still have to show how to deal with ro of the hooks, make
sure we aren't introducing new spectre gadgets, and also have a
way to integrate with LSM syscalls, and probably a few other
things I am missing.

These are all things that would need to be discussed on list.


> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project

