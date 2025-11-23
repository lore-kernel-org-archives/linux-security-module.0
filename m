Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950823BCEE
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931770; cv=none; b=Y6vMwpT9oDXeWNA0M0b/EXmjIggovWN6PL+q3JD8w8X0QKmv4NOSusf4tF05CWtySP8hOnbre3QVlQFOiORiE4EALhxQSaACpx7fCQz6YhQ3WVug+QCLo46qLXfGnzLP3GcAq+lAk20FKwufdDVlzTo+8cKh5r2Y/WyHEpOOTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931770; c=relaxed/simple;
	bh=h0kNXkNCsFQbGkSMffEFxZ/Xb2hdQZHLpYc1pfmrp5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDgMKL1thi9b3tQy5LXk6ZoGNeT9ODoyxyDgcankdHB7JwUuxkyo//c15AqlNNMOtjdCjsZLgNKzMidJhA9x1CCvj83rQojVFpUjU82aowkOkaKu+UH4JLz0/LGdUAkIOcd70jPb52cMgpZki8O5XRXBiyUN+P+hHP65MlBpJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=h6ubFd4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GF75zlyP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="h6ubFd4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GF75zlyP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DB41FEC01D7;
	Sun, 23 Nov 2025 16:02:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 16:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931767; x=
	1764018167; bh=q2b5ruDIkdWaMA5f/apijydQwNVyKHUDwUQjbrV+4sQ=; b=h
	6ubFd4CZpyhlBkdjDTBEZKYkqvetKORtBJftMUHAcIXZ3UsLN+Ef0Ub2k1QyvkNc
	pV2mCITPtf/MxeG7HM5cKkhdOOYqxVSoUWmd3542kRMC+O+1yeIlXl8D4QxKm/iQ
	35iYbzKcywgKukb5CTvoWtSRTgezLWjce0cHF3v88a0irmYCO/X3rKuxk4e6cf3w
	XTuPOhUBDkZTcy6BAkSFq9qAKUkGTpRBpF+S7OwSbo+qGC10rXoQqAd/5RQtJcpp
	yohAE1TlBCwQxDQu9u9u7xtjlJnYyzvDNl7Js1C/j4wVplr1oM8N7n8O63RRnj7w
	ZTNVv8emlU/4O1EF7GxUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931767; x=1764018167; bh=q
	2b5ruDIkdWaMA5f/apijydQwNVyKHUDwUQjbrV+4sQ=; b=GF75zlyP0zTO9nBxM
	EMe2PnnxMb0j59Wu9fq0pD/UjAyUOlWaMOfo3pWuzZ7ewukUgyK+s97raz7NULI/
	Eou06+0/e8vxDsVCQFWSDiitM0BPEyhQ9kABiz9pDtVDya+HcWGSLaeqHrCft1dd
	V+3c2zFjPQyRUNuuP+4me05GdnxKiWTw8Edij30nvupukpjjKmG5t5GA/zW8leBB
	1PEla5tNck/Pps0Q0XLgZt8NpLX3RdJ8WeYK2nXNmokzYsvS3x6je54kU6HgMLib
	Zo0RlYt+ZZ7EJbxH7EM567AtwfUG73/aFHAXwr9y0mA0Mv2u3JIwpF3NY3JVIl8l
	U5Azw==
X-ME-Sender: <xms:d3YjaeQaO4nW5Oa7AIxv7H3VUuV8y_ShTmvdkfeS6ebur5L3tHYNhQ>
    <xme:d3YjaWBPUQm7p_Yu8YpW-HtkzhfhLcsfS1XqpS0o-6wqSZX9Zxx45ZetiQ22SlMvs
    bFxML0WwRrVxwZvtI7Q0PKavLsdZZbBf7hDHW2WzxU7HLrfpFtERlg>
X-ME-Received: <xmr:d3YjaeHnslyT_hkHjsmvEo3WQ9m4ynWt5M1_xXCSFp2f1P3OlffOclZ18KOKHjHz_d3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d3YjaQBPnKSbi9iFW0stKqfjyARnISgBt89-SOmDNvqXb5GFjQr2cg>
    <xmx:d3YjaWV3PKG_Dxa32imkv_4vbScUsR9MUwQpqUJhJ2LJBlrDNmvW6A>
    <xmx:d3YjacrzbPMZElmSlxurUq2BFMAytBOpkesLQX2QkdNi2TAlbMauXQ>
    <xmx:d3YjaaSkfeYlp4RgRd8o_xxE7KJVLfgtXwlZk5jI3zZrVbR1hxijsg>
    <xmx:d3YjaaRsUYc39nrQlWcr6TkQdl1I0DRTWx3FToDIPWF_2PrDGW3POIYG>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:46 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 08/10] selftests/landlock: add tests for quiet flag with net rules
