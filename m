From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:09:01 +0300
Subject: [PATCH v3 13/20] tpm: add tpm_auto_startup into tpm-interface
In-Reply-To: <20180918093459.19165-14-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-14-tomas.winkler@intel.com>
Message-ID: <20180919150901.GF31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:52PM +0300, Tomas Winkler wrote:
> Add wrapper tpm_auto_startup() to tpm-interface.c
> instead of open coded decision between tpm 1.2 and tpm 2.0
> in tpm-chip.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Language.

> ---
> V3: new in the series

Please put the changelog to the cover letter only.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
