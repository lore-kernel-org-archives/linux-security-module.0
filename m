From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 26 Jun 2018 16:25:44 +0300
Subject: [PATCH v5 4/5] ima: Use tpm_default_chip() and call TPM
	functions with a tpm_chip
In-Reply-To: <20180626110619.2362791-5-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
	<20180626110619.2362791-5-stefanb@linux.vnet.ibm.com>
Message-ID: <fbf7822a1c6a07adad22a5afbb0eb4de48e2d48e.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Rather than accessing the TPM functions by passing a NULL pointer for
> the tpm_chip, which causes a lookup for a suitable chip every time, get a
> hold of a tpm_chip and access the TPM functions using it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

(i.e. LGTM but competence to give a detailed review).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
