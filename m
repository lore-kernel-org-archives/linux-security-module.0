Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27781EE017;
	Mon,  3 Mar 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996909; cv=none; b=MWY8jo8By8LhzYDLxTMV7/rITEoOQm7jPHVwcFh2b8gCZynih0PdTmysXWEpzueTNbAUGnUNHy0c4qrY8i1N46Q4ThRY08uUeSZthClJUa2kG5inLhLn6MZaYbkzM4BcELbSYRqYAiLj9076+AQmwihi4Gv+EAhFEvHFce2qdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996909; c=relaxed/simple;
	bh=hmx9uRMd6eYBAZLyd2siW8PPU8dUwCzthn0EugXi2Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0y4rk/OFx/aphRUkh0WSd4xd2swPv5HF8Lc5jnhMkG+jBYmnqjOEvXgik9erH37h7BQ2F8Z3OSx/7IdPEhyL4+lrEJZ2O0QdPiRodLyhM+WeMBwhC4zktMu+uXorArzna2kCBferVYy7L6SWGEf5R15X+y0UcfMPqfAkKliF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 523AEfSb021531;
	Mon, 3 Mar 2025 04:14:41 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 523AEZix021529;
	Mon, 3 Mar 2025 04:14:35 -0600
Date: Mon, 3 Mar 2025 04:14:35 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250303101435.GA21445@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com> <20250225120114.GA13368@wind.enjellic.com> <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com> <20250227121207.GA15116@wind.enjellic.com> <b60f2453-9c7a-4e69-9520-8088c09f4070@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60f2453-9c7a-4e69-9520-8088c09f4070@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 03 Mar 2025 04:14:41 -0600 (CST)

On Thu, Feb 27, 2025 at 08:47:43AM -0800, Casey Schaufler wrote:

Good morning, I hope the week is starting well for everyone.

> On 2/27/2025 4:12 AM, Dr. Greg wrote:
> > On Tue, Feb 25, 2025 at 07:48:31AM -0800, Casey Schaufler wrote:
> >
> > Good morning, I hope this note finds the week going well for everyone.
> >
> >> On 2/25/2025 4:01 AM, Dr. Greg wrote:
> >>> On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> >>>
> >>> For the record, further documentation of our replies to TSEM technical
> >>> issues.
> >>>
> >>> ...
> >>>
> >>> Further, TSEM is formulated on the premise that software teams,
> >>> as a by product of CI/CD automation and testing, can develop precise
> >>> descriptions of the security behavior of their workloads.

> >> I've said it before, and I'll say it again. This premise is
> >> hopelessly naive. If it was workable you'd be able to use SELinux
> >> and audit2allow to create perfect security, and it would have been
> >> done 15 years ago.  The whole idea that you can glean what a
> >> software system is *supposed* to do from what it *does* flies
> >> completely in the face of basic security principles.

> > You view our work as hopelessly naive because you, and perhaps
> > others, view it through a 45+ year old lens of classic
> > subject/object mandatory controls that possess only limited
> > dimensionality.

> I view your work as hopelessly naive because I've seen the basic idea
> fail spectacularly so many times. That includes things I have written,
> such as the Datastate LSM.
> 
> ... and don't play the stodgy old fart card on me. I've been working
> on making the LSM more available to new security models for years.

I'm not playing any cards, I am simply advocating that TSEM needs to
be viewed through the lens of multi-dimensional numerical modeling, a
framework that you are uncomfortable with.

To that end.

One of our project advisors, who manages a large containerized
microservices shop, has been following all of this.  He phoned me and
questioned if the problem could be that you were viewing TSEM as a
whole system solution rather than a modeling solution based on
limited scope modeling.

Just for the record, is it clear that we are working on limited scope
modeling environments?

With respect to this failing before, could you give us a literature
citation that we could review that discusses the failure of previous
systems that were using generative functions to uniquely label each
security event based on the cryptographic identity of the executable
code that is generating the event?

To support further discussion, it would be helpful if you could
document the spectacular failure mode you would anticipate in the
framework of classical security discussion.

