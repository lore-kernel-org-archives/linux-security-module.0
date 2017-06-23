From: jmorris@namei.org (James Morris)
Date: Fri, 23 Jun 2017 12:09:39 +1000 (AEST)
Subject: [GIT PULL] SELinux patches for v4.13
In-Reply-To: <CAHC9VhQBMBgH16Lo8dFYvLZ5k3zhr0ENXThzTtY=WWtQSqxHmg@mail.gmail.com>
References: <CAHC9VhQBMBgH16Lo8dFYvLZ5k3zhr0ENXThzTtY=WWtQSqxHmg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1706231209230.17128@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 22 Jun 2017, Paul Moore wrote:

> Hi James,
> 
> While we're down to 21 patches for v4.13 (it was 31 for v4.12), the
> diffstat jumps up tremendously with over 2k of line changes.  Almost
> all of these changes are the SELinux/IB work done by Daniel Jurgens;
> some other noteworthy changes include a NFS v4.2 labeling fix, a new
> file:map permission, and reporting of policy capabilities on policy
> load.  As usual, everything passes the selinux-testsuite and merges
> cleanly with your current linux-security/next branch; please apply.
> 

Thanks, pulled to -next.

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
