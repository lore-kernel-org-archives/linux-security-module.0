Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1778F3A
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766330485; cv=none; b=uBq5+uF1voCvvd+5yGXUeZf+GLmkClU5v8iZ4ms4qMXNKYWBepegDEFgocbp163d8I6YjicIq5XBkHBZB5OApqcgprdzLB4JWScZgiqKJ3Zg9+vOuzFXHUAirY6WHInMryWiQPzg2EfBAZOLSd4+Jq4N4n4PjKXAcnExnkhNA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766330485; c=relaxed/simple;
	bh=i75QQnNX7jIjXsPYqI+pNexVjd3HtgZF3FazYi+3Vz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCczWhqEyeD7Bo7H2mnsqOw2PoQYaP0LGkOLDVWyTmPbP0BPEvfaCIMFb64MHOVzdYnK9Wx2Tj3lTGJ8OqC6q9Y6llzKIQhM5fIgDpTbKTmiHWqjQ/aysjNYJty5N9pfRnBSP4JcQLLs3k4KkULAwnQasarfJ7ICqg4eHOIf984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=nQLisJGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6B/Ceua; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="nQLisJGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6B/Ceua"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2173FEC009E;
	Sun, 21 Dec 2025 10:21:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 21 Dec 2025 10:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766330483; x=
	1766416883; bh=KtR4MjoNtXhlEQMgqHcTWWE0nYMzfIKD4dvRXGyob4A=; b=n
	QLisJGlcGJO4sXfmnYuiIv3GZXiRAxN5941Q5y05Uep45To/fVn5defeKTGKr8YN
	ZjGOAo+rU/KQaaUSZsckN5uv4PeAAOhz3a6KUFp8xgP1vmcYQg/YnjEWpJaeB8u/
	/HV7VLFntdcHa9BccviiIBklXoPFj+0mRaeZWSR5zuL4j+XO1S6U1b/Q7Sz15dGK
	Okxn/UjHqxP7u4Tr0JnJ3SPnU974fGEyeFgzDUiWOQ2dZHycn5IQYFAPhJG+NtY1
	uRVeb9rjDubZnZg9NxZUQ2kwldKejeomyZlyyGki6Cif4oB5WJLwSzUAW54GN4Cl
	LVJoKvZIqxrRVfjsmyk4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766330483; x=1766416883; bh=K
	tR4MjoNtXhlEQMgqHcTWWE0nYMzfIKD4dvRXGyob4A=; b=V6B/CeuaFqk1IGtRm
	8T+FtiLZThD1SllRU1w4JRx+kw2flEwIj5Qwh8g9larji3sKOhs/Mv6obbJKmf2m
	yIMy3Y3NYCaANcS2G7w63fDhsZvGiaHZwOCXWxZbzUE4qowI6lWQKDarjTDS++mk
	9p/d83HPqq39oAGxasJpGEm8w1njl8ESOLN+lEt1LmtY34Dg4Webu9Djv+MYT3DW
	q1ICaF7Z7nsXg1ndrdXsC/UFBRN5bnsl6Ethwhow/k4qey4Ri5aWAKYh5PgbVCFE
	s+XFEc5IPqlGVv90lzjevA7BmiTYHZY1o5MJyCnj3d3xnB/06/G2ArLkhP7G/0QA
	WPNCw==
X-ME-Sender: <xms:chBIaZvEFLHeTl8tB58_eDEwjVX8G70oBxMy8SlxmLNOqZPBq5-VxA>
    <xme:chBIaUv8LLap2o3c5UoAFW9tnnNFzbEIErVSNuDLdVz0_ULIFZmYD7SpJOz-XwwUe
    LW-cEqd7Crb-pBPnRk1mVv6i7AgFBQMZ7VG4awoMqptwTwwaSnPNpw>
X-ME-Received: <xmr:chBIafCpOoZHgGH_utceRy0ZfVyBBxLFoqGR-hmAbwjMD5M_4Ya7qykYHqznMCSVng>
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
X-ME-Proxy: <xmx:chBIaWNplzOstf4PuPWnYoltCkrGwfmE0NFcEi8gy55hXL8YdV7eNg>
    <xmx:cxBIaYylH0me4Qm19ZOlZVIxvvmB-7GdrvkTotYHOJBnd8nigsPzdA>
    <xmx:cxBIaWWkkuhYsOllPwMHDH6Hes7ysSgcmXB1raHCrW7XbtiGDKpNEg>
    <xmx:cxBIaaMYGV1hNxbw6wmwdiOqPPCigjte3-Ot5fBGLYfoomisszDVwQ>
    <xmx:cxBIaR8Cio7RoUDGQQDxbrltprdh9GUcshtdCniXA1ibow8JQGssbJI8>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 10:21:21 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 8/9] selftests/landlock: Add tests for quiet flag with scope
Date: Sun, 21 Dec 2025 15:20:40 +0000
Message-ID: <ebe56a7e7222c3096ed126d1ed7d2c70c623c595.1766330134.git.m@maowtm.org>
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
index 2cdf1ba07016..1415ab351941 100644
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
