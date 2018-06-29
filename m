From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 29 Jun 2018 14:39:37 +0300
Subject: [PATCH v7 3/5] tpm: Convert tpm_find_get_ops() to use
	tpm_default_chip()
In-Reply-To: <20180626190933.2508821-4-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
	<20180626190933.2508821-4-stefanb@linux.vnet.ibm.com>
Message-ID: <7dddd668a1b45670a52b04daf6c612c947dde0a6.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
