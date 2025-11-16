Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A791C5D6A
	for <linux-security-module@vger.kernel.org>; Sun, 16 Nov 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330562; cv=none; b=i0YpAiB+t4r0+2/g1PjxA4XGVRTDLGBeIa5H3vysaoLUKUDD/hfY/XsNh/tKiVIZyplK3Y7NKw1FK9Qk+Y/QhMkhyFilC3U81z13jhHnoFg8hXwUXIQakzXSZfiFY7PnVGn2glDqULIOXEvH2vmIw/dzgDj4sIdRuG/i2co/sUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330562; c=relaxed/simple;
	bh=M2BOVMhBPAWqmKRfzQ+ld5iiUfCVZFz97QF8o5bbPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlpO3IJiHQwWBRXM01Z8RY/cSiAi0yNcm70ndzLyQUjzgA6VZOL5iKgAVS/xolnZGvaZd7At3o19rUpuo7/zaj8Ayy7pqBvBdB+PFb3B4e8lx1gCw99eh4STdgnsD6zuXACZ4Q5pOuFt01Oqj52sYmOckGI2cKsLW1VBLMuHDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Lwe0Mwtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mG/A6QSO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Lwe0Mwtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mG/A6QSO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B23BF7A00FC;
	Sun, 16 Nov 2025 17:02:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Nov 2025 17:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763330559; x=
	1763416959; bh=xK7iPpvH+IxqDwIaVS8WzBwJVh6QCybfUZjJvCaNHuc=; b=L
	we0MwtrXXJ0nG843TbHc2shQHXGjk+9rb+wdNoPsTmmHkB4DZ4lC43pZeimfgPAo
	bgF1eiTkDhAUUvUqpCArcbKYf/VC0X3n55GVWMLSYpRn8YdX7ltgTHrajvdxNTuu
	7imydqUECCCQtq+lqtMfWJlB1CxsX6+1wftJxKL8irbEvDQe86vJjPaaoP6lPruT
	JupHG+72IZTFdAcQogu/NelaQcyGSohNAs4jtl0mlPgCw1TXLVsjY6TDy2IN68/k
	JNgR7nH6J/phEQfl5WkYVHaCnnv8gZdpFsuotFbUcM1mzHvd+9Z6MzbTX/fq+jLT
	lECwVjPjXWv2v6IIAwUXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763330559; x=1763416959; bh=x
	K7iPpvH+IxqDwIaVS8WzBwJVh6QCybfUZjJvCaNHuc=; b=mG/A6QSOAZ33BPayo
	ai9/wc7wXdoElK9RO8hBazC5Q5tKB79zWutLQRiHO0fFozZTR45nN5MGskiAl8bo
	4iouwWrRrj4qHjnfwD4dFNQOKWXiI5c1RFgXU4Q+Iz1+3UZuzVf9t0FL6kfVsnrQ
	wLSSAHZUItBOKeM6sgosOWZSvGfuD8ATfXh2yvVRn5iLsQzD0GpOc9fKrilYjSkN
	X62cozjQEykGo4pz7NkJabe/6w+TZjmq91qrw8pUE1iRn/fpUwdzEvwpQABl96T6
	ABoPkvhrTDGIHahk5IGjJhB85Nbh06CuL8DoEKCAubecutva3SRR5XhHHtyWepF+
	o+SXw==
X-ME-Sender: <xms:_0kaaQgQJ86435Vv_ei4x1SSjufwSc-hzr11vqls1iwe_MGhBndYSg>
    <xme:_0kaabQHN5VlK_6UbVOQ148sitqhP5A6Pw9Xjxt8x50aFdsoFEqiXNUPKP2Fw3uBG
    AZZmeFGAfxLNl5H76V2S7zLf0FW6By_k_4bgMsfZAAD3cNiKOQ9SVc>
X-ME-Received: <xmr:_0kaaaXbjRbjDVF2eSBz99sZJKEivDnSMlIj8ac-Leo0x3an-2Ugj41FzWyzrllFOeNGJ462sZyueX4yiG1wDbL2oZu_MGR9BTcKpkZTnKB353wFggQEhpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_0kaaXQxiC6PGBufoEU6lQBXgyoL2n5X7C2F2KeWC0AcEKGKHlpWdA>
    <xmx:_0kaackaEKPye7jf3_WmNlY7hH2aSFr1PvownQuskaUXEJ3z9FtE0w>
    <xmx:_0kaaV5dhTcCFJnlCM2k5gIMJIVLaeo6Q3wAwxJYRa6Gk3tUeygoQw>
    <xmx:_0kaaaiQLYBwC7kozc-eSbbFnJtxupnVRhZN2Rz2C4Jf3Xe430hoMg>
    <xmx:_0kaabjCqeugO184zAgoCdL73ROY_DbAqtCN4G5VXxCrVgqbPAEggQpE>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:02:38 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 08/10] selftests/landlock: add tests for quiet flag with net rules
Date: Sun, 16 Nov 2025 21:59:38 +0000
Message-ID: <2400b0c7ef06bea1a7d4490cd94e7a5c454ac574.1763330228.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763330228.git.m@maowtm.org>
References: <cover.1763330228.git.m@maowtm.org>
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

Changes since v2:
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
2.51.2
