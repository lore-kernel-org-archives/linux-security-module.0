From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 13:27:31 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
	<20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
Message-ID: <20171026112731.64d6d4qoz25bay4u@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 01:16:32PM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 26, 2017 at 12:26:10AM +0200, Peter Huewe wrote:
> > 
> > 
> > Am 25. Oktober 2017 20:53:49 MESZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
> > >On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:
> > >> On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
> > >> <jarkko.sakkinen@linux.intel.com> wrote:
> > >> > I'm implementing a fix for CVE-2017-15361 that simply blacklists
> > >> > vulnerable FW versions. I think this is the only responsible action
> > >from
> > >> > my side that I can do.
> > >> 
> > >> I'm not sure this is ideal - do Infineon have any Linux tooling for
> > >> performing firmware updates, and if so will that continue working if
> > >> the device is blacklisted? It's also a poor user experience to have
> > >> systems using TPM-backed disk encryption keys suddenly rendered
> > >> unbootable, and making it as easy as possible for people to do an
> > >> upgrade and then re-seal secrets with new keys feels like the correct
> > >> approach.
> > >
> > >I talked today with Alexander Steffen in the KS unconference and we
> > >concluded that this would be a terrible idea.
> > >
> > >Alexander stated the following things about FW updates (Alexander,
> > >please correct me if I state something incorrectly or if you have
> > >something to add):
> > >
> > >* FW update can be constructed either in a way that the keys in the
> > >  NVRAM are not cleared or in a way that they are cleared.
> > >* FW update cannot be directly applied to the TPM but must come as
> > >  part of the firmware update from the vendor.
> > >
> > >I proposed the following as an alternative:
> > >
> > >* Print a message to the klog (which log level would be appropriate?).
> > Info?
> > Maybe warn, definitely not err
> 
> Since the driver does not fail usually warn would make sense but since
> here even allowing to continue to use such TPM is questionable I would
> use error here.
> 
> People anyway ignore klog too easily so using warn would be a mistake in
> my opinion. It's like saying that nothing serious is happening here,
> move along.
> 
> Do you think so?
> 
> > >* Possibly sleep for few seconds. Is this a good idea?
> > Helps how?
> 
> Obviously to get it noticed that the system integrity is broken.
> 
> > >While writing this email yet another alternative popped into my mind:
> > >what if we allow only in-kernel use but disallow the use of /dev/tpm0?
> > >You could still use trusted keys.
> > >
> > No, same terrible idea since you block the upgrade path.
> > Upgrade tools work from userspace via the kernel driver. 
> > So /dev/tpm0 is necessary.
> 
> Right! How stupid of me (my previous response to Jerry) :-) Of course you
> can have special commands and talk to the TPM to do the upgrade even if
> it is part of the platform and not connected to a standard bus.
> 
> I got understanding in the yesterdays unconfernce discussion that it
> should be part of the firmware upgrade.
> 
> How do you do the upgrade through /dev/tpm0?
> 
> /Jarkko

I received the following email for iavael at iavael.name:

<quote>
Hello,

I'm writing regarding you mail in tpm fw update discussion from Wed, 25 Oct
2017 20:53:49 +0200.

Found it in lkml archive and cannot forward it to myself (captcha is broken),
so I cannot join discussion in maillist and writing directly.

There's a tool infineon-firmware-updater (found with tricky google-fu)

  Here's an archive
  https://gsdview.appspot.com/chromeos-localmirror/distfiles/infineon-firmware-updater-1.1.2459.0.tar.gz

  And here are some patches and ebuild file
  https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/chromeos-base/infineon-firmware-updater/

> * FW update can be constructed either in a way that the keys in the
> NVRAM are not cleared or in a way that they are cleared.

As far as I understand, this tool requires clearing TPM.

> * FW update cannot be directly applied to the TPM but must come as
> part of the firmware update from the vendor.

Some vendors mentioned here
https://www.infineon.com/cms/en/product/promopages/tpm-update/

distribute infineon's update tool for windows (actually 2 variants of it: CLI
and GUI).

Looks like Google got source code of it's *nix variant.
</quote>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
