Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4B186E2D;
	Mon, 17 Feb 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796835; cv=none; b=fRmBEzhkAl9zx3xj6aQrUJdUK/7t+ZQAgMJYWSLZ7HOKQbN1ThGWQq1OTnkkIcjo0VIpZgaUAMzSl4N1JdfITqvJcj7FpMPT7INseOHeIgElSf7ueDwDvnjLqRQjl8u1GzaZpIdKMOm2XMsZZXIKBZIzXoD2XIA41e91m5nZZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796835; c=relaxed/simple;
	bh=N5IYCV85xRfC1EIyuiDLVV0pgkZOgYDqjCXPZrBvI3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Qvmj06V3CC3XLcxhY52Iw5ZcEqV9IyHJHvI+tDT5Oox5285AimD8E7d9L+qbFRgasmvvqQ4sRORbHEpaCTuyDb2QL3BCYqXqqqugeqCsZhOgjWyTQM8yTPe6JrT4wreLO7jyd4UymXVjqJpG9A8nODMCWhFAplLaTcdFgYcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 51HCrQoN011735;
	Mon, 17 Feb 2025 06:53:26 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 51HCrPE1011734;
	Mon, 17 Feb 2025 06:53:25 -0600
Date: Mon, 17 Feb 2025 06:53:25 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250217125325.GA11696@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250205120026.GA15809@wind.enjellic.com> <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com> <20250207102024.GA6415@wind.enjellic.com> <CAHC9VhSd-5Lm4+DPWG-V5eav5k-Q1evh3oVHxgB7in2o+XMMEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSd-5Lm4+DPWG-V5eav5k-Q1evh3oVHxgB7in2o+XMMEg@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 17 Feb 2025 06:53:26 -0600 (CST)

On Fri, Feb 07, 2025 at 07:29:58PM -0500, Paul Moore wrote:

Good morning to everyone.

> On Fri, Feb 7, 2025 at 5:20???AM Dr. Greg <greg@enjellic.com> wrote:
> > On Thu, Feb 06, 2025 at 10:48:57AM -0500, Paul Moore wrote:
> > > On Wed, Feb 5, 2025 at 7:01???AM Dr. Greg <greg@enjellic.com> wrote:
> > > > On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> > > >
> > > > > I believe the LSM can support both the enforcement of security policy
> > > > > and the observation of security relevant events on a system.  In fact
> > > > > most of the existing LSMs do both, at least to some extent.
> > > > >
> > > > > However, while logging of security events likely needs to be
> > > > > asynchronous for performance reasons, enforcement of security policy
> > > > > likely needs to be synchronous to have any reasonable level of
> > > > > assurance.  You are welcome to propose LSMs which provide
> > > > > observability functionality that is either sync, async, or some
> > > > > combination of both (? it would need to make sense to do both ?), but
> > > > > I'm not currently interested in accepting LSMs that provide
> > > > > asynchronous enforcement as I don't view that as a "reasonable"
> > > > > enforcement mechanism.
> > > >
> > > > This is an artificial distinction that will prove limiting to the
> > > > security that Linux will be able to deliver in the future.
> > > >
> > > > Based on your response, is it your stated position as Linux security
> > > > maintainer, that you consider modern Endpoint Detection and Response
> > > > Systems (EDRS) lacking with respect to their ability to implement a
> > > > "reasonable" enforcement and assurance mechanism?
> >
> > > As stated previously: "I'm not currently interested in accepting
> > > LSMs that provide asynchronous enforcement as I don't view that as a
> > > reasonable enforcement mechanism."
> >
> > You personally don't, the IT and security compliance industry does, it
> > seems to leave Linux security infrastructure in an interesting
> > conundrum.

> Your concern over the state of the LSM has been previously noted, and
> I assure you I've rolled my eyes at each reference since.

Addressed at the end of this e-mail.

You can also see our reply to James Morris and the announcement of the
Linux Security Summit in Denver this summer.

> > For the record, just to be very clear as to what an LSM is allowed to
> > do under your administration, for our benefit and the benefit of
> > others ...

> I've repeated my position once already, if any current or aspiring LSM
> developers are unsure about some aspect of this, they are welcome to
> bring their specific concerns to the list and we can discuss them.

For the record, we did bring a specific concern to the list for
discussion, you removed the question and example we raised from your
reply.

Let me re-state the example and question for the benefit of everyone
reading along at home.

An LSM encodes a description of each security event it handles that is
designed to be consumed by an application running in userspace or on a
dedicated device that analyzes the events.  If the application or
device detects an anomalous event or pattern of events it takes action
to protect the system.

Would such an LSM be permitted to exist?

If the answer to the previous question is yes, at what level of event
resolution can the remediative action be taken?

We will look forward to the ensueing discussion.

> > > > If this is the case, your philosophy leaves Linux in a position that
> > > > is inconsistent with how the industry is choosing to implement
> > > > security.
> >
> > > In this case perhaps TSEM is not well suited for the upstream Linux
> > > kernel and your efforts are better spent downstream, much like the
> > > industry you appear to respect.
> >
> > Fascinating response from someone given the privilege of
> > maintainership status of a sub-system in a project whose leadership
> > preaches the need to always work with and submit to upstream.
> >
> > Even more fascinating when that individual publically states that he
> > is employed by the largest technology company in the world because of
> > that companies desire to promote the health and well being of the
> > Linux eco-system and community.

> I would suggest that your interpretation of my previous comments are
> a bit "off" in my opinion, but who am I to argue with a view that
> sees my comments as this fascinating!
>
> Jokes aside, to be clear I didn't tell you not to continue to post
> newer revisions of TSEM, I simply suggested that based on the
> choices you've made in designing and developing TSEM, it may be
> better suited to a downstream solution and not the upstream Linux
> kernel.  However, perhaps continuing to post a LSM that has not been
> accepted upstream due to inherent design decisions is perfectly in
> keeping with a LSM that relishes references to Don Quixote.

Since we seem to be on the precipice of closing down the discussion on
the relevancy of LSM development moving forward, a final comment for
the record.

We were not tilting at windmills when we started this effort two years
ago, we fully understood that we would be involved in a long game.

Our objectives were to either:

1.) Provide Linux security development with infrastructure for a more
generic and safer security modeling architecture that is consistent
with the current and emerging threat environment and counter-offensive
technologies.

or

2.) Document that upstream Linux security development is not a
suitable venue for analyzing and solving these and upcoming security
challenges.

Two outcomes were possible, either outcome was acceptable, the second
seems to be the one that is eventuating.

> paul-moore.com

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
