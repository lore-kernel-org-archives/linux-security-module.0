From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 03:26:22 +0400 (+04)
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710210326100.9435@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, David Howells wrote:

> From: Chun-Yi Lee <joeyli.kernel@gmail.com>
> 
> When KEXEC_VERIFY_SIG is not enabled, kernel should not loads image
> through kexec_file systemcall if securelevel has been set.
> 
> This code was showed in Matthew's patch but not in git:
> https://lkml.org/lkml/2015/3/13/778
> 


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
