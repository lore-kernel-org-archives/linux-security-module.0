From: dhowells@redhat.com (David Howells)
Date: Mon, 30 Oct 2017 15:49:44 +0000
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1509032805.5886.52.camel@linux.vnet.ibm.com>
References: <1509032805.5886.52.camel@linux.vnet.ibm.com>
	<20171026074243.GM8550@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
	<1508774083.3639.124.camel@linux.vnet.ibm.com>
	<26694.1509030144@warthog.procyon.org.uk>
Message-ID: <32764.1509378584@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> Huh?! ?With the "secure_boot" policy enabled on the boot command line,
> IMA-appraisal would verify the kexec kernel image, firmware, kernel
> modules, and custom IMA policy signatures.

What happens if the "secure_boot" policy isn't enabled on the boot command
line?  Can you sum up both cases in a paragraph I can add to the patch
description?

> Other patches in this patch series need to be updated as well to check
> if IMA-appraisal is enabled.

Which exactly?  I've added your "!is_ima_appraise_enabled() &&" line to
kexec_file() and module_sig_check().  Anything else?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
