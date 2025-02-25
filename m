Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162529CF0;
	Tue, 25 Feb 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485213; cv=none; b=qPjTkc1+jcMrhA1QnRF1vQy19O/bXe026NgXHqVOmAplYFZp+PJFu3CKCQMJedFITbPJ9lYZYVEYPUF8E7/fTFKBh9khNEWAnn+3HXTLVFhOXZdTOeBT7vl93LS+uToctVAqeMCOC+CKlRoTYrd/lzmbbEO1fCkXMpUA/1J3t4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485213; c=relaxed/simple;
	bh=Zeua9U34mpIZzVNmoPv424NWh2Wy8ELnVKvzqhinVv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i03HtnOqg69vlB4K3QIi9IBFrlXB3jWXPvHK5vTWA6IlvwvVe/CMebSUxhPmVX8rsorRIM5bkd8edj4xQALQRDdBsQQVPVsyKdw38k8y+TfAsfZv4/WiD0oatcbgv5L6mRAJBuciUIGZzeAXfwCIZYBsm7ac9UFZDzv0LE7Suh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 51PC1Gsg013755;
	Tue, 25 Feb 2025 06:01:16 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 51PC1E2h013753;
	Tue, 25 Feb 2025 06:01:14 -0600
Date: Tue, 25 Feb 2025 06:01:14 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250225120114.GA13368@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 25 Feb 2025 06:01:16 -0600 (CST)

On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:

For the record, further documentation of our replies to TSEM technical
issues.

> On Thu, Jan 16, 2025 at 11:47???PM Dr. Greg <greg@enjellic.com> wrote:
> > > > +In order to handle modeling of security events in atomic context, the
> > > > +TSEM implementation maintains caches (magazines) of structures that
> > > > +are needed to implement the modeling and export of events.  The size
> > > > +of this cache can be configured independently for each individual
> > > > +security modeling namespace that is created.  The default
> > > > +implementation is for a cache size of 32 for internally modeled
> > > > +namespaces and 128 for externally modeled namespaces.
> > > > +
> > > > +By default the root security namespace uses a cache size of 128.  This
> > > > +value can be configured by the 'tsem_cache' kernel command-line
> > > > +parameter to an alternate value.
> >
> > > I haven't looked at the implementation yet, but I don't understand
> > > both why a kmem_cache couldn't be used here as well as why this
> > > implementation detail is deemed significant enough to be mentioned
> > > in this high level design document.
> >
> > TSEM does use kmem_cache allocations for all of its relevant data
> > structures.
> >
> > The use of a kmem_cache, however, does not solve the problem for
> > security event handlers that are required to run in atomic context.
> > To address the needs of those handlers you need to serve the
> > structures out of a pre-allocated magazine that is guaranteed to not
> > require any memory allocation or sleeping locks.

> This still seems somewhat suspicious as there are a couple of GFP
> flags that allow for non-blocking allocations in all but a few cases,
> but I'll defer further discussion of that until I get to the code.  In
> my opinion, there are still enough red flags in these documentation
> reviews to keep me from investing the time in reviewing the TSEM code.

As a group, we can state quite affirmatively to the fact that we have
experience and understanding in use of memory allocation instruction
flags.  Our use of namespace specific event processing structure
caches is not driven by unfamiliarity with the use and implications of
GFP_ATOMIC.

The use of independent structure magazines, for security events
running in atomic context in a security modeling namespace, is driven
by the need to prevent security adversaries from placing pressure on
the global kernel atomic page reserves.

These namespace specific event magazines prevent an adversary from
waging a memory denial of service attack against the kernel at large.
Adversaries can only impair their own functionality in a security
modeling namespace through the use of a synthetic attack workload that
stresses the availability of atomic context memory.

Further, TSEM is formulated on the premise that software teams,
as a by product of CI/CD automation and testing, can develop precise
descriptions of the security behavior of their workloads.  One
component of that description is the cache depth needed to support
security event handlers running in atomic context.

Exceeding that cache depth would be a sentinel forensic event for a
workload.  For anyone unfamiliar with modern IT security
architectures, a very specific alert on your security dashboard that
one of the tens of thousands of workloads that are running is doing
something it shouldn't.

Adversaries really hate to be noticed.

> Regardless, I stand by my previous comment that discussion of these
> caches may be a bit more detail that is needed in this document, but
> of course that is your choice.  It's a balancing act between providing
> enough high level detail to satisfy users and reviewers, and producing
> a document that is so verbose that the time required to properly
> review it is prohibitive.

It was our understanding that the administrative guides to a security
architecture are intended to provide comprehensive information on the
use and management of the implementation.

We were attempting to be thorough in the description and rationale for
all the technical aspects of TSEM.  The discourse in
Documentation/memory-barriers.txt would seem to provide justification
for intimate detail on important operational issues in the kernel.

> > > > +The 'cache' keyword is used to specify the size of the caches used to
> > > > +hold pointers to data structures used for the internal modeling of
> > > > +security events or the export of the security event to external trust
> > > > +orchestrators.  These pre-allocated structures are used to service
> > > > +security event hooks that are called while the process is running in
> > > > +atomic context and thus cannot sleep in order to allocate memory.
> > > > +
> > > > +The argument to this keyword is a numeric value specifying the number
> > > > +of structures that are to be held in reserve for the namespace.
> > > > +
> > > > +By default the root security modeling namespace and externally modeled
> > > > +namespaces have a default value of 128 entries.  An internally modeled
> > > > +namespace has a default value of 32 entries.  The size requirements of
> > > > +these caches can be highly dependent on the characteristics of the
> > > > +modeled workload and may require tuning to the needs of the platform
> > > > +or workload.
> >
> > > Presumably TSEM provides usage statistics somewhere so admins can
> > > monitor and tune as desired?  If so, it seems like it would be a
> > > good idea to add a reference here.
> >
> > We have trended toward the Linus philosophy of reducing the need to
> > worry about properly tuning knobs.

> I agree that generally speaking the less tuning knobs to get wrong,
> the better.  However, that assumes a system that can adjust itself
> as necessary to ensure a reasonable level of operation.  If TSEM can
> not dynamically adjust itself you should consider exposing those
> tunables.

The atomic structure magazine sizes (cache depth) can be set on a per
namespace basis, including the root modeling namespace.

Our current development tree, on our GitHub site if anyone is
interested, has simplified the cache sizing by using a single default
value that is of sufficient size to boot a standard Linux (Debian)
implementation.

For subordinate modeling namespaces, experience has shown that to be
more than what is needed, but it greatly simplifies the ability to use
TSEM 'out of the box'.

We still need to update the documentation to call out this fact and
note that development teams can adjust this value downward for
subordinate workloads that require lower levels of atomic event
reserves, if there is a desire to save memory.  Or upward if a
workload generates a pathologically large corpus of security events
that run in atomic context.

One could arguably make this self-tuning by setting a low water mark
that would trigger the expansion of the depth of the event structure
caches.  Which would invariably lead to a request to have a tunable to
set that low water mark....

Not to mention an argument about the performance impacts of locking
the namespace context to prevent atomic context events from running
while the event magazines are expanded.

> paul-moore.com

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
