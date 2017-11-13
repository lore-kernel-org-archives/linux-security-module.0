From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 13 Nov 2017 21:08:48 +0000
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <20171113174250.GA22894@wotan.suse.de>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
	<1509660641.3416.24.camel@linux.vnet.ibm.com>
	<20171107230700.GJ22894@wotan.suse.de>
	<20171108061551.GD7859@linaro.org>
	<20171108194626.GQ22894@wotan.suse.de>
	<20171109014841.GF7859@linaro.org>
	<1510193857.4484.95.camel@linux.vnet.ibm.com>
	<20171109044619.GG7859@linaro.org>
	<20171111023240.2398ca55@alans-desktop>
	<20171113174250.GA22894@wotan.suse.de>
Message-ID: <20171113210848.4dc344bd@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 13 Nov 2017 18:42:50 +0100
"Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> On Sat, Nov 11, 2017 at 02:32:40AM +0000, Alan Cox wrote:
> > > My assumption here is:
> > > 1) there are some less important and so security-insensitive firmwares,
> > >    by which I mean that such firmwares won't be expected to be signed in
> > >    terms of vulnerability or integrity.
> > >    (I can't give you examples though.)
> > > 2) firmware's signature will be presented separately from the firmware
> > >    blob itself. Say, "firmware.bin.p7s" for "firmware.bin"  
> > 
> > For x86 at least any firmware on any system modern enough to support
> > 'secure' boot should already be signed. The only major exception is
> > likely to be for things like random USB widgets.  
> 
> Alan, the firmware being considered here is /lib/firmware firmware, which
> is not signed today. Its unclear to me how you mean that /lib/firmware files
> are already signed or verified today

By the hardware they get loaded onto. Pretty much all of the hardware on
PC class systems at least is signed and checked by the platform or the
device itself. For a 'secure' boot era PC that's pretty much everything
except USB toys and FPGA.

So you don't actually need to sign a lot of PC class firmware because
it's already signed.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
