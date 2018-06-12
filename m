From: peter.enderborg@sony.com (Peter Enderborg)
Date: Tue, 12 Jun 2018 10:09:10 +0200
Subject: [PATCH 11/13] selinux: Cleanup printk logging in netif
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
Message-ID: <20180612080912.7827-12-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netif.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index ac65f7417413..8c738c189942 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -145,9 +145,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 
 	dev = dev_get_by_index(ns, ifindex);
 	if (unlikely(dev == NULL)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
-		       " invalid network interface (%d)\n", ifindex);
+		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
+			__func__, ifindex);
 		return -ENOENT;
 	}
 
@@ -177,10 +176,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
 	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
-		       " unable to determine network interface label (%d)\n",
-		       ifindex);
+		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
+			__func__, ifindex);
 		kfree(new);
 	}
 	return ret;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
