From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Apr 2017 20:05:07 +0200 (CEST)
Subject: [PATCH 06/24] Add a sysrq option to exit secure boot mode
In-Reply-To: <149142332458.5101.14654616837280513947.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142332458.5101.14654616837280513947.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704142003570.2327@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 5 Apr 2017, David Howells wrote:

> From: Kyle McMartin <kyle@redhat.com>
> 
> Make sysrq+x exit secure boot mode on x86_64, thereby allowing the running
> kernel image to be modified.  This lifts the lockdown.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: x86 at kernel.org

Matt, Ard?

Any opinions on this?

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
