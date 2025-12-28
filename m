Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344412FE59B
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925968; cv=none; b=D4zsh3jpQlkjEL0KRTieycOqBeNdWlAzh6dnfEtwgaHGWBfG/wKYhleUR8Q+07jK8zqc5o6+otOjbYAm5rrhXft/VvnCvvmFs6gXSWJ22yczwgBxBAw6qCu48nU9VXOpkKyiXYcBNV6zSuCiX+3QsiAS6xp1bI4zDkT6oOY6oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925968; c=relaxed/simple;
	bh=uzfZ3eL85jDQJ2BaXJSX7Oo7i/Zd/ThWATkpXSS1PYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBNR3zbWDniJnhnQTZKq4crIFrmjFUxmiU5zsz12TJD9P3d+WAmQbg0gM7dGZtOcgYz3fidPqQSIBiaWarfeX03w5ki+C2m/qtrlcwSKvk/cXliprdO0/ENmWaRQmHP5tWF9cdQe4ZL079wGDN+YDb1LEHpJTA7uZVCcOrVxw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=I1vzU0ke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFbgERAl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="I1vzU0ke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFbgERAl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 671A37A0017;
	Sun, 28 Dec 2025 07:46:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 07:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766925965; x=
	1767012365; bh=oyoPcvtGR0RvgM66472dIzCGH2dxJkBlALAd3htDBog=; b=I
	1vzU0keigZsmencMHFpaynIZ0nffyKr5pZFVnq32i/zceiGJsySDtxkzUoNDQF4R
	becXeTLoPxfunqxlavtbeExMEfsBQdnne9DaQzeRasZqC8twyqef22+gD2/aLdj+
	YDsyEEVlrEqEqaRLaCnX0usHYBMcTGYZ5Kn633RtXEeCxiR7/nY++Ngrm8eCrbwT
	IsCuhGtsZ7orXWlQ9SNbAwhg1NSJOwHEmzvgV0w7USmBo67uy2ub+cWVwy81/efm
	nBZxgT69Riffo05EsKWj2AoGg9u3NEMuxxGSwTQsTRYNZ5IZdmld05s8RDaX981k
	IyqxMFdB63UyZ+nvaOQjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1766925965; x=1767012365; bh=o
	yoPcvtGR0RvgM66472dIzCGH2dxJkBlALAd3htDBog=; b=DFbgERAlXbKr0baRl
	u/N/9Q4DyFKOJd2OYumR94m/o77Z3GNSIcfHRnlXMqBKrWGd6LsXC+j0FbG/zUiK
	6f2svU3Wwz3FfbnCY0WYxJBURzW0aTV+4QKuiZr7FwX8ih5Gvk0QOkaqRaa2haj9
	opAPamu2g0nUlTddmkc3xJSYQ5UhZAgtmM6JCRBQQ3YGYJkKtF17R8FDmxZ4+M+T
	zAD1L1m7kT7KM1tTqSV+lKbHtLxWz/yO8GIw5zGFasVAFyLP97wTlMxRcOODoa4S
	H4iUduE0jBRJrORn5Af0q991cYnk9c1Dcu3W4M2opeNHY0OpPdeHMkjwYpF1YSFJ
	mqJXA==
X-ME-Sender: <xms:jSZRafdgiS1mCn8ugYCXyWWaJXQw40r-U9ckrhe-Esxf2dgzYGfmHw>
    <xme:jSZRaUQuufSRtkB234GG-Wk3rYqSqWlW1kmT1UJILGklEpuFZv_tyRyvY6BJ6YBtN
    v83oYRGW6BbAfDsv1dMo68CDt1JSI4bUyPQdQ_H7KlbuRrne9IXYrQ>
