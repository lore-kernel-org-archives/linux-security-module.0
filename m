Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6DBA34
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272071; cv=none; b=T57URlNdOK/nsVbwrEr+MSAqRaENoZCEOVR0qdrd/pkV8A8GoK+WERuwo4ulqw63OMU/6MT90ix9/RQiZQsCWAXPMXNMdcHQa5VaQstvfvY269HbA+23LQWOzBohy0ENgduxJ36b4B7QYanXXrB3BcKZTdZZIAb4NMPvmoGWrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272071; c=relaxed/simple;
	bh=1ZdD1YSOBgDeKcqps1YGzi9IWCXeBvU4umcJLPhS1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxrNNkQ+T2lEKkthHHm7KVPcVFyEoTZhli7P1pK2Fe2D5k77jYNNgZlwg6xZLiTyq9c4ZgQOtOxekQpFY7RRw/5toF3wpWIXTu3yYNCE8DEQjGCkREGWkNAoq5Z7odqaY6UT4JghvjFObvMmtAATmtTTPkAZaZ4Cg3UIPQifaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=8G7tAiy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5LVwhVh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="8G7tAiy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5LVwhVh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FEE71D000BF;
	Sun, 31 May 2026 20:01:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 31 May 2026 20:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272069; x=
	1780358469; bh=ysweR4kAsteLTHdsuQZ8ZZrdFYSjcsQQwiW64IqKlCI=; b=8
	G7tAiy/Yw4fcLVOVRrSAiuwPb4DZ/5k/L7Ul3D+J48zYhb8oJ3orgcCQ/4JEwAxf
	5zrseRlJRml9M9Kdc9K6+WreFvtXMmGZSlWStyqVD1UJR34Ko2g0rzrMK47FA2en
	ULA6Zf5PtPYHMwKG/x1UIQusGpEzZWp6zg94e2RjOhwaXoWB9AOW1K7BtWPa+EBB
	/LM2pgKBmBIdIBOYE+hO71ieWg2WAoxhvxt/v22TyEZLfrttazZBiHxskLxUefHJ
	zjFNrmqFPBZrYuk756ATDwkeCYSX8qrz/niT1ux77g8lPoaVeRKVabIfR7oJ2KZS
	gOwXUTzXRvt9B4Vy5a5SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272069; x=1780358469; bh=y
	sweR4kAsteLTHdsuQZ8ZZrdFYSjcsQQwiW64IqKlCI=; b=C5LVwhVhw5E283d79
	UfQu6gUwfImTXFOxCa5crHPQeqCFtTT428mnGegAjxGQDpn7CwdeSq3eNGtYPidS
	H7Pt2Xl7t1mXa4Mp66FAL892Ez7+sosfWNpjFXVEjqCTMYdCnxPHdAPaidjNtt6A
	fyLaB08BC9UEHKtpfjcjAX2HXvC2qX7B0x6cKk6VipEX78TlBL8vOIdyNs24PUsL
	TV4ec0stBC9z0RSp0QBinCNDBb/lChskEdVyIzU0oYwxjoNyL5B9OfOZvla1Nj0/
	QUeWdRe/7Q8h5hJWR8JgkJY4zIGpeDKslPM0PSydUQXPAJjYTVySl1TUKhR5mOL9
	H3zAw==
X-ME-Sender: <xms:xcscatppoaLrYYybkYMWOj3ncnFvC7NZTAfXKkt9o0vajwX1OyNRjg>
    <xme:xcscah7ymePaRaC6cfGrc15RFX499POwfqZ5gDpQqvB78yjFPzBiizWY5cqqVKWeJ
    hV8OQl6aqdW0J6Jmju5pfYrrad-eyb9MjYWn6uT1V8mG0hwX-3uBQI>
