From: jmorris@namei.org (James Morris)
Date: Thu, 6 Apr 2017 10:31:06 +1000 (AEST)
Subject: [GIT PULL] tpmdd updates for 4.12
In-Reply-To: <20170404153826.hxzphlvzqcesg7rt@intel.com>
References: <20170404153826.hxzphlvzqcesg7rt@intel.com>
Message-ID: <alpine.LRH.2.20.1704061030490.8642@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 4 Apr 2017, Jarkko Sakkinen wrote:

> Hi James,
> 
> Here is the pull request for 4.12.
> 
> Major new features have been landed:
> 
> 1. TPM resource manager. There's a new device called /dev/tpmrm0. When this
> device is opened, a new session is created that is isolated from other users.
> Each user has its own set of volatile objects. There is also a new internal
> structure called struct tpm_space. This structure can be passed to tpm_transmit
> function and have own session to interact with the TPM. This could be
> potentially utilized by other kernel subsystems in the future.
> 2. ARM64 for support for tpm_crb.
> 3. Support for requesting and relinquishing locality 0 in tpm_crb. TXT uses
> locality 2 so we cannot assume that locality 0 is readily reserved when used
> in combination with TXT.
> 4. Comprehensive overhaul to tpm_tis_spi by Peter Huewe.
> 

Thanks for the summary.

Pulled.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
