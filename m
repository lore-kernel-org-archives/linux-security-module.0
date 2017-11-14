From: mjg59@google.com (Matthew Garrett)
Date: Tue, 14 Nov 2017 15:37:43 -0500
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <CA+55aFwN+yaLg_-jPKiQ4xYBc2zz3ogcHCY9nxMHGiAJxoCU6w@mail.gmail.com>
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
	<CACdnJutiOr0RZEW-9Z4i__o-O2B69cFknqo14Nu2G0_JQaE+xw@mail.gmail.com>
	<CA+55aFwN+yaLg_-jPKiQ4xYBc2zz3ogcHCY9nxMHGiAJxoCU6w@mail.gmail.com>
Message-ID: <CACdnJutfFa2CSf1jFvKtBdTtPWcu0aKdm8ZDdQmD+yTC4GQG6g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 3:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Nov 14, 2017 at 12:31 PM, Matthew Garrett <mjg59@google.com> wrote:
>>
>>> This is all theoretical security masturbation. The _real_ attacks have
>>> been elsewhere.
>>
>> People made the same argument about Secure Boot, and then we
>> discovered that people *were* attacking the boot chain. As we secure
>> other components, the attackers move elsewhere. This is an attempt to
>> block off an avenue of attack before it's abused.
>
> The thing is, if you have attested the system from boot, then you've
> already attested the firmware before it even gets loaded.
>
> And if you haven't, then you can't trust anything else anyway.

Sure you can. You don't need attestation to be able to assert that the
system only booted signed code and that only you have control over
that signing key.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
