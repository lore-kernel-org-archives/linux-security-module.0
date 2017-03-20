From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Mon, 20 Mar 2017 15:42:13 -0400
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
	<20170317161614.GA28082@obsidianresearch.com>
	<bca2bee3c1b84100ac72238425ac4791@MUCSE612.infineon.com>
	<12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
Message-ID: <a518f288-f084-2d11-161a-79ff884b936d@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/20/2017 5:54 AM, Alexander.Steffen at infineon.com wrote:
>
> There are a few special cases that need some thought though. For
> example, it is possible to use an upgrade to switch the TPM family
> from 1.2 to 2.0 (or vice versa). In this case it seems useful to let
> the kernel reinitialize the TPM driver, so it uses the correct
> timeouts for communication, activates the correct features (resource
> manager or not?), etc., without needing to reboot the system.

In practice, would a TPM upgrade from TPM 1.2 to TPM 2.0 even occur 
without a reboot?  Is it an important use case?

1 - It would leave the SHA-256 PCRs in the reset state.

2 - It's possible that this upgrade would also require a BIOS upgrade.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
