From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 18 May 2018 11:05:16 +0300
Subject: [PATCH v4 3/4] tpm: migrate tpm2_get_tpm_pt() to use struct
	tpm_buf
In-Reply-To: <95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
	<20180326121406.14548-4-jarkko.sakkinen@linux.intel.com>
	<95828353-43e1-0a02-ea54-544b709584b9@linux.vnet.ibm.com>
Message-ID: <20180518080516.GB14777@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 18, 2018 at 12:01:46PM +0530, Nayna Jain wrote:
> 
> 
> On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_get_tpm_pt() to use it.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
> Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

For all the rest, thanks. I'll still do one more revision of these
patches to update the kdoc comments (but they do not involve any
code changes).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
