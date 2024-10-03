Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770D168DC;
	Thu,  3 Oct 2024 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922476; cv=none; b=uAsmmcmLf/BmfbVd1Z96EhjQwbWUy04xT0QtH2z3UO9fkwMWZdNxqaIXRhcCetLgYFC026lrCJwoR8qd9fsDEmw2t05jj8qvZ/zrXhJ6oTNv8MvQDznKO92r6XG4SHKgaQhbE7g032ugQVkD2UCVqdaR7a60oVDt7OCKFDg0D6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922476; c=relaxed/simple;
	bh=3OPAftrtMV+qIp4Qz8NWHzz2E0fBiQnLd7zeRbcYWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyeIPCgO+ASVggpfH8I/nsVPY/9LNd8JFCFMJ0EklPopwiCKjmxvKN5YxFdT8S7aItaz8m3woyO3vGlDOscH8L3159H8JFf6llP9vyVDFN3VR3zZuahxdzFKlw4jc4LmWPhrEvAcGp+zjs2HgbR+Pc5Fuyv/wN2hFgHzZ2BLi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rSn00OHO; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rSn00OHO"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AD9F23F24D;
	Thu,  3 Oct 2024 02:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727922470;
	bh=RN31JBI6bHBo+rutpHLe7KMAvry1bQmwrXCcjkow2zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rSn00OHOGcx/Sa+PnHbQZzOaC3CmQKvdnvnEWwV5PHQg91Qwc96tkqsBo8G8LqBJd
	 fB1eSCg5u3X1zSX963q7a1Rli7mNmXnFjq+WTgYYhufKPCYFUoj4iNrzj8mGJsY2qq
	 WNpNST0AL5HFMAuMJqXzljA9bYn3nRP12nLP2hrY4szf8ndUEjp7AyAQ0dRpDvC/xG
	 aukVdl1O4fDpzZXZXBWAbvrigPiOd/VHQRElJBg8brTiYHDkAbUa76pamFJrFDnLba
	 e41s7pSQqnMUSTwyf0vlGxcVmtgD+N0zJQTxG54na6bhgBz6WGG1bG+aig5GxGpoKA
	 h/1SAmTnA6PJw==
Message-ID: <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
Date: Wed, 2 Oct 2024 19:27:47 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20241002103830.GA22253@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 03:38, Dr. Greg wrote:
> On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> 
> Good morning Linus, I hope the week is going well for you.
> 
> Some reflections, for the record, on this issue.
> 
>> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
>>>
>>> Linus, it's unclear if you're still following this thread after the
>>> pull, but can you provide a little insight on your thoughts here?
> 
>> I absolutely hate the whole "security people keep arguing", and I
>> cannot personally find it in myself to care about tomoyo.  I don't
>> even know where it is used - certainly not in Fedora, which is the
>> only distro I can check quickly.
>>
>> If the consensus is that we should revert, I'll happily revert. This
>> was all inside of the tomoyo subdirectory, so I didn't see it as
>> some kind of sidestepping, and treated the pull request as a regular
>> "another odd security subsystem update".
> 
> I see that Paul Moore has further responded with commentary about the
> 'LSM community' responding to this issue.  I wanted, on behalf of our
> project and in support of Tetsuo's concerns, to register directly with
> you a sense of jaded skepticism about the notion of a community
> response.
> 
> Fixing Tetsuo's issue, at least to the extent it can be fixed,
> requires technical improvements in the Linux security architecture.

yes and that is correct place to do it. Doing it within a single
LSM is very much the wrong approach

> Currently, potential technical improvements in this venue are
> struggling to receive any kind of acknowledgement or review, to the
> ultimate detriment of enhancements that Linux should be bringing
> forward to address, not only this issue, but the security industry
> writ-large.
> 

everyone in the LSM community is struggling with available time, and
yes there are disagreements around how this should be done so it
moves slow.

> We have made multiple submissions of technology, that can at least
> positively impact Tetsuo's concerns, and in the process perhaps
> improve the opportunity for security innovation in Linux.  After 20
> months of doing so we have yet to receive anything that would resemble
> substantive technical review [1].
> 
> The following are links to the four submissions.  We believe an
> unbiased observer would conclude that they provide ample evidence of
> very little interest in reviewing submissions for enhancements to the
> Linux security eco-system, outside of perhaps certain constituencies:
> 
> V1:
> https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t
> 
> V2:
> https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t
> 
> V3:
> https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t
> 
> V4:
> https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t
> 
> As of the V4 release, we have added support for an approach that may
> positively impact Tetsuo's concerns.  We do that without touching any
> infrastructure outside of our proposed LSM.
> 
> We can speak, at great length, as to why we feel that Linux would
> benefit from structural improvements to its security infrastructure.
> We will refrain from doing so in this thread, given your stated
> sentiments on these types of discussions.
> 
> However, your mantra, recently expressed on security infrastucture
> issues, has always been:
> 
> "Code talks, bullshit walks."
> 
> For all of this to work, and the Linux community to remain healthy,
> the code needs to be listened to and that is not effectively happening
> in the security arena.
> 
> I started my involvement with Linux in late 1991.  All of what I see
> is giving me a great deal of pause about the health of our community
> moving forward and the potential negative impact these issues have on
> the opportunity for security innovation to emerge
> 
>>                    Linus
> 
> Have a good remainder of the week.
> 
> Apologies in advance for extending conversations you find tiresome.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project
> 
> 
> [1]: A thank you to Casey Schaufler, despite our lively disagreement
> about some issues, who has offered specific review comments and
> dialogue about security modeling.  To Greg Kroah Hartman for
> recommending the most important change we have implemented with
> respect to JSON encoding of security events and a handful of other
> individuals who have provided helpful procedural and technical point
> suggestions.
> 

