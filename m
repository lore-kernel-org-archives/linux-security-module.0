Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7064B640
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272070; cv=none; b=cYdO35KP1Q8VJ0YJ0KRu5S+RWfTjJIJnEFpAQumjwdNmKVcyWkY2IZ4jCntS15jALIVazMei4ucTBzTKb3IfHyX/vgXembqObWiKPEUFHQRpdNu2cEZCu+s6LNeiipW03NWAQ6wxQSFbGgagj0jyssZGSHvr1WP94ILobpkMYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272070; c=relaxed/simple;
	bh=fMtxwLpAQAv9DrqB2JDHa3cx3H19fSFyNKvhOzJFxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/h7NqIXt9S9UkOqLTXNBsivZ9KRtfGijLL3Ea3180xhy3L0sMQZqgUvE6YESDNLvGF02wYvzAm4T2rBKU3pJxXasAVVz2UqN0MdUwoO1DXHuScf6XO2f11yOG3uDxRLPTbfZK5D/KyO9W493O8UqSnkbe//S25rVnGTnGCKaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jErYUe2h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uvhPm32V; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jErYUe2h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uvhPm32V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03ED87A0084;
	Sun, 31 May 2026 20:01:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 31 May 2026 20:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272067; x=
	1780358467; bh=goV3f+j6k+RYEdywb3DeVKGz8z86Y6zYoM5C7bwYjwI=; b=j
	ErYUe2hn4Q451VHzaHk07JXAxzp6YnpXvr+8BT81IBEYwvc5+hkpxLYbGBIQl5w/
	5FtDr+xfzfmQ/65Nty75vjVYIg8whIShM7ke7OBvNpfdmrNeYCDW27VUHvaI/NSj
	UKpAtcx9n2mx1fYGzlaqRSkSZwegOJZSteKUpQPENSkzCR8wT/238bkJ6PYmfuRA
	EILV32sikpIVZwj+RV5689MM1tsXjmUK7Jz24K4rgE60Xn+Kjc0Ig8iSIS0tT13k
	d/rSvgHNSWiZaaQX4hdVhVlzeT4w+LvO3j0jcweZ9b5coT0c0JnE8e+yFM7Bew29
	EXJvOfR7Fr9p65iz4XIQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272067; x=1780358467; bh=g
	oV3f+j6k+RYEdywb3DeVKGz8z86Y6zYoM5C7bwYjwI=; b=uvhPm32VYPK51kIJr
	OSi0o7xuYY4/aEE38dEolY/iX2eY5+J9MMBtNfDBQzf3GKu8GJj0r1HFOBJOCl77
	lLLk1TATBBa8WenLawDWg4+AkechsjHyNlpz4FAXlYDMnxZgRh1blzuOEbhOyJ/0
	BoI1MmFBYez5/d8KKhZTUTK5uV5iAw/W/MdoKHgFIsBrvrFnKqtCHnXATx2m7/E5
	C+x2ZUFoSxVjVDL9w8+CG+cVw1TRGBPQdJLvrGsKVyVvOmERVMA9OchZweMjhbEZ
	d6qX7/Rc78S+9KjljBPW9O8Kqr+VQuDVjAzdsEvsjSgeKHYcJEXlY8FJzLwNlgZP
	fgg0g==
X-ME-Sender: <xms:w8scamH34DDQb7dAtuVFoqk6DYtzJKVxIDLbCXrOd5bCpBBlKBhNrg>
    <xme:w8scapl-RBidVIFWelSO_orkB8bFKN0a0ZduHBhLp3BP5wWINbSmQT8KKQWgCr3Ce
    FvLD1OaIpWJJ2bP9_CfFVx0wu12BGCeFdD4aLeWM_oTvHgeWqD9_RA>
X-ME-Received: <xmr:w8scaiY5Ny1lCK-YflexybTobJ22bZZRuLD3izgxTo9i0UnFX1hqgcBpCHLwuziAVYo>
X-ME-Proxy-Cause: dmFkZTFdvInY70kURnUCfKLYaCaykxu4LL1YtluT4AUkIC4NABNzVKhsvUmfXMXCQVB1Od
    SIsDxPE7K4hcNAjitVx+OxpJplumsMZEK/XMin0zATGGpQYE+onMtG+HalOLgNxkKgJsW3
    F4k7bntDUXB7q//Vc9n+PSMzuliqSvna9VOTWR4jEso6YSxtj79EeHk2RYI3ZFvwpwNMB4
    w5Zv51hC3apNjHa0By5pzX9z3J2+nVr8013d7XNZDDBiKfeftChOTXc5fDDwr919RhizQ6
    d0AGUZ8DxQanjVjYBTu26hK+38ZdNQDSe9/IiqilLy/Zcn0mX2lNmWlUIeEci41ZeiXSVN
    WQzMaf8Vo+ERia/lqaKXLxVXf6f+xK46rncgVot6trlCLP4WJS3SjNw2YEvoCmdTv4gpTa
    1T2OQ69C9zlt9wE1NVHNdxUC8eVXyB9dtI0vMNwrRdpT0Qt6hVVnOW84PIXHjqQb8pa75n
    kj6mN9y/09ZFtp9le0JfyQQk29xUSOQUloSMyar6xCgVix6FTJ/ei+OrAhRyudeqaUqmK/
    IkRFhYNp2ODP0ByfQ4N3B2H6xVIf35eWub6S4E9r/PFDl3DUCKKArlQHyGRqQdHcWtTXco
    6ShF+EfUQBk2bxD1eptKAtlsC8W9wUb5MyLdvTQMKZo4AIBEvYpE/nB3sKqQ
X-ME-Proxy: <xmx:w8scamHnkg-GSfSOOpr1pvVGrFLGTfpDlb5WTNFsyjrZIRWdT7IS0Q>
    <xmx:w8scarJ-jlAYHoFqcmy07j4q3oFJEZA34QyjCofJAMqOHN7F1x-W_g>
    <xmx:w8scapM95cx8BErn_FRu3020Ac5LJ1I40ALF4cTmYtVdBpk977Mc0g>
    <xmx:w8scajmlS-ROzXuC8mQb9Lcx_O_AMJxMe-8chwJSavfFKghh_g_8sQ>
    <xmx:w8scavwA7yilTdiYpsQUX8lsNJml2H_8cFjTjSXZZq6jiVQ-5sEg8iI8>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:01:06 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 7/9] selftests/landlock: add tests for quiet flag with net rules
Date: Mon,  1 Jun 2026 01:00:41 +0100
Message-ID: <0aefb6cf9aba0bf07f70a38a4d6eeb245b891bbb.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
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
