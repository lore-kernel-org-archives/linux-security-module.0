From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Tue, 21 Mar 2017 15:44:17 +0000
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <a518f288-f084-2d11-161a-79ff884b936d@linux.vnet.ibm.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
	<20170317161614.GA28082@obsidianresearch.com>
	<bca2bee3c1b84100ac72238425ac4791@MUCSE612.infineon.com>
	<12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
	<a518f288-f084-2d11-161a-79ff884b936d@linux.vnet.ibm.com>
Message-ID: <b480890a6abe4f9092a547c0f2b7ce17@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> > There are a few special cases that need some thought though. For
> > example, it is possible to use an upgrade to switch the TPM family
> > from 1.2 to 2.0 (or vice versa). In this case it seems useful to let
> > the kernel reinitialize the TPM driver, so it uses the correct
> > timeouts for communication, activates the correct features (resource
> > manager or not?), etc., without needing to reboot the system.
> 
> In practice, would a TPM upgrade from TPM 1.2 to TPM 2.0 even occur
> without a reboot?  Is it an important use case?
> 
> 1 - It would leave the SHA-256 PCRs in the reset state.
> 
> 2 - It's possible that this upgrade would also require a BIOS upgrade.

For a traditional PC and when your goal is platform integrity, a reboot is probably the way to go. But in an embedded environment where there is no BIOS or if you use the TPM more like a smartcard just to store some keys (or generate random numbers), a reboot is unnecessary and it is more comfortable to avoid it.

We probably should inform the kernel before the upgrade anyway, so that it can shut down the TPM gracefully (and maybe switch to the upgrade mode, as Jason suggested). With that infrastructure in place, it does not seem like a lot of effort to also let it switch the TPM back to normal operation mode once the upgrade is complete.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
