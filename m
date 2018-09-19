From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:23:01 +0300
Subject: [PATCH v3 19/20] tpm1: reimplement SAVESTATE using tpm_buf
In-Reply-To: <20180918093459.19165-20-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-20-tomas.winkler@intel.com>
Message-ID: <20180919152301.GL31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:58PM +0300, Tomas Winkler wrote:
> In tpm1_pm_suspend() function reimplement,
> TPM_ORD_SAVESTATE comamnd using tpm_buf.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
