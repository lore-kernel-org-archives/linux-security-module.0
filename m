From: ktkhai@virtuozzo.com (Kirill Tkhai)
Date: Thu, 29 Mar 2018 19:21:20 +0300
Subject: [PATCH net-next 5/5] net: Remove rtnl_lock() in
	nf_ct_iterate_destroy()
In-Reply-To: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
References: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
Message-ID: <152234048028.19153.843006403471156320.stgit@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

rtnl_lock() doesn't protect net::ct::count,
and it's not needed for__nf_ct_unconfirmed_destroy()
and for nf_queue_nf_hook_drop().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 net/netfilter/nf_conntrack_core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 370f9b7f051b..41ff04ee2554 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1763,7 +1763,6 @@ nf_ct_iterate_destroy(int (*iter)(struct nf_conn *i, void *data), void *data)
 {
 	struct net *net;
 
-	rtnl_lock();
 	down_read(&net_rwsem);
 	for_each_net(net) {
 		if (atomic_read(&net->ct.count) == 0)
@@ -1772,7 +1771,6 @@ nf_ct_iterate_destroy(int (*iter)(struct nf_conn *i, void *data), void *data)
 		nf_queue_nf_hook_drop(net);
 	}
 	up_read(&net_rwsem);
-	rtnl_unlock();
 
 	/* Need to wait for netns cleanup worker to finish, if its
 	 * running -- it might have deleted a net namespace from

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
