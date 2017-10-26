From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 19:00:37 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <ffd461a6d2604a0eafca18638a8a17a9@infineon.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<ffd461a6d2604a0eafca18638a8a17a9@infineon.com>
Message-ID: <20171026170037.cpj5ghlzruepucey@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 03:42:27PM +0000, Alexander.Steffen at infineon.com wrote:
> As far as I know, the kernel itself is not using any of the affected
> functionalities, so there is no need for an immediate mitigation
> within the kernel. But I'd like to hear about how similar issues were
> handled in the past. I can think of multiple severe security issues,
> for example in BIOS implementations, but I cannot recall ever hearing
> about the kernel refusing to boot on such machines or even do so much
> as print a warning about that vulnerability.

Hmm.. trusted key with parent other than a primary key?

> > Alexander stated the following things about FW updates (Alexander,
> > please correct me if I state something incorrectly or if you have
> > something to add):
> > 
> > * FW update can be constructed either in a way that the keys in the
> >   NVRAM are not cleared or in a way that they are cleared.
> 
> Correct. But as far as I know, the updates that were already published
> for this issue do not delete any of the keys. And I do not think that
> this would be a good idea. After all, the applications still might
> need access to their key to decrypt their data and reencrypt it with a
> safe key after applying the update.

Right, obviously :-)

> > * FW update cannot be directly applied to the TPM but must come as
> >   part of the firmware update from the vendor.
> 
> Yes, starting the upgrade process is guarded by
> platformAuth/platformPolicy (in the case of TPM2), so the platform
> vendor needs to be involved. And you want them to be involved, since
> they need to make sure that their system still works with the updated
> TPM. I'm not sure whether platform vendors do that for TPMs, but for
> wireless cards whitelisting in the BIOS is common, and you do not want
> your machine refusing to boot just because the BIOS does not recognize
> your TPM's firmware version anymore (as a simple example).
> 
> > I proposed the following as an alternative:
> > 
> > * Print a message to the klog (which log level would be appropriate?).
> > * Possibly sleep for few seconds. Is this a good idea?
> 
> I'd be okay with that, but ideally we'd have some kind of
> agreement/history of how to handle similar security issues in hardware
> components in general. Implementing a special case just for this TPM
> vulnerability does not seem like the right thing to do, especially
> when the kernel itself is not affected (and thus the whole machine
> might not be affected for the way that it is used). We do not want to
> confuse users or make them expect similar warnings in the future, when
> we might have no intention of providing them.
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

Thank you for elaborating this further!

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
