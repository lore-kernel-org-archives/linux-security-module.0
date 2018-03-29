From: ktkhai@virtuozzo.com (Kirill Tkhai)
Date: Thu, 29 Mar 2018 19:20:56 +0300
Subject: [PATCH net-next 3/5] security: Remove rtnl_lock() in
	selinux_xfrm_notify_policyload()
In-Reply-To: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
References: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
Message-ID: <152234045636.19153.4897050357891895124.stgit@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

rt_genid_bump_all() consists of ipv4 and ipv6 part.
ipv4 part is incrementing of net::ipv4::rt_genid,
and I see many places, where it's read without rtnl_lock().

ipv6 part calls __fib6_clean_all(), and it's also
called without rtnl_lock() in other places.

So, rtnl_lock() here was used to iterate net_namespace_list only,
and we can remove it.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 security/selinux/include/xfrm.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 31d66431be1e..a0b465316292 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -47,12 +47,10 @@ static inline void selinux_xfrm_notify_policyload(void)
 {
 	struct net *net;
 
-	rtnl_lock();
 	down_read(&net_rwsem);
 	for_each_net(net)
 		rt_genid_bump_all(net);
 	up_read(&net_rwsem);
-	rtnl_unlock();
 }
 #else
 static inline int selinux_xfrm_enabled(void)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
