From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 6 Apr 2017 21:43:54 +0200
Subject: [PATCH 17/24] acpi: Ignore acpi_rsdp kernel param when the kernel
	has been locked down
In-Reply-To: <149142341772.5101.12366553346604485034.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142341772.5101.12366553346604485034.stgit@warthog.procyon.org.uk>
Message-ID: <CAJZ5v0j580XfGHd+GVQe+7vuSGyxFzfrDOjYfOcGTnKZSvjCoA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 5, 2017 at 10:16 PM, David Howells <dhowells@redhat.com> wrote:
> From: Josh Boyer <jwboyer@redhat.com>
>
> This option allows userspace to pass the RSDP address to the kernel, which
> makes it possible for a user to circumvent any restrictions imposed on
> loading modules.  Ignore the option when the kernel is locked down.

I'm not really sure here.

What exactly is the mechanism?

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
