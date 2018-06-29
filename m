From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 29 Jun 2018 14:36:17 +0300
Subject: [PATCH v7 2/5] tpm: Implement tpm_default_chip() to find a TPM
	chip
In-Reply-To: <20180626190933.2508821-3-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
	<20180626190933.2508821-3-stefanb@linux.vnet.ibm.com>
Message-ID: <d6ffc33cc0870a097fc261e78b4bb3b4eed47f52.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> Implement tpm_default_chip() to find the first TPM chip and return it to
> the caller while increasing the reference count on its device. This
> function can be used by other subsystems, such as IMA, to find the system's
> default TPM chip and use it for all subsequent TPM operations.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
