From: dhowells@redhat.com (David Howells)
Date: Fri, 07 Apr 2017 08:05:27 +0100
Subject: [PATCH 17/24] acpi: Ignore acpi_rsdp kernel param when the kernel
	has been locked down
In-Reply-To: <20170407063107.GA10451@dhcp-128-65.nay.redhat.com>
References: <20170407063107.GA10451@dhcp-128-65.nay.redhat.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142341772.5101.12366553346604485034.stgit@warthog.procyon.org.uk>
	<CAJZ5v0j580XfGHd+GVQe+7vuSGyxFzfrDOjYfOcGTnKZSvjCoA@mail.gmail.com>
Message-ID: <21360.1491548727@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Dave Young <dyoung@redhat.com> wrote:

> > > This option allows userspace to pass the RSDP address to the kernel, which
> > > makes it possible for a user to circumvent any restrictions imposed on
> > > loading modules.  Ignore the option when the kernel is locked down.
> > 
> > I'm not really sure here.
> > 
> > What exactly is the mechanism?
> 
> Actually this acpi_rsdp param is created for EFI kexec reboot in old
> days when we had not supported persistent efi vm space across kexec
> reboot. At that time kexec reboot runs as noefi mode, it can not find
> the acpi root table thus kernel will hang early.
> 
> Now kexec can support EFI boot so this param is not necessary for most
> user unless they still use efi=old_map.

Is this patch now unnecessary?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
