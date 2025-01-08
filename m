Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B220125B
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351056; cv=none; b=KJsqJHAcJsf72TGLDvZx9WHDRtQA0MiWZXG2SAFn76wlAkTh7wGzkMBO8IuEtYgt5gcMIAHqIasAMYhOEvccTc2ul4efApvkOFB+342Gkfnp8oEzEibJdASVwR3dEAP96Vaoo0dH5AcmKINB9peTbsYGmCBdcCyBKCnSXYPCot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351056; c=relaxed/simple;
	bh=QGgkX4ZMdgskH5gQyj4rVDmPlqBeDjSuaVFMj8kT34Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgvpv2n1MsGsZK12jkyVTEvlKneFfn/zqXRg9QpRktwGM1bMScLRXDHVkWdiNGTowsWlMk/tMeeQOzKTpgkjBFLBrPus8vWY8QhiauaJ7lmceq7nCu+erLAp+D/Hz8odtUdK0Fz6SEg48dTr2JsHG1WoQkiWX1ISJuigoDfn1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=A3mJfqi6; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="A3mJfqi6"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfN21RNzq5T;
	Wed,  8 Jan 2025 16:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351052;
	bh=AnTdAtgZSuavEJrYHBVG062ie022jRaSQUPxZ972iwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3mJfqi6bewyqNslA0nOOEGFG81zT0bApU/gNwKLuasYvLiixaEDzKmTbXyaC6JQP
	 IsGuOe20wbZ7VR0HHF5kbJ4SixdUUVHlouQ9xVniBCohftMO7YL/s58mutt14TslGm
	 9iyYwsxwwco15sCdqwn5MqFtvPKgGU1oLi/CNxXk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfM1pmDz4B8;
	Wed,  8 Jan 2025 16:44:11 +0100 (CET)
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
Subject: [PATCH v4 17/30] landlock: Log scoped denials
Date: Wed,  8 Jan 2025 16:43:25 +0100
Message-ID: <20250108154338.1129069-18-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250108154338.1129069-18-mic@digikod.net
---

Changes since v3:
- Cosmetic change to the "scope.*" blocker names.
- Extend commit message.

Changes since v1:
- New patch.
---
 security/landlock/audit.c |  8 ++++++
 security/landlock/audit.h |  2 ++
 security/landlock/task.c  | 58 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 2744e3d4fe73..7a2183ac9add 100644
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
index 9a3697b901b5..dd5deaf7dc4d 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -19,6 +19,8 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
 	LANDLOCK_REQUEST_FS_ACCESS,
 	LANDLOCK_REQUEST_NET_ACCESS,
+	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 };
 
 /*
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4fef963274fd..1b3d5de89e14 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -263,13 +263,27 @@ static int hook_unix_stream_connect(struct sock *const sock,
 	const struct landlock_ruleset *const dom =
 		landlock_get_applicable_domain(landlock_get_current_domain(),
 					       unix_scope);
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
 	if (!dom)
 		return 0;
 
-	if (is_abstract_socket(other) && sock_is_scoped(other, dom))
+	if (is_abstract_socket(other) && sock_is_scoped(other, dom)) {
+		request.layer_plus_one =
+			landlock_match_layer_level(dom, unix_scope) + 1;
+		landlock_log_denial(dom, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -280,6 +294,16 @@ static int hook_unix_may_send(struct socket *const sock,
 	const struct landlock_ruleset *const dom =
 		landlock_get_applicable_domain(landlock_get_current_domain(),
 					       unix_scope);
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
 
 	if (!dom)
 		return 0;
@@ -291,8 +315,12 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (is_abstract_socket(other->sk) && sock_is_scoped(other->sk, dom))
+	if (is_abstract_socket(other->sk) && sock_is_scoped(other->sk, dom)) {
+		request.layer_plus_one =
+			landlock_match_layer_level(dom, unix_scope) + 1;
+		landlock_log_denial(dom, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -307,6 +335,13 @@ static int hook_task_kill(struct task_struct *const p,
 {
 	bool is_scoped;
 	const struct landlock_ruleset *dom;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = p,
+		},
+	};
 
 	if (cred) {
 		/* Dealing with USB IO. */
@@ -324,8 +359,12 @@ static int hook_task_kill(struct task_struct *const p,
 	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(p),
 				     LANDLOCK_SCOPE_SIGNAL);
 	rcu_read_unlock();
-	if (is_scoped)
+	if (is_scoped) {
+		request.layer_plus_one =
+			landlock_match_layer_level(dom, signal_scope) + 1;
+		landlock_log_denial(dom, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -334,6 +373,13 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 				    struct fown_struct *fown, int signum)
 {
 	const struct landlock_ruleset *dom;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_SCOPE_SIGNAL,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = tsk,
+		},
+	};
 	bool is_scoped = false;
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
@@ -349,8 +395,12 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(tsk),
 				     LANDLOCK_SCOPE_SIGNAL);
 	rcu_read_unlock();
-	if (is_scoped)
+	if (is_scoped) {
+		request.layer_plus_one =
+			landlock_match_layer_level(dom, signal_scope) + 1;
+		landlock_log_denial(dom, &request);
 		return -EPERM;
+	}
 
 	return 0;
 }
-- 
2.47.1

