From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 06 Mar 2018 13:32:17 +0200
Subject: [PATCH 4/4] tpm: move tpm1 selftest code from tpm-interface
	tpm1-cmd.c
In-Reply-To: <20180306093041.11996-5-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
	<20180306093041.11996-5-tomas.winkler@intel.com>
Message-ID: <1520335937.7549.10.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> Move the tmp1 selftest code functions to tpm1-cmd.c
> tpm_pcr_read_dev to tpm1_pcr_read_dev
> tpm_continue_selftest to tpm1_continue_selftest
> tpm_do_selftest to tpm1_do_selftest
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

The same remark about tpm_buf as for tpm_get_random().

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
