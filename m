From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 7 Mar 2018 11:24:47 -0700
Subject: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation commands.
In-Reply-To: <1520440503.10396.534.camel@linux.vnet.ibm.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180305125642.GA3425@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
	<20180306074932.GB3624@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
	<1520353933.5393.21.camel@HansenPartnership.com>
	<1520361396.10396.396.camel@linux.vnet.ibm.com>
	<20180307085454.2c820a13@lwn.net>
	<1520440503.10396.534.camel@linux.vnet.ibm.com>
Message-ID: <20180307112447.1eff794a@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 07 Mar 2018 11:35:03 -0500
Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> Some maintainers are saying to put the Changelog after the "---" so
> that it isn't included in the patch description.
> 
> One of the reasons for including the Changelog in the patch
> description, is to credit people with bug fixes, important rework of
> the patch, etc.
> 
> Do you have any thoughts on this?

Not sure I have a strong opinion there.  We do have various tags meant to
ensure proper credit; I would lean toward using those when possible rather
than including long change histories that, in the long term, don't help
readers to understand why the patch was applied.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
