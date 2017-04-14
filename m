From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Apr 2017 20:28:39 +0200 (CEST)
Subject: [PATCH 13/24] x86: Lock down IO port access when the kernel is
	locked down
In-Reply-To: <149142338597.5101.14728426552744019377.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142338597.5101.14728426552744019377.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704142028170.2327@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 5 Apr 2017, David Howells wrote:
> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO
> register space. This would potentially permit root to trigger arbitrary
> DMA, so lock it down by default.
> 
> This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
> KDDISABIO console ioctls.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
