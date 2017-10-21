From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 06:19:19 +0400 (+04)
Subject: [PATCH 26/27] efi: Add an EFI_SECURE_BOOT flag to indicate secure
	boot mode
In-Reply-To: <150842483172.7923.2791223614506312745.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842483172.7923.2791223614506312745.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210618180.22771@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> +	if (efi_enabled(EFI_BOOT)) {
> +		switch (mode) {
> +		case efi_secureboot_mode_disabled:
> +			pr_info("Secure boot disabled\n");
> +			break;
> +		case efi_secureboot_mode_enabled:
> +			set_bit(EFI_SECURE_BOOT, &efi.flags);
> +			pr_info("Secure boot enabled\n");
> +			break;
> +		default:
> +			pr_info("Secure boot could not be determined\n");

Perhaps make this pr_warning and include the unknown mode value?

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
