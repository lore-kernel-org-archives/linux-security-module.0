Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFE2236EE
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843700; cv=none; b=fYUlnh3JWpsr/dHpZJ7pEfRLEVdoJtiDhaheWkn4LbQKQotpHRrsYFQxkmeZyOdflS9O1mtjnbI3LQ0NI88DjOxF6Bs03Jfij4SZDCHcoLVDe3re2R4vQ1khbaq9JF6ssAYOQ0UaE8d4uZD8v1wzlAD1+l3nHkqGO2ZXguOa+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843700; c=relaxed/simple;
	bh=fMtxwLpAQAv9DrqB2JDHa3cx3H19fSFyNKvhOzJFxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnCZpDDcxtxp4QcrxFHl2T2N1PzKydyk6ajA1Qbp9fPsNssm/VBpO/WPOJAo2wz90iuWYL0g8bystp02bUZxXVdbYNt1dKsOK99pzaJeLMWIFT5bNiXQJWw4I3/Dr4vpT+CsVbpNzSm/gBLVgDJs12yFdsl5nFvy+xk7PivvRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hGnDBgiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ppHm5cs0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hGnDBgiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ppHm5cs0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B7BF140005E;
	Tue, 26 May 2026 21:01:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 21:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843698; x=
	1779930098; bh=goV3f+j6k+RYEdywb3DeVKGz8z86Y6zYoM5C7bwYjwI=; b=h
	GnDBgiSkcRQ4uT5Aj50focuLThqu0hAWfhfcBXjKmFXn14i/ibaWrIgV4EWLVyJ+
	VoxBMdENJSa7SDiSR2zWQRELjvX2wud7xTOirALydaQMhzb6TcJz/uFqvpuh1fuJ
	YxWBZMCbGjtJ84J7/Zn8nNLHBMF8bSMdveZDBWrwrgRHNY374y0iT4YbgBNehaHi
	UQg5X+kIbhaBImvufk4640haEhC4E5JkpDv5N9DuZx0ahGz01yXDZRF2Y9ae18Ip
	D1mj8CHFGsCWcWJAnEwsMJr+tODvXTJCFmilSK/OEiHqhGv6rPNys1Zeew63j8Jz
	fOWmEmeSUxjzsSkt9+iUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843698; x=1779930098; bh=g
	oV3f+j6k+RYEdywb3DeVKGz8z86Y6zYoM5C7bwYjwI=; b=ppHm5cs0t2Zpi2Ajx
	XSRWIZV3khVb+GmKhGQZBUrrHasjCEfsL/jwpSU6jMpq+LejMXWzDEPLsDnJAEwK
	AKpYqNZGZW4qIL478+e2mDge2SGRKsfJd/1CoKqspzGSjM7gvNP5BZOOWQo87nao
	JUKrrspTzBe7/e/KjrwGWzZYYsLqDyBAUTihyKGKuXaJKYu5ses3chOTZneWEPlG
	lVNzcevY+59cy+dlBtZGlO2e6qZNxsd4c5VUvER+R6v4quzGFWF00kYQiBtdInLb
	AJXSbTMpkwaGo7OgiIpluYBByuVXcTMbAkgvA7OA5a21xMeMArtrTZVC8peSiWtR
	0IlQw==
X-ME-Sender: <xms:ckIWapefC7l-D63ebGJND0F8-xY9u9qkFXfVNk3M8T9An_YDDJ9ayw>
    <xme:ckIWakx5zDdyOZvd7T8a9OFPjHYBEP0m9aQ_3r51pVtTpy0Fd8Hs_0BxMO3cbtMHg
    FenExfT0PE5Ag0iBGCPCHlQlwLX-3x0PiHB1a0W784Ejz9dp08iBjU>
