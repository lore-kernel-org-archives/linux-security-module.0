From: jmorris@namei.org (James Morris)
Date: Fri, 1 Sep 2017 12:22:49 +1000 (AEST)
Subject: [GIT PULL] SELinux patches for v4.14
In-Reply-To: <CAHC9VhRCnJAHLA8o7t0kF4a=KtA-mrmr5=okLODvb4WEntPTrQ@mail.gmail.com>
References: <CAHC9VhRCnJAHLA8o7t0kF4a=KtA-mrmr5=okLODvb4WEntPTrQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1709011222340.6889@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 31 Aug 2017, Paul Moore wrote:

> Hi James,
> 
> A relatively quiet period for SELinux, 11 patches with only two/three
> having any substantive changes.  These noteworthy changes include
> another tweak to the NNP/nosuid handling, per-file labeling for
> cgroups, and an object class fix for AF_UNIX/SOCK_RAW sockets; the
> rest of the changes are minor tweaks or administrative updates
> (Stephen's email update explains the file explosion in the diffstat).
> Everything passes the selinux-testsuite and merged cleanly on top of
> the linux-security/next branch from earlier today.
> 
> Please apply.

Merged, thanks.

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
