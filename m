From: dhowells@redhat.com (David Howells)
Date: Mon, 13 Nov 2017 21:44:47 +0000
Subject: Firmware signing -- Re: [PATCH 00/27] security,
	efi: Add kernel lockdown
In-Reply-To: <20171113210848.4dc344bd@alans-desktop>
References: <20171113210848.4dc344bd@alans-desktop>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
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
Message-ID: <454.1510609487@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

> So you don't actually need to sign a lot of PC class firmware because
> it's already signed.

Whilst that may be true, we either have to check signatures on every bit of
firmware that the appropriate driver doesn't say is meant to be signed or not
bother.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
