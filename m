From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 30 Oct 2017 12:43:58 -0400
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <32764.1509378584@warthog.procyon.org.uk>
References: <1509032805.5886.52.camel@linux.vnet.ibm.com>
	<20171026074243.GM8550@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
	<1508774083.3639.124.camel@linux.vnet.ibm.com>
	<26694.1509030144@warthog.procyon.org.uk>
	<32764.1509378584@warthog.procyon.org.uk>
Message-ID: <1509381838.3583.134.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-10-30 at 15:49 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > Huh?! ?With the "secure_boot" policy enabled on the boot command line,
> > IMA-appraisal would verify the kexec kernel image, firmware, kernel
> > modules, and custom IMA policy signatures.
> 
> What happens if the "secure_boot" policy isn't enabled on the boot command
> line?  Can you sum up both cases in a paragraph I can add to the patch
> description?

The other patch automatically enables "secure_boot" for lockdown mode.
So there is no need to specify "secure_boot" on the boot command line.
?Reordering the patches so that the other patch comes before any call
to is_ima_appraise_enabled() will simplify this patch description.

> > Other patches in this patch series need to be updated as well to check
> > if IMA-appraisal is enabled.
> 
> Which exactly?  I've added your "!is_ima_appraise_enabled() &&" line to
> kexec_file() and module_sig_check().  Anything else?

load_module(), which calls module_sig_check(), is called by both the
old and new kernel module syscalls. ?IMA is only on the new syscall.
?Did you differentiate between the kernel module syscalls?

There doesn't seem to be any other patches affected. ?That said, the
IMA "secure_boot" policy is more stringent than what you have without
it. ?For example, with the "secure_boot" policy enabled, firwmware
needs to be signed as well. ?At some point, we'll want to also require
the initramfs be signed as well.

Both methods work independently of each other, but there needs to be
better coordination for when both methods are enabled at the same time
(eg. are both signatures required?).

For testing purposes, you can use the same certs/signing_key to sign
the kexec image, kernel modules and firmware, by loading the
signing_key on the .ima keyring. ?Using evmctl, sign the files
(eg.?evmctl ima_sign -a sha256 -k certs/signing_key.pem??--imasig
/boot/<vmlinuz>).

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
