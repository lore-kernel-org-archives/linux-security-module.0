From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Apr 2017 20:30:33 +0200 (CEST)
Subject: [PATCH 14/24] x86: Restrict MSR access when the kernel is locked
	down
In-Reply-To: <149142339340.5101.1283602261267937893.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142339340.5101.1283602261267937893.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704142028440.2327@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 5 Apr 2017, David Howells wrote:

Can you please change the subsys in $subject to 'x86/msr:' ?

> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> Writing to MSRs should not be allowed if the kernel is locked down, since
> it could lead to execution of arbitrary code in kernel mode.  Based on a
> patch by Kees Cook.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> cc: x86 at kernel.org

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
