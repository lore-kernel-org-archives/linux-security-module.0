From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 29 Jun 2017 22:54:56 +0300
Subject: [PATCH 1/2] tpm: use tpm_buf functions in tpm2_pcr_read()
In-Reply-To: <20170628221858.65mybzp6tyzh27g7@linux.intel.com>
References: <20170623134157.30399-1-roberto.sassu@huawei.com>
	<20170623134157.30399-2-roberto.sassu@huawei.com>
	<20170628221858.65mybzp6tyzh27g7@linux.intel.com>
Message-ID: <20170629195456.yesgplwa74l2e6pc@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 29, 2017 at 01:18:58AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 23, 2017 at 03:41:56PM +0200, Roberto Sassu wrote:
> > tpm2_pcr_read() now builds the PCR read command buffer with tpm_buf
> > functions. This solution is preferred to using a tpm2_cmd structure,
> > as tpm_buf functions provide protection against buffer overflow.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
