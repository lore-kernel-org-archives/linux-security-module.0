From: dhowells@redhat.com (David Howells)
Date: Wed, 24 May 2017 14:54:45 +0100
Subject: [PATCH 1/5] efi: Move the x86 secure boot switch to generic code
In-Reply-To: <CAKv+Gu9e-r+m6TEBPOg+o01m5JmF9CYLfH4dc60a_K41zJoCKg@mail.gmail.com>
References: <CAKv+Gu9e-r+m6TEBPOg+o01m5JmF9CYLfH4dc60a_K41zJoCKg@mail.gmail.com>
	<149148299794.3427.549144000807596903.stgit@warthog.procyon.org.uk>
Message-ID: <23673.1495634085@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > +         UEFI Secure Boot provides a mechanism for ensuring that the firmware
> > +         will only load signed bootloaders and kernels.  Secure boot mode may
> > +         be determined from EFI variables provided by the BIOS if not
> 
> Please replace 'the BIOS' with something more generic.

"Firmware" or "System firmware" maybe?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
