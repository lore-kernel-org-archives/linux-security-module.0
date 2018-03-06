From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Mar 2018 15:01:19 +0000
Subject: [PATCH 0/5 V2] tpm: timeouts revamp
In-Reply-To: <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<1520338622.3779.1.camel@linux.intel.com>
	<031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F457@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> > On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> >> This series cleans up tpm timeouts setting and handling.
> >>
> >> First motivation was to fix failures coming from too short timeouts
> >> for commands that creates keys.
> >> Key generation may take significant time depending on the underlying
> >> hardware. Rather than increasing default timeout a new constant is
> >> added, to not stall too long on regular commands failures.
> >>
> >> Second is to define timeouts for new tpm2 commands defined in TCG
> >> 1.36 spec.
> >
> 
> Probably a typo, since the latest TCG spec version is the 1.38 [0].


I have 1.36 as this is what we implement in the HW, but there might be a new one.  

> > Where can we get that specification? I don't have that new version and
> > couldn't find it from the public internet.

> 
> [0]: https://trustedcomputinggroup.org/tpm-library-specification/
> 

Yes this is the place.
Thanks
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
