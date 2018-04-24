From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 24 Apr 2018 19:30:52 +0300
Subject: [PATCH v2 2/2] tpm: reduce polling time to usecs for even finer
	granularity
In-Reply-To: <20180417131246.434-3-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
	<20180417131246.434-3-nayna@linux.vnet.ibm.com>
Message-ID: <20180424163052.GD5119@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 17, 2018 at 09:12:46AM -0400, Nayna Jain wrote:
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

Great, thanks for finding those references. Kind of stuff that I will
forget within months and have to revisit with git blame/log :-)

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
