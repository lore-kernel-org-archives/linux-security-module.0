From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:13:39 +0300
Subject: [PATCH v3 17/20] tpm1: implement tpm1_pcr_read_dev() using
	tpm_buf structure
In-Reply-To: <20180918093459.19165-18-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-18-tomas.winkler@intel.com>
Message-ID: <20180919151339.GJ31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:56PM +0300, Tomas Winkler wrote:
> Implement tpm1_pcr_read_dev() using tpm_buf and remove
> now unneeded structures from tpm.h
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
