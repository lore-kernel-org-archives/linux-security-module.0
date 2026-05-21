Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CF379C3C
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379621; cv=none; b=m0uDNobS8ulXoGKVEFiYx70ZS5fLBdmFMFMdx39f66nV9f48djzSC2kGprXp8Iv/DqnHb1t5TKuFGYhxaUys+0j/ZLYQU6oEuLajQqeKQblVN2lO5Mgsq2iqG2kgI9h1Gkgo55Niw0c4Kftyx8sJPkMOG5CeTc/xA3OAbVyR0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379621; c=relaxed/simple;
	bh=iwHqNlu59dKcBPKAYuW+qb/FbKV8TP+BhgUbJNG7Rp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVcGc6U7gABhXnl8HXhzj9FgBWnx2fl/CzR7/Dx+qUOtjUzGbRWmKC0qoik977qWg6BQxrkBawDKo9vG5+EXG+xAO0CkDAkW6i0VxiZpQvfzStHo5etoN1Y3pI7dh0oNAz9HgrTTPafB2yGhP2SvXMJ4CjdpLbnJKt4HeyaLC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bni1kL5b; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bni1kL5b"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65eb226b1ceso720786d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379619; x=1779984419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2YZgtYzCdoH3fKo8nj+WDqK1O7vQH6P5gI76NRfGS4=;
        b=Bni1kL5bmaI8L88ufZr6vjtPuKIphtFaFs8dOM9xPtNqFdm3akWcV/50ThBBDgZckI
         YXh3e68GO7oLgA+iQQ0VD0+8raR9Sy5cDeTyVl1VI3/MFsrgYuh5PpYQRtJWsonCQReh
         UFxDFhFtVBEVG2cXzFky/eXL8Wsp28kMz78Fk6ad5LP/3kaCatgTL9EzDwItdyV7suuO
         OCG6NlFBDkBsK/w++zivuYOAWM2Wel5H9aJFbOq3QnSDnsdiESn8Hf8EjeTaxGQBXYGB
         CZV8/XPo3LxLIAE5k6+X/VE8uQaddXL11dH+5507+2+K9vhGApghgw9ATw3J7DHS88NE
         7F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379619; x=1779984419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2YZgtYzCdoH3fKo8nj+WDqK1O7vQH6P5gI76NRfGS4=;
        b=m1P+ZTbAorukyC8obfLHJCxWiHlAAVUFNmrffyr0fsMhtorDxgmczr1M0kPuw5VFas
         7vjr/O6uYlsqhBEjTVSyN8ZLB7qvDOIPC1Y/rHkBGrX134Oy1oWhHu4e6oAF8tYn5L34
         3IY/krXDwTVIq7Q+jMDFiqmDt2pLMcBPXE2mQSiRkXLvm556091/09pkNrzUcDyrAazj
         qA71RMhGVzyb61hZW1Q3npTJjicIDonHB3LecMQTLnjs55ondkZQiVoRPXYwAWgPHTUq
         IkfByZw4LIfpv1EqpnIMHRjWLQ074UnKodi/BoZl4Xx86IsQLcNKaulGddhHlgDzDMjk
         et8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Lra82xdR7DL71L3zJnhucX0ahbRTDMVXTEJMMaiEDWhyD1yEO0aOzBq9wF9n65TGWvD6wfRouheDxvc9HryKwb/ZKu/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgQOfV+HdJqGfRL58jozJRLVYFNYykciJnrl3kLGFlHhsJUwE
	nxPbOB5mBY7c40zC1eXqeO7cvj/aVHeS7QTAAh+S5s7O6pnTc7YbiOiJ
X-Gm-Gg: Acq92OEzurAr/Aw398LZlZh0qximruLQqPStLEw97Vl3uQCrD4aA5YdUpRikiT6nD6m
	ViwGnmDfSW8BmosErJvg4g5DophXAfCc2QPDDFQgrwCDt1lC4HGgBhQElSyXjxHWlAahMUOTClq
	imoRLWt3jeT1goW2S12U/KQbNZhGOTFbm5yJnP5Z11FOAauesV7Ki2mhvHdOdHu0Up6YJ69065s
	SaR+/uFxnSXkkRpk73x2HXxcmvmpLpkTiYfu0PkTuBbxIKYfhMMLhNN+/ezHGUD9EmlTsh+UhME
	mQeIEFQ3foDN2gbvrykoyVtHm8WEOeM57QuIdF/d5/RSUo0XEA3gHy+92oR/taBpd01bvmD4hfC
	WY7SIK9zrEozekTglvWXd5z+UFhEJjUl3JEN2XPp7lQkKqQfEfaOh7laSa9XdxV8OPMtacAZnq8
	ZZUgRwRBdbs+9qKDXgnVYSrG6Zizz5YY+ZAaP9jLtYOAEB0N8VTNuHYkPbEbNepJnH/8Cdhpg=
