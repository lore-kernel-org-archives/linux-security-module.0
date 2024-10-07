Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7282AD05;
	Mon,  7 Oct 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300158; cv=none; b=iu71aUDRSHWNU3rTkV5gkrAkC/QG8Lya43JtDTLa5ttftw2HZpRBhgHw2XXmWuPRvAq4tpz3e8U5KSvK7Bnm595cXH5eyGSR3/sau5i6X4lk3iBPxSo/upkB2+NdxrLlho80MX73covm8nMY8JfE3MYkTYgh3/ky7wSTRtI+QWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300158; c=relaxed/simple;
	bh=LDHlrlKj5yPaGcKdiJTL6ZWD5QwcgLJoLpx7mv9CL6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeekjuschuI8CDBrX9xaquxS5GCUBJtqt2gLt820rPCWxvCJXBoKBy6tVbG8Fk3Sc+8SL0grhS3jMozESWSabdrFn+tZrvWj2eU3UZYxevBRvORaBPjKueZexCz7s66G2WWvMATbDX8nGk3pMAU0rruU8vLcmk9cpjI9fyeJSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 497BLx4c010150;
	Mon, 7 Oct 2024 06:21:59 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 497BLw3Y010149;
	Mon, 7 Oct 2024 06:21:58 -0500
Date: Mon, 7 Oct 2024 06:21:58 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241007112158.GA10114@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com> <20241004184019.GA16388@wind.enjellic.com> <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com> <20241005023357.GA20577@wind.enjellic.com> <CAHC9VhSoPK7zMQjUNiHG23Je-iSmxOSdRFvp1ikqCeCxkS9zWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSoPK7zMQjUNiHG23Je-iSmxOSdRFvp1ikqCeCxkS9zWw@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 07 Oct 2024 06:22:00 -0500 (CDT)

On Sat, Oct 05, 2024 at 12:21:31PM -0400, Paul Moore wrote:

Good morning, I hope the week is starting well for everyone.

> On Fri, Oct 4, 2024 at 10:34???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Fri, Oct 04, 2024 at 02:58:57PM -0400, Paul Moore wrote:
> > > On Fri, Oct 4, 2024 at 2:40???PM Dr. Greg <greg@enjellic.com> wrote:
> > > > On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > > > > On 10/2/24 03:38, Dr. Greg wrote:
> > > > > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > > > > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > ...
> > >
> > > > The third problem to be addressed, and you acknowledge it above, is
> > > > that there needs to be a flexible pathway for security innovation on
> > > > Linux that doesn't require broad based consensus and yet doesn't
> > > > imperil the kernel.
> >
> > > The new LSM guidelines are documented at the URL below (and
> > > available in the README.md file of any cloned LSM tree), the
> > > document is also linked from the MAINTAINERS file:
> > >
> > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-guidelines
> > >
> > > The guidelines were developed last summer on the LSM mailing list
> > > with input and edits from a number of LSM developers.
> > >
> > > https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com
> >
> > We are intimately familiar with those documents.
> >
> > Our reference was to the need for a technical solution, not political
> > medicaments.

> Seeing that document as a purely political solution to the challenge
> of gaining acceptance for a new LSM is a telling perspective, and not
> an accurate one as far as I'm concerned.  The document spells out a
> number of things that new LSMs should strive to satisfy if they want
> to be included in the upstream Linux kernel; it's intended as guidance
> both for the development of new LSMs as well as their review.
> 
> If those guidelines are too restrictive or otherwise stifling, you are
> always welcome to suggest changes on the LSM list; that is how the doc
> was established and that is how we'll keep it current and resonable.
> 
> However, if you find yourself objecting to the guidelines simply
> because they are trying your patience, or you find that the technical
> reviews driven by those guidelines are incorrect, but are unable to
> properly respond in a way that satisfies the reviewer, then the
> upstream Linux kernel may not be the best place for your LSM.

The document is an embodiment of a political process, let me take a
swing at defining what it is:

It is a collaboratively developed instrument for establishing
normative guidelines and practices, among a diverse group of
individuals with varying goals and objectives, who desire to cooperate
to create an environment that supports the resolution of conflicts in
the pursuit of individual objectives while maintaining a common good.

I think we have all been around long enough to understand that Linux
kernel development and distribution is a study in technical politics,
probably more so than ever.

You don't have to take my word for it.  Our Quixote team is fortunate
enough to have as a member, a valued consigliere, who hangs both a J.D
and a Ph.D. off the end of her name.  The latter in political science
whose 600+ page dissertation studied, among other issues, the role of
mediation in a legal system.

She was influenced by a top constitutional scholar, and as we all
know, the US constitution was a document designed to mediate a
political process in the pursuit of the common good.

We could get an opinion from her, if you want to take on her hourly
rates.  I'm pretty confident she would conclude that this is a
political process and the ANN document is an instrument for mediating
that process.

For the record, we have no issues with the document.  It is a bit
light on rights of participants in the process and requirements for
leadership, but that is a subject for another day and perhaps the
kernel community at large.

Interestingly enough, and relevant to these conversations, is that
Tetsuo has consistently called out the 'patent' requirements of the
document as problematic.  Once again, a subject for another
conversation.

Citing the document in response to our suggestion that there needs to
be a flexible pathway for security innovation, that doesn't require
consensus, misses the point we were making.

As the TOMOYO incident points out, requiring the need to have kernel
resident code to implement a security architecture that samples LSM
events is problematic and will probably become more as time goes on.

From a commercial perspective, the Linux distributors are being forced
into code signing due to security issues.  As this incident has
demonstrated, the effect of that is to limit choice in security
solutions to what the distributions feel they can or want to support.

From a technical perspective, history has clearly demonstrated that
security engineers have varying and unique ideas on how security
should be implemented, much to the long stated consternation of Linus
himself.  The LSM is a study in the fact that people cannot agree on
how security should be implemented.

The existence of the ANN document doesn't address either of these
issues.

It addresses how to participate in the process of getting a security
implementation into the kernel proper, which this incident has clearly
demonstrated is the problematic requirement.

We will ultimately never 'fix' this problem because it is a political
problem, given that distributions either want to limit choice for
business purposes or are being forced into it by the current threat
environment.

So the path forward to address this problem, the best that we can hope
for, is to develop an architecture that minimizes the need for
consensus on how to implement a security architecture.

Tetsuo has placed one idea on the table, we will see where that goes
and how long it ultimately takes.

As I've stated before, we saw this coming about four years ago and
TSEM was designed to provide an architecture that minimizes the need
for consensus on how to do security.

We will litigate elsewhere the current state of issues we have
experienced with that.

> paul-moore.com

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
