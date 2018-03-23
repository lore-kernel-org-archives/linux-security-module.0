From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Mar 2018 14:16:09 -0500
Subject: [REVIEW][PATCH 06/11] msg: Move struct msg_queue into ipc/msg.c
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
Message-ID: <20180323191614.32489-6-ebiederm@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

All of the users are now in ipc/msg.c so make the definition local to
that file to make code maintenance easier.  AKA to prevent rebuilding
the entire kernel when struct msg_queue changes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/msg.h | 18 ------------------
 ipc/msg.c           | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/msg.h b/include/linux/msg.h
index 0a7eefeee0d1..9a972a296b95 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -3,7 +3,6 @@
 #define _LINUX_MSG_H
 
 #include <linux/list.h>
-#include <linux/time64.h>
 #include <uapi/linux/msg.h>
 
 /* one msg_msg structure for each message */
@@ -16,21 +15,4 @@ struct msg_msg {
 	/* the actual message follows immediately */
 };
 
-/* one msq_queue structure for each present queue on the system */
-struct msg_queue {
-	struct kern_ipc_perm q_perm;
-	time64_t q_stime;		/* last msgsnd time */
-	time64_t q_rtime;		/* last msgrcv time */
-	time64_t q_ctime;		/* last change time */
-	unsigned long q_cbytes;		/* current number of bytes on queue */
-	unsigned long q_qnum;		/* number of messages in queue */
-	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
-
-	struct list_head q_messages;
-	struct list_head q_receivers;
-	struct list_head q_senders;
-} __randomize_layout;
-
 #endif /* _LINUX_MSG_H */
diff --git a/ipc/msg.c b/ipc/msg.c
index cdfab0825fce..af5a963306c4 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -43,6 +43,23 @@
 #include <linux/uaccess.h>
 #include "util.h"
 
+/* one msq_queue structure for each present queue on the system */
+struct msg_queue {
+	struct kern_ipc_perm q_perm;
+	time64_t q_stime;		/* last msgsnd time */
+	time64_t q_rtime;		/* last msgrcv time */
+	time64_t q_ctime;		/* last change time */
+	unsigned long q_cbytes;		/* current number of bytes on queue */
+	unsigned long q_qnum;		/* number of messages in queue */
+	unsigned long q_qbytes;		/* max number of bytes on queue */
+	pid_t q_lspid;			/* pid of last msgsnd */
+	pid_t q_lrpid;			/* last receive pid */
+
+	struct list_head q_messages;
+	struct list_head q_receivers;
+	struct list_head q_senders;
+} __randomize_layout;
+
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
 	struct list_head	r_list;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
