From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 12 Apr 2018 07:38:17 -0400
Subject: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is
	locked down
In-Reply-To: <1523477375.5268.78.camel@linux.vnet.ibm.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
	<87po35k1q6.fsf@xmission.com>
	<1523477375.5268.78.camel@linux.vnet.ibm.com>
Message-ID: <1523533097.31852.11.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-04-11 at 16:09 -0400, Mimi Zohar wrote:
> On Wed, 2018-04-11 at 14:00 -0500, Eric W. Biederman wrote:
> > David Howells <dhowells@redhat.com> writes:
> > 
> > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > >
> > > The kexec_load() syscall permits the loading and execution of arbitrary
> > > code in ring 0, which is something that lock-down is meant to prevent. It
> > > makes sense to disable kexec_load() in this situation.
> > >
> > > This does not affect kexec_file_load() syscall which can check for a
> > > signature on the image to be booted.
> > 
> > Maybing I am missing it but I am not seeing anything that would require
> > kexec_file_load be configured such that it checks the loaded kernel.
> > 
> > Without that I don't see the point of disabling kexec_load.
> > 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> The IMA "secure boot" policy requires the kexec image to be signed.
> ?This call to kernel_is_locked_down() could be replaced with a call
> to?security_kernel_read_file(NULL, READING_KEXEC_IMAGE).
> 
> It would be similar to the existing init_module syscall calling
> security_kernel_read_file().

David, enabling the IMA-appraisal "secure boot" policy should probably
not be dependent on lockdown either.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