X-ME-Received: <xmr:jSZRaeuIpsRe7VAKvTNui-Tj-60qbxlUlPi2nOtSQHt8QXgMpzXAmpdS1uO23uz7xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepueeftd
    etveegueejiefgvdejtdduvddvgeduffduhfevhfejhedvueelhefgkeefnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhdpthihphgvrdhsvggtuhhrihhthienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhr
    ghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggvmh
    hiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhihsshgr
    rdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jSZRadeLeNEBw5MoUsod0dS0V_n1qQvstI1HSWp6UUw7Xf3o1ME1yw>
    <xmx:jSZRaQZDaQJy3DtS2uadl7u8Q69OcftTCKMVeNmDg_89UfdyxMOtZA>
    <xmx:jSZRaXbrSHfQOg_vePniYO2xAL2leBDyGZHN9-neyiwvFScb38qeXQ>
    <xmx:jSZRadKVIzUczNIhAl_Q8d-FAgFs72saKN-GBFP5eUaGiido6EQKgg>
    <xmx:jSZRaaaJX8Y2lvLQ4hmZNA1BoDPTUb_A1gmTRlKIVLhFvZl0MvqTfTfj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 07:46:03 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/6] landlock: Implement LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Sun, 28 Dec 2025 12:45:41 +0000
Message-ID: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766925301.git.m@maowtm.org>
References: <cover.1766925301.git.m@maowtm.org>
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

There is an argument that there should only really be one audit request
type for both sockets, since the only difference is whether path= is
followed by a normal path, or by a hex string starting with 00.  But I'm
not sure if we can change this at this point, so I have created a new
request type.

 security/landlock/audit.c |  4 +++
 security/landlock/audit.h |  1 +
 security/landlock/task.c  | 74 ++++++++++++++++++++++++++++++---------
 3 files changed, 62 insertions(+), 17 deletions(-)

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
index 6dfcc1860d6e..9fbb0ada440b 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -233,57 +233,84 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
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
+static bool sock_addr_is_abstract(const struct unix_address *const addr)
 {
-	struct unix_address *addr = unix_sk(sock)->addr;
-
-	if (!addr)
-		return false;
-
-	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
+	if (addr && addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
 	    addr->name->sun_path[0] == '\0')
 		return true;
 
 	return false;
 }
 
+/* Allow us to quickly test if the current domain scopes any form of socket */
 static const struct access_masks unix_scope = {
-	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+		 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
 };
 
+/*
+ * UNIX sockets can have three types of addresses: pathname (a filesystem path),
+ * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
+ * Unnamed sockets include those created with socketpair() and unbound sockets.
+ * We do not restrict unnamed sockets since they have no address to identify.
+ */
 static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
 	size_t handle_layer;
+	access_mask_t scope;
+	enum landlock_request_type request_type;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
+	const struct unix_address *addr;
 
 	/* Quick return for non-landlocked tasks. */
 	if (!subject)
 		return 0;
 
-	if (!is_abstract_socket(other))
+	addr = unix_sk(other)->addr;
+	/* Unnamed sockets are not restricted. */
+	if (!addr)
 		return 0;
 
-	if (!sock_is_scoped(other, subject->domain))
+	if (sock_addr_is_abstract(addr)) {
+		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
+	} else {
+		/* Pathname socket. */
+		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
+	}
+
+	if (!sock_is_scoped(other, subject->domain, scope))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
-		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.type = request_type,
 		.audit = {
 			.type = LSM_AUDIT_DATA_NET,
 			.u.net = &(struct lsm_network_audit) {
@@ -299,9 +326,12 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	size_t handle_layer;
+	access_mask_t scope;
+	enum landlock_request_type request_type;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
+	const struct unix_address *addr;
 
 	if (!subject)
 		return 0;
@@ -313,14 +343,24 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (!is_abstract_socket(other->sk))
+	addr = unix_sk(other->sk)->addr;
+	/* Unnamed sockets are not restricted. */
+	if (!addr)
 		return 0;
 
-	if (!sock_is_scoped(other->sk, subject->domain))
+	if (sock_addr_is_abstract(addr)) {
+		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
+	} else {
+		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
+		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
+	}
+
+	if (!sock_is_scoped(other->sk, subject->domain, scope))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
-		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.type = request_type,
 		.audit = {
 			.type = LSM_AUDIT_DATA_NET,
 			.u.net = &(struct lsm_network_audit) {
-- 
2.52.0
