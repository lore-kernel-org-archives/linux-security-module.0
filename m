From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:07:06 +0300
Subject: [PATCH v3 11/20] tpm: factor out tpm_startup function
In-Reply-To: <20180918093459.19165-12-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-12-tomas.winkler@intel.com>
Message-ID: <20180919150706.GE31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:50PM +0300, Tomas Winkler wrote:
> tpm manual startup is used only from within tpm1 or tpm2
> code, hence remove tpm_startup function from tpm-interface.c
> and add two static functions implementations tpm1_startup
> and tpm2_startup into to tpm1-cmd.c and tpm2-cmd.c respectively.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Again, language in the commit message. For example, I guess usually
we write abbrevation "TPM" and not "tpm".

Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

/Jarkko
