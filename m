From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 03:19:14 +0400 (+04)
Subject: [PATCH 01/27] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <150842463996.7923.6815305873334959305.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842463996.7923.6815305873334959305.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210318410.9435@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

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
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
