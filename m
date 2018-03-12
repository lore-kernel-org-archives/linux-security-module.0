From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 12 Mar 2018 15:59:57 -0600
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
In-Reply-To: <1520891598.3547.190.camel@linux.vnet.ibm.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
	<20180307185132.GA30102@ziepe.ca>
	<1520448953.10396.565.camel@linux.vnet.ibm.com>
	<1520449719.5558.28.camel@HansenPartnership.com>
	<1520450495.10396.587.camel@linux.vnet.ibm.com>
	<1520451662.24314.5.camel@HansenPartnership.com>
	<1520461156.10396.654.camel@linux.vnet.ibm.com>
	<191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
	<1520615461.12216.6.camel@HansenPartnership.com>
	<1520891598.3547.190.camel@linux.vnet.ibm.com>
Message-ID: <20180312215957.GI24717@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 12, 2018 at 05:53:18PM -0400, Mimi Zohar wrote:

> Using Kconfig to force the TPM to be builtin is not required, but
> helpful. ?Users interested in IMA-measurement could configure the TPM
> as builtin themselves. ?Without the TPM builtin, IMA goes into TPM-
> bypass mode.

This issues, broadly speaking, we have lots of TPM drivers, selecting
only some to actually support IMA shows we have some kind of problem
here.

eg a distro on ARM should not have some TPM hardware work with IMA and
some fail just because of this kconfig.

IMHO if we want to do this, then IMA should completely disable modular
TPM drivers across the board.

Or, IMA folks need to figure out how to safely load TPM modules under
their constraints.

But this current kconfig approach is pretty weird..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
