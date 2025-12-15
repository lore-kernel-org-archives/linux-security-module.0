Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776A2EA147
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775829; cv=none; b=WQD43k+AykOyOC2MgF8wGZQ99ITVluiiihEYsb209FUtZnL+L6JewrNSCa5ByrUqlQjQQ3cPivNL4o19SZRRWtpixeGhb7FeIcbHjLQRrQp5/agpqVdx7QvmJVDvY0AbWuZI+Bc/3L88gh/JEWgwK/fBCZ167gO2r1ezxpWJkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775829; c=relaxed/simple;
	bh=TZKMVucUQyx6CHavgKLMbibM+8YU37sQuQhZTMEd+sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkGeSdXkLK7Hm4QBkQyL+WX9CIjSoSHKXue/bH/68UPuIn8F16T3oaQd2uwi13XqFoyHx4/R/wpvWB0UKM1vK/yueA0Rr788cuVUpUyxJyDehtKVIsVc2Z8N7XFnSRn3mR21etkHscR71gWCKXGSu6HYCNYl/vvU3XxAkBnj4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5BF4tQMw006205;
	Sun, 14 Dec 2025 22:55:26 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5BF4tOo3006203;
	Sun, 14 Dec 2025 22:55:24 -0600
Date: Sun, 14 Dec 2025 22:55:24 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: An opinion about Linux security
Message-ID: <20251215045524.GA6104@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com> <20251212054524.GA23417@wind.enjellic.com> <950ac630-c75e-4d4c-ac70-5e4b0e397989@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950ac630-c75e-4d4c-ac70-5e4b0e397989@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 14 Dec 2025 22:55:27 -0600 (CST)

On Fri, Dec 12, 2025 at 03:43:07PM -0800, Casey Schaufler wrote:

Good morning Casey, pleasant as always to hear from you.

> On 12/11/2025 9:45 PM, Dr. Greg wrote:
> > On Wed, Dec 10, 2025 at 03:15:39AM +0300, Timur Chernykh wrote:
> >
> > Good morning Timur, I hope this note finds your week having gone well.
> >
> >> Hello Linus,
> >>
> >> I'm writing to ask for your opinion. What do you think about Linux's
> >> current readiness for security-focused commercial products?  I'm
> >> particularly interested in several areas.
> > I don't expect you will receive an answer.
> >
> > Based on his previous comments and long standing position on this
> > issue, I believe it can be fairly stated that he looks at the LSM as
> > an unnecessary evil.
> >
> > So in his absence, some 'in loco parentis' reflections on the issues
> > you raise.
> >
> > I've been advised, more than once, that in this day and age, no one is
> > interested in reading more than a two sentence paragraph, so a short
> > response to your issues here and a bit more detail for anyone who
> > wants to read more, at the end.
> >
> > There is active art available to address the shortcomings you outline
> > in your post below.  Our TSEM LSM was designed to service the
> > realitities of the modern security environment and where it is going.
> > In a manner that doesn't provide any restrictions on how 'security'
> > can be implemented.
> >
> > We've done four releases over three years and we believe an unbiased
> > observer would conclude they have received no substantive technical
> > review that would support interest in upstream integration.

> Stop. Really, I mean it. I put significant effort into trying to teach
> you how to submit a patch set that could be reviewed. You ignored it.
> I can't speak to what an "unbiased observer" would conclude because
> your behavior has certainly left me with bias. Rather than writing
> full length novels about why you submitted patches the way you've
> done it you might consider heeding the advice. Grrr.

No, we are not going to stop, see immediately below.

> > The challenge is that the security gatekeepers view LSM submissions
> > through a lens of whether or not the LSM implements security
> > consistent with what they believe is security.
> 
> While there is some truth to that, we're really quite flexible.
> What we need to see is that there is some sort of security model,
> and that the proposed code implements it. We also need to be able
> to examine the proposed code to see that it implements the model.
> You have rejected all suggestions about how to make your proposal
> reviewable.

