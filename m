Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA43290C7
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490823; cv=none; b=FYb9MdwKklvEJMMoOwa2226qxG4X62/CG2uwg+CHBZKesEIs9LPW/RCu0bn/u1gSpFR+zIAk3z18Q/3VCcJgsYxqOz6zuRqEvnBgoOUBLfsPZccSifbgiD13RU0BWIew3g0qv33UHX9Np0RzGAs3K+VqfqlC+HM5YX2ZF+Tv7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490823; c=relaxed/simple;
	bh=b91AAxpMFbMUHVzt+eayqRVZJlbvPWcd7Eyo9HyYfkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpPZM5Zi62JOFnZARwEgsLGbfe+1w+vBKkgM8rbxEMqFqNm/iRgaJbdXZAA1E+Ld2qIN1H25ryW/58VARWvgBIdagGRdy8lXwDWNp7WTBxc2GwZ8+Vmg3IGQgLb1P61Fi5j9YP8NTUO85Gl6Z6xjnCu/0zNSmpe1Huc8Vzjf7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=a4GaJnWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcEy951J; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="a4GaJnWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcEy951J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B019F1D0016D;
	Mon,  6 Apr 2026 11:53:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490821; x=
	1775577221; bh=Xy+E2M+hX0yRZFM5aoPdlIbvMAFBnalQiS/bhUboz2U=; b=a
	4GaJnWL9MbhrsMPYr+xRx+Sy6Pzz2vz1XuLUzD9z+0cVHmx66dxkfk4zWnjpWQu6
	npFo9DqgnfWG4pZul8e0MuQNJTuEDsy8LT5cwyR11atbbiC8oHsYJiu8QzK6htkc
	aYXtkYW6wsc5q+HqxIkpGU9d2lIRycj2+nBo0giqkQv51HvRsggk1ThEXdKunMeE
	blESV5web4XSN5G3Xrk5RbcI2nmDUDA3nn+BKgm+YExgECG6K2hUeU/WoIV8q91f
	w6Ba6M4vPRgub42knpVt5sCERRv65cct7gnoJekMjuKfWc8OXOSRIa4eFAO1EqPL
	u7BaHwBXPgd7/ITPtgTQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490821; x=1775577221; bh=X
	y+E2M+hX0yRZFM5aoPdlIbvMAFBnalQiS/bhUboz2U=; b=EcEy951JQ1D7Mq+26
	s7EHp3UMUKM5CsTQFk1y9WisbkmJ9M7MHADGSq8F8HnvHS048uFgnojGn0uIdz3g
	T7S7FSs+hhcUwWpP/Ou6RNPx+1QBEpYALv5SXfPgnLS9u3yTFjlGrOG7QAAbHQN9
	vj+TxoYi6buVWClGx3D6c0Q2y4LiN8hLVBKj11jVNjZjvNGyZHCgpK2NmRcQy7bz
	az9OruS3CREmGj42EnK9Tm0DFuQ5M8u8ktdEjVBzxqY95hOE6lWU/KETRDvU5SnS
	nl5dMfO45SyDITB4gR4Cv1XpUNh6h6l7BsXoAKlcqZLrQVlAHOM/DMinMdXwunJR
	qd0Sw==
X-ME-Sender: <xms:BdfTaZPDMszChijAxpVLzzKAVqRIqNAuy2XG_-7RyerGhbRzJtmjOQ>
    <xme:BdfTaeNbpVFMbA40KksObhhgFo7y7gwXDd6dfiVrDsqVDPfUu2rgcnMpUUMKot0FY
    O8Ga3Jd4u6LwN-b1bJ0vM7TOWpxw1rWyOADC0MzvUOeU4xEyjvRxG4>
X-ME-Received: <xmr:BdfTaajtfc7oAYqfuhDhR0Td6SicfsJ9zWdfwSI5F-pQKDh4giACW8dfQj9IOHWFl6rUeaUzugEVmgbOD8K8v-tSaVYTUI1bQDNiJQhULGP_UDurptzA5TxFMjakVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BdfTabuOsmQq-nEzx6FsKvu8K_pQgSdUOy0VJqshmAThN61hHJqrEw>
    <xmx:BdfTaQScW1KfG2ZjcWxB-RPFZT-EzRsqDlGZnkvZfrNAogRXsvG_NQ>
    <xmx:BdfTaX1lKv1Rb7di8TYPDifxYNtGfB_btPg3plyS4OlgrjLcx3TzFg>
    <xmx:BdfTadvfUUv0LhYNgEq81b0ZBR9qJRtChtGjDOSpat-FyOdrTj0pRw>
    <xmx:BdfTafYSXG4-aDwVwVyilJazekN2qysJVsX4nQj_HMxFNmPwlNjconQf>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:40 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 8/9] selftests/landlock: Add tests for quiet flag with scope
Date: Mon,  6 Apr 2026 16:52:21 +0100
Message-ID: <0c22db59055643657a5c171846bf2ddccaa8d3ad.1775490344.git.m@maowtm.org>
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

