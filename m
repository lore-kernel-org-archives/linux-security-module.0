Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3D2F50;
	Sat, 18 Jan 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737227065; cv=none; b=Qtn0xpzSHPArNF2uqbTHH9QpmMfbiz1AtBfM4+2FOzkpVcyRuip9zIF1ak0E0gHlGIiSkRQ0EyPm0vExXlz2hElWvShoiIdvhuhqcA2W605BoNM85PrvzXkvt0IlQUq8y5Ept+vbGj8kMsZiD7tfmH1d2ngNlT42iuAJ6HXM3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737227065; c=relaxed/simple;
	bh=y2TJ6UjhQX+95RlcOGwfAdalZSm6tCQ4qCXuecYfUtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNplSquMyjI7JDNVviIJ/ceUooV/GC5161ISQRVZ2rZISULAXwyYYg4RSWWIrkE4WspWLu5OocbgxPWQRp5PuwKse4fvkGszbj3Uyl3tCSADmurFjZEE2XEm11LAxIxQfivnIUis3O87Hy37gBPUe7w7w/zwSSKBJTwOD/IEdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 50IJ3ma3010189;
	Sat, 18 Jan 2025 13:03:48 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 50IJ3kjl010188;
	Sat, 18 Jan 2025 13:03:46 -0600
Date: Sat, 18 Jan 2025 13:03:46 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250118190346.GA9479@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <1630b5cd-c1ef-4afd-9767-7ebf3c0cc7ae@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630b5cd-c1ef-4afd-9767-7ebf3c0cc7ae@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 18 Jan 2025 13:03:48 -0600 (CST)

On Fri, Jan 17, 2025 at 10:10:30AM -0800, Casey Schaufler wrote:

Good morning Casey, I hope your weekend is going well, thanks for
taking the time to forward along your thoughts on our work.

> On 1/16/2025 8:47 PM, Dr. Greg wrote:
> > On Mon, Jan 13, 2025 at 08:29:47PM -0500, Paul Moore wrote:
> >
> ...
> 
> >> Please define the CELL acronym here as I believe it is the first use of
> >> "CELL" in this document.

> > FWIW, CELL isn't an acronym, it is a metaphor.
> >
> > TSEM was conceptually inspired by and derived from the Turing Abstract
> > Machine Model (TAMM), as applied to the problem of modeling the
> > security state of an execution domain.
> >
> > As everyone reading this knows, a TAMM, in practice, consists of a
> > head traversing an infinite paper tape divided into cells that direct
> > the next state of the machine.
> >
> > In TSEM, the model consists of a Context Of Execution (COE) with
> > security definining characteristics, traversing a finite set of
> > measurement points of infinite length, with defining characteristics
> > at each point.
> >
> > We refer to a measurement point and its characteristics as a CELL in
> > deference to the inspiration for all of this.
> >
> > We will add this explanation to the documentation.

> Communication within a community as culturally diverse as the Linux
> kernel developers* requires that you do not assume that "everyone reading
> this" knows much of anything beyond how to type "make". Let's face it,
> there are kernel developers today who would look at the Turing test and
> say "is that even a thing?" There are others who don't have an education
> that includes mid-twentieth century technological history.
> 
> [* Yes, an awful lot of Linux kernel developers are western males. ] 
> 
> ...

Sigh....

It would thus appear that effective dialogue in the Linux kernel
community is now about as perilous as attempting to square dance in a
minefield with snowshoes on.

When we penned the reflections above, we very specifically did not
want to be so pejorative as to suggest that anyone involved in this
endeavor wouldn't have at least a basic understanding of the
computability theory that all of our work is based.  They even have a
movie about it, presumably in multiple languages.

In any event, we apologize for being mistaken.

We will add a Wikipedia link in the documentation pointing to an
article on Turing machines, for the benefit of the unwashed masses now
involved in kernel development.

> > We believe there is a technical solution to this problem as well but
> > our work on that front, at this point, is too technically immature to
> > go into.

> Didn't Pierre de Fermat say something like that about some theorem
> or another?

I believe you are referring to Fermat's Last Theorem, formerly known
as Fermat's Conjecture.

For all the bystanders whose level of understanding is limited to
'make bzImage':

Fermat's Conjecture, now a proven and foundational theorem in
algebraic number theory, states that there exist no three positive
integers: a, b or c; that satisfies the following algebraic
relationship for any value of n greater than two:

a^n + b^n = c^n

Fermat penned the theorem into the margin of his copy of Diophantus's
Arithmetica, and in a note below it, indicated there was insufficient
room in the margin to write the formal proof.

It was called Fermat's Conjecture, since many doubted its validity or
that Fermat ever had any proof for what he was proposing.

As a Quixote team we take some solace to your reference of Fermat's
Theorem with respect to our work.  It took 358 years to formally prove
his theorem, in the face of many nay-sayers.  It turns out he was
absolutely right and his vision is now universally accepted as a
foundational premise of mathematics.

And so it goes with respect to the perils of innovation.

> ... Sorry, all I have time for today.

Yes, and I need to get outside and get my fishhouse off the lake.  It
is going to be -20 tonight and the 4-wheeler isn't going to start in
the morning.

We always appreciate the insight that you bring forward with respect
to our work.

Best wishes for a pleasant weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
