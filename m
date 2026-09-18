Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901E51DDF0
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757989; cv=none; b=ZGZ2/3mezzWb1z0uR37iAdfs6KC2abL0grKybVxo9/dAgABLLygxuWPcgrmkD6bPfGJADs6ysUCF3x9AyLrhMobss9VEYwBWgNUg5i1eRxPv4ldsNoMlQPyvVnrPtuo8AQsZMlUYdXBr+TJqT+zkjlKXvRLYcRvTd2uK/91Zrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757989; c=relaxed/simple;
	bh=hS7n8FSrLhb0Yak6h+t6ivH3bFxKCI3FrWu9LJiLCdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqSd+xEBiJiNfuQS9fqkFN3TBzpdP3OB32gAWi8ezUxbpg+lkCHISrYo1ZL6rnqd5D5C4CXIdp6LiJg5/iKIk0AhxPbK2IONvivdHLDrXwRFH9tcsjCplwGITX+FMlwC/SWm4A+lPAdfXipjppb/0qufdWDx71bU8RRu5teIZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DLKCpGTv; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DLKCpGTv"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXY3YkRznVS;
	Fri, 18 Sep 2026 20:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757453;
	bh=YcgcCFigYXu+MysQjR0T0g68rY1ZXkXE52Y9z1gZOiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLKCpGTv2vWKRt4+v63FlyDQKeBdctlVyfiby2a7VhdCQYWxTrONvzT/M3zz2UCQd
	 j/L89sDo1su2Il4EqeyVWbz2HLmP1579R2JQFWVwCofMabvCn3571SJeNveiOx9Pwu
	 WkH3HEQsU5R8ZrdcUQgtayYd5MOqJLW6Ql+INB9s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXX5brmzJnY;
	Fri, 18 Sep 2026 20:50:52 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] selftests/landlock: Test filesystem denial blockers
Date: Fri, 18 Sep 2026 20:50:30 +0200
Message-ID: <20260918185036.608651-8-mic@digikod.net>
In-Reply-To: <20260918185036.608651-1-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Filesystem denial traces identify the policy change needed to allow a
request, so require exact blocker values rather than merely nonempty
output. Pin a READ_DIR denial to exactly one event with
blockers=read_dir. Pin a REFER-only mount denial to EPERM and exactly
one event with blockers=change_topology.

The mount child retains CAP_SYS_ADMIN so Landlock is the only expected
source of EPERM.  This prevents a later capability failure from masking
a Landlock regression; the trace-collecting parent remains unsandboxed.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 .../selftests/landlock/trace_fs_test.c        | 76 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/trace_fs_test.c b/tools/testing/selftests/landlock/trace_fs_test.c
index 6666d4746cb1..64014ade3a0e 100644
--- a/tools/testing/selftests/landlock/trace_fs_test.c
+++ b/tools/testing/selftests/landlock/trace_fs_test.c
@@ -548,7 +548,8 @@ TEST_F(trace_fs, check_rule_nested)
  */
 TEST_F(trace_fs, deny_access_fs_denied)
 {
-	char *buf;
+	const char *const event_regex = REGEX_DENY_ACCESS_FS(TRACE_TASK);
+	char *buf, blockers[64];
 	int count;
 
 	ASSERT_EQ(0, tracefs_clear_buf());
@@ -564,8 +565,77 @@ TEST_F(trace_fs, deny_access_fs_denied)
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
 
-	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
-	EXPECT_LE(1, count);
+	count = tracefs_count_matches(buf, event_regex);
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 access denial, got %d\n%s", count, buf);
+	}
+	ASSERT_EQ(0, tracefs_extract_field(buf, event_regex, "blockers",
+					   blockers, sizeof(blockers)));
+	EXPECT_STREQ("read_dir", blockers);
+
+	free(buf);
+}
+
+/*
+ * Verifies that a denied mount reports the singleton topology blocker rather
+ * than an empty access mask.
+ */
+TEST_F(trace_fs, deny_change_topology)
+{
+	const char *const event_regex = REGEX_DENY_ACCESS_FS(TRACE_TASK);
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_REFER,
+	};
+	char *buf, blockers[64];
+	int count, ruleset_fd, status;
+	pid_t pid;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Ensure that Landlock is the only expected mount denial. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(2);
+		}
+		close(ruleset_fd);
+
+		if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) != -1)
+			_exit(3);
+
+		if (errno != EPERM)
+			_exit(4);
+
+		_exit(0);
+	}
+	close(ruleset_fd);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+	count = tracefs_count_matches(buf, event_regex);
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 topology denial, got %d\n%s", count, buf);
+	}
+	ASSERT_EQ(0, tracefs_extract_field(buf, event_regex, "blockers",
+					   blockers, sizeof(blockers)));
+	EXPECT_STREQ("change_topology", blockers);
 
 	free(buf);
 }
-- 
2.55.0

