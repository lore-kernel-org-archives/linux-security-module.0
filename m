From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 07 Mar 2018 11:35:03 -0500
Subject: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180307085454.2c820a13@lwn.net>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180305125642.GA3425@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
	<20180306074932.GB3624@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
	<1520353933.5393.21.camel@HansenPartnership.com>
	<1520361396.10396.396.camel@linux.vnet.ibm.com>
	<20180307085454.2c820a13@lwn.net>
Message-ID: <1520440503.10396.534.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-03-07 at 08:54 -0700, Jonathan Corbet wrote:
> On Tue, 06 Mar 2018 13:36:36 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > I've heard that some maintainers are moving away from cover letters,
> > since they are not include in the git repo and are lost.
> 
> If I get a patch series with a cover letter that should be preserved, I
> apply the series in a branch then do a no-ff merge; the cover letter can
> then go into the merge commit.  There's no reason why cover letters need to
> be lost.

Thanks, Jon.  That sounds like a really, good idea.

Some maintainers are saying to put the Changelog after the "---" so
that it isn't included in the patch description.

One of the reasons for including the Changelog in the patch
description, is to credit people with bug fixes, important rework of
the patch, etc.

Do you have any thoughts on this?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
