From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 14 Nov 2017 09:34:29 -0800
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <1510662098.3711.139.camel@linux.vnet.ibm.com>
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
Message-ID: <CA+55aFzvuvqOfsJ9arzcc1QbTGs+U-TsNmsyem9UAVVQC8YkZQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 14, 2017 at 4:21 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-11-13 at 14:09 -0800, Linus Torvalds wrote:
>>
>> Seriously, if you have firmware in /lib/firmware, and you don't trust
>> it, what the hell are you doing?
>
> I might "trust" the files in /lib/firmware, but I also want to make
> sure that they haven't changed.  File signatures provide file
> provenance and integrity guarantees.

Sure. But that has absolutely nothing to do with "firmware".

It is equally true of /usr/bin/* and pretty much everything in the system.

It's this insane "firmware is special" that I disagree with. It's not
special at all.

                Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
