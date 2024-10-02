Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F41E7646;
	Wed,  2 Oct 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865560; cv=none; b=Z+udHcqZFPAx3Tnh8tf0zUeCaLpyBuUF9FH8pMyiriKr+gamQJekJIl/cC757rQdBi6ZMyWWxlQCPRDUiZZVfp64BM4zXp4/hljLu6F8Mwos3+dVkIDeNZOLH2irLjiCs4K3a77knVqJhCPna07GVP5zF1Vnsuc6ITNVI//Cot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865560; c=relaxed/simple;
	bh=rofNQ84XsOHW0/tMwuBE9hUL/Se3Xra/SlgPwJFnwPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJaQQyFEpiw8/klh7UlU3LY/HLfLNa4+4Xe6Cod4M62yWvLXIdXBjg0bDdstiOPsDTXxahjcWaHUMimsl1CqEquxSxl4Lm9fvQTK/WogqqrksXdx1H9Rg+mYs3rD9oTJkWRbIexIng7jJYyzKzrORKIvwc32I7lHtt53MBtLp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 492AcX2m022298;
	Wed, 2 Oct 2024 05:38:33 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 492AcVPU022297;
	Wed, 2 Oct 2024 05:38:31 -0500
Date: Wed, 2 Oct 2024 05:38:31 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241002103830.GA22253@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 02 Oct 2024 05:38:34 -0500 (CDT)

On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:

Good morning Linus, I hope the week is going well for you.

Some reflections, for the record, on this issue.

> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Linus, it's unclear if you're still following this thread after the
> > pull, but can you provide a little insight on your thoughts here?

> I absolutely hate the whole "security people keep arguing", and I
> cannot personally find it in myself to care about tomoyo.  I don't
> even know where it is used - certainly not in Fedora, which is the
> only distro I can check quickly.
>
> If the consensus is that we should revert, I'll happily revert. This
> was all inside of the tomoyo subdirectory, so I didn't see it as
> some kind of sidestepping, and treated the pull request as a regular
> "another odd security subsystem update".

I see that Paul Moore has further responded with commentary about the
'LSM community' responding to this issue.  I wanted, on behalf of our
project and in support of Tetsuo's concerns, to register directly with
you a sense of jaded skepticism about the notion of a community
response.

Fixing Tetsuo's issue, at least to the extent it can be fixed,
requires technical improvements in the Linux security architecture.
Currently, potential technical improvements in this venue are
struggling to receive any kind of acknowledgement or review, to the
ultimate detriment of enhancements that Linux should be bringing
forward to address, not only this issue, but the security industry
writ-large.

We have made multiple submissions of technology, that can at least
positively impact Tetsuo's concerns, and in the process perhaps
improve the opportunity for security innovation in Linux.  After 20
months of doing so we have yet to receive anything that would resemble
substantive technical review [1].

The following are links to the four submissions.  We believe an
unbiased observer would conclude that they provide ample evidence of
very little interest in reviewing submissions for enhancements to the
Linux security eco-system, outside of perhaps certain constituencies:

V1:
https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t

V2:
https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

V3:
https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t

V4:
https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

As of the V4 release, we have added support for an approach that may
positively impact Tetsuo's concerns.  We do that without touching any
infrastructure outside of our proposed LSM.

We can speak, at great length, as to why we feel that Linux would
benefit from structural improvements to its security infrastructure.
We will refrain from doing so in this thread, given your stated
sentiments on these types of discussions.

However, your mantra, recently expressed on security infrastucture
issues, has always been:

"Code talks, bullshit walks."

For all of this to work, and the Linux community to remain healthy,
the code needs to be listened to and that is not effectively happening
in the security arena.

I started my involvement with Linux in late 1991.  All of what I see
is giving me a great deal of pause about the health of our community
moving forward and the potential negative impact these issues have on
the opportunity for security innovation to emerge

>                   Linus

Have a good remainder of the week.

Apologies in advance for extending conversations you find tiresome.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project


[1]: A thank you to Casey Schaufler, despite our lively disagreement
about some issues, who has offered specific review comments and
dialogue about security modeling.  To Greg Kroah Hartman for
recommending the most important change we have implemented with
respect to JSON encoding of security events and a handful of other
individuals who have provided helpful procedural and technical point
suggestions.
