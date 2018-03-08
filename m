From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 08 Mar 2018 15:06:01 -0500
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
In-Reply-To: <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
	<20180307185132.GA30102@ziepe.ca>
	<1520448953.10396.565.camel@linux.vnet.ibm.com>
	<1520449719.5558.28.camel@HansenPartnership.com>
	<1520450495.10396.587.camel@linux.vnet.ibm.com>
	<1520451662.24314.5.camel@HansenPartnership.com>
	<1520461156.10396.654.camel@linux.vnet.ibm.com>
	<191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
Message-ID: <1520539561.3605.92.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:

> So from the discussion, I hear James suggests to overhaul the current
> IMA driver to not do measurement (calling tpm_pcr_read(), etc) until
> after initrd phase so TPM drivers can be built as modules.
> 
> I hear Mimi insists TPM drivers should be built-in when IMA driver is
> enabled and set to Y in Kconfig.
> 
> Do we have a consensus on which way we should go?
> 
> I'm no expert on IMA and its driver.  James, will you be kind enough
> to look into overhauling the IMA driver to not measure until after 
> initrd phase if that's the consensus on resolving this?

IMA selecting the TPM forces the TPM to be builtin. ?There's nothing
keeping you from directly configuring the TPM driver as builtin.

For remote attestation to validate the IMA measurement list against
the PCRs, the existing "ima_tcb" and "ima_policy=tcb" builtin policies
require the TPM to be builtin.

Not building the TPM into the kernel will also affect EVM.

I don't have a problem accepting your patch now; and if/when there is
a real use case for building the TPM driver as a kernel module for use
with IMA-measurement, accepting those changes then.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
