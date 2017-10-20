From: dhowells@redhat.com (David Howells)
Date: Fri, 20 Oct 2017 21:48:16 +0100
Subject: [PATCH 12/27] x86/msr: Restrict MSR access when the kernel is
	locked down
In-Reply-To: <20171020190939.569cedd2@alans-desktop>
References: <20171020190939.569cedd2@alans-desktop>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842472452.7923.2592278090192179002.stgit@warthog.procyon.org.uk>
Message-ID: <18499.1508532496@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

> There are a load of standard tools that use this so I think you are going
> to need a whitelist. Can you at least log *which* MSR in the failing case
> so a whitelist can be built over time ?

Probably.  Is it just the file position for msr_write()?  Should the register
number increment with the copy loop?

What about for the X86_IOC_WRMSR_REGS ioctl?  What's the reg number there?

And do you know where wrmsr_safe_regs() might be found?  I can see things
using it and exporting it, but no implementation, so I'm guessing it's
macroised somewhere.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
