From: dhowells@redhat.com (David Howells)
Date: Tue, 04 Apr 2017 22:49:13 +0100
Subject: [PATCH] KEYS: Fix integrity calls to keyring_alloc
In-Reply-To: <alpine.OSX.2.21.1704041415460.11634@kaweerak-mobl1.amr.corp.intel.com>
References: <alpine.OSX.2.21.1704041415460.11634@kaweerak-mobl1.amr.corp.intel.com>
	<20170404183030.6054-1-mathew.j.martineau@linux.intel.com>
	<26247.1491335089@warthog.procyon.org.uk>
Message-ID: <24435.1491342553@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> > Since I just rebuilt my keys-next branch, it's probably worth you folding in
> > this patch and repushing so that I can repull.  That way you won't get a
> > bisection problem if you're using the integrity stuff.
> 
> Ok, done.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
> keyctl-restrict branch
> 8e323a02e866014091180443ccb186fee1e3d30d

Pulled.

> When you re-apply Stephan's KDF patch, I believe it was his intent to have the
> portion of the commit message before "---8<---" snipped out before applying.

Done.

Thanks,
David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
