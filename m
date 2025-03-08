Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F72063C0
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459511; cv=none; b=jXxoxYP9x9scs4tZ2vP+uRUKt4fvzFZ372sYSWcZHMzQH7DtmCU/GAmyaaCDtprPT88QIMD54g0bJtxEn0+C6mHKrGcAq3dEsMP6+rjR0mWI8bY4OLV12xCZvhKVWda/FeAKhq8NWsWFHzPo6i1iECMMzm8jFFwcA/HqE/lgI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459511; c=relaxed/simple;
	bh=kHEZn5MQ8LTT1IfzNKkZgFDj1sZfNbv6UBntPICu6W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDnvAf7WEcOde1mtv7bwu4PRUaGpjaidb4uTueS1p4myPACCsV2/m19yJuLo43U10vFDmUaoJkZ4KVzKxUWqseKd/tgam02XlHad/D0voIRbB70nyxY8H/lyvjsKA5LQgAMdjatJ0QERom4YP0S1DM1OfD8F5yMAupEnXemxqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mu+Zde5C; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mu+Zde5C"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsv5873zSY9;
	Sat,  8 Mar 2025 19:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459507;
	bh=fvXrafkhzsfsp4waRL01f36DuQHCHVvFnVG4UZpORH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu+Zde5CrIrrMW+JtC8S9Ck5Kc3QOSipC/jx6TNTeyAswqEVw8ZyCiEWILQcD6tWC
	 e8usI8CRzKa7hp2PFzl5HFAlvPJlDBCr2UbsOw/Ug9O8/WqfcwXOBNT6JbBvf2WINx
	 kyVd4W0c3XMLzcoUb+ZylP43siQtjHjSpzHCE6sE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bst63GwzjtJ;
	Sat,  8 Mar 2025 19:45:06 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 23/26] selftests/landlock: Add audit tests for ptrace
Date: Sat,  8 Mar 2025 19:44:19 +0100
Message-ID: <20250308184422.2159360-24-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tests for all ptrace actions checking "blockers=ptrace" records.

This also improves PTRACE_TRACEME and PTRACE_ATTACH tests by making sure
that the restrictions comes from Landlock, and with the expected
process.  These extended tests are like enhanced errno checks that make
sure Landlock enforcement is consistent.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-24-mic@digikod.net
---

Changes since v5:
- Move all audit tests to a new audit.trace test suite.
- Simplify tests by only checking PTRACE_TRACEME and PTRACE_ATTACH with
  one scenario.  This is preferable to not impact existing tests.
- Make sure there is no unknown Landlock audit record.

Changes since v3:
- Update test coverage.

Changes since v2:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 8f31b673ff2d..eebd8268dccf 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2019-2020 ANSSI
+ * Copyright © 2024-2025 Microsoft Corporation
  */
 
 #define _GNU_SOURCE
@@ -17,6 +18,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "audit.h"
 #include "common.h"
 
 /* Copied from security/yama/yama_lsm.c */
@@ -434,4 +436,142 @@ TEST_F(hierarchy, trace)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+static int matches_log_ptrace(struct __test_metadata *const _metadata,
+			      int audit_fd, const pid_t opid)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=ptrace opid=%d ocomm=\"ptrace_test\"$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len =
+		snprintf(log_match, sizeof(log_match), log_template, opid);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+FIXTURE(audit)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(audit)
+{
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN_PARENT(audit)
+{
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+}
+
+/* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
+TEST_F(audit, trace)
+{
+	pid_t child, parent;
+	int status;
+	int pipe_child[2], pipe_parent[2];
+	int yama_ptrace_scope;
+	char buf_parent;
+	struct audit_records records;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	yama_ptrace_scope = get_yama_ptrace_scope();
+	ASSERT_LE(0, yama_ptrace_scope);
+
+	if (yama_ptrace_scope > YAMA_SCOPE_DISABLED)
+		TH_LOG("Incomplete tests due to Yama restrictions (scope %d)",
+		       yama_ptrace_scope);
+
+	/*
+	 * Removes all effective and permitted capabilities to not interfere
+	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.
+	 */
+	drop_caps(_metadata);
+
+	parent = getpid();
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		/* Tests child PTRACE_TRACEME. */
+		EXPECT_EQ(-1, ptrace(PTRACE_TRACEME));
+		EXPECT_EQ(EPERM, errno);
+		/* We should indeed see the parent process. */
+		matches_log_ptrace(_metadata, self->audit_fd, parent);
+
+		audit_count_records(self->audit_fd, &records);
+		EXPECT_EQ(0, records.access);
+		/* Checks for a domain creation. */
+		EXPECT_EQ(1, records.domain);
+
+		/*
+		 * Signals that the PTRACE_ATTACH test is done and the
+		 * PTRACE_TRACEME test is ongoing.
+		 */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		/* Waits for the parent PTRACE_ATTACH test. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	create_domain(_metadata);
+
+	/* Signals that the parent is in a domain. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/*
+	 * Waits for the child to test PTRACE_ATTACH on the parent and start
+	 * testing PTRACE_TRACEME.
+	 */
+	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* The child should not be traced by the parent. */
+	EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+	EXPECT_EQ(ESRCH, errno);
+
+	/* Tests PTRACE_ATTACH on the child. */
+	EXPECT_EQ(-1, ptrace(PTRACE_ATTACH, child, NULL, 0));
+	EXPECT_EQ(EPERM, errno);
+	EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd, child));
+
+	/* Signals that the parent PTRACE_ATTACH test is done. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1

