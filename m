From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 17 Mar 2017 22:42:43 +0200
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
Message-ID: <20170317204243.5j376svqeky6bhqk@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 17, 2017 at 03:40:15PM +0000, Alexander.Steffen at infineon.com wrote:
> > Check for every TPM 2.0 command that the command code is supported and
> > the command buffer has at least the length that can contain the header
> > and the handle area.
> 
> This breaks several use cases for me:

Thank you for reporting these. This is really great feedback to get.

> 1. I've got a TPM that implements vendor-specific command codes. Those
> cannot be send to the TPM anymore, but are rejected with EINVAL.
> 
> 2. When upgrading the firmware on my TPM, it switches to a
> non-standard communication mode for the upgrade process and does not
> communicate using TPM2.0 commands during this time. Rejecting
> non-TPM2.0 commands means upgrading won't be possible anymore.
> 
> 3. I'd like to use the kernel driver to test my TPM implementation. So
> for example, I send an invalid command code to the TPM and expect
> TPM_RC_COMMAND_CODE in response, but now I get EINVAL instead and the
> TPM never sees the command.
> 
> From my point of view, the kernel driver should provide a transparent
> communication channel to the TPM. Whatever I write to /dev/tpm<n>
> should arrive at the TPM device, so that the TPM can handle it and
> return the appropriate response. Otherwise, you'll end up
> reimplementing all the command handling logic, that is already part of
> the TPM's job, and as soon as you miss one case and behave differently
> than the TPM, something relying on this behavior will break.
> 
> I see two possible solutions:
> 
> 1. When the driver does not know a command code, it passes through the
> command unmodified. This bears the risk of unknown side effects
> though, so TPM spaces might not be as independent as they should be.
> 
> 2. Since the command code lookup is only really necessary for TPM
> spaces, it only gets activated when space != NULL. So the change will
> not affect /dev/tpm<n>, but only the new /dev/tpmrm<n>. As
> /dev/tpmrm<n> is not meant to be a transparent interface anyway,
> rejecting unknown commands is acceptable.
> 
> Alexander

I think the most straight-forward way to sort this out would be to limit
validation to the resource manager. If I send a fix, would you care to
test it? If your issues get sorted, I'll squash it to the existing
commits.

Thanks again!

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
