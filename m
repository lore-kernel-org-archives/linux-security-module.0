From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Nov 2017 10:07:12 +0000
Subject: [PATCH 26/30] Lock down ftrace
In-Reply-To: <alpine.LRH.2.00.1711101021440.24296@gjva.wvxbf.pm>
References: <alpine.LRH.2.00.1711101021440.24296@gjva.wvxbf.pm>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024883613.28329.14808632296386937974.stgit@warthog.procyon.org.uk>
Message-ID: <27323.1510308432@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> > This prevents crypto data theft by analysis of execution patterns, and, if
> > in future ftrace also logs the register contents at the time, will prevent
> > data theft by that mechanism also.
> 
> I fail to see how this fits into the secure boot security model, could you 
> please explain?

The idea is to prevent cryptographic data for filesystems and other things
from being read out of the kernel memory as well as to prevent unauthorised
modification of kernel memory.

> Secure boot is about having a constant proof / verification that the code 
> you're running in ring0 can be trusted (IOW is the one that has been 
> signed and verified by the whole boot chain).
> 
> Checking execution patterns doesn't seem to fit at all.

I'll defer this question to Alexei since he suggested I needed to deal with
this too.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
