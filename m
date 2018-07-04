From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 04 Jul 2018 08:10:03 -0400
Subject: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
	a tpm_chip
In-Reply-To: <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
	<1530550839.3709.46.camel@linux.vnet.ibm.com>
	<1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
Message-ID: <1530706203.3452.74.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-07-03 at 19:32 +0300, Jarkko Sakkinen wrote:
> On Mon, 2018-07-02 at 13:00 -0400, Mimi Zohar wrote:
> > On Mon, 2018-07-02 at 11:24 -0400, Stefan Berger wrote:
> > > Rather than accessing the TPM functions by passing a NULL pointer for
> > > the tpm_chip, which causes a lookup for a suitable chip every time, get a
> > > hold of a tpm_chip and access the TPM functions using it. Also get rid of
> > > the ima_used_chip variable and use the new ima_tpm_chip variable instead
> > > for determining whether to call TPM functions.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > 
> > Jarkko, would you mind staging this patch with the rest of the patch
> > set?
> 
> Yes, sure, I can do that. Any additional tag?

Thanks, just these.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
