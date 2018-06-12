From: peter.enderborg@sony.com (Peter Enderborg)
Date: Tue, 12 Jun 2018 10:09:11 +0200
Subject: [PATCH 12/13] selinux: Cleanup printk logging in avc
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
Message-ID: <20180612080912.7827-13-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f3aedf077509..635e5c1e3e48 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -650,7 +650,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
 		if (seqno < avc->avc_cache.latest_notif) {
-			printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
+			pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
 			       seqno, avc->avc_cache.latest_notif);
 			ret = -EAGAIN;
 		}
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
