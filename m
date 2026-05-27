Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0423535E
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843701; cv=none; b=VJs3DJIhmknYHAy5VvzU33djPRGN8ZtZPOIKyOzulgtMcaxYYSnld6DRk+BDFtzGw+lR9Up58FK92WDukAL6j6Q9eIHIoNKkiDxWfbmUqokgSMCKw6vKYKA4oPvMJofd5wYahFqybA6VYGIX1n3umk8wGfbcuKMfwZB99Zw4Od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843701; c=relaxed/simple;
	bh=1ZdD1YSOBgDeKcqps1YGzi9IWCXeBvU4umcJLPhS1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtsar545rNr+vsY0CQuqtZIfijO1EJsuiHspWVX7X5ck0wrApCrKQe/fTAdtMHe8db+VbehHEqWA+zWof/8un8mw4oL0rV8aJYkMv1EjalxnTEsVwgVMN+vd9aQYRL9Hfj7VLaymTQVEczcHgJZz4cSwDOsSbSgcU5AbwejjkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cSGRpkr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYMurcz9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cSGRpkr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYMurcz9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 55155EC0359;
	Tue, 26 May 2026 21:01:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 May 2026 21:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843699; x=
	1779930099; bh=ysweR4kAsteLTHdsuQZ8ZZrdFYSjcsQQwiW64IqKlCI=; b=c
	SGRpkr+A3ND2HPl0Q4j9iu+0fKrfsE7s6S+Kwmju4dFtqhP+FPMYNwF7kX9lCmhK
	88qv5k4oqwxCxD4d/fmKm6lERO+l5wOEiFbXFcLGaV767Ee+GHE2ZQN5Szw3Pd5B
	sjGTh5avaJZRNHNnq58km/En9oLS5pEobgG0J+meRoI1jxysDywU8B2pYOfwi9ls
	6EsCQG9n+zrfyS3ubH1+IFWhOo2qcf4w2gX6Ij0oOrooVxnSDS+W6soFhYb2qUNC
	UBmmPuC4ONvvwF2jWQziY+K1h0CqmDLUpP9QkzSsOZcvYk7eNb3Rb21P5vim66Yf
	KMW7HV0qEX59lP8/32Xvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843699; x=1779930099; bh=y
	sweR4kAsteLTHdsuQZ8ZZrdFYSjcsQQwiW64IqKlCI=; b=mYMurcz9kIyWnLrmX
	0WqMYwDY9dGnUKpKe6WhcxR42OHPN++3FF4LFhVvwQ2DibA69Ctm9KCdr3RrnG+J
	DZOnDpm2QDYt88vBFtOB/TI2b6ZT1oGTTi8xww6YW+68VYVZTBStk4+xkC760pdk
	FzzGzGCp/w4pORe4Yyk9sL88WyWYqDiMYGtJUOWFT2TtyhI4c2gkFoSgbL4GvowW
	o6WJHcRW5ul9DRG2UQyzw55j0p4xcw5dyhn2Fhlp5zgDUzbFwDJm7QSwwuEEHTKC
	cu5ah6RCYd+4a6bPUHUyI2QtF2/E8ixzc0PXvRJWDagfPPWHA3mvxpiDrDZ3jKez
	KOqUQ==
X-ME-Sender: <xms:c0IWakctGXKuUMv0rC5_8Vt5kJp9dB_4H9s85Ubnvgn0tPshoDs9Ww>
    <xme:c0IWaocVqIHZ7haBZ5Nrcd-3A590lzMewoRJBEUTuvTTkqMbMymgdNDYaVmR7rHyS
    z55_LsGsswufruKMrTtN7Q0GCySKAwpNaY0Ny95yY9tUxS4vf0NCjQ>
X-ME-Received: <xmr:c0IWanxQoA1Zq67pvLGO5LflsuCIT_-2E0RATlnMQ4MEEaEX7LQVWoGzaUCv4bQ5sPk>
X-ME-Proxy-Cause: dmFkZTFUre9sXwItw/D32/LRha63U+D2MMre5R4tNoZC3GZT1kninLOZYHQGUdW/3lBBAr
    rH7WEN1NA0Icq7iWzjSibRmCazO7v8ipojfNsqLogvqpKcgpSkktdCK74u1Yx2bEapFKlN
    S0WIZUEX4JR1fUCKvttN8BxAYAt7dVO6aFHlXili/G3YRmDCCBAzY7r9QgnkuQv0FMn/dy
    NAgD25l8Vnwfwc1HnabyZvWY5OmQC4xgsVYFabzy+Dg3mXYfFbgr+O2AYzjg4pZKiA5CQC
    cooAMlaj6Mhx9kTeOxwXV/N6k5f1c0HpAIGUHCT4okSDNym5kyoKxbD0WxnwKa6hKew0QN
    ncliBFLGWJf2+dmp4jXC4BRploaTPhghvXZq31Zi8cPEsvuSWmPIXIhQ2djDlgF3ZuKvlM
    UrgF0XHh2q5OnlotOabBrmwrxvQkm4O/efCVl84MXmimvWwONaMwMmhCc/nnQWwGdlLC1C
    rxqn7wI3MXiHYSiHQFqHEoq6aGZ7yuz6eU5rxCSlG44Bqcf86lGCQ5bHbgil1p4w0icru7
    OiBWYzUgTHRUwqZemWRkB4CVKKpnbwowi2hJxnBhpJqFpEOtDYN9AbFW6xWowPGfhmlMC3
    FWAmdY3aUU+O53KhitqNfvIn0AF81ThREeTO9OUEe2+K0d/WPMUlaK+YKnuA
X-ME-Proxy: <xmx:c0IWav8akR7q3nM1Q5JQgaBC33JHxXj-nv3iyPGGQ745YA6UvV1GcQ>
    <xmx:c0IWavhs0q6Otqg28J3e5mNXeRMnjK-jSdvHmQEH3wSB5md2wTK7Iw>
    <xmx:c0IWamGVbFRu7qTyj0AhbKaPqvFWiYxRUvNHKCFJMdm25Hr14mFdZg>
    <xmx:c0IWau8bt8d5tEMCI6POxIA5oNROP04pm1r1TpDAT56m-HLbVWtxOg>
    <xmx:c0IWanpV0dFSlO11a2GkjCrEKMyI3mR-N5c_cHzZt-fEdvfP46_Z6JAG>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:38 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 8/9] selftests/landlock: Add tests for quiet flag with scope
Date: Wed, 27 May 2026 02:01:18 +0100
Message-ID: <570c95a205ecd5278b4c0950407b30b238655780.1779843375.git.m@maowtm.org>
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
