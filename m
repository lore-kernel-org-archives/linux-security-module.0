From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 29 Aug 2017 14:03:57 -0700
Subject: [PATCH 10/11] LSM: Complete task_alloc hook
In-Reply-To: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
Message-ID: <31d9d21d-8261-a061-a010-d5fb4b3e341e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 10/11] LSM: Complete task_alloc hook

The Task alloc hook needs to allocate the data.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/security.c b/security/security.c
index 6ebcc89004ef..a66663ac932b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1387,6 +1387,10 @@ int security_file_open(struct file *file, const struct cred *cred)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		return rc;
 	return call_int_hook(task_alloc, 0, task, clone_flags);
 }
 
-- 
2.13.0


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
