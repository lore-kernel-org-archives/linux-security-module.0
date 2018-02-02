From: peter.enderborg@sony.com (Peter Enderborg)
Date: Fri, 2 Feb 2018 15:16:40 +0100
Subject: [PATCH-selinuxns] selinux: Annotate lockdep for services locks
Message-ID: <20180202141640.4589-1-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The locks are moved to dynamic allocation, we need to
help the lockdep system to classify the locks.
This adds to lockdep annotation for the page mutex and
for the ss lock.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index abc5383..ba463c0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -70,6 +70,9 @@
 #include "ebitmap.h"
 #include "audit.h"
 
+static struct lock_class_key selinux_ss_class_key;
+static struct lock_class_key selinux_status_class_key;
+
 /* Policy capability names */
 char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"network_peer_controls",
@@ -88,7 +91,9 @@ int selinux_ss_create(struct selinux_ss **ss)
 	if (!newss)
 		return -ENOMEM;
 	rwlock_init(&newss->policy_rwlock);
+	lockdep_set_class(&newss->policy_rwlock, &selinux_ss_class_key);
 	mutex_init(&newss->status_lock);
+	lockdep_set_class(&newss->status_lock, &selinux_status_class_key);
 	*ss = newss;
 	return 0;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
