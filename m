Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADED2FFDF4
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160396; cv=none; b=S7zw9WdmMTeK/F7AaSLQNo2/D4YFufQm301OPFJgO647WHL62tOU7rR3pgXv8OeXLv21y/aEeb7Bzyvpgq8oQcrdnpvnr9thDujnVIrH703YatzIl6/8q6LA0vPmUoJeTcF5hjiM8sHamJkut2kyH8P6Y9GvfHDv1SWFeA16dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160396; c=relaxed/simple;
	bh=rhzWCoqcPnEzfIZDeTAUg3/KJGPPkE/m7dRKQVeg0OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD1uM5Gm9HMojDGkT4a+v6jkanRbPA6Idxmw8x+MerWMphbuyhEvd/g49oUSGwXeVw5ZL73t1P/3Qzz0Amb4Hd6Tq89x7JBVWAKL9oYJh5eYy0+r4zsYd5R5r1AwDI0FZ4uvzwgn+8JOR+M54xivfJ6UgVUvOcJx6Ely3cSCoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=B2lxxYmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7oIMHQ4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="B2lxxYmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7oIMHQ4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A2521EC0261;
	Tue,  3 Feb 2026 18:13:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Feb 2026 18:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770160393; x=
	1770246793; bh=vtFmt09pzWVThkP3O4hXFnBeZ2mZtz1ebx3shAmY9xw=; b=B
	2lxxYmUWdAVY3rGVYWSPZ4xieoYD4+UMAwlCVE4M7ME75S6ElLTrakqGc374ZfuR
	nKujc5tkjA7i2ZG/N1aWwE5bCYqF2X5puQOfB/eY+Z0lj98UDLNAizNsKA5Ccmmq
	vgfgUFGDJu3g/csNDMFCkgk6+fu4RqFQPs+fovGP78/lZmcm5FdbBTcuNAgv3UgN
	1dGa2Bn20x8SBk3UZDi6Zi+PjJmE3OYmDliXsz2QCLBbcpQDrIPLaCNtyLaGPFTb
	82eI+f9U2x5VqY3+yIUcd9D35gCkW9RH9du+XNl5ZaoUIY6WVOchxWkup9BDXM7V
	b2iEbDRDJWkIPwFEu2m2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770160393; x=1770246793; bh=v
	tFmt09pzWVThkP3O4hXFnBeZ2mZtz1ebx3shAmY9xw=; b=v7oIMHQ4jNioR+bVr
	M5nwL0gP3qEDvuM98+dRFBZQIBVe6IHh167tMlEbz/dnfFtYSp3sIdwlT0O5EQ8G
	Wz7o2dwaWsr87nfMRR6V+b06Q0SVY20AC1ge6q3fgGZDR9AKnX2sC2qSgGfzRynP
	JaO48PoWfgaS/BoLvr9I9rzZq/7VB9PmsCGHiywioz4R8uxUMgsfxx1us1I0NW4Y
	YK7iKXKfMfnKiWUs02Qf/XGkMH1ym/QPf/q510HAKbeTQztYlbVnoorjL/LVDhbe
	J0/VZ/fFyPfu/wWZGN7KPfNfr+vJJC8H9jLYOG+ZmWfv6MFUTq1E6gqjFMKVRBGH
	euC1w==
X-ME-Sender: <xms:CYGCaeDzbycqYW47ljXw1Xxk_S2CvmiLxvZzmX1Fumw2eeCvEBhDvg>
    <xme:CYGCabH2-aTq0ZOvm-SsIHwtFgLvIGu90T1fjnOxLhxVRhJeR7Qkxt8K06oCUTdul
    Fy4MzR_BrINLG9Mxh-9Y-Ow2IJOcV2XdEtCuC4SF7gP78plQmVKRmY>
X-ME-Received: <xmr:CYGCaVPkWkK1wBW0YYTaNIKsLxlJ83eOwo38c0YHxJrWsztfU4OaP3bU2BgYKkzj4X64fdf_px1F28ddKRmWC-NG3ZhAgAI-XTTYlgj2APykgD9_dqHKtOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeffhe
    fhffdugeelhfetieeiffehgeefvdejhfehueelteetjeeludehveffiefhgfenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhishgprggsshhtrhgrtghtpghsohgtkhgvthdrsh
    gvtghurhhithihnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthht
    ohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohephhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CYGCac5-5m0se5ab8mePibtDn_jtVEBlhq6EVOR7Nc99veB7WNeEZg>
    <xmx:CYGCaYhBeewhNpgU-IK3HiG1yD8JxfCKOXAzYTtMBRE56HQOnUma5Q>
    <xmx:CYGCaRfNggtK9_VZ9KMd7VJQLc1sxduqHLZDBI7ZHyiOZj_nnRMmng>
    <xmx:CYGCaQz5Ljdg1r9t6nwQLjCjUUbGEsipXfTXV-O_hNkzCcCnWrpamg>
    <xmx:CYGCaadFu-1YvXPVD0BwP7DaXzmm68oTAeezZhaOEteTCZSEloMIaFzC>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:12 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 2/6] landlock: Implement LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Tue,  3 Feb 2026 23:12:29 +0000
