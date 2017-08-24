From: colin.king@canonical.com (Colin King)
Date: Thu, 24 Aug 2017 09:31:45 +0100
Subject: [PATCH] apparmor: fix spelling mistake: "resoure" -> "resource"
Message-ID: <20170824083145.18799-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in comment and also with text in
audit_resource call.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index d8bc842594ed..cf4d234febe9 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -47,7 +47,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
 /**
  * audit_resource - audit setting resource limit
  * @profile: profile being enforced  (NOT NULL)
- * @resoure: rlimit being auditing
+ * @resource: rlimit being auditing
  * @value: value being set
  * @error: error value
  *
@@ -128,7 +128,7 @@ int aa_task_setrlimit(struct aa_label *label, struct task_struct *task,
 		error = fn_for_each(label, profile,
 				audit_resource(profile, resource,
 					       new_rlim->rlim_max, peer,
-					       "cap_sys_resoure", -EACCES));
+					       "cap_sys_resource", -EACCES));
 	else
 		error = fn_for_each_confined(label, profile,
 				profile_setrlimit(profile, resource, new_rlim));
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
