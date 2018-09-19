From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:09:02 +0300
Subject: [PATCH v3 07/20] tpm: move tpm_getcap to tpm1-cmd.c
In-Reply-To: <20180918093459.19165-8-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-8-tomas.winkler@intel.com>
Message-ID: <20180919140902.GB27854@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:46PM +0300, Tomas Winkler wrote:
> 1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
> 2. Remove unused tpm_getcap_header with unused constant
> as this functionality is already implemented using tpm_buf construct.
> 
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:452:38: warning: ?tpm_getcap_header? defined but not used [-Wunused-const-variable=]
>  static const struct tpm_input_header tpm_getcap_header = {
>                                       ^~~~~~~~~~~~~~~~~
> 3. Drop unused TPM_DIGEST_SIZE. It's already defined in
> include/linux/tpm.h

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