X-ME-Received: <xmr:xcscasfm_lqR583akrENcZ49VT3mijT-3GqXd-tSR1CcMmX_nVmOKxh5pqYpzC7kIGc>
X-ME-Proxy-Cause: dmFkZTFdvInY70kURnUCfKLYaCaykxu4LL1YtluT4AUkIC4NABNzVKhsvUmfXMXCQVB1Od
    SIsDxPE7K4hcNAjitVx+OxpJplumsMZEK/XMin0zATGGpQYE+onMtG+HalOLgNxkKgJsW3
    F4k7bntDUXB7q//Vc9n+PSMzuliqSvna9VOTWR4jEso6YSxtj79EeHk2RYI3ZFvwpwNMB4
    w5Zv51hC3apNjHa0By5pzX9z3J2+nVr8013d7XNZDDBiKfeftChOTXc5fDDwr919RhizQ6
    d0AGUZ8DxQanjVjYBTu26hK+38ZdNQDSe9/IiqilLy/Zcn0mX2lNmWlUIeEci41ZeiXSmP
    YoPGeNdH7hpFbFTfcpY7VTezarC5J2Lg1TZM9VvfD+0HM2kDVTlh2zYAkr4J35TSvXlQd5
    h7jt96Eh76QLxQTso8dB3JM1rgDxSLm1KRzkY2z1MaQtimb8P9H28z4vocUebPQMK9aFyi
    Pp4PjPKqZimDH1EtdryNYj2N2lUIKyQxQ8I1PO4osEVtwVluwWZ0lGar3TeMG+6j+0RsJ3
    wq47BF/MOFP63BFGQvXYbfLEdCgNjp7v5HrkoI3ia1RFQM6tEyZwg4zzy2cWpVQa1U8bp9
    htpDRR5Gba2FiftWXiT6QToSsnNyYYpAdIVreTZiZSRKLNP03VLVrRXVn1Hw
X-ME-Proxy: <xmx:xcscau56AqJ_Vwq2afeEVXR2E-HLhhyTeKBN3tGTFxkdOdBmIOMYSQ>
    <xmx:xcscarv_nDRegwHi2Vsvh-U5_jnJMCCxPvgXpTaqlSRukfZCs_epJQ>
    <xmx:xcscamhETLFBodnbClPEg0w6MI5Nln6BbmJAHDsIY7ew8TzXo8SmPw>
    <xmx:xcscaurrqLa5Ke4EHw6QDGyL1nwFnfNaSZCqc6NnknRBLwdA5n0O3g>
    <xmx:xcscatm3Ckq7eaDHj6fghvIdvVFFTfdvkzrq8wbNSY00q9hMdpMjiVAl>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:01:08 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 8/9] selftests/landlock: Add tests for quiet flag with scope
Date: Mon,  1 Jun 2026 01:00:42 +0100
Message-ID: <ec1e426d660bb5279bfa2b3e8179199dd0bbae79.1780272022.git.m@maowtm.org>
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
index 7044781357c0..de4c89cdc0be 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -794,30 +794,42 @@ FIXTURE(audit_flags)
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
@@ -861,12 +873,16 @@ TEST_F(audit_flags, signal)
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
 
@@ -883,8 +899,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(-EAGAIN, matches_log_signal(
 						   _metadata, self->audit_fd,
 						   getppid(), self->domain_id));
@@ -911,8 +926,7 @@ TEST_F(audit_flags, signal)
 
 		/* Makes sure there is no superfluous logged records. */
 		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(0, records.access);
 		} else {
 			EXPECT_EQ(1, records.access);
@@ -936,8 +950,7 @@ TEST_F(audit_flags, signal)
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 
-	if (variant->restrict_flags &
-	    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+	if (!expect_audit) {
 		/*
 		 * No deallocation record: denials=0 never matches a real
 		 * record.
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 72f97648d4a7..d16555f7b0d3 100644
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
@@ -345,7 +391,14 @@ TEST_F(scoped_audit, connect_to_child)
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
@@ -360,14 +413,20 @@ TEST_F(scoped_audit, connect_to_child)
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
2.54.0
