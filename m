Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07EE19753F;
	Tue, 27 Aug 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755971; cv=none; b=otm1aIZRDKTXwodfwZPRT05WuD7TD48CihcxGbfFOXYV7eGSE0WGgUCSRNdUSmfAg6XYL4K3VZXJpS8AWZmrPBtwxl7Bq7iPBRuA37VlwGslK9MptAAXSvb+aOEdRALt5TcwC4l7qBa/FqmTnTuYhgV94c4Ez4DymJDaEHVTWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755971; c=relaxed/simple;
	bh=BAb9f/JMOQQT7cQQjeHp1XzCusfpVObNBohFIn3JObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+DQLs0tN75OqjdFD+EfxMr+1fWttffbb7gnTMe/ZAe15uBFDdTkV75CLyi+PKxINbVV9O7cL46rDXED0NkTEhMIQQ8qwA0dZ/zAAPwxsnOT45U7CxtfFOImW6yhzxNyUU7whtzmUtEjtemm7x8mw11Ax9Ar8K8fZIOLAUycdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 47RAqGMh004847;
	Tue, 27 Aug 2024 05:52:16 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 47RAqFUh004846;
	Tue, 27 Aug 2024 05:52:15 -0500
Date: Tue, 27 Aug 2024 05:52:15 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v4 04/14] Add primary TSEM implementation file.
Message-ID: <20240827105214.GA4769@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com> <20240826103728.3378-5-greg@enjellic.com> <4403f4ce-21eb-47a1-93f1-c663a96de9bc@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4403f4ce-21eb-47a1-93f1-c663a96de9bc@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 27 Aug 2024 05:52:16 -0500 (CDT)

On Mon, Aug 26, 2024 at 08:53:31AM -0700, Casey Schaufler wrote:

Good morning Casey, I hope this note finds your day starting well.

Greetings to others on this 'last' week of summer.

> On 8/26/2024 3:37 AM, Greg Wettstein wrote:
> > The tsem.c file is the 'master' file in the TSEM implementation. It is
> > responsible for initializing the LSM and providing the implementation of the
> > security event handlers.
> > ---
> >  security/tsem/tsem.c | 2446 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 2446 insertions(+)
> >  create mode 100644 security/tsem/tsem.c
> >
> > diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> > new file mode 100644
> > index 000000000000..76d65b3e62b3
> > --- /dev/null
> > +++ b/security/tsem/tsem.c
> > @@ -0,0 +1,2446 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (C) 2024 Enjellic Systems Development, LLC
> > + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> > + *
> > + * This file is the primary implementation file for the tsem LSM.
> > + *
> > + * It implements initialization and setup functions that interpret
> > + * kernel command-line arguments and prepares TSEM for operation.
> > + *
> > + * In addition it contains all of the TSEM specific security event
> > + * handlers that are responsible for handling the LSM events that TSEM
> > + * models.
> > + *
> > + * Each TSEM event handler calls the tsem_allocate_event() function to
> > + * allocate a structure that will be used to describe the event.  The
> > + * CELL union of this structure contains various structures that are
> > + * used to hold these parameters.
> > + *
> > + * Since the event characterization parameters need to be retained for
> > + * the lifetime of the tsem_event structure that is allocated.  In the
> > + * case of internally modeled namespaces this lifespan is the lifetime
> > + * of the security modeling namespace.  In the case of externally
> > + * modeled namespaces, the lifespan is until the security event
> > + * description is exported to an external trust orchestrator.
> > + *
> > + * In order to support this model, the event description structures
> > + * are typically composed of a union over 'in' and 'out' structures.
> > + * The 'in' structures are used to hold arguments to the event handler
> > + * that may only be relevant for the duration of the call.  These
> > + * values are translated into members of the 'out' structure that
> > + * retain the values until the end of the lifetime of the tsem_event
> > + * structure.
> > + *
> > + * Each TSEM event handler is responsible for allocating a tsem_event
> > + * structure and populating the appropriate CELL structure with the
> > + * input characteristics of the event.  The dispatch_event() function
> > + * is called to handle the modeling of the event.  This function
> > + * returns the permission value that is returned as the result of the
> > + * LSM event handler.
> > + *
> > + * The dispatch_event() calls the tsem_event_init() function that is
> > + * responsible for translating the input parameters into values that
> > + * will be retained for the lifetime of the security event
> > + * description.  The populated event description is then dispatched to
> > + * either the tsem_model_event() or the tsem_export_event() for
> > + * modeling by either the internal TMA or by a TMA associated with an
> > + * external trust orchestrator.
> > + */
> > +
> > + ...
> > +
> > +static int tsem_file_open(struct file *file)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct tsem_event *ep;
> > +
> > +	if (static_branch_unlikely(&tsem_not_ready))
> > +		return 0;
> > +	if (bypass_event(TSEM_FILE_OPEN))
> > +		return 0;
> > +	if (unlikely(tsem_inode(inode)->status == TSEM_INODE_CONTROL_PLANE)) {
> > +		if (capable(CAP_MAC_ADMIN))

> Don't you mean CAP_MAC_OVERRIDE? CAP_MAC_ADMIN is for changes to the
> security state of the system, where CAP_MAC_OVERRIDE is for access
> control decision exceptions. Here (and elsewhere) you use the former
> in access checks.

You are clearly the mechanistic expert on capabilities so we would
take your lead on this.

Some background information to hopefully assist in a discussion on the
types of capability checks that should be implemented.

The capability checks we apply in TSEM gate the following five types
of actions:

1.) The ability to issue TSEM control commands.

2.) The ability to register an event processing module.

3.) Access to state information on kernel based modeling agent instances.

4.) The ability to send signals to trust orchestration processes.

5.) The ability to send a signal to a different security modeling namespace.

If we understand the differentiation that you suggest between
CAP_MAC_ADMIN and CAP_MAC_OVERRIDE we would conclude the following:

Checks 1, 2 and 4 would seem, in our opinion, have the ability to
change the security state of a system.  As such it would seem
appropriate to use CAP_MAC_ADMIN for those checks.

Rather than belabor the issue now, we can entertain a subsequent
discussion, if needed, on why we believe that actions 1, 2 and 4 can
change the security state of the system.

By your definition, check type 3 would seem to be consistent with
CAP_MAC_OVERRIDE, since it is gating access to potentially security
sensitive information but which does not imply the ability to change
the security state of the system.

That leaves category 5 as a possible open question.  Given the trust
orchestration model for externally modeled namespaces, we concluded
that the only entities that should be able to issue signals that can
manipulate, particularly terminate a process, should only come from
within the security modeling namespace that the target process is
running in.  Given that, we would consider such operations as possibly
affecting the security state of the system and thus suitable for
CAP_MAC_ADMIN.

Based on what we have always understood, and that is confirmed by 'git
grep', the only thing at this time that is using CAP_MAC_OVERRIDE is
SMACK.  If our analysis is correct, would you have any issues with us
changing the type 3 checks to CAP_MAC_OVERRIDE?

With respect to the check that you call out in
tsem.c:tsem_open_file(), the capability check is to avoid a model
deadlock situation.  If we adopt the model we discuss above, we would
need to unequivocably allow the open if the process is carrying
CAP_MAC_ADMIN or CAP_MAC_OVERRIDE in order to avoid a control
deadlock.

We will look forward to your thoughts on if we should proceed with the
above changes.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