No we didn't.

I've managed engineers before, I've never found a successful strategy
to be:

"Go off and do what I told you to do".

Without some kind of explanation and dialogue.

The Linux community has a process problem with the LSM and the
security sub-system that needs to be addressed.  Personally, I now
have the cycles to address it.

We assume that if Timur elects to port the Apple security API (Timur's
ESF implementation) into the kernel, he will face the same issue that
concerns us.

When Paul Moore came on-board three years ago as the security
maintainer, he was immediately VERY prescriptive with respect to
establishing policies and guidelines that he wanted followed for LSM
submissions.

We see that he sent those guidelines to Timur in case he was
interested in submitting ESF as a new LSM.  Here is the link for those
who haven't seen it.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsms

What those guidelines are missing are prescriptive practices for
bringing a major body of virgin code into the security review process.
As we did with TSEM, and presumably Timur will have to do with ESF, if
he moves forward with that initiative.

For the benefit of those following this conversation and to close the
record in this thread from our perspective, as tedious as that might
be.

From an architectural perspective, TSEM consists of a series of
compilation units, each dedicated to a specific functional role needed
to support the LSM.  We used a single include file that holds all of
the enumerations and structure definitions that are referenced by
every compilation unit.

We chose a submssion model of introducing this include file as a
single patch in the series, after a complete sub-system documentation
patch.  Introduction of virgin sub-systems isn't really common but this
strategy was consistent with what we had previously observed.

In addition, we believe that Knuth was quoted at one time about an
understanding of a program flows from an understanding of its data
structures.

You reviewed about half of one compilation unit and said you didn't
have time for anymore.  For the record, we made the changes that you
requested and responded to your other concerns for that unit.

Your primary issue, which you have repeated often, as you did here,
was with the fact that we had a single header file in the patch series
with all of the LSM global definitions.  You indicated that the patch
series should be broken up in order to 'tell a story' by including the
structure and enumeration definitions with the code.

Fair enough, you are a valued voice in the Linux security community,
but your right pinky finger is not on the RETURN key that sends
security sub-system pull requests to Linus, Paul Moore's is.

If anyone chooses to review the new LSM guidelines, they will note
that it never makes mention of the fact that a patch series should
'tell a story' and/or how that should be done.

So, before we committed a ton of development time into what could very
well end up being a tag team match to try and please two maintainers,
we reached out to Paul for advice on how he would like to see a virgin
patch series structured.

His response was that TSEM had significant issues, the least of which
was the organization of the patch series.  We repeatedly asked him to
detail what those problems were, as by his own admission he had only
read the documentation and not offered any review comments on the code
itself.

The only thing we received was that, in certain security behavior
modeling configurations enabled by TSEM, the security response would
be asynchronous from the event or events that triggered it.

We attempted to pursue further dialogue surrounding this.  The last
response, at least a year ago now, was that he didn't think he needed
to respond to us because of our 'tone'.  If anyone hasn't noticed, our
'tone' is driven by the fact that we tend to not be easily bul*ted.

So, in the interest of furthering Linux security development while at
the same time promoting homeostatic harmony in the community, we will
be sending out a request to the security list to formally address this
issue with new LSM's.

It obviously doesn't make sense to waste your or other people's time
addressing the other issues you have below, other than to agree that
we disagree on where security is headed and how Linux needs to
respond.

