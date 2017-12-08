From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 8 Dec 2017 17:11:53 +0000
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <20171207230238.GW729@wotan.suse.de>
References: <20171111023240.2398ca55@alans-desktop>
	<20171113174250.GA22894@wotan.suse.de>
	<20171113210848.4dc344bd@alans-desktop>
	<454.1510609487@warthog.procyon.org.uk>
	<CA+55aFzrK29hbxoKs3GsvVUY4_uR7aBgZv2eeVyVq7MzfATY3w@mail.gmail.com>
	<1510662098.3711.139.camel@linux.vnet.ibm.com>
	<CA+55aFzvuvqOfsJ9arzcc1QbTGs+U-TsNmsyem9UAVVQC8YkZQ@mail.gmail.com>
	<CACdnJuvP=0AHGtfGJ5+cT+kHRy3fU4BLjwkvzP0rLO6q5ejAQQ@mail.gmail.com>
	<CA+55aFxeLwgwxh2iJTf6Dz0T_a_TZfTdhBw5TkcSsCmjt2N5pw@mail.gmail.com>
	<20171205102757.GA12982@amd> <20171207230238.GW729@wotan.suse.de>
Message-ID: <20171208171153.0a1bbadf@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> One is to get more and more folks reverse engineer firmware. This won't help
> if you can't deploy unsigned firmware though. But you have to also look at it

Oh I think it will. From the experience with things like games consoles
most firmware is such a complete pile of s**t that you'll be able to
exploit it to load your own firmware through the bugs, and at the very
least after the 200th CVE against their firmware the vendor's direct
customers may be a bit fed up and demand proper process and visibility 8)

It's always going to be in tension though - because there is firmware you
really don't want people replacing maliciously, such as battery control,
or thermal protection.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
