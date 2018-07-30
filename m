From: jmorris@namei.org (James Morris)
Date: Tue, 31 Jul 2018 02:32:15 +1000 (AEST)
Subject: [GIT PULL] tpmdd 4.19 updates
In-Reply-To: <20180728142835.GA13620@linux.intel.com>
References: <20180728142130.GA13541@linux.intel.com>
	<20180728142835.GA13620@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1807310231560.24834@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 28 Jul 2018, Jarkko Sakkinen wrote:

> Hi James,
> 
> Sorry, I pressed send before writing anything. Here is the summary:
> 
> * Migrated away from PM runtime as explicit cmdReady/goIdle trasactions
>   for every command is a spec requirement. PM runtime adds only a layer of
>   complexity on our case.
> * tpm_tis drivers can now specify the hwrng quality.
> * TPM 2.0 code uses now tpm_buf for constructing messages. I think Tomas
>   Winkler has done the same for TPM 1.2. I'll start digging those
>   changes from the patchwork in the near future.
> * Bug fixes and clean ups.


Thanks, pulled to next-tpm and next-testing.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
