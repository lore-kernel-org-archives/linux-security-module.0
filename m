From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 26 Jun 2018 16:22:53 +0300
Subject: [PATCH v5 2/5] tpm: Implement tpm_default_chip() to find a TPM
	chip
In-Reply-To: <20180626110619.2362791-3-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
	<20180626110619.2362791-3-stefanb@linux.vnet.ibm.com>
Message-ID: <19062c6c3e07dbd24680f9d56c4bb73fd5154608.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Implement tpm_default_chip() to find a TPM chip and get a reference to it.
> This function is also suitable for other subsystems to call and hold onto
> the chip.

Please make the commit message a bit more verbose i.e. explain what this
tpm_default_chip() is and what it is used for.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
