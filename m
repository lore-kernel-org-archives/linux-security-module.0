From: james.l.morris@oracle.com (James Morris)
Date: Tue, 9 Jan 2018 11:42:16 +1100 (AEDT)
Subject: [GIT PULL] tpmdd updates for v4.16
In-Reply-To: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
References: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
Message-ID: <alpine.LFD.2.20.1801091141410.17337@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 8 Jan 2018, Jarkko Sakkinen wrote:

> Hi James,
> 
> Sorry for a late PR.
> 
> Summary of the content:
> 
> * Reduced polling delays in tpm_tis.
> * Support for retrieving TPM 2.0 Event Log through EFI before
>   ExitBootServices.
> * Replaced tpm-rng.c with a hwrng device managed by the driver for each
>   TPM device.
> * TPM resource manager synthesizes TPM_RC_COMMAND_CODE response instead
>   of returning -EINVAL for unknown TPM commands. This makes user space
>   more sound.
> * CLKRUN fixes:
>   * Keep #CLKRUN disable through the entier TPM command/response flow.
>   * Check whether #CLKRUN is enabled before disabling and enabling it
>     again because enabling it breaks PS/2 devices on a system where it
>     is disabled.
> 

Thanks, merged to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
	next-tpm
	next-testing


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
