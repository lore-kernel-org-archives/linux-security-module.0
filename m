From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 26 Jun 2018 16:26:13 +0300
Subject: [PATCH v5 5/5] ima: Get rid of ima_used_chip and use
	ima_tpm_chip != NULL instead
In-Reply-To: <20180626110619.2362791-6-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
	<20180626110619.2362791-6-stefanb@linux.vnet.ibm.com>
Message-ID: <2bb4c098622cff2430d96f17c02b34fcef4d882e.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Get rid of ima_used_chip and use ima_tpm_chip variable instead for
> determining whether to use the TPM chip.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

(i.e. LGTM but no competence to give a detailed review).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
