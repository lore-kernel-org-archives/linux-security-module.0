Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57C19B59F;
	Thu,  3 Oct 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969997; cv=none; b=YaSoU72TJThs0E2tns76pMEgAVyGpGIGAgd2+uONl8C6r/Fe7KM4FmBg/bobskh3MPvKA7a1VJjoWE4VKgLF0A/PWp+GEPkyFrqIDjtQ5XJ/GDwkIokVWtdujtL4DM0YrWZMc8KSdzAbhGFGB7ZGuzsmdwwyseYaephSkrfoYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969997; c=relaxed/simple;
	bh=vFzmRBofMSnufhH28IhSzyavh8tH0wFkoMyzPhDC7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjEppRdZr/VxMIS4T6yZu1mOCetzfgFEWassLAMcqtFJ5mNRrEpb0sQ2YuUX1PTIhSvp+tXbevbKaWvm9ugj3CCdP6JLUglZgK+WdLRZl0gLzO7s2CW66VSK/pDjdn9ftfMlbfyjRreJfgeDsXROJQ5TWw7/jddI9oYwJIcxwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 493FdAC8004280;
	Thu, 3 Oct 2024 10:39:10 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 493Fd89E004279;
	Thu, 3 Oct 2024 10:39:08 -0500
Date: Thu, 3 Oct 2024 10:39:08 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241003153908.GA3267@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com> <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp> <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com> <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp> <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com> <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp> <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 03 Oct 2024 10:39:11 -0500 (CDT)

On Wed, Oct 02, 2024 at 10:35:27PM -0700, John Johansen wrote:

Good morning, I hope the day is going well for everyone.

> On 10/2/24 21:26, Tetsuo Handa wrote:
> >On 2024/10/03 11:45, John Johansen wrote:
> >>>But due to above-mentioned realities, your assertion no longer stands.
> >>>Kernel source itself might be open, but private keys cannot be open.
> >>>The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
> >>>negative impact on the user side, which cannot be a viable solution).
> >>>
> >>>
> >>Yes, and this is an intentional choice on the base of the distro about
> >>what they support and what is required to meet contractual obligations.
> >
> >The reason Fedora cannot enable TOMOYO is lack of bandwidth.

> which is sadly a very valid argument. Coming from the distro side of
> things it is a very real problem. I tend to advocate for giving the
> user choice where we can but there is more than one occasion where
> Ubuntu has had to declare bug bankruptcy on outstanding kernel bugs
> because the backlog was impossible to handle.

Understand the concept of lack of bandwidth.

Had a 40 hour week in as of 0800 yesterday morning and the end of the
week isn't even remotely in sight.

> >You've just said "Bandwidth is a very real issue". Thus, I need a solution
> >that can solve the bandwidth problem. The question is how we can control
> >division of role (share the workload) in a secure manner.

> I do understand that. The problem is that out of tree doesn't do that.
> From a distro perspective out of tree is more work, and is very problematic
> from a code signing perspective.
> 
> Code signing isn't going away, if anything its become a requirement to
> support the majority of users. Loading unsigned modules, code, even
> bpf is a problem.
> 
> Sure individual users can disable secure boot etc but at the distro
> level we need to support secure boot out of the box. Out of tree code
> really just isn't compatible with this.

Not relevant right now but I do remember, personally at a conference,
Stallman railing on about the threat of signed code and what it
represents with respect to software and device freedom.

And here we are....

> >>Users are still free to build their own kernels they just don't get
> >>support or certification when using them.
> >
> >Nobody can provide bandwidth (or infrastructure) for supporting their
> >locally built kernels.

> right

> >>                                           Stopping the load of out of
> >>tree modules that aren't signed is in general good security policy.
> >
> >Yes, distributors can prevent load of out-of-tree modules that aren't
> >signed. That is good for security. But building kernels locally cannot
> >utilize signed modules functionality. Also,

> true. that is a limitation of the cryptography that is being used, and
> I don't see a way to fix that

> >>Let me be explicitly clear. If Tomoyo is by-passing module signing, and
> >>exporting the LSM interface to loadable modules Ubuntu will be forced
> >>to disable Tomoyo.
> >
> >TOMOYO is one of in-tree modules that can be signed together when building
> >distribution kernels. Fedora can provide tomoyo.ko as a 
> >signed-but-unsupported
> >module (i.e. excluded from main kernel package that is supported by
> >distributors but provided as a separate package that is not supported by
> >distributors).

> yes it can, it has chosen not to. As I have said before that is a
> choice/political reason, not technical. I wish I had a solution to
> this problem for you but I don't. What I can say is Tomoyo adding
> the ability to load out of tree code that isn't signed is going to
> force Ubuntu to do the same and disable it. I really don't want to
> do that, I would rather leave the choice available to our users.
>
> It may be a trade-off worth making for you/Tomoyo if it fixed your
> problem with RHEL/Fedora but I don't see it fixing that problem
> either.

Not much bandwidth for the rest of the day but I wanted to get this
question/issue out to get some feedback for later tonight,
particularly from your perspective John.

We saw these issues coming about four years ago, which is why we
decided to take a deep breath and bring TSEM out of private use to a
wider audience, it isn't a 'pet project' as it has been referred to.
Not sure we would do that again but that is an issue for another day.

TSEM is based on the notion of having a generic modeling architecture
for the LSM.  I know that Casey bristles at the notion of us saying
'model', but we can prosecute that argument in intimate detail at
another time.

We would best characterize TSEM as a 'swiss army knife' for
interpreting kernel security events.  You can run the event
interpretation in the kernel, in userspace, in a hardware device or up
in the cloud.

After watching Tetsuo's concerns over the last year we dropped the
loadable module support into TSEM for the V4 release:

https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

This offers the ability to run the interpretation model via code
implemented in a loadable module.  BPF is also an option but we are
keeping things simple at this point.

So we use the standard loadable module architecture.  We offer the
ability to lock further model loads or unloads after a set of models
have been loaded and the option to completely disable any loadable
models at boot, independent of the general kernel loadable module
state.

It doesn't fully fix Tetsuo's problem, given that a distribution could
compile out TSEM, just like it compiles out Tomoyo, I think we all
agree there is no fix to that problem.  However, if the security bigs
like CrowdStrike, PaloAlto and others, understand that it allows EDR
telemetry and surveillance to be implemented on Linux without having
to install a high privilege or kernel based agent, it makes not having
it in the kernel less attractive.

Just for the sake of advancing these conversations, we are throwing
some bandwidth into implementing Tomoyo as a TSEM loadable module to
get some further insight on the tractability of something like this.

With your distributor hat on does an architecture like this offend
your security sensibilities?

Like it or agree with it, we seem to be standing at a reasonably
important inflection point for Linux, conversations probably suitable
for a 'Summit' type event.

Will look forward to your thoughts.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
