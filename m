From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:12:57 +0300
Subject: [PATCH v3 16/20] tpm: tpm1: rewrite tpm1_get_random() using
	tpm_buf structure
In-Reply-To: <20180918093459.19165-17-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-17-tomas.winkler@intel.com>
Message-ID: <20180919151257.GI31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:55PM +0300, Tomas Winkler wrote:
> 1. Use tpm_buf in tpm1_get_random()
> 2. Fix comment in tpm_get_random() so it is clear that
> the function is expected to return number of random bytes.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
