From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 2 Sep 2017 13:20:11 +0300
Subject: [tpmdd-devel] [PATCH RESEND 3/3] tpm-chip: Export TPM device to
	user space even when startup failed
In-Reply-To: <d284fb46422f468cb2e5c70d3836be69@MUCSE603.infineon.com>
References: <20170824083714.10016-4-Alexander.Steffen@infineon.com>
	<20170825172021.lw3ycxqw63ubrcm2@linux.intel.com>
	<adaaeae32ba64d979abfc4b758c63fc0@MUCSE603.infineon.com>
	<20170829125509.55aylht3ikes3bpy@linux.intel.com>
	<20170829151739.315ae581@kitsune.suse.cz>
	<20170830101510.rlkh2p3zecfsrhgl@linux.intel.com>
	<20170830102002.nufnr77whz5jzwfr@linux.intel.com>
	<20170830123416.29117269@kitsune.suse.cz>
	<20170830110721.edidi46sx2qgovzu@linux.intel.com>
	<d284fb46422f468cb2e5c70d3836be69@MUCSE603.infineon.com>
Message-ID: <20170902102011.j77dpzuiabm2tn5l@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Aug 31, 2017 at 04:18:42PM +0000, Alexander.Steffen at infineon.com wrote:
> > I guess Alexander should be able to propose such subset.
> 
> For scenario #1 you could probably come up with a list of commands
> that are generally useful. But once you are restricted to those five
> commands, you block iterative debugging of the "I see where the
> problem might be, could you try to execute ..." fashion by requiring
> the other person to patch and rebuild their kernel.

If the subset turns out to be wrong, it can be revisited.

> For scenario #2 I see no chance to do that in a generic way. I could
> maybe tell you what the commands in this mode currently look like for
> Infineon TPMs, so that they can be whitelisted, but they might look
> different in the future and they are certainly different for other
> vendor's implementations.

It's easy to check whether a command is vendor specific and allow to
pass those through.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
