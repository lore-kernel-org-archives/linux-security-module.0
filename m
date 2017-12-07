From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 7 Dec 2017 15:32:09 +0000
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <20171204195155.GU729@wotan.suse.de>
References: <1509660641.3416.24.camel@linux.vnet.ibm.com>
	<20171107230700.GJ22894@wotan.suse.de>
	<20171108061551.GD7859@linaro.org>
	<20171108194626.GQ22894@wotan.suse.de>
	<20171109014841.GF7859@linaro.org>
	<1510193857.4484.95.camel@linux.vnet.ibm.com>
	<20171109044619.GG7859@linaro.org>
	<20171111023240.2398ca55@alans-desktop>
	<20171113174250.GA22894@wotan.suse.de>
	<20171113210848.4dc344bd@alans-desktop>
	<20171204195155.GU729@wotan.suse.de>
Message-ID: <20171207153209.5da771a9@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> I am curious though, is the above notion of having hardware require signed
> firmware an implication brought down by UEFI? If so do you have any pointers
> to where this is stipulated? Or is it just a best practice we assume some
> manufacturers are implementing?

It's a mix of best practice and meeting the so called 'secure boot'
requirements. In the non Linux space exactly the same problems exist in
terms of trusting devices and firmware, building a root of trust and even
more so when producing 'hardened' platforms.

Some stuff isn't - USB devices for example don't get to pee on random
memory so often isn't signed.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
