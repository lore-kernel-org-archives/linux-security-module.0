From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:05:31 +0300
Subject: [PATCH v3 09/20] tpm: move tpm1 selftest code from tpm-interface
	tpm1-cmd.c
In-Reply-To: <20180918093459.19165-10-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-10-tomas.winkler@intel.com>
Message-ID: <20180919150531.GD31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:48PM +0300, Tomas Winkler wrote:
> Move the tpm1 selftest code functions to tpm1-cmd.c

TPM 1.x. Also, the function names are missing parentheses.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
