From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 7 Mar 2018 08:54:54 -0700
Subject: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation commands.
In-Reply-To: <1520361396.10396.396.camel@linux.vnet.ibm.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180305125642.GA3425@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
	<20180306074932.GB3624@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
	<1520353933.5393.21.camel@HansenPartnership.com>
	<1520361396.10396.396.camel@linux.vnet.ibm.com>
Message-ID: <20180307085454.2c820a13@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 06 Mar 2018 13:36:36 -0500
Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> I've heard that some maintainers are moving away from cover letters,
> since they are not include in the git repo and are lost.

If I get a patch series with a cover letter that should be preserved, I
apply the series in a branch then do a no-ff merge; the cover letter can
then go into the merge commit.  There's no reason why cover letters need to
be lost.

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
