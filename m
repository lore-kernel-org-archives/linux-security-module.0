Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDA1D0DEE
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931772; cv=none; b=Ea99MuSYewVETG465p4gnrT5P4UIK5S8tz/cTg8qlGkBcdfG8qnIayiuul1qUakoeTXpNs+QGxjpCafFf3p8AvhoxgMdtfxOzphZm0Q17V4kKlfJD3Gw3Pp4rKMr8bHeEvC+c3eijA3fxge4n+XkLetmqDPTwnKmKEiVvmBo87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931772; c=relaxed/simple;
	bh=cjIaJkfGcmmRa1gb1jah+PVn/q/9qXBZ36KgYR1qds8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk7PkmHJiqt02F5+jVkPGxQ1WWWuSDYZ7eIAV9n1RzvH2VKPVwumksEOrS568n+OicUcZn6/2z3FLQ1Efxi5dIZyt7vfxdDGbmVQiW7J3Y6e8Jz95ijVG+Q+OlYxZK5XCbHGa/FP3JRl8EVhiwyv24ed8b6AGQYIJig32FXvbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=HavmhmRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GI2Gtkr8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="HavmhmRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GI2Gtkr8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79928140013E;
	Sun, 23 Nov 2025 16:02:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 16:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931769; x=
	1764018169; bh=PyiAR/033lNhvDm8B0CONU4mpcNv6NNno08PlO9jks8=; b=H
	avmhmRKWt4UwkYtUbAaWnFMGD/hhLLEIBVsDl/827GQe+hMSZvdfo4fnp5BaZMvF
	oNnaDKWXNl+0yjrw/5KFk0+aNiZz1egNPXBNxsmezTKAWoizTKs31kBulhVtvOJr
	J3VK8tH8US24OeLuonbEoeXUlNQ1VIu+XILowSf1LfIkdT/g9ywAflNl/axhYXFZ
	gJpUE91YB5WrVQNRMvKazrYk2qOmSOAWmzINAV3xde6kMlX1geQmU52X6ZkeYpzI
	nrPZmIIpJgXd2dQspPawJEmDySTO3Abt85BCHai9k3RfQqZNtKBYNXVMfKI2Q/2Z
	eVNNmC3mUDHt1PxUi93hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931769; x=1764018169; bh=P
	yiAR/033lNhvDm8B0CONU4mpcNv6NNno08PlO9jks8=; b=GI2Gtkr8ZRyjK6b7Y
	c7C89Vi5Q3QjHOsbQ2BRptxR8nfMoYeE2vPAc2bBqIm1fAx0UPBu4l6aqr/fxATg
	P3SHanM50ugY2RVaPNk+az38p8bhFf+pc4xQxAzq37cSs0KZjrpfW8A1fbTWNv3b
	myxppbC7uMjSaNYjEHkovSupvuNKewD45d+pmVGz8f8CZVaLXZMM8QfCNhB6jsFo
	+M7prbiXRVTC9Kla0K52/rfka71fPX87K60oR7r4iWC+md+yblSJgfXFVtaRs7N6
	E7Ag5X4j3XVKYpakqfdpTzVcFmuXsBCrzyryc/f+Fvistt2CI8m5fXzNO/kscjJt
	+B5mQ==
X-ME-Sender: <xms:eXYjadbMQIInAzL9sfLJ09C2L0-TeD6BNZAgrwpXW2sQZY9igOOkDg>
    <xme:eXYjaWp_tRUGEIdCs0wSQ3hkzXGPt3zmNgekqVNyti3wC-OWUQPCC0tBIAKV-Ns9M
    Yzmi_QpLH2wUoxQ0HVk18rZFbI4XGtkDJCU8ZlO4Y2sZfrcRu5tGHxs>
X-ME-Received: <xmr:eXYjaSNYvJsxe1vOCbWpBsUBsjroHrR7kDtLx9mwPYyL8D213YgNG4orie_ZHz2-j13d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:eXYjaRpnVK8EC5YVv7iQq5vwm4WwXBy1F-FlwutaZBQBmsoaJjc9Gg>
    <xmx:eXYjaXcWPltFCH4oNTT_pL4vZ82MqOLEXiZ1GHh7pb8FST3zpgTSLw>
    <xmx:eXYjaXTan9tnmqiEFHDhl_njMAedHPIaJkfnxZ1BgfIBtIrj0U0TGg>
    <xmx:eXYjaQaXHpB8u9RzY4u831iuUECUmuIxpB9QKSasOVIKAv3IXwyRtA>
    <xmx:eXYjaY71MSalmNySHKkMkuXpcNHAPB9lXpVS6Wj4frggQC_uoBejEZVr>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:48 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 09/10] selftests/landlock: Add tests for quiet flag with scope
Date: Sun, 23 Nov 2025 20:57:45 +0000
Message-ID: <12fc4ea36d61bc04b2e4f46055e6881071aeb761.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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
