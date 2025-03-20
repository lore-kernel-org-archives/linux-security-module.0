Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA922C339
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497673; cv=none; b=QCEi150KmJD29SPrHEA6IqJFL5UE58wIyGG/bp0jJrI549JTsOpTEX+7znzF316XVFqBbEQZN60K2l0jDwa879+W6w6XaoRPujSTKPvG7I/lMjRQdaoJ79lL2kqs4fziqE2z/zE08J0pXVmpHzKAs7xNeRU99YHv0JEerHU/mQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497673; c=relaxed/simple;
	bh=h44dHkbnSKgTNdBTDJCMhwOTg8jE98L5rooXcErr/sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csu47ui2Xw0HRomIzy3cd6mLNmhhdYfVf9Nr8VObn3WRtHxNQgiWWTqJhuvX67PUQLOfELZGVzLJNIxfDh9QPMagmAHtUfeLsNZ5l3KaFWuPExWi1mUeNi4VSuCmIyTNwbTkfLJj+NbzCqFzYGDHEZ0k/D97tpbQqZsSUD8JByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=chSLplrl; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="chSLplrl"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpY60V3zHH3;
	Thu, 20 Mar 2025 20:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497669;
	bh=VdfxIDkLWyeaLlHcbA0lVYCFMXeslwqewX4K6HkHeHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chSLplrlg/xhEokvQsuZcLyxaFAvPrFqsGA0E+AUo7xaefOpk5t1D7lmvquyVEjfo
	 I3oNecuPg+P4ia+AnZEhR8pe9QjwfrQXMGZP1B6K3QbFtVRhmiEL54UzS459CDNnPx
	 QDbjB/G5FsFGyQyxkJI2jnhDquHBYutYzaj+hWJU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpX6GFxzYfY;
	Thu, 20 Mar 2025 20:07:48 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 16/28] landlock: Log scoped denials
Date: Thu, 20 Mar 2025 20:07:05 +0100
Message-ID: <20250320190717.2287696-17-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit support for unix_stream_connect, unix_may_send, task_kill, and
file_send_sigiotask hooks.

The related blockers are:
- scope.abstract_unix_socket
- scope.signal

Audit event sample for abstract unix socket:

  type=LANDLOCK_DENY msg=audit(1729738800.268:30): domain=195ba459b blockers=scope.abstract_unix_socket path=00666F6F

Audit event sample for signal:

  type=LANDLOCK_DENY msg=audit(1729738800.291:31): domain=195ba459b blockers=scope.signal opid=1 ocomm="systemd"

Refactor and simplify error handling in LSM hooks.

Extend struct landlock_file_security with fown_layer and use it to log
the blocking domain.  The struct aligned size is still 16 bytes.

Cc: Günther Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Fix missing ifdef CONFIG_AUDIT for fown_layer, spotted by kernel test
  robot.
- Update headers.

Changes since v5:
- Move request declarations in the landlock_log_denial() calls to
  not impact allowed requests with audit, and return as soon as
  possible when access is allowed.
- Store a fown_layer per file and use it to log the blocking domain.
- Refactor and simplify error handling in LSM hooks.

Changes since v4:
- Rebase on top of the landlock_log_denial() and subject type changes.

Changes since v3:
- Cosmetic change to the "scope.*" blocker names.
- Extend commit message.

Changes since v1:
- New patch.
---
 security/landlock/audit.c |  8 ++++
 security/landlock/audit.h |  2 +
 security/landlock/fs.c    |  8 +++-
 security/landlock/fs.h    | 16 ++++++++
 security/landlock/task.c  | 84 +++++++++++++++++++++++++++++++--------
 5 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 66ff9a5d9866..2dcc55ad451c 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -70,6 +70,14 @@ get_blocker(const enum landlock_request_type type,
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(net_access_strings)))
 			return "unknown";
 		return net_access_strings[access_bit];
+
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.abstract_unix_socket";
+
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.signal";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 486b4e7050d3..92428b7fc4d8 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -19,6 +19,8 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
 	LANDLOCK_REQUEST_FS_ACCESS,
 	LANDLOCK_REQUEST_NET_ACCESS,
+	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 9d7443ff67c7..36d06a8e2287 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1774,6 +1774,7 @@ static void hook_file_set_fowner(struct file *file)
 	struct landlock_ruleset *prev_dom;
 	struct task_struct *p;
 	struct landlock_cred_security fown_subject = {};
+	size_t fown_layer = 0;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
@@ -1791,8 +1792,8 @@ static void hook_file_set_fowner(struct file *file)
 			.scope = LANDLOCK_SCOPE_SIGNAL,
 		};
 		const struct landlock_cred_security *new_subject =
