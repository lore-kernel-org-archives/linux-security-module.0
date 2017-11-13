From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 13 Nov 2017 20:08:48 +0100
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <20171113185035.GB22894@wotan.suse.de>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
	<1509660641.3416.24.camel@linux.vnet.ibm.com>
	<20171107230700.GJ22894@wotan.suse.de>
	<20171108061551.GD7859@linaro.org>
	<20171108194626.GQ22894@wotan.suse.de>
	<20171109014841.GF7859@linaro.org>
	<20171110014641.GO22894@wotan.suse.de>
	<1510321506.3359.42.camel@linux.vnet.ibm.com>
	<20171113185035.GB22894@wotan.suse.de>
Message-ID: <20171113190848.GD22894@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 13, 2017 at 07:50:35PM +0100, Luis R. Rodriguez wrote:
> On Fri, Nov 10, 2017 at 08:45:06AM -0500, Mimi Zohar wrote:
> It does not mean we don't have to support hashes from the start, we can,
> however that could require a driver change where its hash is specified or
> preferred, for instance.

Actually the pseudo code I just demo'd on your RFC proposal shows how we
could support the hashes for firmware an optional first policy and if that
fails check the fw signature if present. So no driver changes would be
needed other than key'ing a respective hash for the firmware, which can
just be a macro driver addition, not an API call change.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
