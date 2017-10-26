From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 26 Oct 2017 11:46:45 -0400
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <26694.1509030144@warthog.procyon.org.uk>
References: <20171026074243.GM8550@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
	<1508774083.3639.124.camel@linux.vnet.ibm.com>
	<26694.1509030144@warthog.procyon.org.uk>
Message-ID: <1509032805.5886.52.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Cc'ing Matthew Garrett]

On Thu, 2017-10-26 at 16:02 +0100, David Howells wrote:
> joeyli <jlee@suse.com> wrote:
> 
> > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) &&
> > +	    !is_ima_appraise_enabled() &&
> > +	    kernel_is_locked_down("kexec of unsigned images"))
> 
> This doesn't seem right.  It seems that you can then kexec unsigned images
> into a locked-down kernel if IMA appraise is enabled.

Huh?! ?With the "secure_boot" policy enabled on the boot command line,
IMA-appraisal would verify the kexec kernel image, firmware, kernel
modules, and custom IMA policy signatures. ?With the "ima: require
secure_boot rules in lockdown mode" patch, the "lockdown" mode would
enable IMA-appraisal's secure_boot policy, without requiring the boot
command line option. ?It would also add the secure_boot rules to the
custom policy, so that if the builtin policy is replaced with a custom
policy, the "secure_boot" policy would still be enforced.

Other patches in this patch series need to be updated as well to check
if IMA-appraisal is enabled.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