X-ME-Received: <xmr:ckIWao9byb_rWB5szxeaCDGUu6zKQ4BQvoG-d0dW76YwzLYfXCt5rmFDrTii1yiB9NI>
X-ME-Proxy-Cause: dmFkZTFUre9sXwItw/D32/LRha63U+D2MMre5R4tNoZC3GZT1kninLOZYHQGUdW/3lBBAr
    rH7WEN1NA0Icq7iWzjSibRmCazO7v8ipojfNsqLogvqpKcgpSkktdCK74u1Yx2bEapFKlN
    S0WIZUEX4JR1fUCKvttN8BxAYAt7dVO6aFHlXili/G3YRmDCCBAzY7r9QgnkuQv0FMn/dy
    NAgD25l8Vnwfwc1HnabyZvWY5OmQC4xgsVYFabzy+Dg3mXYfFbgr+O2AYzjg4pZKiA5CQC
    cooAMlaj6Mhx9kTeOxwXV/N6k5f1c0HpAIGUHCT4okSDNym5kyoKxbD0WxnwKa6hKew0lO
    AtY+/M8hziOuleyM8Yj6pdTozGmFHeWsmE9A7n/ZNzXViiSedZEkwhHqEoVqdKdC+g/MRW
    vHhDEl7W2ZhOq7WSqh4fmBaEyxOXV8MvSBpjRmPdm/M7EiCvdSKX82zNPXEgNghje6fGnN
    wOJc6b62q0U/ss29VEh5LnCVvGLfvbgjtG0J0rj7yCPz1w3vWw1Vl/Y6bzCqS+HmeIFgHb
    HnFUq+dgeO2zNP4e4jxJpRAJ/eAGtH2zkR+ct3txeMVq53F5aAndw7AaeRgCmCxYrAGC4V
    Ox2wHfafy7cgP8yRaQKSjtJYnwpwHiu7BwJEI+p/eYkn0246fbsQ9y+gHNag
X-ME-Proxy: <xmx:ckIWakhKh0IhLh_1Ez6xKrQ48LymcHwuWm9hmSqTS3JmjUZAQOEcFg>
    <xmx:ckIWanGwBB3Z5xFfaEW7bjSBRFg1ElGZDY4TWpQMllXrU9sHhkDvCA>
    <xmx:ckIWar8Bi6tFxQ4nCQpU6EhvgmeVZ55t17AJZ6at7lsn1PILi5V3bA>
    <xmx:ckIWamxTPrrMtWzjoS_la_t7KZW6ue7AWeHRYuSLugxdtQXUD9XtDA>
    <xmx:ckIWaq43DZivkh24OmrmofJNDBWz3wCvvZsIXnd6SJT44RLs_AeIhRhq>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:37 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 7/9] selftests/landlock: add tests for quiet flag with net rules
Date: Wed, 27 May 2026 02:01:17 +0100
Message-ID: <de688a723dcf7d4dc397836bd9a3cad26b321f4b.1779843375.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779843375.git.m@maowtm.org>
References: <cover.1779843375.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that:
- Quiet flag works on network rules
- Quiet flag applied to unrelated ports has no effect
- Denied access not in quiet_access_net is still logged

This is not as thorough as the fs tests, but given the shared logic it
should be sufficient.  There is also no "optional" access for network
rules.

Signed-off-by: Tingmao Wang <m@maowtm.org>
Assisted-by: GitHub Copilot:claude-opus-4.7 copilot-review
---

Changes in v9:
- Rebased on top of UDP support series

Changes in v3:
- New patch

 tools/testing/selftests/landlock/net_test.c | 138 ++++++++++++++++++--
 1 file changed, 128 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2c72fda3c606..879126b0da4e 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2738,12 +2738,22 @@ TEST_F(port_specific, bind_connect_1023)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+/**
+ * matches_auditlog - Check audit log for a network access denial
+ *
+ * @audit_fd:   Audit file descriptor.
+ * @blockers:   A regex-escaped blocker string, e.g., "net\.bind_tcp".
+ * @dir_addr:   Either "saddr" or "daddr", ignored if addr is NULL.
+ * @addr:       A regex-escaped IP address string, or NULL.
+ * @dir_port:   Either "src" or "dst", ignored if addr is NULL.
+ * @port:       A port number, ignored if addr is NULL.
+ */
 static int matches_auditlog(const int audit_fd, const char *const blockers,
 			    const char *const dir_addr, const char *const addr,
-			    const char *const dir_port)
+			    const char *const dir_port, const __u16 port)
 {
 	static const char log_with_addrport_tmpl[] = REGEX_LANDLOCK_PREFIX
-		" blockers=%s %s=%s %s=1024$";
+		" blockers=%s %s=%s %s=%u$";
 	static const char log_without_addrport_tmpl[] = REGEX_LANDLOCK_PREFIX
 		" blockers=%s";
 	/*
@@ -2751,8 +2761,9 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 	 * Max strlen(dir_addr): 5
 	 * Max strlen(addr): 12
 	 * Max strlen(dir_port): 4
+	 * Max strlen(%u port): 5
 	 */
-	char log_match[sizeof(log_with_addrport_tmpl) + 37];
+	char log_match[sizeof(log_with_addrport_tmpl) + 42];
 	int log_match_len;
 
 	if (addr == NULL)
@@ -2761,7 +2772,7 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 	else
 		log_match_len = snprintf(log_match, sizeof(log_match),
 					 log_with_addrport_tmpl, blockers,
-					 dir_addr, addr, dir_port);
+					 dir_addr, addr, dir_port, port);
 	if (log_match_len > sizeof(log_match))
 		return -E2BIG;
 
