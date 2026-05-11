Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC661BD9D0
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459189; cv=none; b=lAlIxw6ffTDpPYqSkcUOF59+q7i1J52D16SETat2yuwlX23OsSdJCDy886U/oP0W4FnQ3sXTqzdEDsYILToN2j7O9RgzGOVvk5InKfsQL78e91LfTGrOYyrUVx0zRbooO8CEYpaz+IdDF5IVJhCoxzttkuNpWVUM4JOWzwMwOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459189; c=relaxed/simple;
	bh=HHGfQno/UCVi95/j7POsermtpEcJBAfSS76g/Tckooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnbTPKmKRvof0YeHfqm8bgCMflgmnm6VFYZJ1rN2+lHg1fKPGP7Gg0uGAfSCu3cXb9l+OFdX7Sq/9BuQ+cjwLsoC2Yc2k/i/t9dK6SqI/uWEL4+jtiIr0nTHDwGaDH1GQQtKQRBJ/XKI0M5oCAzrmIQ2ttYRcW9lOuPTIhT9zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=dKkaXsfa; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="dKkaXsfa"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1778458638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Voqs+D/YxK+2FppjCEsG0gdSqgatbUbn4dzi7srOrb4=;
	b=dKkaXsfaAsaiXLBOjPRKSEnwaDOehPUuhQO681G5Dt6Lc1/yCMpNJpCQluYdOedHL9YjUt
	L27h2kUYwXHzDr+C04E3vNcjyV1zPYZPNN1r3nNMZ6Wn8RUrwC1PvIkmoYT5xWq4OXiemM
	ZH8iF4bhxe7lCU2zbLDjq9ROk/uskc0=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] smack: fix incorrect task context in smack_msg_queue_msgrcv
Date: Mon, 11 May 2026 03:17:16 +0300
Message-ID: <20260511001717.3522345-2-andreev@swemel.ru>
In-Reply-To: <20260511001717.3522345-1-andreev@swemel.ru>
References: <20260511001717.3522345-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The smack_msg_queue_msgrcv() function incorrectly checks
the permissions of the 'current' task instead of the
'target' task.

In the msgsnd() syscall path, if a receiver is already waiting,
the pipelined_send() optimization is used to push the message
directly to the receiver task:

    ipc/msg.c`pipelined_send():
    ` smp_store_release(&msr->r_msg, msg)

In this case, the 'sender' (current) task performs the check
on behalf of the 'receiver' task (msr->r_tsk, passed as the
'target' parameter):

  ipc/msg.c`pipelined_send():
  ` security_msg_queue_msgrcv(,, target := msr->r_tsk,,)

