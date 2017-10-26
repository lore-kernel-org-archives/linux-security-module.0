From: dhowells@redhat.com (David Howells)
Date: Thu, 26 Oct 2017 16:02:24 +0100
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <20171026074243.GM8550@linux-l9pv.suse>
References: <20171026074243.GM8550@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
	<1508774083.3639.124.camel@linux.vnet.ibm.com>
Message-ID: <26694.1509030144@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

joeyli <jlee@suse.com> wrote:

> +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) &&
> +	    !is_ima_appraise_enabled() &&
> +	    kernel_is_locked_down("kexec of unsigned images"))

This doesn't seem right.  It seems that you can then kexec unsigned images
into a locked-down kernel if IMA appraise is enabled.

I think the commit message needs expansion as to why it's okay.  Can you also
do it as an additional patch rather than altering the original IMA-less patch
7?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
