Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909D1F2C31
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341108; cv=none; b=Eo0QBVMnsXEaU6PY709gogAuapZHArOTI5QyltO7RObblFLmpQC+xhdXV0KjDVezgBBNboz6aPtOKxIBLVMh7qVaj+3kgnMoCNFaI0bmF2Ues0Avo7GsN2LGnnXyz10CaW3TXBh+/nP8Vnpm3tHdArXYpBPCjz0bBx80FGDmXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341108; c=relaxed/simple;
	bh=GJOkIPytQ55VoQJDNOBHOJDsTZ+3MdA+wfUMZs4hvmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqSqwlAn4PDRi7xuzT2c+KvGzLMsoAZT2W6Kwfau41JsD235A9tcAtZmoDQA2/ZNywQyqf85AfJEMG5G0/ZfK+JSac65keOiiP6qhpPP7mj/61JjPY+sv21r4GooCfZXdgN5U1xvaJhTyBL7qGaW4+Oi1CdFf70NKgnEX9QwABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ngf08eIN; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ngf08eIN"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cb3shLz17XF;
	Fri, 31 Jan 2025 17:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341103;
	bh=c4vTHQbueVUgihIu4p/N0eP3FBVSHRB9ztdMAGiPSyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ngf08eINnFJzTQvqYseqRvT3byoqhFBnyPVr6f7tAeUA9b3hNhQ09D9EuhwKHbWJq
	 fu40u5A5WXQ4x1HaKV7fZujjhvujyVaLdFI+ZtEVRc+uS1uw/Dnj0yxyZAB9/j/z6D
	 5SPTA8zcx0pkZyQCF6c1STRJazBRWwX2mb5bBqwY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cZ570lzYvS;
	Fri, 31 Jan 2025 17:31:42 +0100 (CET)
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 15/24] landlock: Log scoped denials
Date: Fri, 31 Jan 2025 17:30:50 +0100
Message-ID: <20250131163059.1139617-16-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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

Cc: Günther Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-16-mic@digikod.net
---

Changes since v4:
- Rebase on top of the landlock_log_denial() and subject type changes.

Changes since v3:
- Cosmetic change to the "scope.*" blocker names.
- Extend commit message.

Changes since v1:
- New patch.
---
 security/landlock/audit.c |  8 +++++
 security/landlock/audit.h |  2 ++
 security/landlock/task.c  | 66 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 9c856b31f9f6..fc4d1dfb5c25 100644
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
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 7b313a779de5..10bfba1994d0 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -264,16 +264,31 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
+	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
-						NULL);
+						&handle_layer);
+	struct lsm_network_audit audit_net = {
+		.sk = other,
+	};
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.audit = {
+			.type = LSM_AUDIT_DATA_NET,
+			.u.net = &audit_net,
+		},
+	};
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
 		return 0;
 
-	if (is_abstract_socket(other) && sock_is_scoped(other, subject->domain))
+	if (is_abstract_socket(other) &&
+	    sock_is_scoped(other, subject->domain)) {
+		request.layer_plus_one = handle_layer + 1;
+		landlock_log_denial(subject, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -281,9 +296,20 @@ static int hook_unix_stream_connect(struct sock *const sock,
 static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
+	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
-						NULL);
+						&handle_layer);
+	struct lsm_network_audit audit_net = {
+		.sk = other->sk,
+	};
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.audit = {
+			.type = LSM_AUDIT_DATA_NET,
+			.u.net = &audit_net,
+		},
+	};
 
 	if (!subject)
 		return 0;
@@ -296,8 +322,11 @@ static int hook_unix_may_send(struct socket *const sock,
 		return 0;
 
 	if (is_abstract_socket(other->sk) &&
-	    sock_is_scoped(other->sk, subject->domain))
+	    sock_is_scoped(other->sk, subject->domain)) {
+		request.layer_plus_one = handle_layer + 1;
+		landlock_log_denial(subject, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -311,13 +340,22 @@ static int hook_task_kill(struct task_struct *const p,
 			  const struct cred *cred)
 {
 	bool is_scoped;
+	size_t handle_layer;
 	const struct landlock_cred_security *subject;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = p,
+		},
+	};
 
 	if (!cred)
 		/* Not dealing with USB IO. */
 		cred = current_cred();
 
-	subject = landlock_get_applicable_subject(cred, signal_scope, NULL);
+	subject = landlock_get_applicable_subject(cred, signal_scope,
+						  &handle_layer);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
@@ -329,8 +367,11 @@ static int hook_task_kill(struct task_struct *const p,
 					     landlock_get_task_domain(p),
 					     signal_scope.scope);
 	}
-	if (is_scoped)
+	if (is_scoped) {
+		request.layer_plus_one = handle_layer + 1;
+		landlock_log_denial(subject, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -338,7 +379,15 @@ static int hook_task_kill(struct task_struct *const p,
 static int hook_file_send_sigiotask(struct task_struct *tsk,
 				    struct fown_struct *fown, int signum)
 {
+	size_t handle_layer;
 	const struct landlock_cred_security *subject;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = tsk,
+		},
+	};
 	bool is_scoped = false;
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
@@ -361,8 +410,11 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 					     landlock_get_task_domain(tsk),
 					     signal_scope.scope);
 	}
-	if (is_scoped)
+	if (is_scoped) {
+		request.layer_plus_one = handle_layer + 1;
+		landlock_log_denial(subject, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
-- 
2.48.1

