From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Thu, 26 Oct 2017 15:51:27 +0000
Subject: Fixing CVE-2017-15361
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
Message-ID: <6d23d2e2efbb4b7ba11c7d430d7c816e@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

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
> 
> Right. Thinking more about this issue, I'd say the ideal way to handle it would
> be in the applications using the TPM. Not all functionalities of the TPM are
> affected, so only the applications can know whether their use cases are still
> safe and it are the applications that need to migrate to a safe solution should
> this be necessary. (Of course, this puts the burden on each individual
> application instead of having one central place to decide what is safe and
> what isn't, but I do not see any way around that.)
> 
> As far as I know, the kernel itself is not using any of the affected
> functionalities, so there is no need for an immediate mitigation within the
> kernel.

This does not seem to be entirely true. The code in security/keys/trusted.c might be affected under some circumstances, but I am not familiar enough with that code to say for sure. As far as I can tell, it does not create any RSA keys directly, but it might reference them as parent keys, so that vulnerable keys are used to protect the secrets. 

If that is the case, can we detect that issue and migrate the secrets to a safe configuration? Do we (as the kernel) want to do that? How much do we want/have to involve the user in the process?

> But I'd like to hear about how similar issues were handled in the past.
> I can think of multiple severe security issues, for example in BIOS
> implementations, but I cannot recall ever hearing about the kernel refusing
> to boot on such machines or even do so much as print a warning about that
> vulnerability.
> 
> > Alexander stated the following things about FW updates (Alexander,
> > please correct me if I state something incorrectly or if you have
> > something to add):
> >
> > * FW update can be constructed either in a way that the keys in the
> >   NVRAM are not cleared or in a way that they are cleared.
> 
> Correct. But as far as I know, the updates that were already published for this
> issue do not delete any of the keys. And I do not think that this would be a
> good idea. After all, the applications still might need access to their key to
> decrypt their data and reencrypt it with a safe key after applying the update.
> 
> > * FW update cannot be directly applied to the TPM but must come as
> >   part of the firmware update from the vendor.
> 
> Yes, starting the upgrade process is guarded by platformAuth/platformPolicy
> (in the case of TPM2), so the platform vendor needs to be involved. And you
> want them to be involved, since they need to make sure that their system
> still works with the updated TPM. I'm not sure whether platform vendors do
> that for TPMs, but for wireless cards whitelisting in the BIOS is common, and
> you do not want your machine refusing to boot just because the BIOS does
> not recognize your TPM's firmware version anymore (as a simple example).
> 
> > I proposed the following as an alternative:
> >
> > * Print a message to the klog (which log level would be appropriate?).
> > * Possibly sleep for few seconds. Is this a good idea?
> 
> I'd be okay with that, but ideally we'd have some kind of agreement/history
> of how to handle similar security issues in hardware components in general.
> Implementing a special case just for this TPM vulnerability does not seem like
> the right thing to do, especially when the kernel itself is not affected (and
> thus the whole machine might not be affected for the way that it is used).
> We do not want to confuse users or make them expect similar warnings in
> the future, when we might have no intention of providing them.
> 
> > While writing this email yet another alternative popped into my mind:
> > what if we allow only in-kernel use but disallow the use of /dev/tpm0?
> > You could still use trusted keys.
> >
> > Here are all the ideas that I have and I am open for better
> > alternatives.
> >
> > /Jarkko
> 
> Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
