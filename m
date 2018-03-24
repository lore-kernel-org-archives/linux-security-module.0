From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 24 Mar 2018 00:40:36 -0500
Subject: [REVIEW][PATCH 12/11] ipc: Directly call the security hook in
	ipc_ops.associate
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Fri, 23 Mar 2018 14:11:23 -0500")
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
	<87vadzqqq6.fsf@xmission.com>
	<990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
	<877eqejowd.fsf@xmission.com>
	<3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
	<87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
Message-ID: <877eq2m3or.fsf_-_@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


After the last round of cleanups the shm, sem, and msg associate
operations just became trivial wrappers around the appropriate security
method.  Simplify things further by just calling the security method
directly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/msg.c | 10 +---------
 ipc/sem.c | 10 +---------
 ipc/shm.c | 10 +---------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 825ad585a6ff..d667dd8e97ab 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -272,20 +272,12 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 	ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 }
 
-/*
- * Called with msg_ids.rwsem and ipcp locked.
- */
-static inline int msg_security(struct kern_ipc_perm *ipcp, int msgflg)
-{
-	return security_msg_queue_associate(ipcp, msgflg);
-}
-
 SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
 {
 	struct ipc_namespace *ns;
 	static const struct ipc_ops msg_ops = {
 		.getnew = newque,
-		.associate = msg_security,
+		.associate = security_msg_queue_associate,
 	};
 	struct ipc_params msg_params;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 47b263960524..09d54af076a4 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -564,14 +564,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 }
 
 
-/*
- * Called with sem_ids.rwsem and ipcp locked.
- */
-static inline int sem_security(struct kern_ipc_perm *ipcp, int semflg)
-{
-	return security_sem_associate(ipcp, semflg);
-}
-
 /*
  * Called with sem_ids.rwsem and ipcp locked.
  */
@@ -592,7 +584,7 @@ SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
 	struct ipc_namespace *ns;
 	static const struct ipc_ops sem_ops = {
 		.getnew = newary,
-		.associate = sem_security,
+		.associate = security_sem_associate,
 		.more_checks = sem_more_checks,
 	};
 	struct ipc_params sem_params;
diff --git a/ipc/shm.c b/ipc/shm.c
index 932b7e411c6c..018db3d0e70e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -656,14 +656,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	return error;
 }
 
-/*
- * Called with shm_ids.rwsem and ipcp locked.
- */
-static inline int shm_security(struct kern_ipc_perm *ipcp, int shmflg)
-{
-	return security_shm_associate(ipcp, shmflg);
-}
-
 /*
  * Called with shm_ids.rwsem and ipcp locked.
  */
@@ -684,7 +676,7 @@ SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
 	struct ipc_namespace *ns;
 	static const struct ipc_ops shm_ops = {
 		.getnew = newseg,
-		.associate = shm_security,
+		.associate = security_shm_associate,
 		.more_checks = shm_more_checks,
 	};
 	struct ipc_params shm_params;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
