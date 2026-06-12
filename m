Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D6390CB5
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228965; cv=none; b=G8Mch2FaKJzk8OKI8MYgQglW0GqOr8nVl+ZHnntTVsWoPwBP93VWC9nUPgqolYTLwmGriTAdhIBmqQQeCEzv5bMpho1J6jBsCHPtZBE88VbYkbs+BDXjwRkKNo5qiei7wH47tgCeD/zZEtedHY7FZRjxOUzWtdQSZDpLNzR37yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228965; c=relaxed/simple;
	bh=r9vhHgtvVr/u3l4g8zzg724Xt7TxALLAFe4g58Elnds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG8+sr9iXwQH0LaGDtQLxxQqsfhSgtnLlFsFHyiQcN6bFBPjdNSlSjAT6Z3bcKPnA2fBbXmPGP/XzRuKjNufWwMm1OluMCEEmbZ+ikP9IbK9VYBiRZEYD7+9rFZbdN1MRDH7HkaTmybQgiV7D5VldvF8ppnxeEfHofDznu/ZPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=IqQr6VJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCkbS4q7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="IqQr6VJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCkbS4q7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 411C37A016C;
	Thu, 11 Jun 2026 21:49:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 21:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781228963; x=
	1781315363; bh=z5L901vizGOjYKl+FSeLFLUF+dEmsko1f/QnqVzlpJU=; b=I
	qQr6VJFhz8+lTiYqNS4wwTjQ2TVd+DGqKXb2ZozlFAGkeM5JzsLKL0SmOoQK8mph
	8qnjZYKynFhwVqTEdXUFayy7v5Xh/a2tC9PxxAwE2zdjTXOL30mpPf2VUeJbWH0X
	hixZKFwIBv1kUjS8Li836ZPdABK+lMk00eyD3jD2+JOjDJl38b0QToGkIC5qtyds
	Xk5NuVG0JCD6VnDXvyI6MYPmjW13XNMQ+ioMLIziFfqSog+2uTkz7HvcoZOwgC14
	P7F3ltWrIJ/oTEpl8XnyJIsUSmum+3O0CzJHXOTGqVSZQgCUJCcDxyysSESP4/px
	PSqFJsZZvBh7eOYUi7goQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781228963; x=1781315363; bh=z
	5L901vizGOjYKl+FSeLFLUF+dEmsko1f/QnqVzlpJU=; b=RCkbS4q7u5QmE6W/Z
	jJK89ffjZrbVrBk5sMdPBc72AJWP31vwzWbVu+cHyYaUwHS4pPBb4k+gZE67GaDZ
	UypspymGL8fc5/lD7g02y9jpvWBfilFH0Vb/NJFdP0zcNeFkAIS6vq4HFwtJZlrx
	C8VN3KjiOF9v1QrSd/uxMOmzxNcimFSQkofy6g44N3Uk4hC585rLFemnPAE8c5PM
	mmX+alto3pW5s/vP5u6R0OgdLQCnzFSV+resWPQe03y/ZKIOZOMUkE3YGjZltJzp
	iRD8HTiBQuNYkHB/imuVee3UooZ6FAIN11y2CtJQMlEYkv6Quh+5nn46SK6X/g2O
	McKAg==
X-ME-Sender: <xms:o2Uran54WisxD9ed0fGeYF5sj9rmrNyFDlCo5puo8xYU0IryA_uUTg>
    <xme:o2UravKFvBRMMU-gm9cKbJ5wKuqoZom6meKMwvpu0Bv8JR5IqeyO2Qd0dPIpkOKGv
    KnPU-f1sCOaJb8fqjWRCnc7robrItJHQ3bny574Yvc3Nxzd-u4mJg>
X-ME-Received: <xmr:o2UragtQ-HbqflPutFSEcT-rv-t6V6U6uTU49hH3z6LCUPuTsCeXTqH8N1pB2JMdF4Xd9WsLUV9dAfOcjO2Ru5JptazYLV9mLrwBqVhKUVbR7exyAsKjkSVHElI>
X-ME-Proxy-Cause: dmFkZTErrYj+6BPPVz1/IV8jcji/YbJf7tNmbzKUklDVBw37Mo5r82nPd5buxFHV4OrxKd
    +00SDQV9sSVg4R4yvs2QLHos0drG5qYNr6GNhg9D8ngYxfJUcCtRRhPXhE6kz5yGXnYKMY
    oJHiB0gAaPzyeGZH5d5BTyheBut4xCTujqDHaTful/fQaUhKYSKVr/XYUjihn5pTjMkS8X
    sKVE+fTH1iGH2FWO/9EBeuJFKXH3xovFqufQzUi7llGvIp9TU54IXL348v2qQAgPhg5ZW1
    SUBEtCpHKVb2aYxBd3Ta7zLOiViueqFsE4VHkel083qbKxQFVcQ42U+V55ljlncHcKp7Mx
    8Oe6zQVR8ZYp9AUML1ipdMfcmDNtHg3BJNjtQjNMswV7Ef2XBIHjB/rxRwSfH+Tv2mF5Ax
    rehcU05kHNnFkmSCZ8q2CtWwXVF7bQU74FWew+wmZkgkC9StjHIjyOmpFWIjFgkyqJuxaC
    pxIAdB1Qc2mKUqOpXbbttML5hHd/E4PlFqH7u4dUkqoYmSayaEI3EsBgYo8IDsQby1hr8K
    5DlyIchChfGWd6KmfAr3BTa5AmLhjR5HAl6Tw8dpr8s2QnOHmV7icLHGgZko6vim6BGFE6
    hjfr6PzszOUm9yz71WvOKo/gYoPXokAXh8S30/9V8uhdIkOMCZX3gtUTz6Rw
X-ME-Proxy: <xmx:o2UrauJkd6IOVh-rS6G8xTL1hRkCwUbf-rHvGdd-iXQeyMzCKl4GBA>
    <xmx:o2Urap_UhbVC-fdR1lhOCCIAzdNRITwT1_0EpiUjxRyjLy-RPrWw0w>
    <xmx:o2UranzB473kwoLPtdLbo-QO2xhibSHc8Hi5cKHkDJq5yZOlBsQOWw>
    <xmx:o2Uram4l-dMkyuifEVb0mRODz4YiFi1J_gF2fq54RxfwO141zN789w>
    <xmx:o2Urag3L6lRpZ2Y2T37z4qHj5OCguKooUR8m6-o5f8LNvrsKbPLE44jm>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:21 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 8/9] selftests/landlock: Add tests for quiet flag with scope
Date: Fri, 12 Jun 2026 02:48:54 +0100
Message-ID: <032849ca97bd45b2e14f96192b61537ed9405a0d.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
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
index d55fe4c5b531..3b344b03199e 100644
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
