Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2423AE9B
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228963; cv=none; b=aM5B0jUcN98nFoW0cFilBH0i4ACSOCt35ST/1QQqkZIK14BWIeb+J8k6AvQxby5APzqi+7wBhRZTicLVFTEB1siBAWF2a+2A6yIbUZ4ceqL7sC9wCp3AQIfqWRQ+GH3GJqr5edStF1AMq5k1j0kr3C1KiJpgFYO4mfrmEnzi0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228963; c=relaxed/simple;
	bh=tI+fOiL8cZ2qvDJ8PJI4E3sfzuZB4yKmbTbFqmVNa6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqaVPvD4CDt286vz/FQMWejrmGdRyTCs64yj0w3RURb4roODVSV96+gAckvWyrSxCSHkKIH2yttX/2z4UMg0ULeLXa3rop6qXeDH6xK043fMnlBHgyuI0kR46HIE4fduRLR4YxdSUlxrVOPXSWnqMdzfC9bYOvDZqYK50MJVPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=nVuTTSy0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RD73y3C+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="nVuTTSy0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RD73y3C+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AB837A016A;
	Thu, 11 Jun 2026 21:49:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 21:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781228961; x=
	1781315361; bh=JiYRstfae3lcj6SrHD/ETzirysME+I+XRihlTuSm6+Y=; b=n
	VuTTSy0JF/9FT4L7XUbSxXytiJpn+M/lCjqWjeVxkuNNDNY6FcIU3veF8ZOwZVKD
	suXq69GRnP+N6I4oEG6PSnUqYVWR4McIFmcRgewPyzrazyKzxwq2tVnQDKUvgUjO
	DQpJEP3P4LK+JS1rg0UF7ZiJP0f9bibThUBuBxeA5ZcS9hy3MUyoz7r85/qAmMoV
	vPXL8Z3Khw0ey5c6yGde0LhmhVk3kRzdRvIDq2GWE+B6FtmBkBUw869d1732SMl4
	VCTKSiSTbp1+SI1IIUYivrBaqVW/KPMmqsmbj0250rRQZdL2sEVS3jp2DpRQgbeZ
	32C22b9Ew5AOWTSPjLcog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781228961; x=1781315361; bh=J
	iYRstfae3lcj6SrHD/ETzirysME+I+XRihlTuSm6+Y=; b=RD73y3C+VN/yURQ0s
	lBDPzLqDTIEJS9kv5c5j8/buM48KutbPfYjzQ/rih2Woo2pA6KTf/s0OkTQ5FTML
	1WaZZKIkC6xbJPK3Kny9Jr0FpU8vgpf2zGDWZMODQqrrGtNbZdFIAWSjvzJ/uxRR
	VYe9YUScuxI91j3YZBtsq0mlkBbNIjCBdntdTxwGP63p9vF24D/OLSVGE/VsMwJ4
	Sw89wvC4NRzCyF05NwhI05DvJ7FEU3SVGxSgGh5o8GLGo/G2HJboeRjYl+iQxz+h
	XkS74YuqnmF45G6l2KDYMZO5Ce5Ma/JHrD7fhlFiFXYhbTxFpFbplx0hLhr8twpU
	U+0oQ==
X-ME-Sender: <xms:oWUramXhD-6b9uiFAFtpRV4FZbMDTgB-odHjtqZw_WYZR0rv5oU1LQ>
    <xme:oWUrak26Lf9PhczwMT4HKk7vxkTIWhMtmnpA71OgV3ERP85w-z9wpJQtpx8I3H8BR
    _KD0xBsalCyN8MpnETUTwLbf502Z3h0O43r_d2IGeh2ikchCxarGn0>
X-ME-Received: <xmr:oWUraspcGSws59wmNMZL1zo5oBqp0R5PfsEr07yo3WXvVPwCZ_ViPkHO6P7vK51s0Sl2AzzgWSGKCACgUHCTNTrN1YHp-zd4Joe7zXMhkgXX5FhxiCdKP3B8uzA>
X-ME-Proxy-Cause: dmFkZTErrYj+6BPPVz1/IV8jcji/YbJf7tNmbzKUklDVBw37Mo5r82nPd5buxFHV4OrxKd
    +00SDQV9sSVg4R4yvs2QLHos0drG5qYNr6GNhg9D8ngYxfJUcCtRRhPXhE6kz5yGXnYKMY
    oJHiB0gAaPzyeGZH5d5BTyheBut4xCTujqDHaTful/fQaUhKYSKVr/XYUjihn5pTjMkS8X
    sKVE+fTH1iGH2FWO/9EBeuJFKXH3xovFqufQzUi7llGvIp9TU54IXL348v2qQAgPhg5ZW1
    SUBEtCpHKVb2aYxBd3Ta7zLOiViueqFsE4VHkel083qbKxQFVcQ42U+V55ljlncHcKp7TG
    LY+69Un4ZOa84NGexNr4G/vd2upVzFHl/W/klz2sSNVfkn/jaJi+PJYIjlIQ3DmWV1mj2L
    qvIkOpvm1eaV5WSUQcxnQg8hRmHbXWD+dTcRX+YhO2WKd/d3CvZfRvRBKkUlaQvIKbplyh
    s0OfjvuDRs7ilpEAfOTaHAJQf0XXMDspXyMRRD9XSZCsPgs3icLLvQ+sZYLLdQs2zg/0ES
    F7/01Kb2l8J18/VSyktnmbIzwMIGCeXy6fL/DF8UigJrlylKiipdW6Ol88lOwbN7fciU8A
    fdZ5+wZ5NGz7G8h3TdeKN1skCST1dirQgV4tAFAe5BBP1LheMQHN1aGHHj+g
