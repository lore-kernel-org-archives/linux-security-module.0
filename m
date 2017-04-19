From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 19 Apr 2017 07:58:24 -0400
Subject: SELinux "filtering" capabilities?
In-Reply-To: <82d9ff60-6850-0873-1e68-20bd0e27e9ee@schaufler-ca.com>
References: <82d9ff60-6850-0873-1e68-20bd0e27e9ee@schaufler-ca.com>
Message-ID: <1492603104.31458.1.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-04-18 at 15:37 -0700, Casey Schaufler wrote:
> I don't expect anyone else to have run into this
> as I am working with SELinux and Smack on the same
> machine at the same time. While there are a number
> of interactions that I can explain, I have one that
> is perplexing me. I assume something rational is
> going on, but I am having trouble tracking it down.
> 
> A process with CAP_MAC_ADMIN can change its Smack label
> by writing the new label to /proc/self/attr/smack/current.*
> If I have both SELinux and Smack enabled the write fails
> with -EPERM, indicating that the process lacks CAP_MAC_ADMIN.
> Instrumenting the Smack code verifies that, even though the
> process reports having CAP_MAC_ADMIN, the capability is gone
> in smack_setprocattr().
> 
> It seem that this could be happening in the write() path,
> or perhaps an artifact of SELinux not knowing something
> special about smackfs. I don't see anything obvious.
> Unfortunately, it is going to be somewhat difficult for
> me to claim that I have SELinux and Smack working, if not
> together, at least begrudgingly on the same system.
> 
> ----
> * The smack subdir of attr isn't upstream yet, but I hope
> ? to get it there real soon.

Since smack_privileged() calls capable() rather than cap_capable(), the
CAP_MAC_ADMIN check will trigger a check by all enabled security
modules, including SELinux.  SELinux will then apply a check against
policy as to whether the current process is allowed mac_admin
permission.  This is only allowed to a handful of domains (not even
unconfined_t) because to SELinux, CAP_MAC_ADMIN means the ability to
set or get a raw, uninterpreted security context that may be unknown to
the currently loaded security policy.

I suspect that smack_privileged() should call cap_capable() instead.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
