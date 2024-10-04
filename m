Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0611E573E;
	Fri,  4 Oct 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067267; cv=none; b=jTrcki5p17LnPsHPBPyLN+tfH2uc/hXEirPZ7I1xPYxOxNRziLyZ1qp3vFskHrwZHFllqziYWJPFo18SqwbB+jV8+pyV/rOGwpEOFrGgkLgc8WA11Eh+J1sBalMwN1dayeWMWoJdvk7Nd4c3ZY799Gf+nVr3fhYJX+nqJ2Oqc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067267; c=relaxed/simple;
	bh=augURPccsdIY9LZoN8gxtoUuNUyj6/brJ7N31RDwniE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhWd18JlST1a8Jk01uo0tBi8KSQB61Clbm1euzKyl8lDIXR1xqnrWqcsvNqXHpjmCIzBJ33q9R7nSD8l+9SukQwnw10vslpeKy8VQMTIm20U/Pc+lxhqlafnv4m+OhNsioRsGA83Vo6HlKBMBUng9mkeyfImClJQHVbEsjHuZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 494IeLVM016535;
	Fri, 4 Oct 2024 13:40:21 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 494IeJhT016534;
	Fri, 4 Oct 2024 13:40:19 -0500
Date: Fri, 4 Oct 2024 13:40:19 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241004184019.GA16388@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 04 Oct 2024 13:40:21 -0500 (CDT)

On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:

Hi, I hope the week has gone well for everyone.

> On 10/2/24 03:38, Dr. Greg wrote:
> >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> >
> >Good morning Linus, I hope the week is going well for you.
> >
> >Some reflections, for the record, on this issue.
> >
> >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> >>>
> >>>Linus, it's unclear if you're still following this thread after the
> >>>pull, but can you provide a little insight on your thoughts here?
> >
> >>I absolutely hate the whole "security people keep arguing", and I
> >>cannot personally find it in myself to care about tomoyo.  I don't
> >>even know where it is used - certainly not in Fedora, which is the
> >>only distro I can check quickly.
> >>
> >>If the consensus is that we should revert, I'll happily revert. This
> >>was all inside of the tomoyo subdirectory, so I didn't see it as
> >>some kind of sidestepping, and treated the pull request as a regular
> >>"another odd security subsystem update".
> >
> >I see that Paul Moore has further responded with commentary about the
> >'LSM community' responding to this issue.  I wanted, on behalf of our
> >project and in support of Tetsuo's concerns, to register directly with
> >you a sense of jaded skepticism about the notion of a community
> >response.
> >
> >Fixing Tetsuo's issue, at least to the extent it can be fixed,
> >requires technical improvements in the Linux security architecture.

> yes and that is correct place to do it. Doing it within a single LSM
> is very much the wrong approach

I don't disagree and have publically stated that a number of times
over the last 10 months or so that this issue has been raging,
including in e-mail to Tetsuo himself.

Our opinion or ACK doesn't matter much in the grand scheme of things,
but Paul can feel free to take his black sharpie pen and place a mark
in the column that indicates that it is in everyone's interest to have
a standard framework for security event dispatch, on our behalf.

That being said, if we are actually serious about responding properly
to this event/crisis, we need to step back and have an intellectually
honest engineering discussing surrounding the following question:

Has the threat environment, its significance to society and industry
and the scale and scope of the solutions needed to mount a response to
it, changed since the inception of the LSM 22 years ago?

Colleagues I have in the counseling industry tell me that the first
step in resolving a problem is recognizing that there is a problem.

> >Currently, potential technical improvements in this venue are
> >struggling to receive any kind of acknowledgement or review, to the
> >ultimate detriment of enhancements that Linux should be bringing
> >forward to address, not only this issue, but the security industry
> >writ-large.

> everyone in the LSM community is struggling with available time, and
> yes there are disagreements around how this should be done so it
> moves slow.

With respect to bandwidth there are two problems that need to addressed:

1.) The amount of time and talent it takes for developers to implement
security policies with mandatory enforcement capabilities.

2.) The ability to implement security technology solutions on linux,
based on a standardized infrastructure, in less than 4-5+ year
timeframes.

The third problem to be addressed, and you acknowledge it above, is
that there needs to be a flexible pathway for security innovation on
Linux that doesn't require broad based consensus and yet doesn't
imperil the kernel.

This latter issue is the most fundamental problem with security on
Linux and something that Linus has publically complained about
multiple times, as we all know.

With TSEM we placed a design on the table, influenced by individuals
with significant experience in the field and its challenges, that was
a legitimate attempt to address these issues, including the problem
that Tetuso has.  Unfortunately it sat on the cutting room floor for
20 months without even a legitimate technical discussion as to its
motivation and design and the fact that it could have provided a
method to derail this current crisis/controversy.

We fully recognize and respect the bandwidth crisis.  If it is as bad
as everyone claims it is, and there is no reason to assume otherwise,
then we need to acknowledge and address this issue as one of the two
roots of our problem, if security innovation on Linux is to remain
even remotely relevant and healthy.

We appreciate your willingness to review TSEM sometime down the road
and will look forward to your thoughts.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
