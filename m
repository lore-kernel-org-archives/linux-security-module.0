From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 5 Jul 2018 18:43:00 +0300
Subject: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
	a tpm_chip
In-Reply-To: <1530706203.3452.74.camel@linux.vnet.ibm.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
	<1530550839.3709.46.camel@linux.vnet.ibm.com>
	<1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
	<1530706203.3452.74.camel@linux.vnet.ibm.com>
Message-ID: <20180705154300.GA12193@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 04, 2018 at 08:10:03AM -0400, Mimi Zohar wrote:
> > > Jarkko, would you mind staging this patch with the rest of the patch
> > > set?
> > 
> > Yes, sure, I can do that. Any additional tag?
> 
> Thanks, just these.

I pushed the changes to my tree (also next).

> Mimi

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
