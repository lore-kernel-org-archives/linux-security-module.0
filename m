From: dhowells@redhat.com (David Howells)
Date: Thu, 06 Apr 2017 09:48:17 +0100
Subject: [PATCH 01/24] efi: Add EFI_SECURE_BOOT bit
In-Reply-To: <CAKv+Gu-3fegAE+oZ+YLXfSf1dwyxO9eYrgJbXOHn9A7eC3gzsw@mail.gmail.com>
References: <CAKv+Gu-3fegAE+oZ+YLXfSf1dwyxO9eYrgJbXOHn9A7eC3gzsw@mail.gmail.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142327748.5101.9712540392655343615.stgit@warthog.procyon.org.uk>
Message-ID: <15226.1491468497@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > @@ -1184,6 +1184,7 @@ void __init setup_arch(char **cmdline_p)
> >                         pr_info("Secure boot disabled\n");
> >                         break;
> >                 case efi_secureboot_mode_enabled:
> > +                       set_bit(EFI_SECURE_BOOT, &efi.flags);
> >                         pr_info("Secure boot enabled\n");
> >                         break;
> >                 default:
> 
> Like I asked when this patch was sent round the last time: is there
> any reason for this not to live in generic code?

It's interpreting the x86 boot_params at this point.  I suppose I could move
the following piece:

	if (efi_enabled(EFI_BOOT)) {
		switch (boot_params.secure_boot) {
		case efi_secureboot_mode_disabled:
			pr_info("Secure boot disabled\n");
			break;
		case efi_secureboot_mode_enabled:
			pr_info("Secure boot enabled\n");
			break;
		default:
			pr_info("Secure boot could not be determined\n");
			break;
		}
	}

into generic code and pass in boot_params.secure_boot as an argument (since
that's x86-specific I believe.  Any suggestions as to where?  The same file as
efi_get_secureboot() would seem to be the wrong place since that gets linked
into the bootwrapper.  I could put it into drivers/firmware/efi/secure_boot.c
and make that conditional in the Makefile.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
