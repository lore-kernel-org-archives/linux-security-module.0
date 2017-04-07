From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 07 Apr 2017 04:28:08 -0400
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <20170407074159.GB10737@dhcp-128-65.nay.redhat.com>
References: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
	<21418.1491548875@warthog.procyon.org.uk>
	<20170407074159.GB10737@dhcp-128-65.nay.redhat.com>
Message-ID: <1491553688.4184.73.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-04-07 at 15:41 +0800, Dave Young wrote:
> On 04/07/17 at 08:07am, David Howells wrote:
> > Dave Young <dyoung@redhat.com> wrote:
> > 
> > > > > > +	/* Don't permit images to be loaded into trusted kernels if we're not
> > > > > > +	 * going to verify the signature on them
> > > > > > +	 */
> > > > > > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_down())
> > > > > > +		return -EPERM;
> > > > > > +
> > > > > >  
> > > > 
> > > > IMA can be used to verify file signatures too, based on the LSM hooks
> > > > in ?kernel_read_file_from_fd(). ?CONFIG_KEXEC_VERIFY_SIG should not be
> > > > required.
> > > 
> > > Mimi, I remember we talked somthing before about the two signature 
> > > verification. One can change IMA policy in initramfs userspace,
> > > also there are kernel cmdline param to disable IMA, so it can break the
> > > lockdown? Suppose kexec boot with ima disabled cmdline param and then
> > > kexec reboot again..
> > 
> > I guess I should lock down the parameter to disable IMA too.
> 
> That is one thing, user can change IMA policy in initramfs userspace,
> I'm not sure if IMA enforce the signed policy now, if no it will be also
> a problem.

I'm not sure how this relates to the question of whether IMA verifies
the kexec kernel image signature, as the test would not be based on a
Kconfig option, but on a runtime variable.

To answer your question, the rule for requiring the policy to be
signed is: ?appraise func=POLICY_CHECK appraise_type=imasig

When the ability to append rules is Kconfig enabled, the builtin
policy requires the new policy or additional rules to be signed.
?Unfortunately, always requiring the policy to be signed, would have
broken userspace.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
