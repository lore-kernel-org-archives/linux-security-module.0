Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2F21D3F8
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511544; cv=none; b=Lb9TNfBQfd0srQPkQDYm2b2bSWgqjHpntdqaLEAu0Ap105bfmSOcvTzi1x6b4UCsURbzJfibtvGERy+o0Bk5uFIGVYZE3+Aj4UbY9ck9/ma2nWXu01D2v8fFdED7EVQ/j1xkBFioPsEbR6IsIO5S6Fz+lZuXFMHgZp97V9VBfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511544; c=relaxed/simple;
	bh=kYU3VWBUrtSbhy7fHEGb0Zv4lC8KXuS7A9WBFRCl1Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+PQ4+UTbjYpStmGKHt565abC2FqA2DT8gOmU2MnN0OvxLQzKfMqTDR7e8e/p76GbOVCG5Zod03p3L83pgbQc8giFlQEibhJ34W5BwomE4onHJGd0bMsZan67YQjDAdZlTuG7bHpGnC+VcFTxZdIzJAOb3tJFvEdbzb4DkBU0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ZM6ASBNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkByqrcF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ZM6ASBNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkByqrcF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0218EEC027B;
	Sun, 26 Oct 2025 16:45:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 16:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761511541; x=
	1761597941; bh=kkfqQuLsKC8LLzANffIeFKkPjDcAzfHJ+fU1gP7kGyI=; b=Z
	M6ASBNyd7dBeTZJ2n+0u/NrcaNQp6WA/1ao3nPbJlNECRmV20nrQIrP5W01t3h10
	21WsHCWqQrnMmoVEJeUMoOUvuqMAtdJ2NKCvs4EQYNVmbFzU3VxRIVisuEYdsjE6
	/CmaUpUKLF8VitrxMneT6Cxi0JHP4jEo8MS/ywu63RyXpb79grW/PChcujusytmL
	3mjHaFDar7i9lJQq+9EhvJq6rGjjqU642skq3i1EvwypKmRFmRDxyNXlTFIAdIML
	jkFpZmUdyhmO99sjaDea1yaxe+xdBvdjgQbEEIZVzaQXBu7f6WxMLAc16GqYIhvP
	Jq7G7eQN8DxcUKekVGAbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761511541; x=1761597941; bh=k
	kfqQuLsKC8LLzANffIeFKkPjDcAzfHJ+fU1gP7kGyI=; b=PkByqrcF/Bp/Tr4ys
	xtCsmrjuHx4oznTd2dfswoby1bq3EPqmDM/iRTJ2osjmyx1n8FvD326BdVm9fUos
	LSLG+IwSj/FTg8k36em4MbinBtG9ssKlcP6h8azIg9I9V5axF7Uvi6HhOWi5hkni
	9n/DwaSl/qVq2NSJLyFk/70e3vkKQN4Ehru9lmq2gsiIKUSqPD92XynJnoemBAjs
	K9RG5tAZJNQ1g08Vhg5bA1/NgAZZe8OuLRAAAjfzODfIc7f/gXtY+HpJG+DkupLD
	jag40SWZ+twiUDDk0Rx+ifQYC3cuBB0lIfF+k5DOvzU7NftWZuT3Ml7lD8tzByo3
	GngaQ==
X-ME-Sender: <xms:dYj-aMIVUJI_VP0vkSaGMxJay2OeFBiROrBUS50hOt6pjwy4xXwKjg>
    <xme:dYj-aP3Q7oGhK4i6ndtHxDPn0GxP4EiabrUCHr0dsb8m44MfWzUKZhn4X988_12z4
    qUWaCk-n48eJw7EXZiuEkxGDWeWWiGMNKB8L5etJrNaJuH6YwIYB65l>
X-ME-Received: <xmr:dYj-aGikcToQ4SKKteeZ2eadZ20_4rOGWqchfzVNDRTrtRLxD6Tp2XE47UYZUXF9kGW9gt2vQh3DiipXgHIldH_vcM3pawsUSGzBji3D937xPCWdxrvl04FOXhKOgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dYj-aAXg5Z-8L9rzfBfzeV3J9dRKJ6jTQhQfHgtJGd7fbRzMJ-BgOA>
    <xmx:dYj-aFWvNt2iAYEgrHZCeouhzk6x7axrg8l7-hvP2H9cmdS85SZqwA>
    <xmx:dYj-aAgkWznJUVRmx70INWtf7OPYbk7LjqPTCZvRQfI7OnWkb5X0ag>
    <xmx:dYj-aAb-lYP_eNVbCmL-BO6iAZHI7bldR7mwcMZXZOU6NBhoOkeHrg>
    <xmx:dYj-aLWaqf6sHU9ryki95LWxfGZXr-f2lkGNyEXf0w9z_YHrHQkHBdwc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:40 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 8/8] selftests/landlock: add tests for quiet flag with net rules
Date: Sun, 26 Oct 2025 20:44:23 +0000
Message-ID: <6e82c7c7dbbd1f608d6f4ec9cacdda6932a74c0a.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
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
2.51.1
