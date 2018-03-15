From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:37:43 +0200
Subject: [PATCH v2 4/8] tpm: move tpm1 selftest code from tpm-interface
	tpm1-cmd.c
In-Reply-To: <20180310082428.31519-5-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-5-tomas.winkler@intel.com>
Message-ID: <f70bda7aa50a99a3ed535742ac0939823d4a9f45.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Move the tmp1 selftest code functions to tpm1-cmd.c
> and adjust callers to use the new function names.
>  1. tpm_pcr_read_dev to tpm1_pcr_read_dev
>  2. tpm_continue_selftest to tpm1_continue_selftest
>  3. tpm_do_selftest to tpm1_do_selftest
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
