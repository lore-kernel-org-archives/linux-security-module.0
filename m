From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:22:19 +0300
Subject: [PATCH v3 18/20] tpm: use u32 instead of int for pcr index
In-Reply-To: <20180918093459.19165-19-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-19-tomas.winkler@intel.com>
Message-ID: <20180919152219.GK31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:57PM +0300, Tomas Winkler wrote:
> TPM pcr indices cannot be negative, also the tpm
> commands accept u32 number as a pcr index.
> 
> 1. Adjust the API to use u32 instead of int in all pcr related
> functions.

NAK.

> 2. Rename tpm1_pcr_read_dev to tpm1_pcr_read() to match
> the counterpart tpm2_pcr_read()

I would accept this a separate commit (and it should be a separate).

> 3. Remove redundant constants in tpm1_pcr_extend() function.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

/Jarkko
