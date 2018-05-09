From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 09 May 2018 15:57:18 -0400
Subject: [PATCH 3/6] firmware: differentiate between signed
	regulatory.db and other firmware
In-Reply-To: <20180509191508.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20180504000743.GR27853@wotan.suse.de>
	<1525393466.3539.133.camel@linux.vnet.ibm.com>
	<20180508173404.GG27853@wotan.suse.de>
	<1525865428.3551.175.camel@linux.vnet.ibm.com>
	<20180509191508.GR27853@wotan.suse.de>
Message-ID: <1525895838.3551.247.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-05-09 at 19:15 +0000, Luis R. Rodriguez wrote:

> > > >?If both are enabled, do we require both signatures or is one enough.
> > > 
> > > Good question. Considering it as a stacked LSM (although not implemented
> > > as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> > > IMA though, then surely I agree that enabling
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> > > system integrator to decide.
> > 
> > Just because IMA-appraisal is enabled in the kernel doesn't mean that
> > firmware signatures will be verified. ?That is a run time policy
> > decision.
> 
> Sure, I accept this if IMA does not do signature verification. However
> signature verification seems like a stackable LSM decision, no?

IMA-appraisal can be configured to enforce file signatures. ?Refer to
discussion below as to how.

> > > If we however want to make it clear that such things as
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> > > could just make the kconfig depend on !IMA or something?  Or perhaps a new
> > > kconfig for IMA which if selected it means that drivers can opt to open code
> > > *further* kernel signature verification, even though IMA already is sufficient.
> > > Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?
> > 
> > The existing CONFIG_IMA_APPRAISE is not enough. ?If there was a build
> > time IMA config that translated into an IMA policy requiring firmware
> > signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
> > be sorted out at build time.
> 
> I see makes sense.

Ok, so instead of introducing READING_FIRMWARE_REGULATORY_DB, I'll
post patches introducing CONFIG_IMA_APPRAISE_FIRMWARE, as described
above.

> 
> > > > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > > > to handle regdb files differently.
> > > 
> > > That's not the main concern here, its the precedent we are setting here for
> > > any new kernel interface which open codes firmware signing on its own. What
> > > you are doing means other kernel users who open codes their own firmware
> > > signing may need to add yet-another reading ID. That doesn't either look
> > > well on code, and seems kind of silly from a coding perspective given
> > > the above, in which I clarify IMA still is doing its own appraisal on it.
> > 
> > Suppose,
> > 
> > 1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
> > "CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.
> > 
> > 2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
> > "CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
> > appraises the firmware signature could be defined. ?In this case, both
> > signature verification methods would be enforced.
> > 
> > then READING_FIRMWARE_REGULATORY_DB would not be needed.
> 
> True, however I'm suggesting that CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> could just be a mini subsystem stackable LSM.

Yes, writing regdb as a micro/mini LSM sounds reasonable. ?The LSM
would differentiate between other firmware and the regulatory.db based
on the firmware's pathname.

Making regdb an LSM would have the same issues as currently - deciding
if regdb, IMA-appraisal, or both verify the regdb's signature.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
