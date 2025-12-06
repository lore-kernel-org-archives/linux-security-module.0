Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD823EAB4
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041123; cv=none; b=QGzVx1XCyMYsCIednqwxn9L0ahL1uKls9Wc6yRPrmKmKmV/wZb+h0olCeMM7PW+pp/p1DulU3dxnwvTr7UBqrsRFYxAzvWsqfqRF6G1RUElPnjmoHoyTXkuQtO4aEDWE6nskI9RcLGxgHCvG9DMqQN4Rpy2aS4S4WnMUPvJBUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041123; c=relaxed/simple;
	bh=cjIaJkfGcmmRa1gb1jah+PVn/q/9qXBZ36KgYR1qds8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmHMVLCEmUJ+n99zoZ2Ol8DmrwfR7gBHaujVTZcV5sGq6qC6hIQ/t2JZazeksHiRI0KI3ox1/ug87ZdOyMF4oqUqWSVX3akbxgmHDS9iL69A9WEQd+/q1g2AJxxYMC3mJembTPKZeGPgNZ8XHeZ1w/DIbKXrXNVLhcsm4J8rKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=rxwLh2n2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5Y8unD5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="rxwLh2n2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5Y8unD5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 727327A006A;
	Sat,  6 Dec 2025 12:12:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 12:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765041120; x=
	1765127520; bh=PyiAR/033lNhvDm8B0CONU4mpcNv6NNno08PlO9jks8=; b=r
	xwLh2n2H96M7QY7rYRP7BDedauXWdERxHEGQ5NvnGGTkVFn1hfRhd1upj55vMBqR
	BKMmE0Ff/hA2pe0ynL0vMEry27CQmDQbPOzzndGU6EIhpUuS3B4+W+9H2j9efYX4
	Y0dUsbBJcbm0WGBUwTk5fmRi74IJJuajaXQsENZJgV72IDOu4kxmE8HQTf7cDNul
	+L3WKINiBSWb09SUJZN6YMZgpQoSrl610pBlpCYJWM9GNmZxjmG++8EhuTODj2Yf
	FT4P5k9uEiIIO7Dzbglh2rqAdeV8LxT0L0rNalPogW+ylp4L0LIIWNhHuBLQX+Z5
	FpYp2aDNPsLrCxINsXS0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765041120; x=1765127520; bh=P
	yiAR/033lNhvDm8B0CONU4mpcNv6NNno08PlO9jks8=; b=K5Y8unD5Qbbeh+fPI
	235fsTpMXrZxhSsJmXqsfcqIDkVr9TIbVDJFO8tHXqOXAQk0HT0jZpmtMuc3mfd7
	q5UcFpanT/eht7uTizd9CzGBX6tZu7CAXTs7o5iYk+Rc1I56+8CzdH/0rA+EY6Ep
	Mueh6z7qhv1PyabKBUiMywG7aAcHLPHfEjbSWuSu3HZX1A0llwQ41k2yyvIcdD6K
	bh6mB/xvATb6cD15RjB+M3Hx61h2faZO+fZW93+ksdEFJxxYu9JpsIOmV0JYFfnV
	vUuSPNZHJ0IHWj4cYe1QzgZsvu+NoYxkosDP3MAF/Ls9vLiHaZTr2jeQMteBRIds
	fdTyw==
X-ME-Sender: <xms:4GM0aSoYS94ZMwHDjRSuF1RCYGogH9fh1BYjWqGZaRgogRG-WQMqBQ>
    <xme:4GM0aS4KNc-rkFnvs3apKSsPXrZcK6sFlyiQAtv2ZVAhPjV4erCTNlGADwwNUEv3B
    T-egrCfDEX9Tty0WLW5tebd218msY1y7_4Uh2pFMuRfGXk2uLV970w>
X-ME-Received: <xmr:4GM0aZeFZhIua3R3xb-FEMiM--LrmqzN-B7Pv8TlnL3zoYpuPx3u_nLmg57oEKnwhVPhlKc7l02KC4wYI0nxwOz1AKi1mLIBk4krTJL7gqXb8qvzZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4GM0aX75j5kMdZJcGHrY5oH5-7iFjJjOv4oA17uvoI2brX6FJlY7nA>
    <xmx:4GM0aQtDUUjX1bZZyY8SdlcXa1g0YhWwwgxGorgnLuun8pKmSGZnsw>
    <xmx:4GM0aXjNRneLCvbRQfOKTVtoEFgpsCjbi5uadoEaCDrF3-EtcfPUCA>
    <xmx:4GM0abqnOVQH5YM88iDiItbTjcw27fsh3ItI3twvCR9MVX-ALilx5Q>
    <xmx:4GM0aRL7g_L29ycD5ABqXQ8ryvAnAT-gBrYm5W2nZMEB80njw-LtADLZ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:11:58 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 09/10] selftests/landlock: Add tests for quiet flag with scope
Date: Sat,  6 Dec 2025 17:11:11 +0000
Message-ID: <a9b8e0a40e9b55c2bf4b849e03cb598855ca5baa.1765040503.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765040503.git.m@maowtm.org>
References: <cover.1765040503.git.m@maowtm.org>
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
index 4417cdedeadd..818ce485ecd9 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -289,30 +289,42 @@ FIXTURE(audit_flags)
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
@@ -356,12 +368,16 @@ TEST_F(audit_flags, signal)
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
 
@@ -378,8 +394,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(-EAGAIN, matches_log_signal(
 						   _metadata, self->audit_fd,
 						   getppid(), self->domain_id));
@@ -406,8 +421,7 @@ TEST_F(audit_flags, signal)
 
 		/* Makes sure there is no superfluous logged records. */
 		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
-		if (variant->restrict_flags &
-		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		if (!expect_audit) {
 			EXPECT_EQ(0, records.access);
 		} else {
 			EXPECT_EQ(1, records.access);
@@ -431,8 +445,7 @@ TEST_F(audit_flags, signal)
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
 
-	if (variant->restrict_flags &
-	    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+	if (!expect_audit) {
 		EXPECT_EQ(-EAGAIN,
 			  matches_log_domain_deallocated(self->audit_fd, 0,
 							 &deallocated_dom));
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 6825082c079c..d6da9c20bde3 100644
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
2.52.0
