From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 25 May 2017 09:50:59 -0600
Subject: [PATCH] tpm: vtpm_proxy: Do not run tpm2_shutdown
In-Reply-To: <1495717956-14252-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1495717956-14252-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170525155059.GA5151@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 25, 2017 at 09:12:36AM -0400, Stefan Berger wrote:
> The tpm2_shutdown does not work with the VTPM proxy driver since the
> function only gets called when the backend file descriptor is already
> closed and at this point no data can be sent anymore. A proper shutdown
> would have to be initated by a user space application, such as a container
> management stack, that sends the command via the character device before
> terminating the TPM emulator.
> 
> To avoid the tpm2_shutdown we introduce a TPM_CHIP_FLAG_NO_SHUTDOWN flag
> that only the VTPM proxy driver sets. This also avoids misleading kernel
> log messages.

This seems strange to me..

Why isn't ops null if the fd has gone away?

What is the call flow that hits this?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
