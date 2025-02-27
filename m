Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5A22B8D0;
	Thu, 27 Feb 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658354; cv=none; b=pMnyFda+7y/HQS652Se5uGSyCP8YVWhVtsN5c1/3QAbN5Zlf4ol58cpe/Jp4p/0ruI8yjSvu3rmqaxcFeXIuCwiKJU9cDFA9Ipt28KQmseP1Suh2A1EYjSoT0c/4uYtDye9EDbVWdX6AnJ1zVJMZ57ImdL3Ns2mPuWUN02tdEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658354; c=relaxed/simple;
	bh=UC2rpvyWXrKN4d3nbei/pEG8zi0Fltfi8u5srY/6kvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6I0o/moa/kGYEjbxVZvkz1E0yQoE3PL5qe+DmaSJ8SgK8RGFPNc0qj0+MTcl2MgK/UpR+9l/vaEun+t0hrF/PMgNzRn8d17AeAAE+ks4aftLRBuxjL7AsDBNSvywfj1QLwQNRk63kR2wH0tsFEescC1nH0sxcYjWheCwhl9dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 51RCC9A7015235;
	Thu, 27 Feb 2025 06:12:09 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 51RCC72v015234;
	Thu, 27 Feb 2025 06:12:07 -0600
Date: Thu, 27 Feb 2025 06:12:07 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250227121207.GA15116@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com> <20250225120114.GA13368@wind.enjellic.com> <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 27 Feb 2025 06:12:09 -0600 (CST)

On Tue, Feb 25, 2025 at 07:48:31AM -0800, Casey Schaufler wrote:

Good morning, I hope this note finds the week going well for everyone.

> On 2/25/2025 4:01 AM, Dr. Greg wrote:
> > On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> >
> > For the record, further documentation of our replies to TSEM technical
> > issues.
> >
> > ...
> >
> > Further, TSEM is formulated on the premise that software teams,
> > as a by product of CI/CD automation and testing, can develop precise
> > descriptions of the security behavior of their workloads.

> I've said it before, and I'll say it again. This premise is
> hopelessly naive. If it was workable you'd be able to use SELinux
> and audit2allow to create perfect security, and it would have been
> done 15 years ago.  The whole idea that you can glean what a
> software system is *supposed* to do from what it *does* flies
> completely in the face of basic security principles.

You view our work as hopelessly naive because you, and perhaps others,
view it through a 45+ year old lens of classic subject/object
mandatory controls that possess only limited dimensionality.

We view it through a lens of 10+ years of developing new multi-scale
methods for modeling alpha2-adrenergic receptor antagonists... :-)

We don't offer this observation just in jest.  If people don't
understand what we mean by this, they should consider the impact that
Singular Value Decomposition methods had when they were brought over
from engineering and applied to machine learning and classification.

A quote from John von Neumann, circa 1949, would seem appropriate:

"It would appear that we have reached the limits of what is
 possible to achieve with computer technology, although one should be
 careful with such statements, as they tend to sound pretty silly in 5
 years."

If anyone spends time understanding the generative functions that we
are using, particularly the task identity model, they will find that
the coefficients that define the permitted behaviors have far more
specificity, with respect to classifying what a system is *supposed*
to do, than the two, possibly three dimensions of classic
subject/object controls.

More specifically to the issues you raise.

Your SeLinux/audit2allow analogy is flawed and isn't a relevant
comparison to what we are implementing.  audit2allow is incapable of
defining a closed set of allowed security behaviors that are
*supposed* to be exhibited by a workload.

The use of audit2allow only generates what can be considered as
possible permitted exceptions to a security model, after the model has
failed and hopefully before people have simply turned off the
infrastructure in frustration because they needed a working system.

Unit testing of a workload under TSEM produces a closed set of high
resolution permitted behaviors generated by the normal functioning of
that workload, in other words all of the security behaviors that are
exibited when the workload is doing what it is *supposed* to do.  TSEM
operates under default deny criteria, so if workload testing is
insufficient in coverage, any unexpressed behaviors will be denied,
thus blocking or alerting on any undesired security behaviors.

I believe our team is unique in these conversations in being the only
group that has ever compiled a kernel with TSEM enabled and actually
spent time running and testing its performance with the trust
orchestrators and modeling tools we provide.  That includes unit
testing of workloads and then running the models developed from those
tests against kernels and application stacks with documented
vulnerabilities.  To determine whether the models can detect
deviations generated by an exploit of those vulnerabilities, from what
the workload is *supposed* to be doing.

If anyone is interested in building and testing TSEM and can
demonstrate that security behaviors, undesired from its training set,
can escape detection we would certainly embrace an example so we can
review why it is occurring and integrate it into our testing and
development framework.

FWIW, a final thought for those reading along at home.

TSEM is not as much an LSM as it is a generic framework for driving
mathematical models over the basis set of information provided by the
LSM hooks.

All of the above starts the conversation on deterministic models, we
can begin argueing about the relevancy of probabilistic and
inferential models at everyone's convenience.  The latter two of which
will probably drive how the industry does security for the next 45
years.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
