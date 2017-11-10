From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Nov 2017 10:21:44 +0000
Subject: [PATCH 26/30] Lock down ftrace
In-Reply-To: <nycvar.YFH.7.76.1711101114410.32604@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1711101114410.32604@cbobk.fhfr.pm>
	<alpine.LRH.2.00.1711101021440.24296@gjva.wvxbf.pm>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024883613.28329.14808632296386937974.stgit@warthog.procyon.org.uk>
	<27323.1510308432@warthog.procyon.org.uk>
Message-ID: <27646.1510309304@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> > The idea is to prevent cryptographic data for filesystems and other things
> > from being read out of the kernel memory as well as to prevent unauthorised
> > modification of kernel memory.
> 
> Then it would make sense to actually lock down dumping of registers / 
> function arguments (kprobes can currently do that, ftrace eventually could 
> as well I guess), but disabling the whole ftrace altogether seems like a 
> totally unnecessary overkill.

That would be fine by me.  I have a patch that locks down kprobes in this
series.  Steven says that ftrace might acquire the ability to dump registers
in the future.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
