From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 15 Nov 2017 06:49:57 -0500
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
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
Message-ID: <1510746597.3711.268.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-11-14 at 21:50 +0100, Luis R. Rodriguez wrote:

> Johannes made cfg80211 recently just use request_firmware() now via commit on
> linux-next 90a53e4432 ("cfg80211: implement regdb signature checking") [0] as
> he got tired of waiting firmware signing, but note he implemented a signature
> checking on its own so he open codes verify_pkcs7_signature() after the
> request_firmware() call. If we are happy to live with this, then so be it.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=90a53e4432b12288316efaa5f308adafb8d304b0

Johannes was tired of waiting? ?Commit 5a9196d "ima: add support for
measuring and appraising firmware" has been in the kernel since linux-
3.17.

The original firmware hook for verifying firmware signatures were
replaced with the common LSM pre and post kernel_read_file() hooks
in?linux-4.6.y.

Even if you wanted to support firmware signature verification without
IMA-appraisal, it should be using the LSM hooks.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
