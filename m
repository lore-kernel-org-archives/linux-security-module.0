From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 25 May 2017 14:44:14 -0600
Subject: [PATCH] tpm: vtpm_proxy: Do not run tpm2_shutdown
In-Reply-To: <9ff88c24-ca7a-1867-7284-17689fdac655@linux.vnet.ibm.com>
References: <1495717956-14252-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170525155059.GA5151@obsidianresearch.com>
	<f6c024ae-fe93-251a-a176-1f27f25b1e21@linux.vnet.ibm.com>
	<20170525200931.GA12733@obsidianresearch.com>
	<9ff88c24-ca7a-1867-7284-17689fdac655@linux.vnet.ibm.com>
Message-ID: <20170525204414.GA13742@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 25, 2017 at 04:32:50PM -0400, Stefan Berger wrote:

> It doesn't hang. Everything is torn down immediately. What is primarily
> annoying are these two log messages:
> tpm tpm0: tpm_transmit: tpm_send: error -32
> tpm tpm0: transmit returned -32 while stopping the TPM

I think it would be better to change the core to suppress that logging
if the FD is closed.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
