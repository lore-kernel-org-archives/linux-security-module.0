From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 20 Oct 2017 19:09:39 +0100
Subject: [PATCH 12/27] x86/msr: Restrict MSR access when the kernel is
	locked down
In-Reply-To: <150842472452.7923.2592278090192179002.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842472452.7923.2592278090192179002.stgit@warthog.procyon.org.uk>
Message-ID: <20171020190939.569cedd2@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017 15:52:04 +0100
David Howells <dhowells@redhat.com> wrote:

> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> Writing to MSRs should not be allowed if the kernel is locked down, since
> it could lead to execution of arbitrary code in kernel mode.  Based on a
> patch by Kees Cook.

There are a load of standard tools that use this so I think you are going
to need a whitelist. Can you at least log *which* MSR in the failing case
so a whitelist can be built over time ?

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