X-Received: by 2002:a05:690c:c531:b0:7c9:30f5:2054 with SMTP id 00721157ae682-7d20c9453b9mr38927037b3.40.1779379618563;
        Thu, 21 May 2026 09:06:58 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:06:58 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 2/6] landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Thu, 21 May 2026 12:06:36 -0400
Message-ID: <20260521160640.1716746-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new scoped access right LANDLOCK_SCOPE_SYSV_MSG_QUEUE for
controlling operations msgget, msgsnd, msgrcv, and msgctl on SysV
message queues.

Merely handling msgget is insufficient; SysV message queues do not
use FDs or process local handles, and the msqid associated with a
queue is valid within the IPC namespace.  There is no requirement
to perform a msgget to interact with a SysV message queue.

When a process enforces this scoping, access to SysV message queues
by a restricted process is only allowed if the queue was created by
a process in the same or a nested Landlock domain.

When a SysV message queue is allocated by a process in a Landlock
domain, the security blob for the kern_ipc_perm is updated to
reflect domain provenance and the blob is tagged as a message queue
via the new @kind enum.

The scope is enforced from the generic ipc_permission hook rather
than the per-call msg_queue_* hooks.  ipc_permission is the choke
point for msgget on an existing queue and for msgsnd / msgrcv /
msgctl(IPC_STAT, MSG_STAT, MSG_STAT_ANY).

ipc_permission also fires for semaphores and shared memory, so the
hook bails out when the blob's @kind is not LANDLOCK_SYSV_IPC_MSG_QUEUE.

msgctl_down() (IPC_RMID and IPC_SET) does not go through
ipc_permission, so msg_queue_msgctl is kept to cover those.  It
also guards against the IPC_INFO / MSG_INFO case where @msq is
NULL and there is no specific queue to scope.

Also update the scoped_test ACCESS_LAST sentinel to track the new
last scope so the unknown-scope selftest does not falsely accept
LANDLOCK_SCOPE_SYSV_MSG_QUEUE as unknown.