Date: Sun, 23 Nov 2025 20:57:44 +0000
Message-ID: <1995a20397c8b19e7fec15c9b6672d6cadf7ec59.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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
---

Changes in v3:
- New patch

 tools/testing/selftests/landlock/net_test.c | 121 ++++++++++++++++++--
 1 file changed, 111 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2a45208551e6..0fd0ec85faff 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1871,21 +1871,22 @@ TEST_F(port_specific, bind_connect_1023)
 
 static int matches_log_tcp(const int audit_fd, const char *const blockers,
 			   const char *const dir_addr, const char *const addr,
-			   const char *const dir_port)
+			   const char *const dir_port, const __u16 port)
 {
 	static const char log_template[] = REGEX_LANDLOCK_PREFIX
-		" blockers=%s %s=%s %s=1024$";
+		" blockers=%s %s=%s %s=%u$";
 	/*
 	 * Max strlen(blockers): 16
 	 * Max strlen(dir_addr): 5
 	 * Max strlen(addr): 12
 	 * Max strlen(dir_port): 4
+	 * Max strlen(%d port): 5
 	 */
-	char log_match[sizeof(log_template) + 37];
+	char log_match[sizeof(log_template) + 42];
 	int log_match_len;
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
-				 blockers, dir_addr, addr, dir_port);
+				 blockers, dir_addr, addr, dir_port, port);
 	if (log_match_len > sizeof(log_match))
 		return -E2BIG;
 
@@ -1895,7 +1896,8 @@ static int matches_log_tcp(const int audit_fd, const char *const blockers,
 
 FIXTURE(audit)
 {
-	struct service_fixture srv0;
+	/* srv1 has a rule with no access but quiet bit set, srv0 does not. */
+	struct service_fixture srv0, srv1;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
@@ -1929,6 +1931,7 @@ FIXTURE_VARIANT_ADD(audit, ipv6) {
 FIXTURE_SETUP(audit)
 {
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
 	setup_loopback(_metadata);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -1949,6 +1952,12 @@ TEST_F(audit, bind)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.quiet_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				    LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv1.port,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -1956,6 +1965,8 @@ TEST_F(audit, bind)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -1963,11 +1974,21 @@ TEST_F(audit, bind)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv0));
 	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.bind_tcp", "saddr",
-				     variant->addr, "src"));
+				     variant->addr, "src", self->srv0.port));
 
+	/* No other logs expected. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
+
+	sock_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv1));
+
+	/* No log expected due to quiet rule. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(1, records.domain);
 
 	EXPECT_EQ(0, close(sock_fd));
 }
@@ -1977,6 +1998,12 @@ TEST_F(audit, connect)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.quiet_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				    LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv1.port,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -1984,18 +2011,92 @@ TEST_F(audit, connect)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	sock_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
-	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.connect_tcp",
-				     "daddr", variant->addr, "dest"));
+	EXPECT_EQ(0,
+		  matches_log_tcp(self->audit_fd, "net\\.connect_tcp", "daddr",
+				  variant->addr, "dest", self->srv0.port));
+
+	/* No other logs expected. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
+
+	sock_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
+
+	/* Quieted - no logs expected. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
+/* Quieting bind access has no effect on connect. */
+TEST_F(audit, connect_quiet_bind)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.quiet_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_2 = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.quiet_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	const struct landlock_net_port_attr quiet_rule = {
+		.allowed_access = 0,
+		.port = self->srv1.port,
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
+	sock_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
+	EXPECT_EQ(0,
+		  matches_log_tcp(self->audit_fd, "net\\.connect_tcp", "daddr",
+				  variant->addr, "dest", self->srv1.port));
+
+	/* No other logs expected. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(sock_fd));
+
+	/* New layer that also denies connect but has the correct quiet bit. */
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr_2, sizeof(ruleset_attr_2), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
 
+	/* Quieted - no logs expected. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(1, records.domain);
 
 	EXPECT_EQ(0, close(sock_fd));
 }
-- 
2.52.0
