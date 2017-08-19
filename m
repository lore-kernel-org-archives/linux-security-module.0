From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 19 Aug 2017 15:16:20 +0300
Subject: [PATCH v2] msleep() delays - replace with usleep_range() in TPM
	1.2/2.0 generic drivers
In-Reply-To: <20170814180916.GA5574@dev-HP-EliteBook-Folio-1040-G1>
References: <20170814180916.GA5574@dev-HP-EliteBook-Folio-1040-G1>
Message-ID: <20170819121620.4zxnvz5ki76jbbe4@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 14, 2017 at 07:09:16PM +0100, Hamza Attak wrote:
> The patch simply replaces all msleep function calls with usleep_range calls
> in the generic drivers.
> 
> Tested with an Infineon TPM 1.2, using the generic tpm-tis module, for a
> thousand PCR extends, we see results going from 1m57s unpatched to 40s
> with the new patch. We obtain similar results when using the original and
> patched tpm_infineon driver, which is also part of the patch.
> Similarly with a STM TPM 2.0, using the CRB driver, it takes about 20ms per
> extend unpatched and around 7ms with the new patch.
> 
> Note that the PCR consistency is untouched with this patch, each TPM has
> been tested with 10 million extends and the aggregated PCR value is
> continuously verified to be correct.
> 
> As an extension of this work, this could potentially and easily be applied
> to other vendor's drivers. Still, these changes are not included in the
> proposed patch as they are untested.
> 
> Signed-off-by: Hamza Attak <hamza@hpe.com>

Applying this.

Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

PS. Your short summary is broken. See how I fixed it. Otherwise,
no complains.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
