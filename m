From: jmorris@namei.org (James Morris)
Date: Thu, 26 Apr 2018 04:44:38 +1000 (AEST)
Subject: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Message-ID: <alpine.LRH.2.21.1804260443110.11568@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 23 Apr 2018, David Herrmann wrote:

> This patch series tries to close this gap and makes both behave the
> same. A new LSM-hook is added which allows LSMs to cache the correct
> peer information on newly created socket-pairs.

Looks okay to me.

Once it's respun with the Smack backend and maybe the hook name change, 
I'll merge this unless DaveM wants it to go in via his networking tree.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
