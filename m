From: davem@davemloft.net (David Miller)
Date: Fri, 04 May 2018 13:31:08 -0400 (EDT)
Subject: [PATCH v2 2/4] net: hook socketpair() into LSM
In-Reply-To: <20180504142822.15233-3-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
	<20180504142822.15233-3-dh.herrmann@gmail.com>
Message-ID: <20180504.133108.824679852510791586.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:20 +0200

> Use the newly created LSM-hook for socketpair(). The default hook
> return-value is 0, so behavior stays the same unless LSMs start using
> this hook.
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
