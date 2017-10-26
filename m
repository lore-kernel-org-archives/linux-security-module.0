From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 13:01:15 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171025202221.gkgch7rjjqoblzpf@rhwork>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<20171025202221.gkgch7rjjqoblzpf@rhwork>
Message-ID: <20171026110115.lyubl22zikwlulhi@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 01:22:21PM -0700, Jerry Snitselaar wrote:
> On Wed Oct 25 17, Jarkko Sakkinen wrote:
> > On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:
> > > On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > I'm implementing a fix for CVE-2017-15361 that simply blacklists
> > > > vulnerable FW versions. I think this is the only responsible action from
> > > > my side that I can do.
> > > 
> > > I'm not sure this is ideal - do Infineon have any Linux tooling for
> > > performing firmware updates, and if so will that continue working if
> > > the device is blacklisted? It's also a poor user experience to have
> > > systems using TPM-backed disk encryption keys suddenly rendered
> > > unbootable, and making it as easy as possible for people to do an
> > > upgrade and then re-seal secrets with new keys feels like the correct
> > > approach.
> > 
> > I talked today with Alexander Steffen in the KS unconference and we
> > concluded that this would be a terrible idea.
> > 
> > Alexander stated the following things about FW updates (Alexander,
> > please correct me if I state something incorrectly or if you have
> > something to add):
> > 
> > * FW update can be constructed either in a way that the keys in the
> >  NVRAM are not cleared or in a way that they are cleared.
> > * FW update cannot be directly applied to the TPM but must come as
> >  part of the firmware update from the vendor.
> 
> If that is the case, can the two of you get Intel to update the fw
> for the tpm in the nuc5i5myhe (slb9665) :) ? It has needed an update for a while, due
> to issues with context management. My understanding (quite likely I misunderstood)
> from a recent discussion with Peter was that it was possible to update the fw.

I don't know but I can at least forward the complains to the mother ship
:-)

It is fairly intuitive why dTPM cannot be updated without full firmware
update. It's part of the proprietary HW platform, not something
connected through PCI, USB or any standard bus.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
