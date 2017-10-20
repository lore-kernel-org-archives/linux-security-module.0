From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 03:22:41 +0400 (+04)
Subject: [PATCH 05/27] kexec: Disable at runtime if the kernel is locked
	down
In-Reply-To: <150842466996.7923.17995994984545441369.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842466996.7923.17995994984545441369.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210322320.9435@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> kexec permits the loading and execution of arbitrary code in ring 0, which
> is something that lock-down is meant to prevent. It makes sense to disable
> kexec in this situation.
> 
> This does not affect kexec_file_load() which can check for a signature on the
> image to be booted.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> cc: kexec at lists.infradead.org


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
