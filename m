From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 26 Jun 2018 16:21:40 +0300
Subject: [PATCH v5 1/5] tpm: rename tpm_chip_find_get() to
	tpm_find_get_ops()
In-Reply-To: <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
	<20180626110619.2362791-2-stefanb@linux.vnet.ibm.com>
	<55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
Message-ID: <0084b7ca7e5b9a48f4f8354805eed8b3c44f90c3.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 16:18 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> > Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
> > the tpm_put_ops() counter part.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> Awesome, makes sense by itself alone. Thanks Stefan. If we need
> follow up versions, no need to include this patch. I would take
> it even if the whole patch set was discarded for whatever reason.
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already pushed to my master. Kind of waiting James to rebase his
tree before moving stuff to next.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
