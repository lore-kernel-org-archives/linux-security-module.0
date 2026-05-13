Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4039F172
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669855; cv=none; b=noXvPKTjrefmDL/MbTgFy0dwSWWK/Vbpvr7ztRTZmhuMXw7TKBWiqZ/eEVB7IX2bcQ6MNaUnW2HKicHCVUOLn2e8fd80ke18yaFE9TR1ciF6gQwJ+X0sRzJM9U/o9jo1LfXRKsO+UdlBmzRIH+oDU1hriCpjFllDiNK0yzJBWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669855; c=relaxed/simple;
	bh=Ov+pM/oJWQKvHQi4WYxknjvoH81rwBrXkZdsrkylY7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eco/eoA+ZGNOg56+vpxC09rNsgBlWmtMZZZwEHLRxW+V/gXDgbul1O2ctupUs1as4ImyMDxVYetuNq/1PQ3UDSU0byHXnYmjaGpeg9tlGlM3gUwdy8FK3XKJx/l3ZVh1NhX0q44R2UXiS+8kGqdO7/dnIeI0hkckcmy9SZHsYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=d0TwHZLW; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="d0TwHZLW"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gFqyP08ynzZHB;
	Wed, 13 May 2026 12:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1778669484;
	bh=T4fcr3bXr29fORuqK6cfuoXfwkjZJ8EdZ2TZutstLGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=d0TwHZLWJ02pzBIyDT2td6R3r13QFcLOB/4ZwHhsaKM2K7Lnau74zPZ7phZiqDZ09
	 yPjaguEDLyGgAzfQq+34jcQjYqO81vWB9f1kRqdiTnPW3bPtDJJB1uRjhjhXCJRb4e
	 tGPWzp0E3hdd4Jz9qIU2cMwN1KC6ilVYfqES3BxU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gFqyM22P2zHbG;
	Wed, 13 May 2026 12:51:23 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] selftests/landlock: Filter dealloc records in audit_count_records()
Date: Wed, 13 May 2026 12:51:08 +0200
Message-ID: <20260513105112.140137-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

audit_count_records() counts both AUDIT_LANDLOCK_DOMAIN allocation and
deallocation records in records.domain .  Domain deallocation is tied to
asynchronous credential freeing via kworker threads
(landlock_put_ruleset_deferred), so the dealloc record can arrive after
the drain in audit_init() and after the preceding audit_match_record()
call.  This causes flaky failures in tests that assert an exact
records.domain count: a stale dealloc record from a previous test's
domain inflates the count by one.

Observed on x86_64 under build configurations that delay the kworker
firing the dealloc callback (e.g. coverage instrumentation): the
audit_layout1 tests in fs_test.c intermittently saw records.domain == 2
where 1 was expected.  The fix is in the shared helper, so those
existing checks become robust without needing a fs_test.c edit.

Filter audit_count_records() with a regex to skip records containing
deallocation status.  The remaining domain records (allocation, emitted
synchronously during landlock_log_denial()) are deterministic.
Deallocation records are already tested explicitly via
matches_log_domain_deallocated() in audit_test.c, which uses its own
domain-ID-based filtering and longer timeout.

With this filter in place, re-add the records.domain == 0 checks that
were removed in commit 3647a4977fb7 ("selftests/landlock: Drain stale
audit records on init") as a workaround for this race.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/audit.h      | 39 ++++++++++++-------
 tools/testing/selftests/landlock/audit_test.c |  2 +
 .../testing/selftests/landlock/ptrace_test.c  |  1 +
 .../landlock/scoped_abstract_unix_test.c      |  1 +
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 834005b2b0f0..699aed5ffab4 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -381,18 +381,24 @@ struct audit_records {
 };
 
 /*
- * WARNING: Do not assert records.domain == 0 without a preceding
- * audit_match_record() call.  Domain deallocation records are emitted
- * asynchronously from kworker threads and can arrive after the drain in
- * audit_init(), corrupting the domain count.  A preceding audit_match_record()
- * call consumes stale records while scanning, making the assertion safe in
- * practice because stale deallocation records arrive before the expected access
- * records.
+ * Counts remaining audit records by type, skipping domain deallocation records.
+ * Deallocation records are emitted asynchronously from kworker threads after a
+ * previous test's child has exited, so they can arrive after the drain in
+ * audit_init() and after the preceding audit_match_record() call.  Allocation
+ * records are emitted synchronously during landlock_log_denial() in the current
+ * test's syscall context, so only those are counted in records->domain.
  */
 static int audit_count_records(int audit_fd, struct audit_records *records)
 {
+	static const char dealloc_pattern[] = REGEX_LANDLOCK_PREFIX
+		" status=deallocated ";
 	struct audit_message msg;
-	int err;
+	regex_t dealloc_re;
+	int ret, err = 0;
+
+	ret = regcomp(&dealloc_re, dealloc_pattern, 0);
+	if (ret)
+		return -ENOMEM;
 
 	records->access = 0;
 	records->domain = 0;
@@ -402,9 +408,8 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 		err = audit_recv(audit_fd, &msg);
 		if (err) {
 			if (err == -EAGAIN)
-				return 0;
-			else
-				return err;
+				err = 0;
+			break;
 		}
 
 		switch (msg.header.nlmsg_type) {
@@ -412,12 +417,20 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 			records->access++;
 			break;
 		case AUDIT_LANDLOCK_DOMAIN:
-			records->domain++;
+			ret = regexec(&dealloc_re, msg.data, 0, NULL, 0);
+			if (ret == REG_NOMATCH) {
+				records->domain++;
+			} else if (ret != 0) {
+				err = -EIO;
+				goto out;
+			}
 			break;
 		}
 	} while (true);
 
-	return 0;
+out:
+	regfree(&dealloc_re);
+	return err;
 }
 
 static int audit_init(void)
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 93ae5bd0dcce..758cf2368281 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -730,6 +730,7 @@ TEST_F(audit_flags, signal)
 		} else {
 			EXPECT_EQ(1, records.access);
 		}
+		EXPECT_EQ(0, records.domain);
 
 		/* Updates filter rules to match the drop record. */
 		set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -917,6 +918,7 @@ TEST_F(audit_exec, signal_and_open)
 	/* Tests that there was no denial until now. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	/*
 	 * Wait for the child to do a first denied action by layer1 and
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 1b6c8b53bf33..4f64c90583cd 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -342,6 +342,7 @@ TEST_F(audit, trace)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index c47491d2d1c1..72f97648d4a7 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -312,6 +312,7 @@ TEST_F(scoped_audit, connect_to_child)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
-- 
2.54.0