Enhance scoped_audit.connect_to_child and audit_flags.signal to test
interaction with various quiet flag settings.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v4:
- New patch

 tools/testing/selftests/landlock/audit_test.c | 25 ++++--
 .../landlock/scoped_abstract_unix_test.c      | 77 ++++++++++++++++---
 2 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 36b0e750e889..a0f51e3e93b1 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -607,30 +607,42 @@ FIXTURE(audit_flags)
 FIXTURE_VARIANT(audit_flags)
 {
 	const int restrict_flags;
+	const __u64 quiet_scoped;
 };
 
 /* clang-format off */
 FIXTURE_VARIANT_ADD(audit_flags, default) {
 	/* clang-format on */
 	.restrict_flags = 0,
+	.quiet_scoped = 0,
 };
 
 /* clang-format off */
 FIXTURE_VARIANT_ADD(audit_flags, same_exec_off) {
 	/* clang-format on */
 	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+	.quiet_scoped = 0,
 };
 
 /* clang-format off */
 FIXTURE_VARIANT_ADD(audit_flags, subdomains_off) {
 	/* clang-format on */
 	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF,
+	.quiet_scoped = 0,
 };
 
 /* clang-format off */
 FIXTURE_VARIANT_ADD(audit_flags, cross_exec_on) {
 	/* clang-format on */
 	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
+	.quiet_scoped = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_flags, signal_quieted) {
+	/* clang-format on */
+	.restrict_flags = 0,
+	.quiet_scoped = LANDLOCK_SCOPE_SIGNAL,
 };
 
 FIXTURE_SETUP(audit_flags)
@@ -674,12 +686,16 @@ TEST_F(audit_flags, signal)
 	pid_t child;
 	struct audit_records records;
 	__u64 deallocated_dom = 2;
+	bool expect_audit = !(variant->restrict_flags &
+			      LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) &&
+			    !(variant->quiet_scoped & LANDLOCK_SCOPE_SIGNAL);
 
 	child = fork();
 	ASSERT_LE(0, child);
 	if (child == 0) {
 		const struct landlock_ruleset_attr ruleset_attr = {
 			.scoped = LANDLOCK_SCOPE_SIGNAL,
+			.quiet_scoped = variant->quiet_scoped,
 		};
 		int ruleset_fd;
 
@@ -696,8 +712,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(-EAGAIN, matches_log_signal(
 						   _metadata, self->audit_fd,
 						   getppid(), self->domain_id));
@@ -724,8 +739,7 @@ TEST_F(audit_flags, signal)
 
 		/* Makes sure there is no superfluous logged records. */
 		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(0, records.access);
 		} else {
 			EXPECT_EQ(1, records.access);
@@ -748,8 +762,7 @@ TEST_F(audit_flags, signal)
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 
-	if (variant->restrict_flags &
-	    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+	if (!expect_audit) {
 		/*
 		 * No deallocation record: denials=0 never matches a real
 		 * record.
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index c47491d2d1c1..ac456185b835 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -293,6 +293,45 @@ FIXTURE_TEARDOWN_PARENT(scoped_audit)
 	EXPECT_EQ(0, audit_cleanup(-1, NULL));
 }
 
+FIXTURE_VARIANT(scoped_audit)
+{
+	const __u64 scoped;
+	const __u64 quiet_scoped;
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, no_quiet)
+{
+	// clang-format on
+	.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+	.quiet_scoped = 0,
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, quiet_abstract_socket)
+{
+	// clang-format on
+	.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+	.quiet_scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, quiet_abstract_socket_2)
+{
+	// clang-format on
+	.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL,
+	.quiet_scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
+			LANDLOCK_SCOPE_SIGNAL,
+};
+
+// clang-format off
+FIXTURE_VARIANT_ADD(scoped_audit, quiet_unrelated)
+{
+	// clang-format on
+	.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET | LANDLOCK_SCOPE_SIGNAL,
+	.quiet_scoped = LANDLOCK_SCOPE_SIGNAL,
+};
+
 /* python -c 'print(b"\0selftests-landlock-abstract-unix-".hex().upper())' */
 #define ABSTRACT_SOCKET_PATH_PREFIX \
 	"0073656C6674657374732D6C616E646C6F636B2D61627374726163742D756E69782D"
@@ -308,6 +347,13 @@ TEST_F(scoped_audit, connect_to_child)
 	char buf;
 	int dgram_client;
 	struct audit_records records;
+	int ruleset_fd;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = variant->scoped,
+		.quiet_scoped = variant->quiet_scoped,
+	};
+	bool should_audit =
+		!(variant->quiet_scoped & LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
@@ -344,7 +390,14 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(0, close(pipe_child[1]));
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd)
+	{
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -359,14 +412,20 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(-1, err_dgram);
 	EXPECT_EQ(EPERM, errno);
 
-	EXPECT_EQ(
-		0,
-		audit_match_record(
-			self->audit_fd, AUDIT_LANDLOCK_ACCESS,
-			REGEX_LANDLOCK_PREFIX
-			" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
-			"[0-9A-F]\\+$",
-			NULL));
+	if (should_audit) {
+		EXPECT_EQ(
+			0,
+			audit_match_record(
+				self->audit_fd, AUDIT_LANDLOCK_ACCESS,
+				REGEX_LANDLOCK_PREFIX
+				" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
+				"[0-9A-F]\\+$",
+				NULL));
+	}
+
+	/* No other logs */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	EXPECT_EQ(0, close(dgram_client));
-- 
2.53.0