However, smack_msg_queue_msgrcv() ignores the 'target' and
checks 'current':

  smack_msg_queue_msgrcv(…)
  ` smk_curacc_msq(isp, MAY_READWRITE); // current task

'current' MAY satisfy smack_msg_queue_msgrcv r/w requirement,
but 'target' (the receiver task) might NOT;
as a result, an unauthorized receiver gets the message,
violating MAC policy.

Test:
1) create a sysv message queue with label “foo”
2) echo "bar foo r" >/smack/load2
3) msgrcv(,,,0,MSG_NOERROR) in "bar"-labeled task.
    The task is waiting for the messages ...
4) msgsnd() from a "foo"-labeled task:
"bar"-labeled task gets the message.

This patch fixes the issue by checking permission on the
'target' task instead of 'current'.

(2008-02-04, Casey Schaufler)
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 65 +++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f4ef840b203e..3146fa83c2f1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -130,12 +130,13 @@ static int smk_bu_note(char *note, struct smack_known *sskp,
 #define smk_bu_note(note, sskp, oskp, mode, RC) (RC)
 #endif
 
-#ifdef CONFIG_SECURITY_SMACK_BRINGUP
-static int smk_bu_current(char *note, struct smack_known *oskp,
-			  int mode, int rc)
+static int
+smk_bu_tsk_to_obj(struct task_struct *tsk, const struct task_smack *tsp,
+		  char *note, struct smack_known *oskp, int mode, int rc)
 {
-	struct task_smack *tsp = smack_cred(current_cred());
+#ifdef CONFIG_SECURITY_SMACK_BRINGUP
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
+	char comm[TASK_COMM_LEN];
 
 	if (rc <= 0)
 		return rc;
@@ -143,14 +144,22 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
 		rc = 0;
 
 	smk_bu_mode(mode, acc);
+
 	pr_info("Smack %s: (%s %s %s) %s %s\n", smk_bu_mess[rc],
-		tsp->smk_task->smk_known, oskp->smk_known,
-		acc, current->comm, note);
+		smk_of_task(tsp)->smk_known, oskp->smk_known,
+		acc, get_task_comm(comm, tsk), note);
 	return 0;
-}
 #else
-#define smk_bu_current(note, oskp, mode, RC) (RC)
+	return rc;
 #endif
+}
+
+static int smk_bu_current(char *note, struct smack_known *oskp,
+			  int mode, int rc)
+{
+	return smk_bu_tsk_to_obj(current, smack_cred(current_cred()),
+				 note, oskp, mode, rc);
+}
 
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_task(struct task_struct *otp, int mode, int rc)
@@ -3353,14 +3362,20 @@ static int smack_sem_semop(struct kern_ipc_perm *isp, struct sembuf *sops,
 }
 
 /**
- * smk_curacc_msq : helper to check if current has access on msq
- * @isp : the msq
+ * smk_tskacc_msq : helper to check if tsk has access on msq
+ * @tsk: the task that requests access
+ * @isp : the sysv msg queue permissions
  * @access : access requested
  *
- * return 0 if current has access, error otherwise
+ * return 0 if tsk has access, error otherwise
  */
-static int smk_curacc_msq(struct kern_ipc_perm *isp, int access)
+static int
+smk_tskacc_msq(struct task_struct *tsk, struct kern_ipc_perm *isp, int access)
 {
+	const bool tsk_is_current = (tsk == current);
+	const struct cred * const tsk_cred =
+			(tsk_is_current ? current_cred() : get_task_cred(tsk));
+	struct task_smack * const tsp = smack_cred(tsk_cred);
 	struct smack_known *msp = smack_of_ipc(isp);
 	struct smk_audit_info ad;
 	int rc;
@@ -3369,11 +3384,25 @@ static int smk_curacc_msq(struct kern_ipc_perm *isp, int access)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
 	ad.a.u.ipc_id = isp->id;
 #endif
-	rc = smk_curacc(msp, access, &ad);
-	rc = smk_bu_current("msq", msp, access, rc);
+	rc = smk_tskacc(tsp, msp, access, &ad);
+	rc = smk_bu_tsk_to_obj(tsk, tsp, "msq", msp, access, rc);
+	if (!tsk_is_current)
+		put_cred(tsk_cred);
 	return rc;
 }
 
+/**
+ * smk_curacc_msq : helper to check if current has access on msq
+ * @isp : the sysv msg queue permissions
+ * @access : access requested
+ *
+ * return 0 if current has access, error otherwise
+ */
+static int smk_curacc_msq(struct kern_ipc_perm *isp, int access)
+{
+	return smk_tskacc_msq(current, isp, access);
+}
+
 /**
  * smack_msg_queue_associate - Smack access check for msg_queue
  * @isp: the object
@@ -3441,21 +3470,21 @@ static int smack_msg_queue_msgsnd(struct kern_ipc_perm *isp, struct msg_msg *msg
 }
 
 /**
- * smack_msg_queue_msgrcv - Smack access check for msg_queue
+ * smack_msg_queue_msgrcv - check it target has r/w access to msg_queue
  * @isp: the object
  * @msg: unused
- * @target: unused
+ * @target: the task that msgrcv() from the queue
  * @type: unused
  * @mode: unused
  *
- * Returns 0 if current has read and write access, error code otherwise
+ * Returns 0 if target has read and write access, error code otherwise
  */
 static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp,
 				  struct msg_msg *msg,
 				  struct task_struct *target, long type,
 				  int mode)
 {
-	return smk_curacc_msq(isp, MAY_READWRITE);
+	return smk_tskacc_msq(target, isp, MAY_READWRITE);
 }
 
 /**
-- 
2.47.3

