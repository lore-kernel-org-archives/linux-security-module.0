From: davem@davemloft.net (David Miller)
Date: Wed, 25 Apr 2018 14:48:37 -0400 (EDT)
Subject: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
In-Reply-To: <alpine.LRH.2.21.1804260443110.11568@namei.org>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
	<alpine.LRH.2.21.1804260443110.11568@namei.org>
Message-ID: <20180425.144837.752183283641043903.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: James Morris <jmorris@namei.org>
Date: Thu, 26 Apr 2018 04:44:38 +1000 (AEST)

> On Mon, 23 Apr 2018, David Herrmann wrote:
> 
>> This patch series tries to close this gap and makes both behave the
>> same. A new LSM-hook is added which allows LSMs to cache the correct
>> peer information on newly created socket-pairs.
> 
> Looks okay to me.
> 
> Once it's respun with the Smack backend and maybe the hook name change, 
> I'll merge this unless DaveM wants it to go in via his networking tree.

No, feel free to take it via your tree James.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
