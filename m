From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 26 Jul 2017 14:31:08 -0400
Subject: [PATCH] security: fix description of values returned by
	cap_inode_need_killpriv
Message-ID: <1501093868-30838-1-git-send-email-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cap_inode_need_killpriv returns 1 if security.capability exists,
0 otherwise. Fix the description of the return value to reflect this.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/commoncap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd7..92931f8 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -302,8 +302,7 @@ static inline void bprm_clear_caps(struct linux_binprm *bprm)
  * affects the security markings on that inode, and if it is, should
  * inode_killpriv() be invoked or the change rejected?
  *
- * Returns 0 if granted; +ve if granted, but inode_killpriv() is required; and
- * -ve to deny the change.
+ * Returns 1 if security.capability has a value, 0 otherwise.
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
