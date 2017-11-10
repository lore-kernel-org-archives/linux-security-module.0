From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 10 Nov 2017 08:45:06 -0500
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <20171110014641.GO22894@wotan.suse.de>
References: <1509660086.3416.15.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
	<1509660641.3416.24.camel@linux.vnet.ibm.com>
	<20171107230700.GJ22894@wotan.suse.de>
	<20171108061551.GD7859@linaro.org>
	<20171108194626.GQ22894@wotan.suse.de>
	<20171109014841.GF7859@linaro.org>
	<20171110014641.GO22894@wotan.suse.de>
Message-ID: <1510321506.3359.42.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-10 at 02:46 +0100, Luis R. Rodriguez wrote:
> On Thu, Nov 09, 2017 at 10:48:43AM +0900, AKASHI, Takahiro wrote:
> > On Wed, Nov 08, 2017 at 08:46:26PM +0100, Luis R. Rodriguez wrote:
> > > But perhaps I'm not understanding the issue well, let me know.
> > 
> > My point is quite simple:
> > my_deviceA_init() {
> >         err = request_firmware(&fw, "deviceA"); <--- (a)
> >         if (err)
> >                 goto err_request;
> > 
> >         err = verify_firmware(fw);  <--- (b)
> >         if (err)
> >                 goto err_verify;
> > 
> >         load_fw_to_deviceA(fw);     <--- (c)
> >         ...
> > }
> > 
> > As legacy device drivers does not have (b), there is no chance to
> > prevent loading a firmware at (c) for locked-down kernel.
> 
> Ah, I think your example requires another piece of code to make it clearer.
> Here is an example legacy driver:
> 
> my_legacy_deviceB_init() {
>         err = request_firmware(&fw, "deviceB"); <--- (a)
>         if (err)
>                 goto err_request;
> 
>         load_fw_to_deviceA(fw);     <--- (c)
>         ...
> }
> 
> There is no verify_firmware() call here, and as such the approach Linus
> suggested a while ago cannot possibly fail on a "locked down kernel", unless
> *very* legacy API call gets a verify_firmware() sprinkled.
> 
> One sensible thing to say here is then that all request_firmware() calls should
> just fail on a "locked down kernel", however if this were true then even calls
> which *did* issue a subsequent verify_firmware() would fail earlier therefore
> making verify_firmware() pointless on new drivers.

As long as these "*very* legacy API calls", are calling
kernel_read_file_from_path() to read the firmware, there shouldn't be
a problem.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
