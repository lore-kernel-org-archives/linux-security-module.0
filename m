From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 25 Oct 2017 20:53:49 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
Message-ID: <20171025185349.ocptudim3g35j6im@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:
> On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > I'm implementing a fix for CVE-2017-15361 that simply blacklists
> > vulnerable FW versions. I think this is the only responsible action from
> > my side that I can do.
> 
> I'm not sure this is ideal - do Infineon have any Linux tooling for
> performing firmware updates, and if so will that continue working if
> the device is blacklisted? It's also a poor user experience to have
> systems using TPM-backed disk encryption keys suddenly rendered
> unbootable, and making it as easy as possible for people to do an
> upgrade and then re-seal secrets with new keys feels like the correct
> approach.

I talked today with Alexander Steffen in the KS unconference and we
concluded that this would be a terrible idea.

Alexander stated the following things about FW updates (Alexander,
please correct me if I state something incorrectly or if you have
something to add):

* FW update can be constructed either in a way that the keys in the
  NVRAM are not cleared or in a way that they are cleared.
* FW update cannot be directly applied to the TPM but must come as
  part of the firmware update from the vendor.

I proposed the following as an alternative:

* Print a message to the klog (which log level would be appropriate?).
* Possibly sleep for few seconds. Is this a good idea?

While writing this email yet another alternative popped into my mind:
what if we allow only in-kernel use but disallow the use of /dev/tpm0?
You could still use trusted keys.

Here are all the ideas that I have and I am open for better
alternatives.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
