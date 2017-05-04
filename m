From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 4 May 2017 09:34:16 -0600
Subject: [PATCH v3 1/3] tpm: vtpm_proxy: Implement new ioctl to get
	supported flags
In-Reply-To: <1493909787-1848-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1493909787-1848-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1493909787-1848-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170504153416.GA15930@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 04, 2017 at 10:56:25AM -0400, Stefan Berger wrote:
> Implement VTPM_PROXY_IOC_GET_SUPT_FLAGS ioctl to get the bitmask
> of flags that the vtpm_proxy driver supports in the
> VTPM_PROXY_IOC_NEW_DEV ioctl. This helps user space in deciding
> which flags to set in that ioctl.

you might be better off just having a VTPM_PROXY_IO_ENABLE_FEATURE
.feature = LOCALITY

If that fails then the feature is not supported, no real need for the
query in that case.

Not sure about Jarkko's point on request/release locality.. Is there a
scenario where the emulator should fail the request locality?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
