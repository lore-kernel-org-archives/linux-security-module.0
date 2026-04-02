Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005A2737FC
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158307; cv=none; b=V/6S+9BTHnXQqgUEh7JniuX3vzo3YJB5WWMrik0oxwgNXV75bYiy3W64x2FJNpvzFMqF7j5m6dekwldrmx8AR3weI1nSvjC4KOCno3X6kbTy62Bxsn0Ar4GiQqAptP7VXt473I3emR7MBkujSe4kS9gC23OjKeg0OAwldPa1nP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158307; c=relaxed/simple;
	bh=/rZ1RkQQE1QfVAErnU252Kue2/ZHae6ru40mVqfeOiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiYzDT6lrHkYaGr2GuREVlmVmP30eBqCJxweHC4CQLmQwA/HEakBltpBEvhD9Apk3iY4n5bS3kGQOwnMlTAynY4qszbwTTM7iCVxphwkexhEroC+o3aLRfFwTPeLeRK6qTvfSXnzRLztalInqMvw674z2ECT7EoIRaKJmi8zxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MzmHD5lM; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MzmHD5lM"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKP3r4GzK3J;
	Thu,  2 Apr 2026 21:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157977;
	bh=0CJ1265KVthTPYvyZOAZmY5vMNc+V2cG1scm9CCbRY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzmHD5lM3Ikt1DX9d2PIj6l+GmLOp6o9d4nCO4TnL6EpwJuZ8IDe/FfnC6Of9XPEq
	 M1f27Xin3RsYR8h7LKUS0CreEZUsvGgOQt6uYedTwUfud3XAItQhPbGJwYx95HXrVF
	 jSzOoyifHnPCxsS5FZq6G6U4S2AyNR5ynR6B7Vhk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKP0jD8z3lm;
	Thu,  2 Apr 2026 21:26:17 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/5] selftests/landlock: Drain stale audit records on init
Date: Thu,  2 Apr 2026 21:26:04 +0200
Message-ID: <20260402192608.1458252-4-mic@digikod.net>
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Non-audit Landlock tests generate audit records as side effects when
audit_enabled is non-zero (e.g. from boot configuration).  These records
accumulate in the kernel audit backlog while no audit daemon socket is
open.  When the next test opens a new netlink socket and registers as
the audit daemon, the stale backlog is delivered, causing baseline
record count checks to fail spuriously.

Fix this by draining all pending records in audit_init() right after
setting the receive timeout.  The 1-usec SO_RCVTIMEO causes audit_recv()
to return -EAGAIN once the backlog is empty, naturally terminating the
drain loop.

Domain deallocation records are emitted asynchronously from a work
queue, so they may still arrive after the drain.  Remove records.domain
== 0 checks that are not preceded by audit_match_record() calls, which
would otherwise consume stale records before the count.  Document this
constraint above audit_count_records().

Increasing the drain timeout to catch in-flight deallocation records was
considered but rejected: a longer timeout adds latency to every
audit_init() call even when no stale record is pending, and any fixed
timeout is still not guaranteed to catch all records under load.
Removing the unprotected checks is simpler and avoids the spurious
failures.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- Also remove domain checks from audit.trace and
  scoped_audit.connect_to_child.
- Document records.domain == 0 constraint above
  audit_count_records().
- Explain why a longer drain timeout was rejected.
- Drop Reviewed-by (new code comment not in v1).
- Split snprintf and fd leak fixes into separate patches.
---
 tools/testing/selftests/landlock/audit.h      | 19 +++++++++++++++++++
 tools/testing/selftests/landlock/audit_test.c |  2 --
 .../testing/selftests/landlock/ptrace_test.c  |  1 -
 .../landlock/scoped_abstract_unix_test.c      |  1 -
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 6422943fc69e..74e1c3d763be 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -338,6 +338,15 @@ struct audit_records {
 	size_t domain;
 };
 
+/*
+ * WARNING: Do not assert records.domain == 0 without a preceding
+ * audit_match_record() call.  Domain deallocation records are emitted
+ * asynchronously from kworker threads and can arrive after the drain in
+ * audit_init(), corrupting the domain count.  A preceding audit_match_record()
+ * call consumes stale records while scanning, making the assertion safe in
+ * practice because stale deallocation records arrive before the expected access
+ * records.
+ */
 static int audit_count_records(int audit_fd, struct audit_records *records)
 {
 	struct audit_message msg;
@@ -393,6 +402,16 @@ static int audit_init(void)
 		goto err_close;
 	}
 
+	/*
+	 * Drains stale audit records that accumulated in the kernel backlog
+	 * while no audit daemon socket was open.  This happens when non-audit
+	 * Landlock tests generate records while audit_enabled is non-zero (e.g.
+	 * from boot configuration), or when domain deallocation records arrive
+	 * asynchronously after a previous test's socket was closed.
+	 */
+	while (audit_recv(fd, NULL) == 0)
+		;
+
 	return fd;
 
 err_close:
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 46d02d49835a..f92ba6774faa 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -412,7 +412,6 @@ TEST_F(audit_flags, signal)
 		} else {
 			EXPECT_EQ(1, records.access);
 		}
-		EXPECT_EQ(0, records.domain);
 
 		/* Updates filter rules to match the drop record. */
 		set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -601,7 +600,6 @@ TEST_F(audit_exec, signal_and_open)
 	/* Tests that there was no denial until now. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(0, records.domain);
 
 	/*
 	 * Wait for the child to do a first denied action by layer1 and
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4f64c90583cd..1b6c8b53bf33 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -342,7 +342,6 @@ TEST_F(audit, trace)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(0, records.domain);
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 72f97648d4a7..c47491d2d1c1 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -312,7 +312,6 @@ TEST_F(scoped_audit, connect_to_child)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(0, records.domain);
 
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
-- 
2.53.0

