From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 10 May 2018 17:55:06 -0700
Subject: [PATCH 15/23] LSM: Mark security blob allocation failures as unlikely
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Message-ID: <2e03ca7d-35b7-4af0-a328-ad280a59f001@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:33:57 -0700
Subject: [PATCH 15/23] LSM: Mark security blob allocation failures as unlikely

The allocation of security blobs is unlikely to fail.
Mark the checks thus for performance reasons.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 359ed1137c00..412dba75da65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1245,7 +1245,7 @@ int security_file_alloc(struct file *file)
 {
 	int rc = lsm_file_alloc(file);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(file_alloc_security, 0, file);
 	if (unlikely(rc))
@@ -1368,7 +1368,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
@@ -1388,7 +1388,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(cred, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
@@ -1409,7 +1409,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
