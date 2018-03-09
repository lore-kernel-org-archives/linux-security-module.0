From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Fri, 09 Mar 2018 09:11:01 -0800
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
Message-ID: <1520615461.12216.6.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:
[...]
> I'm no expert on IMA and its driver.??James, will you be kind enough
> to look into overhauling the IMA driver to not measure until after?
> initrd phase if that's the consensus on resolving this?

I'll add it to my todo list.

Since my TPM 2.0 test environment is a VM with a tpm that has a network
connection to an emulator on my host, it's impossible to set it up so
that it's built in (because you need the network config before you init
the TPM) so I might accelerate if I suddenly need to debug IMA issues
in this configuration.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
