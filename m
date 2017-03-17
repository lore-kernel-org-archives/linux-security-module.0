From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 17 Mar 2017 10:16:14 -0600
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
Message-ID: <20170317161614.GA28082@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 17, 2017 at 03:40:15PM +0000, Alexander.Steffen at infineon.com wrote:

> 1. I've got a TPM that implements vendor-specific command
> codes. Those cannot be send to the TPM anymore, but are rejected
> with EINVAL.
> 
> 2. When upgrading the firmware on my TPM, it switches to a
> non-standard communication mode for the upgrade process and does not
> communicate using TPM2.0 commands during this time. Rejecting
> non-TPM2.0 commands means upgrading won't be possible anymore.

How non standard? Is the basic header even there? Are the lengths
and status code right?

This might be an argument to add a 'raw' ioctl or something
specifically for this special case.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
