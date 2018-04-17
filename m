From: jmorris@namei.org (James Morris)
Date: Tue, 17 Apr 2018 15:24:41 +1000 (AEST)
Subject: [PATCH] security: remove security_settime
In-Reply-To: <20180401084205.GA14512@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180401084205.GA14512@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <alpine.LRH.2.21.1804171524190.5681@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 1 Apr 2018, Sargun Dhillon wrote:

> security_settime was a wrapper around security_settime64. There are no more
> users of it. Therefore it can be removed. It was removed in:
> commit 4eb1bca17933 ("time: Use do_settimeofday64() internally")
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
