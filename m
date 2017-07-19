From: bfields@fieldses.org (Bruce Fields)
Date: Wed, 19 Jul 2017 17:23:53 -0400
Subject: [PATCH v2] integrity: track mtime in addition to i_version for
	assessment
In-Reply-To: <1499882210.3426.47.camel@linux.vnet.ibm.com>
References: <1499446642.4967.3.camel@poochiereds.net>
	<1499448249.3130.143.camel@linux.vnet.ibm.com>
	<1499449777.4852.3.camel@redhat.com>
	<1499457558.3130.173.camel@linux.vnet.ibm.com>
	<1499459718.4852.8.camel@redhat.com>
	<1499688612.6034.111.camel@linux.vnet.ibm.com>
	<1499822252.26839.5.camel@redhat.com>
	<1499862021.3904.23.camel@linux.vnet.ibm.com>
	<20170712143504.GB31196@fieldses.org>
	<1499882210.3426.47.camel@linux.vnet.ibm.com>
Message-ID: <20170719212353.GB5449@fieldses.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 12, 2017 at 01:56:50PM -0400, Mimi Zohar wrote:
> On Wed, 2017-07-12 at 10:35 -0400, Bruce Fields wrote:
> > On Wed, Jul 12, 2017 at 08:20:21AM -0400, Mimi Zohar wrote:
> > > Right, currently the only way of knowing is by looking at the IMA
> > > measurement list to see if modified files are re-measured or, as you
> > > said, by looking at the code.
> > 
> > Who's actually using this, and do they do any kind of checks, or
> > document the filesystem-specific limitations?
> 
> Knowing who is using it and how it is being used is the big question.
> ?I only hear about it when there are problems.
> 
> Over the years, there have been a number of Linux Security Summit
> (LSS) talks, which have been mostly about embedded systems or locked
> down systems, not so much for generic systems.
> 
> Examples include:

Thanks, I skimmed a couple.  Hard to tell, but it sounds like they need
this to work.  I wonder if they're getting this right.  It'd be easy
enough to test for.

--b.

> 
> - Design and Implementation of a Security Architecture for Critical
> Infrastructure Industrial Control Systems - David Safford, GE 2016
> 
> - IMA/EVM: Real Applications for Embedded Networking Systems - Petko
> Manolov, Konsulko Group, and Mark Baushke, Juniper Networks 2015
> 
> -?CC3: An Identity Attested Linux Security Supervisor Architecture
> ?-?Greg Wettstein, IDfusion 2015
> 
> - The Linux Integrity Subsystem and TPM-based Network Endpoint
> Assessment -?Andreas Steffen, HSR University of Applied Sciences
> Rapperswil, Switzerland 2012
> 
> Mimi
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
