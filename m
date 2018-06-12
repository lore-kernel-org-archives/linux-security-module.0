From: peter.enderborg@sony.com (Peter Enderborg)
Date: Tue, 12 Jun 2018 10:09:07 +0200
Subject: [PATCH 08/13] selinux: Cleanup printk logging in netlink
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
Message-ID: <20180612080912.7827-9-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 828fb6a4e941..8a8a72507437 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -94,7 +94,7 @@ static void selnl_notify(int msgtype, void *data)
 out_kfree_skb:
 	kfree_skb(skb);
 oom:
-	printk(KERN_ERR "SELinux:  OOM in %s\n", __func__);
+	pr_err("SELinux:  OOM in %s\n", __func__);
 	goto out;
 }
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
