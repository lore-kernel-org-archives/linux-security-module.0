Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485826ED4C
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765520706; cv=none; b=s4YtlmXQ2BsMT+/h+ijksg2ReAPhwj3wpoRS+9l4fsJ1lrbwktCz17ANSLSpHLhxYefrXsQbxnbKkZThQTMbcUY7Y2qX4neWAF5K0zeaDC6gyYWLQjCW+IPYXW1K0cSVydRj3kg0Y+Rw6WaFT46D1vv2ehTCEr1OmJFF1reKEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765520706; c=relaxed/simple;
	bh=5AxPazC873bvSn7Uh36mc/yi7gByud9tAvw8VptLBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3e1OUtMHi68wdZejGerWqL/ZFvpo45Yvg9VYcm2vKgrqZeiq+OK3Ud63M+Os0pBdkMOgT5UjumXhdxqncr7CnzbCRh+Wu+QMJKTBXXwUfdn5twBuohh8zkeR6t9Fp+IScAbQWfFAHAofxP6isjOVVpGfCtTicM7tem2hgpeCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5BC5jR24023436;
	Thu, 11 Dec 2025 23:45:28 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5BC5jOKI023435;
	Thu, 11 Dec 2025 23:45:24 -0600
Date: Thu, 11 Dec 2025 23:45:24 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org
Subject: Re: An opinion about Linux security
Message-ID: <20251212054524.GA23417@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 11 Dec 2025 23:45:28 -0600 (CST)

On Wed, Dec 10, 2025 at 03:15:39AM +0300, Timur Chernykh wrote:

Good morning Timur, I hope this note finds your week having gone well.

> Hello Linus,
>
> I'm writing to ask for your opinion. What do you think about Linux's
> current readiness for security-focused commercial products?  I'm
> particularly interested in several areas.

I don't expect you will receive an answer.

Based on his previous comments and long standing position on this
issue, I believe it can be fairly stated that he looks at the LSM as
an unnecessary evil.

So in his absence, some 'in loco parentis' reflections on the issues
you raise.

I've been advised, more than once, that in this day and age, no one is
interested in reading more than a two sentence paragraph, so a short
response to your issues here and a bit more detail for anyone who
wants to read more, at the end.

There is active art available to address the shortcomings you outline
in your post below.  Our TSEM LSM was designed to service the
realitities of the modern security environment and where it is going.
In a manner that doesn't provide any restrictions on how 'security'
can be implemented.

We've done four releases over three years and we believe an unbiased
observer would conclude they have received no substantive technical
review that would support interest in upstream integration.

The challenge is that the security gatekeepers view LSM submissions
through a lens of whether or not the LSM implements security
consistent with what they believe is security.  Those views are
inconsistent with the realities of the modern security market, a
market that that is now predicated on detection rather than
enforcement.  A trend that will only accelerate with advancements in
machine learning and AI.

It is worth noting that the history of the technology industry is
littered with examples of technology incumbents usually missing
disruptive innovation.

This restriction on suitability is actually inconsistent with Linus'
stated position on how Linux sub-systems can be used, as expressed in
his comment in the following post.

https://lore.kernel.org/lkml/CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com/

So the problem is not technical, it is a political eco-system problem.

So, big picture, that is the challenge facing resolution of your
concerns.

Apologies to everyone about the paragraph/sentence overflow and any
afront to sensibilities.

More detail below if anyone is interested.

> First, in today's 3rd-party (out-of-tree) EDR development EDR
> being the most common commercial class of security products eBPF
> has effectively become the main option. Yet eBPF is extremely
> restrictive.  It is not possible to write fully expressive real-time
> analysis code: the verifier is overly strict, non-deterministic
> loops are not allowed, and older kernels lack BTF support. These
> issues create real limitations.
>
> Second, the removal of the out-of-tree LSM API in the 4.x kernel
> series caused significant problems for many AV/EDR vendors. I was
> unable to find an explanation in the mailing lists that convincingly
> justified that decision.
> 
> The next closest mechanism, fanotify, was a genuine improvement.
> However, it does not allow an AV/EDR vendor to protect the integrity
> of its own product. Is Linux truly expecting modern AV/EDR solutions
> to rely on fanotify alone?
> 
> My main question is: what are the future plans? Linux provides very
> few APIs for security and dynamic analysis. eBPF is still immature,
> fanotify is insufficient, and driver workarounds that bypass kernel
> restrictions are risky they introduce both stability and security
> problems. At the same time, properly implemented in-tree LSMs are not
> inherently dangerous and remain the safer, supported path for
> extending security functionality. Without safe, supported interfaces,
> however, commercial products struggle to be competitive. At the
> moment, macOS with its Endpoint Security Framework is significantly
> ahead.
>
> Yes, the kernel includes multiple in-tree LSM modules, but in
> practice SELinux does not simplify operations it often complicates
> them, despite its long-standing presence. Many of the other LSMs are
> rarely used in production. As an EDR developer, I seldom encounter
> them, and when I do, they usually provide little practical
> value. Across numerous real-world server intrusions, none of these
> LSM modules have meaningfully prevented attacks, despite many years
> of kernel development.
>
> Perhaps it is time for Linux to focus on more than a theoretical model
> of security.

