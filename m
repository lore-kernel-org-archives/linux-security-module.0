From: ktkhai@virtuozzo.com (Kirill Tkhai)
Date: Thu, 29 Mar 2018 19:21:09 +0300
Subject: [PATCH net-next 4/5] ovs: Remove rtnl_lock() from ovs_exit_net()
In-Reply-To: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
References: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
Message-ID: <152234046913.19153.5014546114733288472.stgit@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Here we iterate for_each_net() and removes
vport from alive net to the exiting net.

ovs_net::dps are protected by ovs_mutex(),
and the others, who change it (ovs_dp_cmd_new(),
__dp_destroy()) also take it.
The same with datapath::ports list.

So, we remove rtnl_lock() here.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 net/openvswitch/datapath.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 9746ee30a99b..015e24e08909 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2363,12 +2363,10 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
 
-	rtnl_lock();
 	down_read(&net_rwsem);
 	for_each_net(net)
 		list_vports_from_net(net, dnet, &head);
 	up_read(&net_rwsem);
-	rtnl_unlock();
 
 	/* Detach all vports from given namespace. */
 	list_for_each_entry_safe(vport, vport_next, &head, detach_list) {

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
