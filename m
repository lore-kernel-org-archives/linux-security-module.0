From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 03:21:22 +0400 (+04)
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210321120.9435@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> If the kernel is locked down, require that all modules have valid
> signatures that we can verify.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
