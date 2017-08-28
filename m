From: geliangtang@gmail.com (Geliang Tang)
Date: Mon, 28 Aug 2017 21:58:58 +0800
Subject: [PATCH] lsm_audit: use get_task_comm
Message-ID: <304ab87b276f87462fbeaccacb9dc1e02300df75.1502451616.git.geliangtang@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

get_task_comm() copys the task's comm under the task_lock, it's safer
than directly using memcpy().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 security/lsm_audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 28d4c3a..555b1c4 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -221,7 +221,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
@@ -312,7 +312,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
-				    memcpy(comm, tsk->comm, sizeof(comm)));
+				    get_task_comm(comm, tsk));
 			}
 		}
 		break;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
