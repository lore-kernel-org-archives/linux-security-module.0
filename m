From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 29 Jun 2018 15:13:09 +0300
Subject: [PATCH v7 0/5] Have IMA find and use a tpm_chip until system
	shutdown
In-Reply-To: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
Message-ID: <285d705b92b2f3a9351ac31b2e25ad36cb47204a.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 15:09 -0400, Stefan Berger wrote:
> This series of patches converts IMA's usage of the tpm_chip to find a TPM
> chip initially and use it until the machine is shut down. To do this we need
> to introduce a kref for the tpm_chip that IMA and all other users of a
> tpm_chip hold onto until they don't need the TPM chip anymore.

All the TPM patches are now in my tree and I just updated also the
next branch so they should be soon available also in linux-next.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
