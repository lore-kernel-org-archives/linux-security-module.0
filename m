From: pmoore@redhat.com (Paul Moore)
Date: Tue, 06 Mar 2018 17:27:44 -0500
Subject: [PATCH] net: don't unnecessarily load kernel modules in dev_ioctl()
Message-ID: <152037526427.18953.14013300464173153064.stgit@chester>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Starting with v4.16-rc1 we've been seeing a higher than usual number
of requests for the kernel to load networking modules, even on events
which shouldn't trigger a module load (e.g. ioctl(TCGETS)).  Stephen
Smalley suggested the problem may lie in commit 44c02a2c3dc5
("dev_ioctl(): move copyin/copyout to callers") which moves changes
the network dev_ioctl() function to always call dev_load(),
regardless of the requested ioctl.

This patch moves the dev_load() calls back into the individual ioctls
while preserving the rest of the original patch.

Reported-by: Dominick Grift <dac.override@gmail.com>
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/core/dev_ioctl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 0ab1af04296c..a04e1e88bf3a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -402,8 +402,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	if (colon)
 		*colon = 0;
 
-	dev_load(net, ifr->ifr_name);
-
 	/*
 	 *	See which interface the caller is talking about.
 	 */
@@ -423,6 +421,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	case SIOCGIFMAP:
 	case SIOCGIFINDEX:
 	case SIOCGIFTXQLEN:
+		dev_load(net, ifr->ifr_name);
 		rcu_read_lock();
 		ret = dev_ifsioc_locked(net, ifr, cmd);
 		rcu_read_unlock();
@@ -431,6 +430,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		return ret;
 
 	case SIOCETHTOOL:
+		dev_load(net, ifr->ifr_name);
 		rtnl_lock();
 		ret = dev_ethtool(net, ifr);
 		rtnl_unlock();
@@ -447,6 +447,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSIFNAME:
+		dev_load(net, ifr->ifr_name);
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		rtnl_lock();
@@ -494,6 +495,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		/* fall through */
 	case SIOCBONDSLAVEINFOQUERY:
 	case SIOCBONDINFOQUERY:
+		dev_load(net, ifr->ifr_name);
 		rtnl_lock();
 		ret = dev_ifsioc(net, ifr, cmd);
 		rtnl_unlock();
@@ -518,6 +520,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		    cmd == SIOCGHWTSTAMP ||
 		    (cmd >= SIOCDEVPRIVATE &&
 		     cmd <= SIOCDEVPRIVATE + 15)) {
+			dev_load(net, ifr->ifr_name);
 			rtnl_lock();
 			ret = dev_ifsioc(net, ifr, cmd);
 			rtnl_unlock();

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
