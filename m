Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279C2F24
	for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226475; cv=none; b=a5a+nYhpEDKQMCerKPnYgUnvrcIl2GkZ6RYFV1qIpv9q9kKjMj7qRh2zuYc1IbMqNJBcILkHIswLYAQqdgs2w+EiEhgI98TPf7uNY75y8rZWSxhg0MDYlxagSCjzJfPeAm+GMiApHdwgbU09lZGgGGAk7C8aMgo/wG/M1pZPRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226475; c=relaxed/simple;
	bh=7UAQHmqfvj7fgr86jsnB/zIVnUnl676QBnmnXy35SSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heSMDAjOSZf1kvQxHSebWaPJFsOfqjlIUaaaeSEAj2O7E+82XUqtlMJKyZmAL4J80MOGqghWxI9HnMzSbsRJg8qInUsKU7k9x35QwfwGKpodxRL7Y7Ny95i4XZlPrmat0ZES1UyTPAuSIt6BFodtjXqNcyMl0i2jbgstbIH1lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 45OAs312027545;
	Mon, 24 Jun 2024 05:54:03 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 45OAs2TB027544;
	Mon, 24 Jun 2024 05:54:02 -0500
Date: Mon, 24 Jun 2024 05:54:02 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
Message-ID: <20240624105401.GA27511@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com> <9978b326-15de-465f-b032-252899526119@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9978b326-15de-465f-b032-252899526119@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 24 Jun 2024 05:54:04 -0500 (CDT)

On Thu, Jun 20, 2024 at 11:39:43PM +0900, Tetsuo Handa wrote:

Good morning, I hope the week is starting well for everyone.

> On 2024/06/20 22:40, Timur Chernykh wrote:
> > Questions I'm interested in:
> > How does the community feel about this idea? Is it a viable concept?
> > If all is OK, what should I, as developer, do further? How much kernel
> > code outside the LSM module may be modified to keep further merge
> > acceptable? (currently not all LSM hooks meet to intercept all needed
> > data).
> > 
> > The general purpose is to make AV/EDR software development easier,
> > more convinient, and stable for Linux-based operating systems. This
> > PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> > based on MAC policy.

> I agree that security hooks for AV/EDR software are missing in
> Linux.

The issue isn't an insufficient number of security hooks, the issue is
that the detection of anomalous behavior is not being framed properly.

This is a modeling problem.  The challenge is that it is a modeling
problem over a range of potential model types, each with its own set
of advantages and disadvantages.  So the best thing that can be done
is to expose the basis set of information that the Linux development
community has indicated as relevant to the security posture of the
operating system.

That basis set is currently the LSM hooks.  Given the amount of
information that can be surfaced by these hooks, the security industry
hasn't even scratched the surface with respect to the available
detection limits.

> My experience says that customers cannot afford managing
> allowlist-based access control mechanisms (such as SELinux and
> AppArmor) and they instead choose AV/EDR software for their systems.

This issue, which may be an unpopular concept in some corners of the
this list, is true.  The market has spoken, for both technical and
political reasons, the future is going to involve host based modeling
and detection of unwanted platform or workload behaviors.

There are a myriad of technical reasons for this, the political reason
though is pretty sample, paying a vendor to be responsible for
detecting security intrusions allows companies, to at least
ostensibly, transfer the liability from themselves to another entity.

It is basically a manifestation of the long standing technology meme
of: "No one ever got fired for buying IBM".

> The LSM framework (which is using linked list for registering multiple
> LSM modules) is about to be replaced with static calls (which reduces
> overhead, at the cost of restricting at build time LSM modules which can
> be registered). Use of static calls might make it possible to insert more
> hooks into the Linux kernel because the overhead becomes negligible, but
> kernel code used by AV/EDR software cannot be built into distributor
> kernels due to support problem. Therefore, without ability to load
> unlimited number of LSM modules after boot, AV/EDR software won't be
> benefited with static calls. Such limitation will lead people to invent
> a new set of security hooks (or resort to unofficial hacks such as
> rewriting readonly data structure) rather than trying to utilize LSM
> framework.

The commentary above would thus suggest that the problem is not one of
an insufficient number of LSM hooks but rather the amount of
flexibility with respect to interpreting the existing hooks.

What we would suggest is needed is 2-fold.

First, there is not a need for more LSM's but rather an LSM that has
more flexibility with respect to the type of responses that can be
implemented for the existing hooks.  The BPF LSM is a partial step in
that direction, but there are challenges that you have previously
documented, with respect to what can be accomplished.

Secondly, we would posit that there is more interest from the security
industry in getting the information provided by the existing hooks out
of the kernel for analysis rather than implementing the classic
immediate response model of current mandatory access control systems.

We would further suggest that even casual observation of the security
industry would indicate, that like many other technology venues, it is
now completely enamored with the notion of the application of
AI/machine learning to it mission.  That is not going to happen inside
of the kernel, the question will be providing an optimized framework
for making this happen.

At the risk of being accussed of 'hijacking' a thread, we would posit
that we are addressing both issues with our TSEM implementation,
particularly in the V4 release that is right around the corner.

> I prefer getting kernel code used by AV/EDR software reviewed (and get
> their code tested by fuzzers), by allowing AV/EDR software developers
> to submit their kernel code for upstream.

We would also suggest that it is unlikely that security vendors are
going to be willing to submit much, if any, of their 'secret sauce'
for inclusion in the kernel.  Alexey Starovoitov aluded to this at his
BPF presentation at the European Security Summit.

At least on Linux, the current endpoint security agent architecture
that the industry is grappling with is a functional and security
nightmare waiting to happen.

The most positive security contributions will surround reducing the
security footprint and privilege level that the vendors need in order
to accomplish their objectives, along with increasing the simplicity
of access to the vast amount of information that is available from the
existing hooks/handlers.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
