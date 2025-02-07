Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8CF80BFF;
	Fri,  7 Feb 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923654; cv=none; b=pX8V7Xheq4lavWwn6bQMSYRsFqNrDAcOwgR1KGgEYuJG3kGZiAmz+sqg4Zk3d/MsxNf3saZjBGmyKNcTgFkxiq3WFcc0TydJB/Q7jdr2bu83QtbMBbzUcqvhWuxg/TNObbBzqDKmbe1xjCL3mt5P/vranquZDa24Xro1EvA79x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923654; c=relaxed/simple;
	bh=FsMReRhSR0sfiNrZcqLBVDxK/HU2cNflLinb44tDRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeDGL53dqbw8gs8Iq4A++K4+VctO+Xy+YXCEdVa1ZHkwKhtAIivTPE427MXEcvRwzv0gNoH238pSW7erZiDVdsX749QmZX5JOafYokFr+9UTHm7jPAs2bM0kR4xl8BYY61t2t/ccMBbBM8WVtSA1xgVWL2DIVxm5oVrebGoucvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 517AKQEU007044;
	Fri, 7 Feb 2025 04:20:26 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 517AKOvj007043;
	Fri, 7 Feb 2025 04:20:24 -0600
Date: Fri, 7 Feb 2025 04:20:24 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250207102024.GA6415@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250205120026.GA15809@wind.enjellic.com> <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 07 Feb 2025 04:20:26 -0600 (CST)

On Thu, Feb 06, 2025 at 10:48:57AM -0500, Paul Moore wrote:

Good morning to everyone.

> On Wed, Feb 5, 2025 at 7:01???AM Dr. Greg <greg@enjellic.com> wrote:
> > On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> >
> > > I believe the LSM can support both the enforcement of security policy
> > > and the observation of security relevant events on a system.  In fact
> > > most of the existing LSMs do both, at least to some extent.
> > >
> > > However, while logging of security events likely needs to be
> > > asynchronous for performance reasons, enforcement of security policy
> > > likely needs to be synchronous to have any reasonable level of
> > > assurance.  You are welcome to propose LSMs which provide
> > > observability functionality that is either sync, async, or some
> > > combination of both (? it would need to make sense to do both ?), but
> > > I'm not currently interested in accepting LSMs that provide
> > > asynchronous enforcement as I don't view that as a "reasonable"
> > > enforcement mechanism.
> >
> > This is an artificial distinction that will prove limiting to the
> > security that Linux will be able to deliver in the future.
> >
> > Based on your response, is it your stated position as Linux security
> > maintainer, that you consider modern Endpoint Detection and Response
> > Systems (EDRS) lacking with respect to their ability to implement a
> > "reasonable" enforcement and assurance mechanism?

> As stated previously: "I'm not currently interested in accepting
> LSMs that provide asynchronous enforcement as I don't view that as a
> reasonable enforcement mechanism."

You personally don't, the IT and security compliance industry does, it
seems to leave Linux security infrastructure in an interesting
conundrum.

For the record, just to be very clear as to what an LSM is allowed to
do under your administration, for our benefit and the benefit of
others:

An LSM asynchronously streams an encoding of every security event that
occurs into something in userspace, somewhere, that interprets those
events.  Is userspace allowed to directly signal the operating system
if it detects an anomaly in one of those events or a pattern of events
and at what resolution level can the signalling occur?

> > If this is the case, your philosophy leaves Linux in a position that
> > is inconsistent with how the industry is choosing to implement
> > security.

> In this case perhaps TSEM is not well suited for the upstream Linux
> kernel and your efforts are better spent downstream, much like the
> industry you appear to respect.

Fascinating response from someone given the privilege of
maintainership status of a sub-system in a project whose leadership
preaches the need to always work with and submit to upstream.

Even more fascinating when that individual publically states that he
is employed by the largest technology company in the world because of
that companies desire to promote the health and well being of the
Linux eco-system and community.

For the record, we don't respect any industry, we respect the need to
address the challenges associated with how we are currently doing and
thinking about things.

> paul-moore.com

Our apologies to everyone for being a voice crying out in the
wilderness.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
