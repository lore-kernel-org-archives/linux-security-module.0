From: mjg59@google.com (Matthew Garrett)
Date: Tue, 14 Nov 2017 15:31:40 -0500
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <CA+55aFxeLwgwxh2iJTf6Dz0T_a_TZfTdhBw5TkcSsCmjt2N5pw@mail.gmail.com>
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
	<CACdnJuvP=0AHGtfGJ5+cT+kHRy3fU4BLjwkvzP0rLO6q5ejAQQ@mail.gmail.com>
	<CA+55aFxeLwgwxh2iJTf6Dz0T_a_TZfTdhBw5TkcSsCmjt2N5pw@mail.gmail.com>
Message-ID: <CACdnJutiOr0RZEW-9Z4i__o-O2B69cFknqo14Nu2G0_JQaE+xw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 3:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Nov 14, 2017 at 11:58 AM, Matthew Garrett <mjg59@google.com> wrote:
>>
>> Our ability to determine that userland hasn't been tampered with
>> depends on the kernel being trustworthy. If userland can upload
>> arbitrary firmware to DMA-capable devices then we can no longer trust
>> the kernel. So yes, firmware is special.
>
> You're ignoring the whole "firmware is already signed by the hardware
> manufacturer and we don't even have access to it" part.

Firmware is sometimes signed by the hardware manufacturer. There's
plenty of hardware that accepts unsigned firmware.

> You're also ignoring the fact that we can't trust firmware _anyway_,
> as Alan pointed out.

Yeah, for arbitrary devices. There are cases where security has been
well audited, and it's viable to build systems where that's the
configuration you're running.

> Seriously. Some of the worst security issues have been with exactly
> the fact that we can't trust the hardware to begin with, where
> firmware/hardware combinations are not trusted to begin with.

You're right. But by that argument we might as well give up on *all*
security work - there's no way we can prove that a set of unprivileged
instructions won't backdoor a system.

> This is all theoretical security masturbation. The _real_ attacks have
> been elsewhere.

People made the same argument about Secure Boot, and then we
discovered that people *were* attacking the boot chain. As we secure
other components, the attackers move elsewhere. This is an attempt to
block off an avenue of attack before it's abused.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
