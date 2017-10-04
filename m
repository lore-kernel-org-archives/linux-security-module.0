From: jmorris@namei.org (James Morris)
Date: Thu, 5 Oct 2017 09:10:58 +1100 (AEDT)
Subject: [PATCH] fix security_release_secctx seems broken
In-Reply-To: <ff77bdc9-e642-113d-dbde-f4d0770fff00@yandex-team.ru>
References: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
	<c007fac4-4e2a-6076-513d-6f52f7133a2d@schaufler-ca.com>
	<ec271e46-07d3-78ba-e58d-3606b0889cbf@schaufler-ca.com>
	<alpine.LRH.2.21.1710041713160.19339@namei.org>
	<ff77bdc9-e642-113d-dbde-f4d0770fff00@yandex-team.ru>
Message-ID: <alpine.LRH.2.21.1710050910300.28944@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 4 Oct 2017, Konstantin Khlebnikov wrote:

> Just "getcap /bin/ping" is enough to tigger leak if file has capabilities.
> Selinux shouldn't be loaded because its release_secctx hook call kfree.

Ahh, makes sense.

> 
> But sometimes it takes some time for kmemleak to find leak. Presumably
> because stale poiner stays on stack which could be reused nowdays.

Thanks for finding this!


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
