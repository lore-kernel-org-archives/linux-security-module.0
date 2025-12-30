Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B92459E5
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115265; cv=none; b=E4Mvr6uOyYsU2Ae93V4QPoxeLJU9gAKJL04Kp8Fs7qeulJAhgfn3T1wRo+I7UCeXSJGz3LiauXHpRztm2NmzQkcKhzeEjC9W7k/zW3HTzZ/VRht4mgZKjZ8RY/9KHWL6vlZW2oCgEeHsq6Nz9E5rX1vEaSZhiJyoEwsAJ4dzWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115265; c=relaxed/simple;
	bh=rb1bxJWtDOY3Q0yGcC+E0hjg/S3Z3ReaP367Q13QRgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGg19K6JQfMFwSH9kvEuVe93s8r+89Fg0YGvveTVX9UhL3iadFHJvKM/7Tu54Ie73p3acEOEvzwi83rBQO3OZSm7LMlkt0AR9oUtGX8Q7juIeqd8zoDG8bUNC8WdEAtPyDQjJmV0yw0MQFKHCXGLtjDwtlpY+RsL66hR0SIGJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Aei5NwRR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLomi46p; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Aei5NwRR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLomi46p"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D32541D00069;
	Tue, 30 Dec 2025 12:21:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 12:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767115262; x=
	1767201662; bh=IRrxnb4HVo0sSsBYmZdNSe4Uo7xJyrloM7VRuv5mnMc=; b=A
	ei5NwRRF5mH4ksn33JpQ387rMgg4/zeB4nUpBdWhfcKp4Ul8vlgRSDiqEG/E0EbR
	PWIp4t6w3zHhZXiZO6DsONCSouOHBKEEoDt355HEfch9wrF9MPkY/x9YCe2cNJPr
	a/+16VTT2GxpQqHPnua+zd2Rg4EiKeUSCgsQIax1U6bDK3ZU79NOWUaYzdUOOi7x
	XffjS8p0bWfsa4DYNiD3st34Xlb0TN26TxtfNmxKMM32SrCXVpMXL1ib07XLn59X
	XzZ9mz/b/1hPKF/kzs7v9+I9VmIH9sAn8BfU0L9dngUbm/FwAZQu1/xm/K+w5Hb5
	sYyC0Bv1jSFzCDGoFnymw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767115262; x=1767201662; bh=I
	Rrxnb4HVo0sSsBYmZdNSe4Uo7xJyrloM7VRuv5mnMc=; b=OLomi46pBaGSf3Izx
	45HdT2MYozGvj7uuxx7m2o9H9IdDmb+qBMqrCjmOqb6keszZ5MuApFea1z5ZzzAI
	ETQazVHnCXu1UyS6unA6aeO1mcEWgxJZ6WvCpJdf8sWi/xcM1+pGr4/uW9SRmAW5
	I6MlKvQPglxagHsmYASYtm3NQYptWw8Ju6CY+WyCjKgPqp1Y8aM4uJ8QLpAfCzMy
	FRqpPMPt8p6R5qBYaRA0OWMevGCHHnAU0ff5COmeJm/nZFvvORV/VJU9Uru5c4pM
	VvUVd1Y6BgHloboNHfl2C4uILWT3Ast3cxAVVqUWxggg47bURnt+PWLa09OjfATW
	lR8+Q==
X-ME-Sender: <xms:_glUaQivu-KMaa3XI7ja_AwmiObRhzrHNb4r-7a7vMLkbIPldUQGdg>
    <xme:_glUabmWPqe1VqxYokvA5UvkoP0J8bL4_QUCMOW__OvTTC1lc9Nrei3TnTI-jdvsN
    p6tvcUnqP4zkHXgMM54Rv6H2NCcvJ5X_iKZAHLOrRZzOkckKuNbPE8>
X-ME-Received: <xmr:_glUabs3ulgXZy5OjMMJI2_J6M12SWb-2HOpSUKQnHqa8mpIyIUukj5pBUxkYTGaQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepffehhf
    ffudeglefhteeiieffheegfedvjefhheeuleetteejleduheevffeihffgnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhdpihhspggrsghsthhrrggtthgpshhotghkvghtrdhsvg
    gtuhhrihhthienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthho
    pehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepuggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgt
    phhtthhopehhihesrghlhihsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:_glUaRZyTK1e_mpK4__O0V7cCtgucyQ7f-FlGEozRfaK0Mp0pvSV_A>
    <xmx:_glUaTCH1Dl1DYzcbbwdYXpr6B3_fyy8yQ_ckhhTrCDT64uT_ISpyQ>
    <xmx:_glUaZ9l1OLHjbOLnXJdtniZoRSKk03Hk_ZUZR4Pd0cGG6qEZOUbhw>
    <xmx:_glUafQaV8HpuEejho_686XxC7-KcHegg0jpsTtfVddv8qyjop5GjA>
    <xmx:_glUaW4mWiBFSln5D06xhv6n25T_TZ7S8GnS0WGTEFhOZlY-AQBwSXvc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 12:21:01 -0500 (EST)
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
Subject: [PATCH v2 2/6] landlock: Implement LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Tue, 30 Dec 2025 17:20:20 +0000
Message-ID: <a6d6479888d9d216a3f2e7bb133523f856f92461.1767115163.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767115163.git.m@maowtm.org>
References: <cover.1767115163.git.m@maowtm.org>
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

Changes in v2:
- Factor out common code in hook_unix_stream_connect and
  hook_unix_may_send into check_socket_access(), and inline
  is_abstract_socket().

 security/landlock/audit.c |   4 ++
 security/landlock/audit.h |   1 +
 security/landlock/task.c  | 109 ++++++++++++++++++++++----------------
 3 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e899995f1fd5..0626cc553ab0 100644
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
index 92428b7fc4d8..1c9ce8588102 100644
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
index 833bc0cfe5c9..10dc356baf6f 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -232,35 +232,81 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
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
+/* Allow us to quickly test if the current domain scopes any form of socket */
+static const struct access_masks unix_scope = {
+	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+		 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
+};
+
+/*
+ * UNIX sockets can have three types of addresses: pathname (a filesystem path),
+ * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
+ * Unnamed sockets include those created with socketpair() and unbound sockets.
+ * We do not restrict unnamed sockets since they have no address to identify.
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
+	 * Abstract and pathname Unix sockets have separate scope and audit
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
@@ -275,23 +321,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
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
@@ -302,6 +332,7 @@ static int hook_unix_may_send(struct socket *const sock,
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
 
+	/* Quick return for non-landlocked tasks. */
 	if (!subject)
 		return 0;
 
@@ -312,23 +343,7 @@ static int hook_unix_may_send(struct socket *const sock,
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