> >   Those views are
> > inconsistent with the realities of the modern security market,
> 
> Oh, stop it. Look at how many LSMs have been added over the past
> few years. Sandboxing and application controlled security are
> "modern" security concepts that were unheard of when the LSM was
> introduced. As I said before, security is a dynamic technology.
> If it were not, we'd have a Bell & LaPadula kernel config option
> instead of an LSM infrastructure.
> 
> >  a
> > market that that is now predicated on detection rather than
> > enforcement.  A trend that will only accelerate with advancements in
> > machine learning and AI.
> 
> Without the underlying access controls detection is rather pointless.
> 
> > It is worth noting that the history of the technology industry is
> > littered with examples of technology incumbents usually missing
> > disruptive innovation.
> 
> The technology industry is not unique on this. Acme Buggy Whips, inc.
> 
> > This restriction on suitability is actually inconsistent with Linus'
> > stated position on how Linux sub-systems can be used, as expressed in
> > his comment in the following post.
> >
> > https://lore.kernel.org/lkml/CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com/
> >
> > So the problem is not technical, it is a political eco-system problem.
> >
> > So, big picture, that is the challenge facing resolution of your
> > concerns.
> >
> > Apologies to everyone about the paragraph/sentence overflow and any
> > afront to sensibilities.
> >
> > More detail below if anyone is interested.
> >
> >> First, in today's 3rd-party (out-of-tree) EDR development EDR
> >> being the most common commercial class of security products eBPF
> >> has effectively become the main option. Yet eBPF is extremely
> >> restrictive.  It is not possible to write fully expressive real-time
> >> analysis code: the verifier is overly strict, non-deterministic
> >> loops are not allowed, and older kernels lack BTF support. These
> >> issues create real limitations.
> >>
> >> Second, the removal of the out-of-tree LSM API in the 4.x kernel
> >> series caused significant problems for many AV/EDR vendors. I was
> >> unable to find an explanation in the mailing lists that convincingly
> >> justified that decision.
> >>
> >> The next closest mechanism, fanotify, was a genuine improvement.
> >> However, it does not allow an AV/EDR vendor to protect the integrity
> >> of its own product. Is Linux truly expecting modern AV/EDR solutions
> >> to rely on fanotify alone?
> >>
> >> My main question is: what are the future plans? Linux provides very
> >> few APIs for security and dynamic analysis. eBPF is still immature,
> >> fanotify is insufficient, and driver workarounds that bypass kernel
> >> restrictions are risky they introduce both stability and security
> >> problems. At the same time, properly implemented in-tree LSMs are not
> >> inherently dangerous and remain the safer, supported path for
> >> extending security functionality. Without safe, supported interfaces,
> >> however, commercial products struggle to be competitive. At the
> >> moment, macOS with its Endpoint Security Framework is significantly
> >> ahead.
> >>
> >> Yes, the kernel includes multiple in-tree LSM modules, but in
> >> practice SELinux does not simplify operations it often complicates
> >> them, despite its long-standing presence. Many of the other LSMs are
> >> rarely used in production. As an EDR developer, I seldom encounter
> >> them, and when I do, they usually provide little practical
> >> value. Across numerous real-world server intrusions, none of these
> >> LSM modules have meaningfully prevented attacks, despite many years
> >> of kernel development.
> >>
> >> Perhaps it is time for Linux to focus on more than a theoretical model
> >> of security.
> > The heart of the political eco-system challenge is best expressed by a
> > quote from Kyle Moffett, in which he stated that security should only
> > be developed and implemented by experts.  Unfortunately that view is
> > inconsistent with the current state of the technology industry.
> 
> Glad to hear I'm not an expert! - Not!
> 
> > Classical security practititioners will defend complex subject/object
> > architectures with: "Google uses SeLinux for Android security".
> 
> Yea gads. Subject/Object is about as simple as it gets. Look at Smack.
> 
> > Our response to that is that the world doesn't have a security problem
> > because Google lacks sufficient resources to implement anything it
> > desires to implement, regardless of the development and maintenance
> > input costs.
> >
> > Unfortunately, that luxury is inconsistent with the rest of the
> > software development world that doesn't enjoy a 3.8 trillion dollar
> > market capitalization.
> >
> > The world simply lacks enough experts to make the 'security only by
> > experts' model work.
> >
> > Today, the fastest way to a product is to grab Linux and a development
> > team and write software for hardware that is now completely
> > commoditized.  Everyone knows that security is not one of the
> > fundamental project predicates in this model.
> >
> > Both NIST and DHS/CISA are officially on record as indicating that
> > security needs to start with and be baked in through the development
> > process.  One of the objectives of TSEM was to provide a framework for
> > enabling this concept for the implementation of analysis and mandatory
> > behavior controls for software workloads.
> >
> > A second fundamental problem is that the world has moved, in large
> > part, to containerized execution workloads.  The Linux LSM, in its
> > current form, doesn't effectively support the application of workload
> > specific security policies.
> >
> > Further complicating this issue is the fact that LSM 'stacking'
> > requires reasoning as to what a final security policy will be when
> > multiple different security architectures/policies get to decide on
> > the outcome of a security event/hook.  The concept of least surprise
> > would suggest the need for stacking to have idempotency, in other
> > words, the order in which LSM event consumers are called shouldn't
> > influence the effective policy, but this is generally acknowledged as
> > not being the case with 'stacking'.
> 
> Any other approach, and they have been considered, fails miserably
> and introduces a host of complications. Not to mention performance
> de-optimization.
> 
> > So we designed TSEM to provide an alternative, not a replacement, but
> > an alternative to how developers and system administrators can develop
> > and apply security policy, including integrity controls.
> >
> > TSEM is an LSM that implements containerized security infrastructure
> > rather than security policy.  It is designed around the concept of a
> > security orchestrator that can execute security isolated workloads and
> > receive the LSM events and their parameters from that workload and
> > process them in any manner it wishes.
> 
> I shan't repeat the objections that have been raised, but I will
> point out that you have done nothing to address them.
> 
> > For example: A Docker/Kubernetes container can be run and all of the
> > security events by that workload exported up into an OpenSearch or
> > ElasticSearch instance for anomaly detection and analysis.
> >
> > So an EDR implemented on top of this has visibility into all of the
> > security events and their characteristics that are deemed security
> > relevant by the kernel developers.
> >
> > One of the pushbacks is that this can lead to asynchronous security
> > decisions, but as you note, that is the model that the commercial
> > security industry and the consumers of its products has embraced,
> > particularly in light of the advancements coming out of the AI
> > industry, detection rather than enforcement.
> >
> > If synchronous enforcement is required TSEM provides that as well,
> > including the use of standard kernel modules to implement analysis and
> > response to the LSM hooks.  Internally we have implemented other LSM's
> > such as Tomoyo and IMA as loadable modules that can support multiple
> > and independent workload policies.
> >
> > If you or other EDR vendors are interested, we would be more than
> > happy to engage in conversations as to how to improve the capabilities
> > of this type of architecture, as an alternative to what is currently
> > available in Linux, which as you note, has significant limitations.
> >
> >> Everything above reflects only my personal opinion. I would greatly
> >> appreciate your response and any criticism you may have.
> > As I mentioned at the outset, you are unlikely to hear anything.
> >
> > For the necessary Linux infrastructure improvements to emerge we
> > believe there is the need to develop and engage a community effort
> > that independently pursues the advancements that are necessary,
> > particularly those that enable Linux to implement first class AI based
> > security controls.
> >
> > We believe that only this will result in sufficient 'market pull' at the
> > distribution level to help shape upstreaming decisions.
> >
> > Absent that, it is likely that Linux will continue to implement what
> > has failed to work in the past in the hope that it will somehow work
> > in the future.
> 
> Wow. calling Linux a failure is a bit of a stretch, don't you think?
> 
> > Comments and criticism welcome, we have had plenty of experience with
> > the latter.... :-)
> 
> We've been over these issues many times. Go back and make some changes to
> your approach.
> 
> >> Best regards,
> >> Timur Chernykh
> > Best wishes for the success of your work and a pleasant holiday season.
> >
> > As always,
> > Dr. Greg
> >
> > The Quixote Project - Flailing at the Travails of Cybersecurity
> >               https://github.com/Quixote-Project
> >

Best wishes for a productive week and a pleasant holiday season.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
