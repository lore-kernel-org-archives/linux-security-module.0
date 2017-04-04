From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Tue, 4 Apr 2017 14:23:53 -0700 (PDT)
Subject: [PATCH] KEYS: Fix integrity calls to keyring_alloc
In-Reply-To: <26247.1491335089@warthog.procyon.org.uk>
References: <20170404183030.6054-1-mathew.j.martineau@linux.intel.com>
	<26247.1491335089@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.21.1704041415460.11634@kaweerak-mobl1.amr.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On Tue, 4 Apr 2017, David Howells wrote:

> Since I just rebuilt my keys-next branch, it's probably worth you folding in
> this patch and repushing so that I can repull.  That way you won't get a
> bisection problem if you're using the integrity stuff.

Ok, done.

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
keyctl-restrict branch
8e323a02e866014091180443ccb186fee1e3d30d

When you re-apply Stephan's KDF patch, I believe it was his intent to have 
the portion of the commit message before "---8<---" snipped out before 
applying.

--
Mat Martineau
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
