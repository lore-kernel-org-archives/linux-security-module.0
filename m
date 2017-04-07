From: dyoung@redhat.com (Dave Young)
Date: Fri, 7 Apr 2017 14:19:35 +0800
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1491536950.4184.10.camel@linux.vnet.ibm.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
Message-ID: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/06/17 at 11:49pm, Mimi Zohar wrote:
> On Fri, 2017-04-07 at 11:05 +0800, Dave Young wrote:
> > On 04/05/17 at 09:15pm, David Howells wrote:
> > > From: Chun-Yi Lee <joeyli.kernel@gmail.com>
> > > 
> > > When KEXEC_VERIFY_SIG is not enabled, kernel should not loads image
> > > through kexec_file systemcall if securelevel has been set.
> > > 
> > > This code was showed in Matthew's patch but not in git:
> > > https://lkml.org/lkml/2015/3/13/778
> > > 
> > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: kexec at lists.infradead.org
> > > ---
> > > 
> > >  kernel/kexec_file.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index b118735fea9d..f6937eecd1eb 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -268,6 +268,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > >  		return -EPERM;
> > >  
> > > +	/* Don't permit images to be loaded into trusted kernels if we're not
> > > +	 * going to verify the signature on them
> > > +	 */
> > > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_down())
> > > +		return -EPERM;
> > > +
> > >  
> 
> IMA can be used to verify file signatures too, based on the LSM hooks
> in ?kernel_read_file_from_fd(). ?CONFIG_KEXEC_VERIFY_SIG should not be
> required.

Mimi, I remember we talked somthing before about the two signature 
verification. One can change IMA policy in initramfs userspace,
also there are kernel cmdline param to disable IMA, so it can break the
lockdown? Suppose kexec boot with ima disabled cmdline param and then
kexec reboot again..

> 
> Mimi
> 
> 
> > 	/* Make sure we have a legal set of flags */
> > >  	if (flags != (flags & KEXEC_FILE_FLAGS))
> > >  		return -EINVAL;
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > Acked-by: Dave Young <dyoung@redhat.com>
> > 
> > Thanks
> > Dave
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
