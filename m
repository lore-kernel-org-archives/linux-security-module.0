From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Thu, 31 Aug 2017 16:18:42 +0000
Subject: [tpmdd-devel] [PATCH RESEND 3/3] tpm-chip: Export TPM device to
	user space even when startup failed
In-Reply-To: <20170830110721.edidi46sx2qgovzu@linux.intel.com>
References: <20170824083714.10016-1-Alexander.Steffen@infineon.com>
	<20170824083714.10016-4-Alexander.Steffen@infineon.com>
	<20170825172021.lw3ycxqw63ubrcm2@linux.intel.com>
	<adaaeae32ba64d979abfc4b758c63fc0@MUCSE603.infineon.com>
	<20170829125509.55aylht3ikes3bpy@linux.intel.com>
	<20170829151739.315ae581@kitsune.suse.cz>
	<20170830101510.rlkh2p3zecfsrhgl@linux.intel.com>
	<20170830102002.nufnr77whz5jzwfr@linux.intel.com>
	<20170830123416.29117269@kitsune.suse.cz>
	<20170830110721.edidi46sx2qgovzu@linux.intel.com>
Message-ID: <d284fb46422f468cb2e5c70d3836be69@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Wed, Aug 30, 2017 at 12:34:16PM +0200, Michal Such??nek wrote:
> > On Wed, 30 Aug 2017 13:20:02 +0300
> > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > > On Wed, Aug 30, 2017 at 01:15:10PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 29, 2017 at 03:17:39PM +0200, Michal Such??nek wrote:
> > > > > Hello,
> > > > >
> > > > > On Tue, 29 Aug 2017 15:55:09 +0300 Jarkko Sakkinen
> > > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > >
> > > > > > On Mon, Aug 28, 2017 at 05:15:58PM +0000,
> > > > > > Alexander.Steffen at infineon.com wrote:
> > > > > > > But is that just because nobody bothered to implement the
> > > > > > > necessary logic or for some other reason?
> > > > > >
> > > > > > We do not want user space to access broken hardware. It's a
> > > > > > huge risk for system stability and potentially could be used
> > > > > > for evil purposes.
> > > > > >
> > > > > > This is not going to mainline as it is not suitable for
> > > > > > general consumption. You must use a patched kernel if you want
> this.
> > > > > >
> > > > > > /Jarkko
> > > > > >
> > > > >
> > > > > It has been pointed out that userspace applications that use
> > > > > direct IO access exist for the purpose. So using a kernel driver
> > > > > is an improvement over that if the interface is otherwise sane.
> > > > >
> > > > > What do you expect is the potential for instability or evil use?
> > > >
> > > > By definition the use of broken hardware can have unpredictable
> > > > effects. Use a patched kernel if you want to do it.
> > > >
> > > > /Jarkko
> > >
> > > I.e. too many unknown unknowns for mainline.
> > >
> > > I could consider a solution for the TPM error case on self-test that
> > > allows only restricted subset of commands.
> > >
> > > The patch description did not go to *any* detail on how it is used
> > > so practically it's unreviewable at this point. There's a big burder
> > > of proof and now there's only hand waving.
> > >
> > Hello,
> >
> > there was a bug patched recently in which Linux was not sending the
> > shutdown command on system shutdown. Presumably with this bug some
> > TPMs consider being under attack and stop performing most functions.
> > However, you should be able to read the log if this is implemented
> > sanely. For that the TPM needs to be accessible.
> >
> > There are probably other cases when the TPM might be useless for
> > system use but it might be useful to access it. For example, does
> > Linux handle uninitialized TPMs?
> >
> > Thanks
> >
> > Michal

The two scenarios that I had in mind:

1. A TPM in failure mode. This signals a broken device, yes, but it is part of the specification, so we should support it. If it was unreasonable to talk to such a device, why specify failure mode in the first place?

2. A TPM in some vendor-specific mode. This is what happens during field upgrade with some Infineon TPMs. During the field upgrade process, the communication looks TPM-like (i.e. the usual 10-byte header is present), but it is not part of any (public) specification, and standard TPM commands are obviously unsupported. This works fine with the current driver, as long as you do not interrupt the upgrade process, as the driver never checks the device again during usage. But if the upgrade process is interrupted (e.g. by power loss) and the TPM has to start again in this vendor-specific mode, then the device simply disappears from the system and you have no chance to fix the problem.

> Agreed. I still think it would make sense to start with a limited subset of TPM
> commands, not with all-command-allowed.
> 
> I guess Alexander should be able to propose such subset.

For scenario #1 you could probably come up with a list of commands that are generally useful. But once you are restricted to those five commands, you block iterative debugging of the "I see where the problem might be, could you try to execute ..." fashion by requiring the other person to patch and rebuild their kernel.

For scenario #2 I see no chance to do that in a generic way. I could maybe tell you what the commands in this mode currently look like for Infineon TPMs, so that they can be whitelisted, but they might look different in the future and they are certainly different for other vendor's implementations.

So with both scenarios you end up with a lot of infrastructure for this whitelist approach in general and add a growing list of allowed commands, that are initially never present in the kernel version where you need them most, and where it then takes several months or years until they finally reach your users through official channels. And with all that in place, you gain what exactly? Why is it even useful to whitelist functionality based on command codes? If the device is broken, it might be that just some TIS registers do not work correctly. Or maybe just some parameter combinations for specific commands do not work anymore (e.g. your RSA hardware is broken, so RSA operations fail, but ECC is still good).

My point is: You already need to guard against misbehaving devices, but you cannot do so by trying to classify devices as either "good" or "bad". A device that initially looks good can turn bad at any time. So for example, you cannot run an endless loop until the good device returns the expected answer, but you always have to use proper timeouts. If such safeguards are missing somewhere, then it is already a bug that needs to be fixed. But if such safeguards are present everywhere where needed, there should be nothing that a good or a bad device can do, that harms the kernel or any (well-written) application.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
