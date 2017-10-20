From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 03:29:00 +0400 (+04)
Subject: [PATCH 09/27] uswsusp: Disable when the kernel is locked down
In-Reply-To: <150842470227.7923.15293760935442172683.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842470227.7923.15293760935442172683.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210328510.9435@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> uswsusp allows a user process to dump and then restore kernel state, which
> makes it possible to modify the running kernel.  Disable this if the kernel
> is locked down.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