Message-ID: <c5b090acf2c16f120d340ec376ed3a538d535158.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770160146.git.m@maowtm.org>
References: <cover.1770160146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the existing abstract UNIX socket scoping to pathname sockets as
well.  Basically all of the logic is reused between the two types, just
that pathname sockets scoping are controlled by another bit, and has its
own audit request type (since the current one is named
"abstract_unix_socket").

Closes: https://github.com/landlock-lsm/linux/issues/51
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- missing dot in comment
- More accurate comment on check_socket_access
- Unix -> UNIX

Changes in v2:
- Factor out common code in hook_unix_stream_connect and
  hook_unix_may_send into check_socket_access(), and inline
  is_abstract_socket().

 security/landlock/audit.c |   4 ++
 security/landlock/audit.h |   1 +
 security/landlock/task.c  | 113 ++++++++++++++++++++++----------------
 3 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 650bd7f5cb6b..97f0f503a836 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -75,6 +75,10 @@ get_blocker(const enum landlock_request_type type,
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.abstract_unix_socket";
 
+	case LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.pathname_unix_socket";
+
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 104472060ef5..0e40fed17f21 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET,
 };
 
 /*
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 833bc0cfe5c9..973de1efc08a 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -232,35 +232,85 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 	return false;
 }
 
+/**
+ * sock_is_scoped - Check if socket connect or send should be restricted
+ *    based on scope controls.
+ *
+ * @other: The server socket.
+ * @domain: The client domain.
+ * @scope: The relevant scope bit to check (i.e. pathname or abstract).
+ *
+ * Returns: True if connect should be restricted, false otherwise.
+ */
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_ruleset *const domain)
+			   const struct landlock_ruleset *const domain,
+			   access_mask_t scope)
 {
 	const struct landlock_ruleset *dom_other;
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
-	return domain_is_scoped(domain, dom_other,
-				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	return domain_is_scoped(domain, dom_other, scope);
 }
 
-static bool is_abstract_socket(struct sock *const sock)
+/*
+ * Allow us to quickly test if the current domain scopes any form of
+ * socket.
+ */
+static const struct access_masks unix_scope = {
+	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+		 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
+};
+
+/*
+ * UNIX sockets can have three types of addresses: pathname (a filesystem path),
+ * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
+ * Unnamed sockets include those created with socketpair() and unbound sockets.
+ * We do not restrict unnamed sockets since they cannot be used to reach a
+ * new peer.
+ */
+static int
+check_socket_access(struct sock *const other,
+		    const struct landlock_cred_security *const subject,
+		    const size_t handle_layer)
 {
-	struct unix_address *addr = unix_sk(sock)->addr;
+	const struct unix_address *addr = unix_sk(other)->addr;
+	access_mask_t scope;
+	enum landlock_request_type request_type;
 
+	/* Unnamed sockets are not restricted. */
 	if (!addr)
-		return false;
+		return 0;
 
+	/*
+	 * Abstract and pathname UNIX sockets have separate scope and audit
+	 * request type.
+	 */
 	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
-	    addr->name->sun_path[0] == '\0')
-		return true;
+	    addr->name->sun_path[0] == '\0') {
+		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
+	} else {
+		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
+	}
 
-	return false;
-}
+	if (!sock_is_scoped(other, subject->domain, scope))
+		return 0;
 
-static const struct access_masks unix_scope = {
-	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
-};
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = request_type,
+		.audit = {
+			.type = LSM_AUDIT_DATA_NET,
+			.u.net = &(struct lsm_network_audit) {
+				.sk = other,
+			},
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+	return -EPERM;
+}
 
 static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
@@ -275,23 +325,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 	if (!subject)
 		return 0;
 
-	if (!is_abstract_socket(other))
-		return 0;
-
-	if (!sock_is_scoped(other, subject->domain))
-		return 0;
-
-	landlock_log_denial(subject, &(struct landlock_request) {
-		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
-		.audit = {
-			.type = LSM_AUDIT_DATA_NET,
-			.u.net = &(struct lsm_network_audit) {
-				.sk = other,
-			},
-		},
-		.layer_plus_one = handle_layer + 1,
-	});
-	return -EPERM;
+	return check_socket_access(other, subject, handle_layer);
 }
 
 static int hook_unix_may_send(struct socket *const sock,
@@ -302,6 +336,7 @@ static int hook_unix_may_send(struct socket *const sock,
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
 
+	/* Quick return for non-landlocked tasks. */
 	if (!subject)
 		return 0;
 
@@ -312,23 +347,7 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (!is_abstract_socket(other->sk))
-		return 0;
-
-	if (!sock_is_scoped(other->sk, subject->domain))
-		return 0;
-
-	landlock_log_denial(subject, &(struct landlock_request) {
-		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
-		.audit = {
-			.type = LSM_AUDIT_DATA_NET,
-			.u.net = &(struct lsm_network_audit) {
-				.sk = other->sk,
-			},
-		},
-		.layer_plus_one = handle_layer + 1,
-	});
-	return -EPERM;
+	return check_socket_access(other->sk, subject, handle_layer);
 }
 
 static const struct access_masks signal_scope = {
-- 
2.52.0
