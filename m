Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405431C1744
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613446; cv=none; b=jtc6Hn+wZveBbVz/4ReAJbhdqpD+hXE9Sv58pSPftZyBCADVS93xn5eTJZT7IPHx76FXuC57y2bPQg0kjCbab+2USWm0bOTAkfumDnGke8S3swn2q7T+Ou/33mYziCm3Vywk7qii9Sx9JgJcLh8jCVZtX012mBmaXLwk7xFOYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613446; c=relaxed/simple;
	bh=rlNg5xRtAk/fMeKAFzaVUpBQpvdKcN3yBcGs9kIU4is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qttfHfinoZv/3Z2QTlyPnS+ztlA+BcNBHlvOEX/78Td7BUhaonx+MXI/nKuRysfxvs37NYGMthN0kX5yzseunAkXXPGOmAbh/taDOY4FBpVSM1px26qjd87Py2ISitiDnFapCcgNwREMhBJ1/t5EbOLa+zuW5ID9SB0xapmyPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=L1L1LnKf; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="L1L1LnKf"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxws2SYtz19l7;
	Tue, 22 Oct 2024 18:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613437;
	bh=5q+SMXfS7orwC9ZKwlMlPSsCzyX9dmv07VXZUyHdcYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1L1LnKfBUVWY4s5szp1XEk/qkhAtcVRHfQZ4iqStkVQqdEyk9Vl8iEvwT+kE71G2
	 cjJzaQiZLYyLvoEYeYfya6zD979fwbY7/c8zIas04+z9uJq3EG8dy0ljbCC1DetBSu
	 xWJF7hbdGa2TitGp0O9xOLqVe0LxzY3lsKCrGjiA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwr38Wmz57j;
	Tue, 22 Oct 2024 18:10:36 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 13/14] landlock: Log scoped denials
Date: Tue, 22 Oct 2024 18:10:08 +0200
Message-ID: <20241022161009.982584-14-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
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

Audit record sample:

  DENY:    domain=4533720578 blockers=scope_abstract_unix_socket path=00666F6F
  SYSCALL: arch=c000003e syscall=42 success=no exit=-1 ...

Cc: Günther Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-14-mic@digikod.net
---
 security/landlock/audit.c |  8 ++++++
 security/landlock/audit.h |  2 ++
 security/landlock/task.c  | 58 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c31a4a8719ee..b551812b8bc9 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -69,6 +69,14 @@ get_blocker(const enum landlock_request_type type,
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(net_access_strings)))
 			return "unknown";
 		return net_access_strings[access_bit];
+
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope_abstract_unix_socket";
+
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope_signal";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 1075b0c8401f..1e0a9164bacc 100644
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
index 8c4468fb86bf..ddcb993bd53a 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -262,13 +262,27 @@ static int hook_unix_stream_connect(struct sock *const sock,
 {
 	const struct landlock_ruleset *const dom = landlock_match_ruleset(
 		landlock_get_current_domain(), unix_scope);
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
@@ -278,6 +292,16 @@ static int hook_unix_may_send(struct socket *const sock,
 {
 	const struct landlock_ruleset *const dom = landlock_match_ruleset(
 		landlock_get_current_domain(), unix_scope);
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
@@ -289,8 +313,12 @@ static int hook_unix_may_send(struct socket *const sock,
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
@@ -305,6 +333,13 @@ static int hook_task_kill(struct task_struct *const p,
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
@@ -322,8 +357,12 @@ static int hook_task_kill(struct task_struct *const p,
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
@@ -332,6 +371,13 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
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
@@ -347,8 +393,12 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
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
2.47.0

