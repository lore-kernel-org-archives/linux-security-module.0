From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 1 Jun 2018 21:25:45 +0200
Subject: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
	(pre-allocated buffer)
In-Reply-To: <20180601191545.GP4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
	<20180601191545.GP4511@wotan.suse.de>
Message-ID: <20180601192545.GR4511@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 01, 2018 at 09:15:45PM +0200, Luis R. Rodriguez wrote:
> On Tue, May 29, 2018 at 02:01:59PM -0400, Mimi Zohar wrote:
> > Some systems are memory constrained but they need to load very large
> > firmwares.  The firmware subsystem allows drivers to request this
> > firmware be loaded from the filesystem, but this requires that the
> > entire firmware be loaded into kernel memory first before it's provided
> > to the driver.  This can lead to a situation where we map the firmware
> > twice, once to load the firmware into kernel memory and once to copy the
> > firmware into the final resting place.
> > 
> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
> > that allows drivers to request firmware be loaded directly into a
> > pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
> > allocate this buffer.  According to Documentation/DMA-API.txt,
> > 
> >      Consistent memory is memory for which a write by either the
> >      device or the processor can immediately be read by the processor
> >      or device without having to worry about caching effects.  (You
> >      may however need to make sure to flush the processor's write
> >      buffers before telling devices to read that memory.)
> > 
> > Devices using pre-allocated DMA memory run the risk of the firmware
> > being accessible by the device prior to the kernel's firmware signature
> > verification has completed.
> 
> Indeed. And since its DMA memory we have *no idea* what can happen in
> terms of consumption of this firmware from hardware, when it would start
> consuming it in particular.
> 
> If the device has its own hardware firmware verification mechanism this is
> completely obscure to us, but it may however suffice certain security policies.
> 
> The problem here lies in the conflicting security policies of the kernel wanting
> to not give away firmware until its complete and the current inability to enable
> us to have platforms suggest they trust hardware won't do something stupid.
> This becomes an issue since the semantics of the firmware API preallocated
> buffer do not require currently allow the kernel to inform LSMs of the fact
> that a buffer is DMA memory or not, and a way for certain platforms then
> to say that such use is fine for specific devices.
> 
> Given a pointer can we determine if a piece of memory is DMA or not?

FWIW

Vlastimil suggests page_zone() or virt_to_page() may be able to.

  Luis

> Seems
> hacky to use such inferences if we had them anyway... but worth asking...
> 
> I would suggest we augment the prealloc buffer firmware API to pass a
> flags argument which helps describe the preallocated buffer, and for now
> allow us to enable callers to describe if the buffer is kernel memory or
> DMA memory, and then have the LSMs decide based on this information as well.
> The qualcomm driver would change to use the DMA flag, and IMA would in turn
> deny such uses. Once and if platforms want to trust the DMA flag they can
> later add infrastructure for specifying this somehow.
> 
> > Loading firmware already calls the security_kernel_read_file LSM hook.
> > With an IMA policy requiring signed firmware, this patch prevents
> > loading firmware into a pre-allocated buffer.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  security/integrity/ima/ima_main.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 4a87f78098c8..3dae605a1604 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -419,6 +419,15 @@ void ima_post_path_mknod(struct dentry *dentry)
> >  		iint->flags |= IMA_NEW_FILE;
> >  }
> >  
> > +static int read_idmap[READING_MAX_ID] = {
> > +	[READING_FIRMWARE] = FIRMWARE_CHECK,
> > +	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> > +	[READING_MODULE] = MODULE_CHECK,
> > +	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> > +	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> > +	[READING_POLICY] = POLICY_CHECK
> > +};
> > +
> >  /**
> >   * ima_read_file - pre-measure/appraise hook decision based on policy
> >   * @file: pointer to the file to be measured/appraised/audit
> > @@ -442,18 +451,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> >  		}
> >  		return 0;	/* We rely on module signature checking */
> >  	}
> > +
> > +	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
> > +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> > +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > +			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
> > +			return -EACCES;
> > +		}
> > +	}
> >  	return 0;
> >  }
> >  
> > -static int read_idmap[READING_MAX_ID] = {
> > -	[READING_FIRMWARE] = FIRMWARE_CHECK,
> > -	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> > -	[READING_MODULE] = MODULE_CHECK,
> > -	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> > -	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> > -	[READING_POLICY] = POLICY_CHECK
> > -};
> > -
> >  /**
> >   * ima_post_read_file - in memory collect/appraise/audit measurement
> >   * @file: pointer to the file to be measured/appraised/audit
> > -- 
> > 2.7.5
> > 
> > 
> 
> -- 
> Do not panic
> 

-- 
Do not panic
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
