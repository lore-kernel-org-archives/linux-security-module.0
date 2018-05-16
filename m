From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 16 May 2018 17:10:35 +0300
Subject: [PATCH v4 1/2] tpm: reduce poll sleep time in tpm_transmit()
In-Reply-To: <20180516055125.5685-2-nayna@linux.vnet.ibm.com>
References: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
	<20180516055125.5685-2-nayna@linux.vnet.ibm.com>
Message-ID: <20180516141035.GA10304@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 16, 2018 at 01:51:24AM -0400, Nayna Jain wrote:
> tpm_try_transmit currently checks TPM status every 5 msecs between
> send and recv. It does so in a loop for the maximum timeout as defined
> in the TPM Interface Specification. However, the TPM may return before
> 5 msecs. Thus the polling interval for each iteration can be reduced,
> which improves overall performance. This patch changes the polling sleep
> time from 5 msecs to 1 msec.
> 
> Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
> moves it to tpm.h as an enum value.
> 
> After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.
> 
> [1] All tests are performed on an x86 based, locked down, single purpose
> closed system. It has Infineon TPM 1.2 using LPC Bus.

Already applied previous version of this.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