TSEM, like other security architectures, has basically two failure
modes:

1.) False positives.

2.) False negatives.

3.) Implementation complexity failures.

False negatives are arguably the most dangerous.  Something was
allowed to occur that should not have been allowed to occur.

When a workload is trained, either a security coefficient for a
security behavior is generated or it is not.  Thus, when the model is
enforced, generated coefficients either exist or do not exist in the
outcome set.

If the coefficient does not exist, there is a chance that this is a
false positive due to insufficient training coverage.  The correction
is the same as in other architectures, fold the false positive back
into the training set.  Until that happens the behavior is constrained
from occurring.

By definition there are no false negatives, ie. an event that did
occur but should not have occured, since the only coefficients in the
training sets are those that are consistent with the training
behavior.

Implementation complexity focuses on the ability of the technology to
either be deployed at all, or more importantly, deployed properly due
to lack of industry skills or infrastructure support.

We would look forward to elaborations on the specific failure modes
that would occur.

> > We view it through a lens of 10+ years of developing new multi-scale
> > methods for modeling alpha2-adrenergic receptor antagonists... :-)

> Which is relevant how?

In industry it is referred to as the application of tanslational
technologies.  The notion that advances beyond current practice in a
field can achieved by the novel application of methods from other
technology disciplines.

See my 2017 invited presentation at the NSA's High Confidence Software
Systems conference.

Also, see the impact of the application of Singular Value
Decomposition on machine learning and classification.

> > We don't offer this observation just in jest.  If people don't
> > understand what we mean by this, they should consider the impact that
> > Singular Value Decomposition methods had when they were brought over
> > from engineering and applied to machine learning and classification.
> >
> > A quote from John von Neumann, circa 1949, would seem appropriate:
> >
> > "It would appear that we have reached the limits of what is
> >  possible to achieve with computer technology, although one should be
> >  careful with such statements, as they tend to sound pretty silly in 5
> >  years."

> New good ideas can shatter old conceptions. Old bad ideas with a
> fresh coat of paint and impressive new terminology fail to impress.

Once again, as we noted above, if you could, please forward to the
list citations that specifically reference failure modes of numerical
modeling of security events to assist further discussion.

> > If anyone spends time understanding the generative functions that we
> > are using, particularly the task identity model, they will find that
> > the coefficients that define the permitted behaviors have far more
> > specificity, with respect to classifying what a system is *supposed*
> > to do, than the two, possibly three dimensions of classic
> > subject/object controls.

> Squirrels are funny rodents. If you model their behavior you will
> declare that they are herbivores. In California (where many strange
> and wonderful things happen) squirrels have begun to eat voles, a
> very carnivorous behavior. If you believe in modeling as a way to
> identify correct behavior, you have to say that these furry
> creatures that eat voles are not squirrels.  If, on the other hand,
> you look at the environment they live in you can see that the loss
> of native habitat has reduced the available fat calories to the
> point where survival requires changed behavior. They're still
> squirrels, and no amount of modeling is going to change that.

Personally, I never thought it would come down to this but here you
go:

I have a pet squirrel named Rocky that I have owned since it was a pup
and its mother was killed crossing Douglas County Road 7 in front of
our house.  He lives in a small kennel in our house.

Every day I take Rocky outside and open the door to his kennel.  Rocky
runs around the yard twice and then up an oak tree and loads his
cheeks with acorns.  He comes back to his kennel, eats his acorns and
falls asleep until the next day.

One night Jay Evil sneaks into the house, abducts Rocky and replaces
him with his evil squirrel Rabid, who looks exactly like Rocky but
fell out of a tree on his head when he missed a jump from one branch
to another and hasn't been right since.

As usual, the next day I take what I think is Rocky out into the front
yard and open the kennel door.  The faux Rocky runs out into the yard,
chases down, attacks, kills and begins to eat our German Shepherd
Max.

Conclusion, this squirrel's behavior is suspicious and should be
remediated.

TSEM, as a high granularity modeling architecture, would interrupt the
process when the squirrel began to chase Max.

