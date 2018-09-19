From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:02:54 +0300
Subject: [PATCH v3 04/20] tpm: add tpm_calc_ordinal_duration wrapper
In-Reply-To: <20180918093459.19165-5-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-5-tomas.winkler@intel.com>
Message-ID: <20180919140254.GG26571@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:43PM +0300, Tomas Winkler wrote:
> Add convenient wrapper for ordinal duration computation
> to remove boiler plate if else statement over TPM2.
> 
> if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 	tpm2_calc_ordinal_duration(chip, ordinal);
> else
> 	tpm1_calc_ordinal_duration(chip, ordinal);
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
