Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535678F39;
	Sun, 26 Jan 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737918411; cv=none; b=EI91C8yPmoAi9CcF34czMtO82v2b3sGePveLlSfZQ+Fqmf95volfEEWMH3ZYuNYHH4l+MhtZ2S0Jub/j58DTyY1zTHt5yYVgsiuy4FIV/dQyIuTTpmzz3R1aA3VXmRwanavNQwowBzm/pUJ4XoAx+JbuJSVUZC+alL6qd1uSd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737918411; c=relaxed/simple;
	bh=0wZSAjqf7l3VytlHTwrIt2U0jZeddNU7sXfoQwAaI6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEceissMFr0rVbaxRfZOIp/04QoCc2EfCJzxM4LpCg44x042aT1QSBr8rJDqZ0it5/NQgw1gZkXzoFu29bJrVhx3eQnj7qtTNx7wXskkIWw9boUsZPMHg/0M2v6BWJhxXgnk4H5mEmofV18zDIMVyvlvV1WsjmzIQM1OwJdwgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 50QIeY62004281;
	Sun, 26 Jan 2025 12:40:34 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 50QIeWR8004280;
	Sun, 26 Jan 2025 12:40:32 -0600
Date: Sun, 26 Jan 2025 12:40:32 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250126184032.GA4277@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <1630b5cd-c1ef-4afd-9767-7ebf3c0cc7ae@schaufler-ca.com> <20250118190346.GA9479@wind.enjellic.com> <d61082f5-7426-48cb-8d64-3d8aefee68ca@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61082f5-7426-48cb-8d64-3d8aefee68ca@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 26 Jan 2025 12:40:35 -0600 (CST)

On Tue, Jan 21, 2025 at 10:09:59AM -0800, Casey Schaufler wrote:

Hi Casey, I hope your weekend has gone well, greetings to other on the
list as well.

> On 1/18/2025 11:03 AM, Dr. Greg wrote:
> > On Fri, Jan 17, 2025 at 10:10:30AM -0800, Casey Schaufler wrote:
> >
> > Good morning Casey, I hope your weekend is going well, thanks for
> > taking the time to forward along your thoughts on our work.
> >
> >> On 1/16/2025 8:47 PM, Dr. Greg wrote:
> >>> On Mon, Jan 13, 2025 at 08:29:47PM -0500, Paul Moore wrote:
> >>>
> >> ...
> >>
> >>>> Please define the CELL acronym here as I believe it is the first use of
> >>>> "CELL" in this document.
> >>> FWIW, CELL isn't an acronym, it is a metaphor.
> >>>
> >>> TSEM was conceptually inspired by and derived from the Turing Abstract
> >>> Machine Model (TAMM), as applied to the problem of modeling the
> >>> security state of an execution domain.
> >>>
> >>> As everyone reading this knows, a TAMM, in practice, consists of a
> >>> head traversing an infinite paper tape divided into cells that direct
> >>> the next state of the machine.
> >>>
> >>> In TSEM, the model consists of a Context Of Execution (COE) with
> >>> security definining characteristics, traversing a finite set of
> >>> measurement points of infinite length, with defining characteristics
> >>> at each point.
> >>>
> >>> We refer to a measurement point and its characteristics as a CELL in
> >>> deference to the inspiration for all of this.
> >>>
> >>> We will add this explanation to the documentation.
> >> Communication within a community as culturally diverse as the Linux
> >> kernel developers* requires that you do not assume that "everyone reading
> >> this" knows much of anything beyond how to type "make". Let's face it,
> >> there are kernel developers today who would look at the Turing test and
> >> say "is that even a thing?" There are others who don't have an education
> >> that includes mid-twentieth century technological history.
> >>
> >> [* Yes, an awful lot of Linux kernel developers are western males. ] 
> >>
> >> ...
> > Sigh....
> >
> > It would thus appear that effective dialogue in the Linux kernel
> > community is now about as perilous as attempting to square dance in a
> > minefield with snowshoes on.

> This isn't about Political Correctness. It's about communication.
> Your documentation appears to target PHD level computer scientists.

Probably not surprising, given that Quixote has been architected and
stewarded by three Ph.D.'s, one soon to be Ph.D. and a rather
remarkable individual that has four Ph.D.'s worth of experience, if I
can choose my phrasing carefully, in global cyber-operations of
various types.

> Most Linux kernel developers are much more the BS engineer sort.
> I'm not saying you need to dumb it down, I'm suggesting that you
> could make it easier to review by targeting your audience better.

In the theory portion of the documentation we attempted to draw
correlations between classic mandatory access control and integrity
architectures and what we are implementing with Quixote/TSEM.

> > When we penned the reflections above, we very specifically didot
> > want to be so pejorative as to suggest that anyone involved in this
> > endeavor wouldn't have at least a basic understanding of the
> > computability theory that all of our work is based.  They even have a
> > movie about it, presumably in multiple languages.
> >
> > In any event, we apologize for being mistaken.
> >
> > We will add a Wikipedia link in the documentation pointing to an
> > article on Turing machines, for the benefit of the unwashed masses now
> > involved in kernel development.

> The link is a good idea.

Clarifications to the theory section and a Wikipedia link have been
added and will appear in V5.

> >>> We believe there is a technical solution to this problem as well but
> >>> our work on that front, at this point, is too technically immature to
> >>> go into.

> >> Didn't Pierre de Fermat say something like that about some theorem
> >> or another?

> > As a Quixote team we take some solace to your reference of Fermat's
> > Theorem with respect to our work.  It took 358 years to formally prove
> > his theorem, in the face of many nay-sayers.  It turns out he was
> > absolutely right and his vision is now universally accepted as a
> > foundational premise of mathematics.

> If it takes the Quixote team 358 years to develop a technical
> solution I expect you will miss your market window. :(

If we didn't believe that we have a solid technical solution in hand
within the context of this century, and groups that have asked for it
to be in the kernel, we wouldn't be expending cycles on getting it
upstreamed.

We are hoping for considerably better than 358 years, but that would
seem to be dependent on Linux review bandwidth, which everyone agrees
is strained.

More to the point, we were making an allusion with our comments that
throughout history, disruptive innovation has been consistently missed
by the technical status quo.

Once again, thank you for your comments and review.

Have a good remainder of the weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
