From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 30 Oct 2017 13:39:38 -0400
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <3691.1509383138@warthog.procyon.org.uk>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
	<1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
	<3691.1509383138@warthog.procyon.org.uk>
Message-ID: <1509385178.3583.159.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-10-30 at 17:05 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > > Did you mean "true" rather than "TRUE"?
> > 
> > Yes, of course. ?Commit 9f4b6a254d7a "ima: Fix bool
> > initialization/comparison" already addresses it. ?Please remove it
> > from this patch.
> 
> Is that with James?  I don't seem to have a copy, and I don't want to cause a
> patch collision.

No, it's staged in my next branch. ?After the disaster during the last
open window due to a linux-integrity patch, Linus requested linux-
integrity be pulled independently of the security pull request. ?We'll
see how that goes during the next open window.

James is staging the subsystem patches independently of each other, in
case of a similar problem, so that they can be pulled separately.
?There's a new "next-general" branch.

> > > I guess also that oopsing is okay if the allocation fails.  We've run out of
> > > memory during early boot, after all.
> > 
> > If the memory allocation fails, the "secure_boot" policy will not be
> > enabled for custom policies, but how is that "oopsing".
> 
> Sorry - I overlooked the fact that the variable is not used if it's not zero.
> 
> > If it fails, there needs to be some indication of the failure, which there
> > currently isn't. ?Perhaps also prevent loading a custom policy.
> 
> Does it need to panic (probably fine as a small memory alloc failed)?  If it
> doesn't set this policy what's the effect on things using
> is_ima_appraise_enabled() - assuming we get that far?

Assuming that the memory is a temporary failure, the system continues
to boot, and a custom policy is installed, there's a potential IMA-
appraisal gap, meaning that if the custom policy doesn't include the
secure boot rules, files that should be appraised (eg. kernel modules,
kexec'ed kernel image, firmware) won't be.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
