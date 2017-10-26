From: james.l.morris@oracle.com (James Morris)
Date: Thu, 26 Oct 2017 21:20:47 +0200 (CEST)
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <29447.1509035858@warthog.procyon.org.uk>
References: <29447.1509035858@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1710262116270.27877@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Oct 2017, David Howells wrote:

> Hi James,
> 
> Can you pull this patchset into security/next please?
> 
> It adds kernel lockdown support for EFI secure boot.  Note that it doesn't yet
> cover:
> 
> 	bpf	- No agreement as to how
> 	ftrace	- Recently suggested, query sent to maintainer
> 	perf	- Not looked at yet.

How useful is this really if it's incomplete?

And I think it really needs more testing in -next.


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
