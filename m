From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 3 Jul 2018 19:51:02 +0300
Subject: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
	shutdown
In-Reply-To: <1530631615.3142.6.camel@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
	<20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
	<edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
	<1530631615.3142.6.camel@linux.vnet.ibm.com>
Message-ID: <20180703165102.GB19800@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> On Tue, 2018-07-03 at 18:24 +0300, Jarkko Sakkinen wrote:
> [...]
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Is James maintaining this now? Have not seen his feedback yet...
> 
> Hey, I thought we both were ...
> 
> However, it looks fine to me
> 
> Reviewed-by: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> 
> James

OK, I was not sure how that discussion went. I could add myself as
co-maintainer to MAINTAINERS because I anyway need to go through
all of these.

If anyone does not vote against, I'll send a patch.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
