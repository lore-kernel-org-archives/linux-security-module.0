From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:41:43 +0200
Subject: [PATCH v2 6/8] tpm: factor out tpm_startup function
In-Reply-To: <20180310082428.31519-7-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-7-tomas.winkler@intel.com>
Message-ID: <d224d2ad2e9a6c1ba91b379401fb51f132074fdf.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> tpm manual startup is used only from within tpm1 or tpm2
> code, hence remove tpm_startup function from tpm-interface.c
> and add two static functions implementations tpm1_startup
> and tpm2_startup into to tpm1-cmd.c and tpm2-cmd.c respectively.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
