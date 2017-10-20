From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:40:00 +0800
Subject: [PATCH 06/27] Copy secure_boot flag in boot params across kexec
	reboot
In-Reply-To: <150842468009.7923.5512653689857540199.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468009.7923.5512653689857540199.stgit@warthog.procyon.org.uk>
Message-ID: <20171020064000.GO3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 03:51:20PM +0100, David Howells wrote:
> From: Dave Young <dyoung@redhat.com>
> 
> Kexec reboot in case secure boot being enabled does not keep the secure
> boot mode in new kernel, so later one can load unsigned kernel via legacy
> kexec_load.  In this state, the system is missing the protections provided
> by secure boot.
> 
> Adding a patch to fix this by retain the secure_boot flag in original
> kernel.
> 
> secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
> stub.  Fixing this issue by copying secure_boot flag across kexec reboot.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: kexec at lists.infradead.org

I have reviewed and tested this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
> 
>  arch/x86/kernel/kexec-bzimage64.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index fb095ba0c02f..7d0fac5bcbbe 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -179,6 +179,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	if (efi_enabled(EFI_OLD_MEMMAP))
>  		return 0;
>  
> +	params->secure_boot = boot_params.secure_boot;
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
>  	ei->efi_systab_hi = current_ei->efi_systab_hi;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
