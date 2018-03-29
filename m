From: davem@davemloft.net (David Miller)
Date: Thu, 29 Mar 2018 13:48:14 -0400 (EDT)
Subject: [PATCH net-next 0/5] Introduce net_rwsem to protect
	net_namespace_list
In-Reply-To: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
References: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
Message-ID: <20180329.134814.2157489714350229877.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Thu, 29 Mar 2018 19:20:23 +0300

> The series introduces fine grained rw_semaphore, which will be used
> instead of rtnl_lock() to protect net_namespace_list.
> 
> This improves scalability and allows to do non-exclusive sleepable
> iteration for_each_net(), which is enough for most cases.
> 
> scripts/get_maintainer.pl gives enormous list of people, and I add
> all to CC.
> 
> Note, that this patch is independent of "Close race between
> {un, }register_netdevice_notifier and pernet_operations":
> https://patchwork.ozlabs.org/project/netdev/list/?series=36495
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Great stuff!

Series applied, thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
