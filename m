From: jmorris@namei.org (James Morris)
Date: Tue, 30 May 2017 20:49:03 +1000 (AEST)
Subject: [PATCH 5/5] Add a sysrq option to exit secure boot mode
In-Reply-To: <149563716341.9419.12043461651917925181.stgit@warthog.procyon.org.uk>
References: <149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
	<149563716341.9419.12043461651917925181.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.20.1705302048370.31018@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 24 May 2017, David Howells wrote:

> From: Kyle McMartin <kyle@redhat.com>
> 
> Make sysrq+x exit secure boot mode on x86_64, thereby allowing the running
> kernel image to be modified.  This lifts the lockdown.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: x86 at kernel.org


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
