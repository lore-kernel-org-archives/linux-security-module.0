Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83624149E1A
	for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831668; cv=none; b=q+GMRf4MG30vkdrvwbQ7YCGLI6E+z4pKexPHknZlSFkap5Ue21X9wJEPV4130SwJ4yqr07S2S+6l5nE5eEqgmdG4RpFkTZtGGpd6vTTB5eG4seT43yTE8ayG4OKVxE3xCslzbjkfk4YdlYZ+9P68yZWV+vQ6Aw+KDTxLjBJ0wms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831668; c=relaxed/simple;
	bh=9HnffcfMQhvCbYJQG+oZtImYwtDH+HMsjF1GHC12VOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCCEusOj3oZDu8APdBJnKtek+kqIrAy4r68HGVh/U5nMbtwQTB+gVzWrIJJlMwh+VEgl4WnpnkoQzpvVHGJtp9juBUjYpSijT81x95HPs+Enx5VJncHbHQUCTtRdpx0x+6sFngCsMm3lJFWDwEJDALE9X/7Z0Lz/Y9PSNjV5/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 43BAXqvb011937;
	Thu, 11 Apr 2024 05:33:53 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 43BAXq1H011936;
	Thu, 11 Apr 2024 05:33:52 -0500
Date: Thu, 11 Apr 2024 05:33:52 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        KP Singh <kpsingh@kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
Message-ID: <20240411103351.GA11734@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com> <202404091041.63A1CFC1A@keescook> <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 11 Apr 2024 05:33:53 -0500 (CDT)

On Tue, Apr 09, 2024 at 11:24:44AM -0700, Linus Torvalds wrote:

Good morning, I hope the week is winding down well for everyone.

> On Tue, 9 Apr 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
> >
> > I don't think it's sane to demand that LSM stacking be removed. That's
> > just not the world we live in -- we have specific and large scale needs
> > for the infrastructure that is in place.
> 
> I think we really need to push back on this all.
> 
> The whole stacking is new. There can't be too many users. And it damn
> well can be limited.
> 
> Right now that sttaic stacking code is written to allow 11 levels.
> 
> Why? Just because you people cannot agree.
> 
> Stop it.

Kees' response is well taken.  There is about as much chance of
everyone agreeing on what type of security control to implement as
there is on the one file system or text editor that everyone should
use.

We are also rapidly racing into an environment where there are going
to be multiple and potentially industry specific mandated security
controls, particularly as Linux takes over the critical infrastructure
control market.

> > I don't think describing static calls as "random hacks" is very fair;
> 
> Static calls aren't random hacks.
> 
> But the "up to eleven levens of nesting" and "reorider arbitrarily" IS.
> 
> This needs to be *fixed*.
> 
> Seriously, what part of "this is now an attack vector" did people
> not get?

I don't believe there is any active disagreement with respect to the
need to eliminate an attack vector and the performance impacts of
indirect branching.

Doing so is going to raise a number of issues, many of which will
determine whether or not Linux will be in a position to support the
security development that will be required moving forward.

The one LSM that rules all paradigm is fine, but that LSM needs to be
able to support multiple and diverse security policies or models.  We
are in the situation we are in now because our security architecture
required a separate LSM for each type of security policy/model that
there was a desire to implement.

From a technical perspective, this leaves us in a situation where
multiple security architectures are simultaneously active, with users
left to reason as to what security behavior results from the union of
the respective controls.  Specific LSM ordering ends up being demanded
because LSM's either want to be first, before another, after another
or at the end and the issues go on and on.

Most fundamentally limiting, we are left in a situation where anyone
with a technical requirement, or interest, in using Linux as a
platform for security development needs to get an LSM accepted into
the mainline kernel.  A requirement that is problematic if not
completely unrealistic.

The static branch patches are going to codify this latter requirement.
If we don't have an effective technical solution, it will end up
impairing the future usability of Linux from a security perspective.

There needs to be an 'LSM' architecture that allows a security policy
to be implemented for a process hierarchy, just like we do for all
other resource namespaces.  Platform owners are then free to select
whether they want to implement multiple orthogonal security controls
or lock the platform into a single control of their choosing.

This seems consistent with the history of Linux and free software
being about choice and the ability to use a system as one chooses to.

This isn't to suggest that infrastructural controls, such as
capabilities, would not be simultaneously active with more
comprehensive model or policy based controls.

LSM's based on loadable modules were rejected because it wasn't
possible to do that safely, ie. race free.  This issue goes away if a
model/policy is available for a process hierarchy to subscribe to,
before the use of the control method is engaged.  That being said, a
model/policy configurable LSM doesn't need to require loadable modules
but we use that as a metaphor that everyone understands.

There may be an inclination to shout BPF but the following should be
taken into consideration:

https://lore.kernel.org/linux-security-module/CAHC9VhRruSLET+aOhCt7WKucWNBE_qLCYV3won+p10XOjLLiHQ@mail.gmail.com/T/#m4cbae6c1d8371e7994a57700dcbcab03bf9d1146

BPF is an extremely useful adjunctive technology.  However, achieving
something of the status of a major security control engine will end up
necessitating the development and introduction of a collection of
kfuncs, a barrier not unlike the introduction of a new LSM.

>             Linus

FWIW, we didn't come by these impressions from the cheap seats and we
will leave our motivations for composing this note at that.

Have a good remainder of the week.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project
