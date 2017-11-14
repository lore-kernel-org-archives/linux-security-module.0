From: mjg59@google.com (Matthew Garrett)
Date: Tue, 14 Nov 2017 11:58:20 -0800
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <CA+55aFzvuvqOfsJ9arzcc1QbTGs+U-TsNmsyem9UAVVQC8YkZQ@mail.gmail.com>
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
	<20171113210848.4dc344bd@alans-desktop>
	<454.1510609487@warthog.procyon.org.uk>
	<CA+55aFzrK29hbxoKs3GsvVUY4_uR7aBgZv2eeVyVq7MzfATY3w@mail.gmail.com>
	<1510662098.3711.139.camel@linux.vnet.ibm.com>
	<CA+55aFzvuvqOfsJ9arzcc1QbTGs+U-TsNmsyem9UAVVQC8YkZQ@mail.gmail.com>
Message-ID: <CACdnJuvP=0AHGtfGJ5+cT+kHRy3fU4BLjwkvzP0rLO6q5ejAQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 9:34 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It's this insane "firmware is special" that I disagree with. It's not
> special at all.

Our ability to determine that userland hasn't been tampered with
depends on the kernel being trustworthy. If userland can upload
arbitrary firmware to DMA-capable devices then we can no longer trust
the kernel. So yes, firmware is special.

Here's an example: we have a signed initramfs that's loaded by a
signed bootloader. That initramfs sets up a trustworthy audit chain
and loads an LSM policy that prevents the rest of userland from
interfering with it. From that point on, we don't care about the rest
of userland being signed - we know it can't interfere with us, but we
can reliably inspect what it's doing. Even an offline attack can't do
any damage, since the audit code is still signed. However, the
LSM-imposed boundary depends on the kernel being trustworthy. If an
attacker can replace the firmware that's uploaded to a device that can
do arbitrary DMA then they can tamper with the supposedly trustworthy
audit code and provide false information. Being able to tamper with
the contents of /usr/bin/* doesn't give them that.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
