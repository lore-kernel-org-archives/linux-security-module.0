From: jmorris@namei.org (James Morris)
Date: Mon, 25 Sep 2017 15:58:51 +1000 (AEST)
Subject: Sync to v4.14-rc2
Message-ID: <alpine.LRH.2.21.1709251548070.3093@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Folks, I've synced the next-general branch of 

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 

to v4.14-rc2.

Please track and post against the new 'next-general' branch, which 
replaces the 'next' branch.  This is part of providing branches for 
security subsystems if he wishes to pull them independently, as well as 
maintaining a combined branch for testing and development purposes.

See:

http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003160.html
and
http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003356.html


I'll document this in more detail later in the week, but note that your 
worklfow does not not change except for using 'next-general' in place of 
'next'.




- James
-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