@@ -2773,6 +2784,8 @@ FIXTURE(audit)
 {
 	struct service_fixture srv0;
 	struct service_fixture srv1;
+	/* srv2 has a rule with no access but quiet bit set. */
+	struct service_fixture srv2;
 	struct service_fixture unspec_srv0;
 	struct audit_filter audit_filter;
 	int audit_fd;
@@ -2832,6 +2845,7 @@ FIXTURE_SETUP(audit)
 
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
 	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
 	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
 
 	setup_loopback(_metadata);
@@ -2862,6 +2876,11 @@ TEST_F(audit, bind)
 				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = access_rights,
+		.quiet_access_net = access_rights,
+	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv2.port,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -2869,6 +2888,8 @@ TEST_F(audit, bind)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -2876,13 +2897,24 @@ TEST_F(audit, bind)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "saddr",
-				      variant->addr, "src"));
+				      variant->addr, "src", self->srv0.port));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
 	EXPECT_EQ(0, close(sock_fd));
+
+	/* Bind to srv2 (with quiet rule): no new audit logs. */
+	sock_fd = socket_variant(&self->srv2);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv2));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
 }
 
 TEST_F(audit, connect)
@@ -2899,11 +2931,16 @@ TEST_F(audit, connect)
 	const int access_rights = bind_right | conn_right;
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = access_rights,
+		.quiet_access_net = access_rights,
 	};
 	const struct landlock_net_port_attr rule_connect_p1 = {
 		.allowed_access = conn_right,
 		.port = self->srv1.port,
 	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv2.port,
+	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
 
@@ -2912,6 +2949,8 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &rule_connect_p1, 0));
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -2919,7 +2958,7 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
-				      variant->addr, "dest"));
+				      variant->addr, "dest", self->srv0.port));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2930,12 +2969,90 @@ TEST_F(audit, connect)
 		EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
 
 		EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp",
-					      NULL, NULL, NULL));
+					      NULL, NULL, NULL, 0));
 		EXPECT_EQ(0, records.access);
 		EXPECT_EQ(1, records.domain);
 	}
 
 	EXPECT_EQ(0, close(sock_fd));
+
+	/* Connect to srv2 (with quiet rule): no new audit logs. */
+	sock_fd = socket_variant(&self->srv2);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
+/* Quieting bind access has no effect on connect. */
+TEST_F(audit, connect_quiet_bind)
+{
+	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
+					 "net\\.connect_tcp" :
+					 "net\\.connect_send_udp");
+	const int bind_right = (variant->prot.type == SOCK_STREAM ?
+					LANDLOCK_ACCESS_NET_BIND_TCP :
+					LANDLOCK_ACCESS_NET_BIND_UDP);
+	const int conn_right = (variant->prot.type == SOCK_STREAM ?
+					LANDLOCK_ACCESS_NET_CONNECT_TCP :
+					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+	const int access_rights = bind_right | conn_right;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = access_rights,
+		.quiet_access_net = bind_right,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_2 = {
+		.handled_access_net = access_rights,
+		.quiet_access_net = conn_right,
+	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv2.port,
+	};
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv2);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
+				      variant->addr, "dest", self->srv2.port));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
+
+	/* New layer that also denies connect but has the correct quiet bit. */
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr_2,
+					     sizeof(ruleset_attr_2), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv2);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
+
+	/* Quieted - no logs expected. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
 }
 
 TEST_F(audit, sendmsg)
@@ -2967,7 +3084,8 @@ TEST_F(audit, sendmsg)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv0, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
-				      "daddr", variant->addr, "dest"));
+				      "daddr", variant->addr, "dest",
+				      self->srv0.port));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2976,14 +3094,14 @@ TEST_F(audit, sendmsg)
 	/* Check that autobind generates a denied bind event. */
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
-				      NULL, NULL));
+				      NULL, NULL, 0));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
 	EXPECT_EQ(-EACCES,
 		  sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
-				      "daddr", NULL, "dest"));
+				      "daddr", NULL, "dest", 0));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-- 
2.54.0
