Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE12D47E9
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490822; cv=none; b=dvqDF/srGuk2n3m/nr8Oq4njOG3CBNRN6CgOz75xQarmef/2qyg2vng9CQ4AGjikjXL6O/STx551Yktfpztf5oY4xZrJ4bTuLfImevEeka+T4zbcbV16YffqQq/mdyzsKSorQuT5i0sfqv97yFCC1hz0Ooa91v0SIqQ6Xm9XymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490822; c=relaxed/simple;
	bh=BO4uDbH0iZQRbuexf9ip6Akjf0bbhcut7MX7POki4hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjmi/WE1Vp9JSbZpLi2w3/KdPavHuqe0Ahnws1+kUdQxyhXZecRURt9AjTHE/w+tBDdiKjjnWq5Vp9xeQjh6m7DC6IWuUr/z50SYMTrjqoUbg/UeAuW5o6SPNRy5kkXPfnAQRQwY60fKMMY9TO6HUCtUdf9bCO5gIKsLb3YIxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=T5wT2oUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pn+DDcOd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="T5wT2oUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pn+DDcOd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3521F1D0012C;
	Mon,  6 Apr 2026 11:53:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 06 Apr 2026 11:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490820; x=
	1775577220; bh=6aQPAsRUv+Jk9M+RPwceU0em0/Dv0LaTIEhs3QDe5ZQ=; b=T
	5wT2oUjKB1i/YSjou53hCQFlw6dvOETfRwsNce/WUT703LIrDbW8PJ/7dUTQ9EL8
	t54Eb5cBdmrTRFyKrv3wjIIMG1Em72DkFzJoLu9ZNZzb1vnwTzW4gK8QDDgd7sBQ
	O/PkFG+rYex1usH9n6uptbQddMZ60SZM2QtgAjCQws10r9zxPRIa5aNhcmG9m04f
	5bEKDMhraD5QDByOoHY2fWmrFf7js5j22/7LJ37jN9pXixOO6hHAmKUaIupOLHO4
	n+SyU+bw+BJgX0v+aFRCKDzxAClCfteSXSB7uID/UHtV2g1wdsP5J+1KHnVjMWtW
	6gxSbwVIYcj7DDtkxDEsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490820; x=1775577220; bh=6
	aQPAsRUv+Jk9M+RPwceU0em0/Dv0LaTIEhs3QDe5ZQ=; b=pn+DDcOdIuZ4HzxEz
	l3/EYP33Iyt7ddKTBTjAbJ1c2b2EYmsr/43XXwfRCD86Re9C8ffW6BCNcztUFGMh
	7kJY8nKOTwv5RWzDiZqLDboaV0oox9uVLJb+YYATmz5g22SlM76drjBnN7Nb37PI
	fLMNezlvbFsMj7qBA7aTaglY0sXHerQ9iYVM2zvuVwoL351F1af6aKALmD3HWsSm
	gTkvUlIPR+85cRQepRvLBo8lIqmSXqmTq47DMfcQWC+S3HhORtJI5xcCzjxxAFcO
	AC7+2w6zTn3lVk6Ke2x49XQiNl+UvoXD/mey2TCACL7qgtKyIh/pH0nc4mudBUTq
	7vENg==
X-ME-Sender: <xms:A9fTaQjZg3Q1lEsmqW8DdO7mhHVi0XiBrpH6ikKGCEbYoXtnsN_lRA>
    <xme:A9fTabScThOLsFXfkQ3hqVCelQZ0Zm5i3oEWfIvmBOGM7dSlXcq771yKo3nq-v7Ws
    bn-rtmYgs3atCW5XTnCEFqpwkjYBF0OB8-LRMusQgz1qBVFVPHlOKI>
X-ME-Received: <xmr:A9fTaaVMdlLDIrdxpKzyMSwvoLTqHnKt2PkU8Q-qCPLkd7Uf8-WbwfatHlRX-wVSoemXQYz05yEaXDHWzev9ji_BU2nN5RsneTvdgbCdcVhopDYwWkfCSc1zYjCdjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A9fTaXROBrJWVOVPqKHGyOGS_L2QxYxGXveNb3-gata7lEDjYhRg5w>
    <xmx:A9fTaclz0KkYYS5Au-B2MepoIzCSSkty-cueq40dzqEWDkhtq5DKiA>
    <xmx:A9fTaV5CYfPLhx2RqHMbXS-jZH4QPLUvL73-2sMatwL4ztYFwR_5fQ>
    <xmx:A9fTaagRjCj9q8ZpbNhvCdA1NbZ4JNaoPW8TS7szd6ja9jvnFQLlAw>
    <xmx:A9fTab--2_uiFa2uAi_nk68zF5GfQC4TTvBIKdHXM6kixdXNf9iOCb6n>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:38 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 7/9] selftests/landlock: add tests for quiet flag with net rules
Date: Mon,  6 Apr 2026 16:52:20 +0100
Message-ID: <9d1f16d184a46be602496ae17b63f40ac2920ec3.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
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
index 4c528154ea92..729cb2f76517 100644
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
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr_2,
+					     sizeof(ruleset_attr_2), 0);
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
2.53.0
