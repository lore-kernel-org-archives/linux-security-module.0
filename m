From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:06:34 +0300
Subject: [PATCH v3 06/20] tpm: move tpm1_pcr_extend to tpm1-cmd.c
In-Reply-To: <20180918093459.19165-7-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-7-tomas.winkler@intel.com>
Message-ID: <20180919140634.GA27854@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:45PM +0300, Tomas Winkler wrote:
> Move tpm1_pcr_extend to tpm1-cmd.c and remove
> unused pcrextend_header structure.
> 
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:609:38: warning: ?pcrextend_header? defined but not used [-Wunused-const-variable=]
>  static const struct tpm_input_header pcrextend_header = {
>                                       ^~~~~~~~~~~~~~~~
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Can someone with a working IMA environment to test it? Don't have one
right now (should probably setup).

/Jarkko
