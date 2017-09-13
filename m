From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Wed, 13 Sep 2017 14:52:12 -0400
Subject: [tpmdd-devel] [PATCH v2 1/4] tpm: ignore burstcount to improve
	tpm_tis send() performance.
In-Reply-To: <20170906161246.GA9747@obsidianresearch.com>
References: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
	<20170906125643.5070-2-nayna@linux.vnet.ibm.com>
	<20170906161246.GA9747@obsidianresearch.com>
Message-ID: <3c418974-a4c7-518e-b218-f6373c10209e@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/6/2017 12:12 PM, Jason Gunthorpe wrote:
> 
> The problem with this approach is that the TPM could totally block
> the CPU for very long periods of time.
> 
> It seems very risky to enable..
> 

How would you characterize "very long"?

The TPM vendors confirm that they empty the FIFO at internal speeds that
are comparable to the bus speed.  Thus, any stall will be sub-usec.  Is
that an issue?

In addition, new TPMs have ever larger FIFO's, making stalls less likely
going forward.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
