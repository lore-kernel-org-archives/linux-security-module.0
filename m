From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 24 Apr 2018 19:27:52 +0300
Subject: [PATCH v2 1/2] tpm: reduce poll sleep time in tpm_transmit()
In-Reply-To: <20180417131246.434-2-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
	<20180417131246.434-2-nayna@linux.vnet.ibm.com>
Message-ID: <20180424162752.GC5119@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 17, 2018 at 09:12:45AM -0400, Nayna Jain wrote:
> The TPM polling code in tpm_transmit sleeps in each loop iteration for
> 5 msecs. However, the TPM might return earlier, and thus waiting for
> 5 msecs adds an unnecessary delay. This patch reduces the polling sleep
> time in tpm_transmit() from 5 msecs to 1 msecs.

I'm not sure what TPM returning earlier has to do with this. TPM probably
never returns exactly in the spec defined timeout/duration. I just don't
understand reasoning in this paragraph.

> Additionally, this patch renames TPM_POLL_SLEEP and moves it to tpm.h as
> an enum value.
> 
> After this change, performance on a TPM 1.2 with an 8 byte burstcount
> for 1000 extends improved from ~14 sec to ~10.7 sec.

You cannot give absolute numbers without a context (platform, software).

> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
