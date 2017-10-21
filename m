From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 06:11:34 +0400 (+04)
Subject: [PATCH 25/27] Lock down /proc/kcore
In-Reply-To: <150842482228.7923.9630520914833154257.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842482228.7923.9630520914833154257.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210609270.22771@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> Disallow access to /proc/kcore when the kernel is locked down to prevent
> access to cryptographic data.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: James Morris <james.l.morris@oracle.com>

I have to wonder, though, after everything is locked down, how easy will 
it be for new things to slip in which need to be included in the lockdown, 
but are not.


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
