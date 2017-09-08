From: jmorris@namei.org (James Morris)
Date: Sat, 9 Sep 2017 08:09:01 +1000 (AEST)
Subject: [PATCH] usb,signal,security: only pass the cred, not the secid,
	to kill_pid_info_as_cred and security_task_kill
In-Reply-To: <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
	<CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1709090808200.15026@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 8 Sep 2017, Paul Moore wrote:

> Looks fine to me from a SELinux perspective.  If Casey and John are
> happy with this I can volunteer to pull it into the selinux/next tree
> (once the merge window closes), otherwise if someone else wants to
> merge this my ack is below.
> 

As this impacts multiple LSMs, I'd prefer to take it via my tree.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