Audit records are generated for this scope on denials.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h                 |   3 +
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/task.c                      | 137 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 6 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..c879b345afa3 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -398,10 +398,13 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_SYSV_MSG_QUEUE: Restrict a sandboxed process from interacting
+ *   with a sysv msg queue created by a process outside the domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#define LANDLOCK_SCOPE_SYSV_MSG_QUEUE			(1ULL << 2)
 /* clang-format on*/
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8d0edf94037d..174ddf6bd42c 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -79,6 +79,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
+
+	case LANDLOCK_REQUEST_SCOPE_MSG_QUEUE:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.sysv_msg_queue";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 56778331b58c..cc5700adab5a 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_MSG_QUEUE,
 };
 
 /*
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b454ad73b15e..7b74bcd66470 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -27,7 +27,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SYSV_MSG_QUEUE
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 6d46042132ce..68ac46baa2a5 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -434,6 +434,138 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	return -EPERM;
 }
 
+static const struct access_masks sysv_msg_queue_scope = {
+	.scope = LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
+};
+
+/**
+ * hook_msg_queue_alloc_security - Record the creator's domain on a SysV msg
+ *				   queue
+ *
+ * @perm: IPC permission structure of the newly created message queue.
+ *
+ * Save a reference to the creating task's Landlock domain in the IPC security
+ * blob and tag the blob as belonging to a message queue so that the generic
+ * ipc_permission hook can distinguish msg queues from sem and shm objects.
+ *
+ * Return: 0 (allocation of the blob itself is handled by the LSM core).
+ */
+static int hook_msg_queue_alloc_security(struct kern_ipc_perm *const perm)
+{
+	struct landlock_kern_ipc_perm_security *const ipc_sec =
+		landlock_kern_ipc_perm(perm);
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(),
+						sysv_msg_queue_scope, NULL);
+
+	ipc_sec->kind = LANDLOCK_SYSV_IPC_MSG_QUEUE;
+
+	/*
+	 * The blob is zero-allocated by the LSM core, so owner_subject.domain
+	 * is already NULL for an unsandboxed creator.
+	 */
+	if (!subject)
+		return 0;
+
+	landlock_get_ruleset(subject->domain);
+	ipc_sec->owner_subject = *subject;
+	return 0;
+}
+
+/**
+ * hook_msg_queue_free_security - Release the creator's domain reference
+ *
+ * @perm: IPC permission structure of the message queue being destroyed.
+ *
+ * The IPC security blob itself is freed by the LSM core.
+ */
+static void hook_msg_queue_free_security(struct kern_ipc_perm *const perm)
+{
+	struct landlock_kern_ipc_perm_security *const ipc_sec =
+		landlock_kern_ipc_perm(perm);
+
+	/* May be called from an RCU callback (msg_rcu_free()). */
+	landlock_put_ruleset_deferred(ipc_sec->owner_subject.domain);
+}
+
+/**
+ * hook_ipc_permission - Enforce SysV msg queue scoping on the current task
+ *
+ * @ipcp: IPC permission structure of the object being accessed.
+ * @flag: Requested mode bits (unused; same value for every msg queue access).
+ *
+ * The ipc_permission hook is the choke point for msgget on an existing queue
+ * and for msgsnd / msgrcv / msgctl(IPC_STAT, MSG_STAT, MSG_STAT_ANY) before
+ * they touch any per-message state. Using the per-message msg_queue_msgrcv hook
+ * instead would not work: find_msg() silently skips messages for which the
+ * hook returns an error and turns the result into -EAGAIN / -ENOMSG.
+ *
+ * The hook fires for sem and shm objects as well; @kind is used to filter
+ * them out.
+ *
+ * Return: 0 if access is allowed, -EPERM if scoped out.
+ */
+static int hook_ipc_permission(struct kern_ipc_perm *const ipcp,
+			       const short flag)
+{
+	const struct landlock_kern_ipc_perm_security *const ipc_sec =
+		landlock_kern_ipc_perm(ipcp);
+	size_t handle_layer;
+	const struct landlock_cred_security *subject;
+
+	/* Don't worry about other IPC objects for now */
+	if (ipc_sec->kind != LANDLOCK_SYSV_IPC_MSG_QUEUE)
+		return 0;
+
+	subject = landlock_get_applicable_subject(current_cred(),
+						  sysv_msg_queue_scope,
+						  &handle_layer);
+	if (!subject)
+		return 0;
+
+	if (!domain_is_scoped(subject->domain, ipc_sec->owner_subject.domain,
+			      sysv_msg_queue_scope.scope))
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_MSG_QUEUE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_IPC,
+			.u.ipc_id = ipcp->key,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	/*
+	 * What error return here technically doesn't matter; it all gets
+	 * mapped into EACCES when it's non-zero. Return EACCES anyway for
+	 * consistency.
+	 */
+	return -EACCES;
+}
+
+/**
+ * hook_msg_queue_msgctl - Enforce scoping on msgctl(IPC_RMID, IPC_SET)
+ *
+ * @msq: IPC permission structure of the message queue, or NULL for
+ *	 namespace-wide commands (IPC_INFO, MSG_INFO).
+ * @cmd: msgctl command code (unused).
+ *
+ * msgctl_down() does not go through ipc_permission(), so this hook is
+ * needed to cover IPC_RMID and IPC_SET.  IPC_INFO and MSG_INFO are
+ * namespace-wide queries with no specific queue, so they are not in scope
+ * for SysV msg queue scoping.
+ *
+ * Return: 0 if access is allowed, -EPERM if scoped out.
+ */
+static int hook_msg_queue_msgctl(struct kern_ipc_perm *const msq, const int cmd)
+{
+	/* IPC_INFO and MSG_INFO are queue-less; nothing to scope. */
+	if (!msq)
+		return 0;
+
+	return hook_ipc_permission(msq, 0);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
@@ -443,6 +575,11 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(task_kill, hook_task_kill),
 	LSM_HOOK_INIT(file_send_sigiotask, hook_file_send_sigiotask),
+
+	LSM_HOOK_INIT(msg_queue_alloc_security, hook_msg_queue_alloc_security),
+	LSM_HOOK_INIT(msg_queue_free_security, hook_msg_queue_free_security),
+	LSM_HOOK_INIT(msg_queue_msgctl, hook_msg_queue_msgctl),
+	LSM_HOOK_INIT(ipc_permission, hook_ipc_permission),
 };
 
 __init void landlock_add_task_hooks(void)
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..6692ba0573e6 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-#define ACCESS_LAST LANDLOCK_SCOPE_SIGNAL
+#define ACCESS_LAST LANDLOCK_SCOPE_SYSV_MSG_QUEUE
 
 TEST(ruleset_with_unknown_scope)
 {
-- 
2.53.0