-			landlock_get_applicable_subject(current_cred(),
-							signal_scope, NULL);
+			landlock_get_applicable_subject(
+				current_cred(), signal_scope, &fown_layer);
 		if (new_subject) {
 			landlock_get_ruleset(new_subject->domain);
 			fown_subject = *new_subject;
@@ -1801,6 +1802,9 @@ static void hook_file_set_fowner(struct file *file)
 
 	prev_dom = landlock_file(file)->fown_subject.domain;
 	landlock_file(file)->fown_subject = fown_subject;
+#ifdef CONFIG_AUDIT
+	landlock_file(file)->fown_layer = fown_layer;
+#endif /* CONFIG_AUDIT*/
 
 	/* Called in an RCU read-side critical section. */
 	landlock_put_ruleset_deferred(prev_dom);
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 3a09ba985b74..294ca813c7f2 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -9,6 +9,7 @@
 #ifndef _SECURITY_LANDLOCK_FS_H
 #define _SECURITY_LANDLOCK_FS_H
 
+#include <linux/build_bug.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
@@ -61,6 +62,11 @@ struct landlock_file_security {
 	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
 	 */
 	deny_masks_t deny_masks;
+	/**
+	 * @fown_layer: Layer level of @fown_subject->domain with
+	 * LANDLOCK_SCOPE_SIGNAL.
+	 */
+	u8 fown_layer;
 #endif /* CONFIG_AUDIT */
 
 	/**
@@ -73,6 +79,16 @@ struct landlock_file_security {
 	struct landlock_cred_security fown_subject;
 };
 
+#ifdef CONFIG_AUDIT
+
+/* Makes sure all layers can be identified. */
+/* clang-format off */
+static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
+	      LANDLOCK_MAX_NUM_LAYERS);
+/* clang-format off */
+
+#endif /* CONFIG_AUDIT */
+
 /**
  * struct landlock_superblock_security - Superblock security blob
  *
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 60e2953d2c71..e95e4ebe724d 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Landlock LSM - Ptrace hooks
+ * Landlock - Ptrace hooks
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2019-2020 ANSSI
+ * Copyright © 2021-2025 Microsoft Corporation
  */
 
 #include <asm/current.h>
@@ -265,26 +266,41 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
+	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
-						NULL);
+						&handle_layer);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
 		return 0;
 
-	if (is_abstract_socket(other) && sock_is_scoped(other, subject->domain))
-		return -EPERM;
+	if (!is_abstract_socket(other))
+		return 0;
+
+	if (!sock_is_scoped(other, subject->domain))
+		return 0;
 
-	return 0;
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.audit = {
+			.type = LSM_AUDIT_DATA_NET,
+			.u.net = &(struct lsm_network_audit) {
+				.sk = other,
+			},
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	return -EPERM;
 }
 
 static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
+	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
-						NULL);
+						&handle_layer);
 
 	if (!subject)
 		return 0;
@@ -296,11 +312,23 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (is_abstract_socket(other->sk) &&
-	    sock_is_scoped(other->sk, subject->domain))
-		return -EPERM;
+	if (!is_abstract_socket(other->sk))
+		return 0;
+
+	if (!sock_is_scoped(other->sk, subject->domain))
+		return 0;
 
-	return 0;
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.audit = {
+			.type = LSM_AUDIT_DATA_NET,
+			.u.net = &(struct lsm_network_audit) {
+				.sk = other->sk,
+			},
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	return -EPERM;
 }
 
 static const struct access_masks signal_scope = {
@@ -312,6 +340,7 @@ static int hook_task_kill(struct task_struct *const p,
 			  const struct cred *cred)
 {
 	bool is_scoped;
+	size_t handle_layer;
 	const struct landlock_cred_security *subject;
 
 	if (!cred) {
@@ -330,7 +359,8 @@ static int hook_task_kill(struct task_struct *const p,
 		cred = current_cred();
 	}
 
-	subject = landlock_get_applicable_subject(cred, signal_scope, NULL);
+	subject = landlock_get_applicable_subject(cred, signal_scope,
+						  &handle_layer);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
@@ -342,10 +372,19 @@ static int hook_task_kill(struct task_struct *const p,
 					     landlock_get_task_domain(p),
 					     signal_scope.scope);
 	}
-	if (is_scoped)
-		return -EPERM;
 
-	return 0;
+	if (!is_scoped)
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = p,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	return -EPERM;
 }
 
 static int hook_file_send_sigiotask(struct task_struct *tsk,
@@ -374,10 +413,21 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 					     landlock_get_task_domain(tsk),
 					     signal_scope.scope);
 	}
-	if (is_scoped)
-		return -EPERM;
 
-	return 0;
+	if (!is_scoped)
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = tsk,
+		},
+#ifdef CONFIG_AUDIT
+		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
+#endif /* CONFIG_AUDIT */
+	});
+	return -EPERM;
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.49.0

