From: jmorris@namei.org (James Morris)
Date: Fri, 7 Apr 2017 08:45:52 +1000 (AEST)
Subject: [PATCH 3/5] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <149148301242.3427.10901430670266893587.stgit@warthog.procyon.org.uk>
References: <149148299794.3427.549144000807596903.stgit@warthog.procyon.org.uk>
	<149148301242.3427.10901430670266893587.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.20.1704070845170.27111@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 6 Apr 2017, David Howells wrote:

> Provide a single call to allow kernel code to determine whether the system
> should be locked down, thereby disallowing various accesses that might
> allow the running kernel image to be changed including the loading of
> modules that aren't validly signed with a key we recognise, fiddling with
> MSR registers and disallowing hibernation,
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
