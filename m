From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 02 Nov 2017 18:10:41 -0400
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <14219.1509660259@warthog.procyon.org.uk>
References: <1509660086.3416.15.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
Message-ID: <1509660641.3416.24.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-11-02 at 22:04 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > > Only validly signed device firmware may be loaded.
> > 
> > fw_get_filesystem_firmware() calls kernel_read_file_from_path() to
> > read the firmware, which calls into the security hooks. Is there
> > another place that validates the firmware signatures. ?I'm not seeing
> > which patch requires firmware to be signed?
> 
> Luis has a set of patches for this.  However, I'm not sure if that's going
> anywhere at the moment.  Possibly I should remove this from the manpage for
> the moment.

Or reflect that IMA-appraisal, if enabled, will enforce firmware being
validly signed.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
