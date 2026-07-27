Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E83F788F
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193730; cv=none; b=gF86S/tdiHBFZFCmEAB4/ZuXhqnZr+xLIEEs/B/BfYpalQY6ffq8/DrFlTPjWSgbrv/bVlpLFr1Lb+9cgPVtelSU5MgyQ18FiTOikW8f3HEB9E7XQQ0vwt/bfBsPYM7GEFwltLmWzHrsslbzZyW+D0VMn/b1uOcKx6e6JyTh0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193730; c=relaxed/simple;
	bh=pCVM8CbTV/89qEMSe1UdmpGCN1y7sO1/y/c5eyxKpt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKcyI+/Y/h+neh3xUWLk3aIt1orbLr3GHoScZqwagzVU6TRbQx80s4/10cW/nDJkVnJ06bwRqg8k7+bnk7vQR0igTgkh/vS1kaRRP0QgmHaylSQgEdyYQcZwcG9yeizoKITnLPN7s07wW4jkdLTbgBIwqwJ/JK4Q1ziqHE+0YiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csrJ7nrv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csrJ7nrv"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e9f7491ffso41443877b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193725; x=1785798525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3eY49UKYfC9mZVwPcmu6Qk3eUn9qxUqbKgCyIHE61Rc=;
        b=csrJ7nrv2mT5f/TkOxy+QxT3j+IWqfb4LR6oFuyLilvmcwT4PBL3qZBgI1h1MID+1c
         aqDNQyXR7qtK6ilnrepNv+ZTaAOgD+edH78tNGPgl55BKB+kQtnZWbQHP5bgvJtrdz6/
         eUB7vycRktfU5CglPLEsds1uzBi8t0jthQ+oAB/WdALd3Sz68hLhiCP4VUP6OaVIK6aM
         jGQ+JGxwiJkI3dOCEu4Xs4BG5a2hKjH/5nyveg1QGSxKfHW5RmDhVZKN0UnNcdwN/LJ8
         F8QaV033/yt7STeop0ofl4FR4xUdwmKM0dOWvdtqCHdLTvFLl/Lf5GjJoPPu0pmILg4y
         Xw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193725; x=1785798525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3eY49UKYfC9mZVwPcmu6Qk3eUn9qxUqbKgCyIHE61Rc=;
        b=JIKaHX2Y4nYgrOxIY0w+9L/iG1Ci3gajjtZPxveKYaHwjdlCj/MsXgAaQpoZop1zay
         qE3+7llXim4viX+1Ont4AjKk6WtvYQgZHWvLqzFDtS8q7VAYc+oPp7JMi45RHBK1j86D
         6fSJFi4b+ityGXBcQhet+YFgeRzPkvHAKY3fG+BWqQmDYPKe6TG7ug7fH9PB09EmnVDF
         sx2cDkhRlW1TZbn2d1BNzxGo8bA4SPRy97C6YTawMmm+b0evoaL1aJuNprKb6w4eDOAD
         ZxcWqQKOHo4Z1hN7ZulArKzpHj740czn1kowKTRGcRumHhvskQ/8DGy2kCu7l+Ab2gFL
         Posw==
X-Forwarded-Encrypted: i=1; AHgh+Rrw/1qnUyyYfVaD7EimkfBh9f5UHKK8bmijMqnl8cKY/1v1X4czMIQY9r1iuhNUHlkjr9PdRqL+RKPkcJH+WJpdkLhIR7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkwuOHyL6zTh2YIpMW/2DBv9FRIL/WuqZ6HJzD7nQtZ4P07cO
	SHUgDeDqAxK4QhUTzSTo+pCAesuHdHAclB+0Q7vh9A2dpehSdrToQ2jI
X-Gm-Gg: AR+sD12+DIsDkcqDXADMgWaU2s+T0IZSsw3kUynQTQjNwXUmHcZm2IuONtrvrRPEoXk
	Ktl6siSJTHnTXKPprGbKW1Q1UXabN+Bkk9+BRcFoc/DmxQMWa58AIxookT2+Q9SBY24uFiq36DN
	fRPGeuJmSe5/J/j553FTU1v7XbABJ8i0giH5ComOum3AKgyiFMopCpzPkHKU2SrY1fWx1gCyd+p
	un5Hsz2Cir4OCKCeY2zI9S9uDkXKJ5BotGcBS1Ds1RMxn3HPckAh5iV1ZLs59N7ZfG2Cl5A3eSB
	4j4n2FNp2z1vYFaii5+lYIRd1ZiUww+Uv2EyEO9Ktv3PzL7gbmhto7TYBLDvzM6kAuPf5zQM8vT
	ZHsJzqQdTBY99qlxEP74S9/T8x9jK6yU25qynhIeC4Di+eWo2Zxmz6Re7lY/RHEYLeBTjjnyeTB
	CD5iaEOP26zdq1g3oRya4aR9h3G2R71wIv1Bvg
X-Received: by 2002:a05:690c:38b:b0:81f:47b5:d930 with SMTP id 00721157ae682-81f939854bamr6948867b3.31.1785193725091;
        Mon, 27 Jul 2026 16:08:45 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:44 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 2/6] landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Mon, 27 Jul 2026 19:08:29 -0400
Message-ID: <20260727230833.138165-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
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
 include/uapi/linux/landlock.h                 |   4 +
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/task.c                      | 137 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 6 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 272f047df438..0b25e5b7acc7 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -487,10 +487,14 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_SYSV_MSG_QUEUE: Restrict a sandboxed process from
+ *   interacting with a System V message queue created by a process outside the
+ *   domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#define LANDLOCK_SCOPE_SYSV_MSG_QUEUE			(1ULL << 2)
 /* clang-format on*/
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 50536c568526..32a125fdb5a1 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -82,6 +82,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
+
+	case LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.sysv_msg_queue";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 620f8a24291d..f089f960ef17 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE,
 };
 
 /*
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 08d5f2f6d321..77b2f3ada1bd 100644
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
index 55522a601367..64c2d5dca2d6 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -453,6 +453,138 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	return -EPERM;
 }
 
+static const struct access_masks sysv_msg_queue_scope = {
+	.scope = LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
+};
+
+/**
+ * hook_msg_queue_alloc_security - Record the creator's domain on a msg queue
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
+ * Return: 0 if access is allowed, -EACCES if scoped out.
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
+		.type = LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_IPC,
+			.u.ipc_id = ipcp->key,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	/*
+	 * The precise error value does not reach user space through
+	 * ipcperms(): its callers map any non-zero return to -EACCES.
+	 * Return -EACCES anyway so that the msgctl_down() path (which
+	 * propagates the hook's return value as is) reports the same error.
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
+ * Return: 0 if access is allowed, -EACCES if scoped out.
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
@@ -462,6 +594,11 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 
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
2.54.0

