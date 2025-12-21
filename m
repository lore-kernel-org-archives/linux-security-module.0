Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBB7262F
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766330484; cv=none; b=bWH4vhJB5LQj/6lVIKkNwHCcd7BK18a2Xg4guYaDZSb6rlOoDw4RQa9UsSQzEXVlBAvz0gH02wabwVNbXVHhyd9FFzfuJiTZw/nhVHQ+CCFFpntqRxsjd/xa+BB1TxzJ6DJfz1jAuFtrOIxdfooUex8uT2jcEGpGlijNTt3FlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766330484; c=relaxed/simple;
	bh=Q45qvLisPhscdmznCJIWmMwjAgcjPKbsrfxIgK3q+wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo0W4UawbivfxDFwZgQ1smxv/0w3AlghIoLsHKNnBeNh4DAR4Ica+HHaIgoAkVfpvQg3NaoJGm6XuwUT0celv6JYCsrxGjyTNbGnBfGAAJB2SLtnWh7g9PEerhKT1z7E5y0Ywu0hMq4uOyUcMKyJuqFlt18ZF0rYCYeF1Shc53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=EBm/uIuS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UaU+89/+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="EBm/uIuS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UaU+89/+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3E82140001B;
	Sun, 21 Dec 2025 10:21:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 21 Dec 2025 10:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766330481; x=
	1766416881; bh=uyJcasQJJZTiD6RfJLVeUFJAJeO3OEmDpBojbzpVFEw=; b=E
	Bm/uIuSu8OeWr+JFMVMFJ5yjcw20AeNcFvgD6Y7Ca7bziCKw+h3Ht7EayWqyXpON
	AiE76BDbTGS6rmHDO3dNsvV8JlyuPsmsMCK/oZJetBEgc0sOHaJgB1ej4ss2y78F
	jjj8ZBF6EfmHvpfoKnTmW/5z7C89fX+F8yYLKtgq0XPAW/Mvpu0q2N3fl79GJKHg
	k5NKgMt4Ti0IfTKJA/ZuRu1zgdy49cDyOf2LQ3FmpgKRzPhekdmlGh1jw5wpKM6r
	dhhMEovyMRabljQtp/i/LAymw3cxOUDPWvW3dPmOW+2Yns4XeutlL6JvkdiaIXHk
	vv/fAAISzpAohxrD0+R1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766330481; x=1766416881; bh=u
	yJcasQJJZTiD6RfJLVeUFJAJeO3OEmDpBojbzpVFEw=; b=UaU+89/+L4MsuwKON
	cwelol/xA3mDwtJehJEyBLjJ8yFyId3ujAqTgEsfkXAWs7vApaKX19nJ3FsfLWlo
	xCzjIOwsQtoPuS50LCczrM1CGKLcFMnaGP49BJid9SpZkgBmT1bbwlxzhC/pbiBT
	doTE/NGsfRGlImgql28S+9LMfRcCj9Rtq0NsKcfTMVpAF8m64v9+ZO6tdNXMXUm1
	8y7SYFfUNPLgCRLq8noojF0ljboqMFob1lEc/iBWxdsVhS2kTt/L+gwn6AQAaDOY
	lfShAumAGHCJVYZ3hxjIrktXnCOPpuANN3PFjlCuymmlLvQfkePlNqvfLcSwzADl
	OukOA==
X-ME-Sender: <xms:cRBIaXwE0TRb4mz1bDEm2Z8EtbI_nXsnLH-xIp-mu9tZsbOfWy3LAA>
    <xme:cRBIaRhVJPCAzpYtrxLGBQ7gnDgs9IQDbE5JFSe7bXL16oedrXZ8IhnsxXhvomRMp
    7U_ukqqEmOrIjsCzT9d8xtDS9KfeIxNZwPicmkOruW7stW8yNMG-Bo>
X-ME-Received: <xmr:cRBIaTmnTxEJf1QEi8rIDDJSeE-T1-LNt6Mv2LtJRY-rHcYuXAjQ1P6x-jzKiOK3Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cRBIaXjXYhS-peqQoaprL6C6gap4whm5UvCRpRu-yi9Y_SyIwPxW9w>
    <xmx:cRBIaX1iAHaTyNoIKzpKSrmJR0f0jOOqZ0s_0relGPRvwNnVjQZT1A>
    <xmx:cRBIaQKdLxp9eqx0nk01xKl-bwcjDBKnMo7RKMUAJBRpuHta1FIp_w>
    <xmx:cRBIaXwBCNtZy1zf7X2pLXuD_5Qe-XCTGM6U7a0IEDNOkON2Nz9_Xw>
    <xmx:cRBIadx4_ug6PmaG2-pUFPpBWpNu3BxlKZlLelfS1kPsAXK1rETXvfl1>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 10:21:20 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 7/9] selftests/landlock: add tests for quiet flag with net rules
Date: Sun, 21 Dec 2025 15:20:39 +0000
Message-ID: <236314bb16e700af6a4f3c939cf6ed1fea108862.1766330134.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766330134.git.m@maowtm.org>
References: <cover.1766330134.git.m@maowtm.org>
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
index b34b139b3f89..137718ff89bd 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1897,21 +1897,22 @@ TEST_F(port_specific, bind_connect_1023)
 
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
 
@@ -1921,7 +1922,8 @@ static int matches_log_tcp(const int audit_fd, const char *const blockers,
 
 FIXTURE(audit)
 {
-	struct service_fixture srv0;
+	/* srv1 has a rule with no access but quiet bit set, srv0 does not. */
+	struct service_fixture srv0, srv1;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
@@ -1955,6 +1957,7 @@ FIXTURE_VARIANT_ADD(audit, ipv6) {
 FIXTURE_SETUP(audit)
 {
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
 	setup_loopback(_metadata);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -1975,6 +1978,12 @@ TEST_F(audit, bind)
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
@@ -1982,6 +1991,8 @@ TEST_F(audit, bind)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &quiet_rule, LANDLOCK_ADD_RULE_QUIET));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -1989,11 +2000,21 @@ TEST_F(audit, bind)
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
@@ -2003,6 +2024,12 @@ TEST_F(audit, connect)
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
@@ -2010,18 +2037,92 @@ TEST_F(audit, connect)
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
