From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Mar 2018 15:05:44 +0000
Subject: [PATCH 0/5 V2] tpm: timeouts revamp
In-Reply-To: <20180306140256.GC5700@linux.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<1520338622.3779.1.camel@linux.intel.com>
	<031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
	<20180306140256.GC5700@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F491@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

 
> On Tue, Mar 06, 2018 at 01:39:49PM +0100, Javier Martinez Canillas wrote:
> > On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> > > On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> > >> This series cleans up tpm timeouts setting and handling.
> > >>
> > >> First motivation was to fix failures coming from too short timeouts
> > >> for commands that creates keys.
> > >> Key generation may take significant time depending on the
> > >> underlying hardware. Rather than increasing default timeout a new
> > >> constant is added, to not stall too long on regular commands failures.
> > >>
> > >> Second is to define timeouts for new tpm2 commands defined in TCG
> > >> 1.36 spec.
> > >
> >
> > Probably a typo, since the latest TCG spec version is the 1.38 [0].
> >
> > > Where can we get that specification? I don't have that new version
> > > and couldn't find it from the public internet.
> > >
> > > /Jarkko
> > >
> >
> > [0]: https://trustedcomputinggroup.org/tpm-library-specification/
> 
> I already have that version of the specifications but I thought that we were
> speaking about PC Client Platform spefication, which is at version 1.30. TCG
> spec is an ambiguous term so that is where the confusion started from.
> 
TCG spec doesn't define timeouts just new commands 

> The only spec I've seen some timeouts is the PC Client Specification but I
> guess I've then missed the list in TPM 2.0 spefication. Where are they listed?
> I worked with Will Arthur durations based on PC Client Specification when
> TPM 2.0 support was first implemented.


That's correct, this  PTP spec. It defines the timeouts for the commands, this is stated in the patch comments.

Need to cross reference these two specs. 

Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