X-ME-Proxy: <xmx:oWUrajVsEdVbXvA9HGW_pNwK6QIPFSPFqfJHXlPi5j48q8LdfpG0XA>
    <xmx:oWUravaEM15wNx1GPC7rqkZE7pAC0S9w2FsMrnw-N4HsA6uqqiTkig>
    <xmx:oWUraocAep7uuDW9-8dDd5bfJCn8pm-D-E62N-DOcqUqZK-TDJw2PA>
    <xmx:oWUrah3fuRjjc_1Dirg0t0Zs5Vux-f59AdVss4_w54osI4l5T5f5mg>
    <xmx:oWUrahBN5YrRUQIcu3783IHdjW1iWgBDwMhB9cXGDrpBkCrMhTZ0t_8y>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:20 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 7/9] selftests/landlock: add tests for quiet flag with net rules
Date: Fri, 12 Jun 2026 02:48:53 +0100
Message-ID: <364fbd08081318d64bc23049d3a7721f0a3a3624.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
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
Assisted-by: GitHub-Copilot:claude-opus-4.7 copilot-review
---

Changes in v10:
- Fix comment: dst -> dest

Changes in v9:
- Rebased on top of UDP support series

Changes in v3:
- New patch

 tools/testing/selftests/landlock/net_test.c | 138 ++++++++++++++++++--
 1 file changed, 128 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 05b41e4da28f..d35610401954 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2742,12 +2742,22 @@ TEST_F(port_specific, bind_connect_1023)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+/**
+ * matches_auditlog - Check audit log for a network access denial
+ *
+ * @audit_fd:   Audit file descriptor.
+ * @blockers:   A regex-escaped blocker string, e.g., "net\.bind_tcp".
+ * @dir_addr:   Either "saddr" or "daddr", ignored if addr is NULL.
+ * @addr:       A regex-escaped IP address string, or NULL.
+ * @dir_port:   Either "src" or "dest", ignored if addr is NULL.
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
@@ -2755,8 +2765,9 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 	 * Max strlen(dir_addr): 5
 	 * Max strlen(addr): 12
 	 * Max strlen(dir_port): 4
+	 * Max strlen(%u port): 5
 	 */
-	char log_match[sizeof(log_with_addrport_tmpl) + 37];
+	char log_match[sizeof(log_with_addrport_tmpl) + 42];
 	int log_match_len;
 
 	if (addr == NULL)
@@ -2765,7 +2776,7 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 	else
 		log_match_len = snprintf(log_match, sizeof(log_match),
 					 log_with_addrport_tmpl, blockers,
-					 dir_addr, addr, dir_port);
+					 dir_addr, addr, dir_port, port);
 	if (log_match_len > sizeof(log_match))
 		return -E2BIG;
 
@@ -2777,6 +2788,8 @@ FIXTURE(audit)
 {
 	struct service_fixture srv0;
 	struct service_fixture srv1;
+	/* srv2 has a rule with no access but quiet bit set. */
+	struct service_fixture srv2;
 	struct service_fixture unspec_srv0;
 	struct audit_filter audit_filter;
 	int audit_fd;
@@ -2836,6 +2849,7 @@ FIXTURE_SETUP(audit)
 
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
 	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
 	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
 
 	setup_loopback(_metadata);
@@ -2866,6 +2880,11 @@ TEST_F(audit, bind)
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
@@ -2873,6 +2892,8 @@ TEST_F(audit, bind)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -2880,13 +2901,24 @@ TEST_F(audit, bind)
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
@@ -2903,11 +2935,16 @@ TEST_F(audit, connect)
 	const __u64 access_rights = bind_right | conn_right;
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
 
@@ -2916,6 +2953,8 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &rule_connect_p1, 0));
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -2923,7 +2962,7 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
-				      variant->addr, "dest"));
+				      variant->addr, "dest", self->srv0.port));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2934,13 +2973,91 @@ TEST_F(audit, connect)
 		EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
 
 		EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp",
-					      NULL, NULL, NULL));
+					      NULL, NULL, NULL, 0));
 		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 		EXPECT_EQ(0, records.access);
 		EXPECT_EQ(0, records.domain);
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
@@ -2973,7 +3090,8 @@ TEST_F(audit, sendmsg)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv0, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
-				      "daddr", variant->addr, "dest"));
+				      "daddr", variant->addr, "dest",
+				      self->srv0.port));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2982,7 +3100,7 @@ TEST_F(audit, sendmsg)
 	/* Check that autobind generates a denied bind event. */
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
-				      NULL, NULL));
+				      NULL, NULL, 0));
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
@@ -2990,7 +3108,7 @@ TEST_F(audit, sendmsg)
 	EXPECT_EQ(-EACCES,
 		  sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
-				      "daddr", NULL, "dest"));
+				      "daddr", NULL, "dest", 0));
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
-- 
2.54.0
