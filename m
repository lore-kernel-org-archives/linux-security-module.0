Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FD198823
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459814; cv=none; b=SYw4eYvoetVx7AuGirV2WYP6Wq1RStIAmxIiw2PB4hpbE6gatUaL5MkgpfsIoU9MPK0H2nfy3Th6KAewOsptlMl7Zql+7UJJbaHnnu6v/0YCbJ+TiYsZlJoI6BOMPC0xLQe3ONZsdk7MtXAbwCrPjAAbfluLGKuiZe9MjoyYYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459814; c=relaxed/simple;
	bh=cpV6J7vFv8QlFZY9S6XFDG63kp4XExRkTYYnDCOW2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOPjFKFipcJUboythx4H97MzazNSz0RFoh+FvtW1af9DQ+wAcSEo9CBpimhd6G4w7w72zXuA/uv1jxMoCOPIYikprQRJ+hiasV9Mhr03vX9j100P4TuapXQj0hYSgj7yhA51rOS7/TvAN3K1fsfmh5zwUmqnh+yhzIG1vwGmkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ts51/geC; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ts51/geC"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsg6DYgzS6w;
	Sat,  8 Mar 2025 19:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459495;
	bh=v7zxGlR9p2Vk6aOhQ+9hHdnseZZyVA7sQx36u2Dx7Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts51/geCAI90y4KlErY52fZVtW5rS8byJpifQ7ixm9wf9grvtX2gUw3HcgdeM4EsU
	 UVXTvKtmLIecvxi2aJIec4JfZU9UfwtFy2xSz2YbKqKb9cFcaASrpCmgYOXF1yD1hP
	 E7XTo20BVmZYCMDAVgIv2JwuEBWWsRc/OCfSAP7E=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsf6tT7zGbL;
	Sat,  8 Mar 2025 19:44:54 +0100 (CET)
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
Subject: [PATCH v6 15/26] landlock: Log scoped denials
Date: Sat,  8 Mar 2025 19:44:11 +0100
Message-ID: <20250308184422.2159360-16-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250308184422.2159360-16-mic@digikod.net
---

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
 security/landlock/fs.c    |  7 +++-
 security/landlock/fs.h    | 14 +++++++
 security/landlock/task.c  | 79 +++++++++++++++++++++++++++++++--------
 5 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 6c34758b9ff2..d0eafb946f31 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -71,6 +71,14 @@ get_blocker(const enum landlock_request_type type,
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
index eeff2c5bfa4f..aaf21b31baa8 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -20,6 +20,8 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
 	LANDLOCK_REQUEST_FS_ACCESS,
 	LANDLOCK_REQUEST_NET_ACCESS,
+	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 };
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 14f9c6d9903f..34f316031ecf 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1798,6 +1798,7 @@ static void hook_file_set_fowner(struct file *file)
 	const struct landlock_cred_security *new_subject;
 	struct landlock_cred_security *fown_subject;
 	struct landlock_ruleset *prev_dom;
+	size_t handle_layer;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
@@ -1807,15 +1808,17 @@ static void hook_file_set_fowner(struct file *file)
 
 	fown_subject = &landlock_file(file)->fown_subject;
 	prev_dom = fown_subject->domain;
-	new_subject = landlock_get_applicable_subject(current_cred(),
-						      signal_scope, NULL);
+	new_subject = landlock_get_applicable_subject(
+		current_cred(), signal_scope, &handle_layer);
 	if (new_subject) {
 		landlock_get_ruleset(new_subject->domain);
 		*fown_subject = *new_subject;
+		landlock_file(file)->fown_layer = handle_layer;
 	} else {
 		static const struct landlock_cred_security empty = {};
 
 		*fown_subject = empty;
+		landlock_file(file)->fown_layer = 0;
 	}
 
 	/* Called in an RCU read-side critical section. */
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 3a09ba985b74..a2a2014d68ae 100644
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
@@ -73,6 +79,14 @@ struct landlock_file_security {
 	struct landlock_cred_security fown_subject;
 };
 
+#ifdef CONFIG_AUDIT
+
+/* Makes sure all layers can be identified. */
+static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
+	      LANDLOCK_MAX_NUM_LAYERS);
+
+#endif /* CONFIG_AUDIT */
+
 /**
  * struct landlock_superblock_security - Superblock security blob
  *
diff --git a/security/landlock/task.c b/security/landlock/task.c
index e8a0b4ead381..f6359cf4c11b 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -264,26 +264,41 @@ static int hook_unix_stream_connect(struct sock *const sock,
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
@@ -295,11 +310,23 @@ static int hook_unix_may_send(struct socket *const sock,
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
@@ -311,13 +338,15 @@ static int hook_task_kill(struct task_struct *const p,
 			  const struct cred *cred)
 {
 	bool is_scoped;
+	size_t handle_layer;
 	const struct landlock_cred_security *subject;
 
 	if (!cred)
 		/* Not dealing with USB IO. */
 		cred = current_cred();
 
-	subject = landlock_get_applicable_subject(cred, signal_scope, NULL);
+	subject = landlock_get_applicable_subject(cred, signal_scope,
+						  &handle_layer);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
@@ -329,10 +358,19 @@ static int hook_task_kill(struct task_struct *const p,
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
@@ -361,10 +399,19 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
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
+		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
+	});
+	return -EPERM;
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.48.1