> > More specifically to the issues you raise.
> >
> > Your SeLinux/audit2allow analogy is flawed and isn't a relevant
> > comparison to what we are implementing.  audit2allow is incapable of
> > defining a closed set of allowed security behaviors that are
> > *supposed* to be exhibited by a workload.
> >
> > The use of audit2allow only generates what can be considered as
> > possible permitted exceptions to a security model, after the model has
> > failed and hopefully before people have simply turned off the
> > infrastructure in frustration because they needed a working system.

> It's a poor workman who blames his tools. Why haven't audit and
> audit2allow been enhanced to provide the information necessary to
> create your analysis?  I suggest that it's because the value has
> been recognized as unimportant.

You suggest or you have proof?

Once again, audit2allow is a tool for folding false positives back
into a security model.  Mathematically, it is designed to provide the
row and column definition of a false positive security violation in an
access vector matrix.

TSEM creates a high precision bounded training set of known good
security behaviors from a high dimensionality basis set.  This
training set is used to constrain subsequent executions of the
workload on which it was trained.

audit2allow was a tool that was implemented to compensate for
complexity induced limitations of SeLinux.

TSEM is designed to eliminate the need for such a tool.

> > Unit testing of a workload under TSEM produces a closed set of
> > high resolution permitted behaviors generated by the normal
> > functioning of that workload, in other words all of the security
> > behaviors that are exibited when the workload is doing what it is
> > *supposed* to do.  TSEM operates under default deny criteria, so
> > if workload testing is insufficient in coverage, any unexpressed
> > behaviors will be denied, thus blocking or alerting on any
> > undesired security behaviors.

> And how is that different from running SELinux in permissive mode?

SeLinux in permissive mode operates after the fact to correct a model
that was incorrect in its design.

TSEM is designed to produce a high precision definition of what a
workload should do.  High precision definitions are less prone to
false positives that have historically proven to be the reason that
security controls are disabled and thus rendered ineffective, despite
their technical superiority.

> > I believe our team is unique in these conversations in being the only
> > group that has ever compiled a kernel with TSEM enabled and actually
> > spent time running and testing its performance with the trust
> > orchestrators and modeling tools we provide.  That includes unit
> > testing of workloads and then running the models developed from those
> > tests against kernels and application stacks with documented
> > vulnerabilities.  To determine whether the models can detect
> > deviations generated by an exploit of those vulnerabilities, from what
> > the workload is *supposed* to be doing.
> >
> > If anyone is interested in building and testing TSEM and can
> > demonstrate that security behaviors, undesired from its training set,
> > can escape detection we would certainly embrace an example so we can
> > review why it is occurring and integrate it into our testing and
> > development framework.

> Sigh. You keep coming back to a train of logic that is based on a
> flawed assumption. If you accept that observed behavior describes
> intended behavior the arguments that follow may be convincing. I,
> for one, do not accept that assumption.

As I noted above, you operate from a mindset of classic subject/object
mandatory access controls rather than from the notion of numerically
modeled security behavior.

Future students of technology will note that Linux moved through three
phases of security architecture development:

Subject/object based mandatory access controls.

Pathname based controls.

Model based controls.

TSEM is the the first major implementation of the latter type of
control for the Linux kernel.  We accept resistance to the appearance
of these types of controls, the same thing happened with pathname
based controls.  The resistance doesn't mean the technology is
invalid.

The technology industry is moving towards model based security
controls, for a variety of reasons, too numerous to be litigated in
this context, so lets consider just one.

Without question, SeLinux is world class security technology.
However, by virtue statements of individuals like Kyle Moffett, it is
designed, by experts, to be implemented, by experts.  That model is
inconsistent with the world we find ourselves in, both from a
personnel and a technology context.

Companies that can run well tuned SeLinux implementations, for free,
turn it off and instead install security solutions, based on behavior
observation and modeling, that they have to pay significant amounts of
money for.

TSEM is designed to provide better and more trouble free access to the
data needed to drive model based workload controls.  Nothing we do
constrains the ability of anyone to implement an alternate security
model of their choosing.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
