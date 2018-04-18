From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 18 Apr 2018 11:02:12 -0400
Subject: [PATCH v2 2/2] tpm: reduce polling time to usecs for even finer
	granularity
In-Reply-To: <20180417131246.434-3-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
	<20180417131246.434-3-nayna@linux.vnet.ibm.com>
Message-ID: <1524063732.3272.302.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-04-17 at 09:12 -0400, Nayna Jain wrote:
> The TPM burstcount and status commands are supposed to return very
> quickly [1][2]. This patch further reduces the TPM poll sleep time to usecs
> in get_burstcount() and wait_for_tpm_stat() by calling usleep_range()
> directly.
> 
> After this change, performance on a TPM 1.2 with an 8 byte burstcount for
> 1000 extends improved from ~10.7 sec to ~7 sec.
> 
> [1] From TCG Specification "TCG PC Client Specific TPM Interface
> Specification (TIS), Family 1.2":
> 
> "NOTE : It takes roughly 330 ns per byte transfer on LPC. 256 bytes would
> take 84 us, which is a long time to stall the CPU. Chipsets may not be
> designed to post this much data to LPC; therefore, the CPU itself is
> stalled for much of this time. Sending 1 kB would take 350 ?s. Therefore,
> even if the TPM_STS_x.burstCount field is a high value, software SHOULD
> be interruptible during this period."
> 
> [2] From TCG Specification 2.0, "TCG PC Client Platform TPM Profile
> (PTP) Specification":
> 
> "It takes roughly 330 ns per byte transfer on LPC. 256 bytes would take
> 84 us. Chipsets may not be designed to post this much data to LPC;
> therefore, the CPU itself is stalled for much of this time. Sending 1 kB
> would take 350 us. Therefore, even if the TPM_STS_x.burstCount field is a
> high value, software should be interruptible during this period. For SPI,
> assuming 20MHz clock and 64-byte transfers, it would take about 120 usec
> to move 256B of data. Sending 1kB would take about 500 usec. If the
> transactions are done using 4 bytes at a time, then it would take about
> 1 msec. to transfer 1kB of data."
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>


> ---
>  drivers/char/tpm/tpm.h          | 4 +++-
>  drivers/char/tpm/tpm_tis_core.c | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 7e797377e1eb..f0e4d290c347 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -54,7 +54,9 @@ enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> -	TPM_TIMEOUT_POLL = 1	/* msecs */
> +	TPM_TIMEOUT_POLL = 1,	/* msecs */
> +	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> +	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
>  };
> 
>  /* TPM addresses */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 021e6b68f2db..5bba5c662423 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -84,7 +84,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			tpm_msleep(TPM_TIMEOUT_POLL);
> +			usleep_range(TPM_TIMEOUT_USECS_MIN,
> +					TPM_TIMEOUT_USECS_MAX);
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> @@ -226,7 +227,7 @@ static int get_burstcount(struct tpm_chip *chip)
>  		burstcnt = (value >> 8) & 0xFFFF;
>  		if (burstcnt)
>  			return burstcnt;
> -		tpm_msleep(TPM_TIMEOUT_POLL);
> +		usleep_range(TPM_TIMEOUT_USECS_MIN, TPM_TIMEOUT_USECS_MAX);
>  	} while (time_before(jiffies, stop));
>  	return -EBUSY;
>  }

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
