From: mjg59@google.com (Matthew Garrett)
Date: Tue, 14 Nov 2017 15:55:10 -0500
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <20171114205014.GJ729@wotan.suse.de>
References: <20171109044619.GG7859@linaro.org>
	<20171111023240.2398ca55@alans-desktop>
	<20171113174250.GA22894@wotan.suse.de>
	<20171113210848.4dc344bd@alans-desktop>
	<454.1510609487@warthog.procyon.org.uk>
	<CA+55aFzrK29hbxoKs3GsvVUY4_uR7aBgZv2eeVyVq7MzfATY3w@mail.gmail.com>
	<1510662098.3711.139.camel@linux.vnet.ibm.com>
	<CA+55aFzvuvqOfsJ9arzcc1QbTGs+U-TsNmsyem9UAVVQC8YkZQ@mail.gmail.com>
	<CACdnJuvP=0AHGtfGJ5+cT+kHRy3fU4BLjwkvzP0rLO6q5ejAQQ@mail.gmail.com>
	<CA+55aFxeLwgwxh2iJTf6Dz0T_a_TZfTdhBw5TkcSsCmjt2N5pw@mail.gmail.com>
	<20171114205014.GJ729@wotan.suse.de>
Message-ID: <CACdnJuvzPnMwsAF4mUJXCaJWQ=nCc9Yi5u3gj1A0+BsWf1Swgw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 3:50 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Nov 14, 2017 at 12:18:54PM -0800, Linus Torvalds wrote:
>> This is all theoretical security masturbation. The _real_ attacks have
>> been elsewhere.
>
> In my research on this front I'll have to agree with this, in terms of
> justification and there are only *two* arguments which I've so far have found
> to justify firmware signing:
>
> a) If you want signed modules, you therefore should want signed firmware.
>    This however seems to be solved by using trusted boot thing, given it
>    seems trusted boot requires having firmware be signed as well. (Docs
>    would be useful to get about where in the specs this is mandated,
>    anyone?). Are there platforms that don't have trusted boot or for which
>    they don't enforce hardware checking for signed firmware for which
>    we still want to support firmware signing for? Are there platforms
>    that require and use module signing but don't and won't have a trusted
>    boot of some sort? Do we care?

TPM-backed Trusted Boot means you don't /need/ to sign anything, since
the measurements of what you loaded will end up in the TPM. But
signatures make it a lot easier, since you can just assert that only
signed material will be loaded and so you only need to measure the
kernel and the trusted keys.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