The heart of the political eco-system challenge is best expressed by a
quote from Kyle Moffett, in which he stated that security should only
be developed and implemented by experts.  Unfortunately that view is
inconsistent with the current state of the technology industry.

Classical security practititioners will defend complex subject/object
architectures with: "Google uses SeLinux for Android security".

Our response to that is that the world doesn't have a security problem
because Google lacks sufficient resources to implement anything it
desires to implement, regardless of the development and maintenance
input costs.

Unfortunately, that luxury is inconsistent with the rest of the
software development world that doesn't enjoy a 3.8 trillion dollar
market capitalization.

The world simply lacks enough experts to make the 'security only by
experts' model work.

Today, the fastest way to a product is to grab Linux and a development
team and write software for hardware that is now completely
commoditized.  Everyone knows that security is not one of the
fundamental project predicates in this model.

Both NIST and DHS/CISA are officially on record as indicating that
security needs to start with and be baked in through the development
process.  One of the objectives of TSEM was to provide a framework for
enabling this concept for the implementation of analysis and mandatory
behavior controls for software workloads.

A second fundamental problem is that the world has moved, in large
part, to containerized execution workloads.  The Linux LSM, in its
current form, doesn't effectively support the application of workload
specific security policies.

Further complicating this issue is the fact that LSM 'stacking'
requires reasoning as to what a final security policy will be when
multiple different security architectures/policies get to decide on
the outcome of a security event/hook.  The concept of least surprise
would suggest the need for stacking to have idempotency, in other
words, the order in which LSM event consumers are called shouldn't
influence the effective policy, but this is generally acknowledged as
not being the case with 'stacking'.

So we designed TSEM to provide an alternative, not a replacement, but
an alternative to how developers and system administrators can develop
and apply security policy, including integrity controls.

TSEM is an LSM that implements containerized security infrastructure
rather than security policy.  It is designed around the concept of a
security orchestrator that can execute security isolated workloads and
receive the LSM events and their parameters from that workload and
process them in any manner it wishes.

For example: A Docker/Kubernetes container can be run and all of the
security events by that workload exported up into an OpenSearch or
ElasticSearch instance for anomaly detection and analysis.

So an EDR implemented on top of this has visibility into all of the
security events and their characteristics that are deemed security
relevant by the kernel developers.

One of the pushbacks is that this can lead to asynchronous security
decisions, but as you note, that is the model that the commercial
security industry and the consumers of its products has embraced,
particularly in light of the advancements coming out of the AI
industry, detection rather than enforcement.

If synchronous enforcement is required TSEM provides that as well,
including the use of standard kernel modules to implement analysis and
response to the LSM hooks.  Internally we have implemented other LSM's
such as Tomoyo and IMA as loadable modules that can support multiple
and independent workload policies.

If you or other EDR vendors are interested, we would be more than
happy to engage in conversations as to how to improve the capabilities
of this type of architecture, as an alternative to what is currently
available in Linux, which as you note, has significant limitations.

> Everything above reflects only my personal opinion. I would greatly
> appreciate your response and any criticism you may have.

As I mentioned at the outset, you are unlikely to hear anything.

For the necessary Linux infrastructure improvements to emerge we
believe there is the need to develop and engage a community effort
that independently pursues the advancements that are necessary,
particularly those that enable Linux to implement first class AI based
security controls.

We believe that only this will result in sufficient 'market pull' at the
distribution level to help shape upstreaming decisions.

Absent that, it is likely that Linux will continue to implement what
has failed to work in the past in the hope that it will somehow work
in the future.

Comments and criticism welcome, we have had plenty of experience with
the latter.... :-)

> Best regards,
> Timur Chernykh

Best wishes for the success of your work and a pleasant holiday season.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
