From: ktkhai@virtuozzo.com (Kirill Tkhai)
Date: Thu, 29 Mar 2018 19:20:23 +0300
Subject: [PATCH net-next 0/5] Introduce net_rwsem to protect net_namespace_list
Message-ID: <152234005959.19153.17907173734141707348.stgit@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The series introduces fine grained rw_semaphore, which will be used
instead of rtnl_lock() to protect net_namespace_list.

This improves scalability and allows to do non-exclusive sleepable
iteration for_each_net(), which is enough for most cases.

scripts/get_maintainer.pl gives enormous list of people, and I add
all to CC.

Note, that this patch is independent of "Close race between
{un, }register_netdevice_notifier and pernet_operations":
https://patchwork.ozlabs.org/project/netdev/list/?series=36495

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---

Kirill Tkhai (5):
      net: Introduce net_rwsem to protect net_namespace_list
      net: Don't take rtnl_lock() in wireless_nlevent_flush()
      security: Remove rtnl_lock() in selinux_xfrm_notify_policyload()
      ovs: Remove rtnl_lock() from ovs_exit_net()
      net: Remove rtnl_lock() in nf_ct_iterate_destroy()


 drivers/infiniband/core/roce_gid_mgmt.c |    2 ++
 include/linux/rtnetlink.h               |    1 +
 include/net/net_namespace.h             |    1 +
 net/core/dev.c                          |    5 +++++
 net/core/fib_notifier.c                 |    2 ++
 net/core/net_namespace.c                |   18 +++++++++++++-----
 net/core/rtnetlink.c                    |    5 +++++
 net/netfilter/nf_conntrack_core.c       |    4 ++--
 net/openvswitch/datapath.c              |    4 ++--
 net/wireless/wext-core.c                |    6 ++----
 security/selinux/include/xfrm.h         |    4 ++--
 11 files changed, 37 insertions(+), 15 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
