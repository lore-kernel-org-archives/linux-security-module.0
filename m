Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053F1F09BF
	for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305918; cv=none; b=N4zDVmWhtSjGyVvl/G9Rlkb4c7QkWMZ5O6yr6UCGCN2kywbfMgOGjImqFtH/+SmB3AksF9imEs8QjQauBl7IcqzU6pZ9e4Ja1tP6I8AjoD/BSxKybTky47OPT7epYwrW7w9BZMVcXEH/s12Fxavh2xBgYBJsSDdneO5f+3iC9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305918; c=relaxed/simple;
	bh=IzSTGxrRRiCItD0srLShw+8nST5LMas3YolXKiNwVeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZJlNs38mqbTKR+pTaxRE+mY7LAX9eyoSWjDDT1bteKdqeqVk/hQJJh7ZYvj9RDQH3jRTDqvT64pEw1ZaQGQTXE/XmwFJwmpjYqIl5CvIgLS1qpKf1Ah9ePUGvtzZnlX5Jc8NHbsNGIQw28Nf+0w4+FzFQPoNiKaZ7Ktzk5C3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QA+15piz; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QA+15piz"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZYRMl0BNVzZ39;
	Thu, 10 Apr 2025 19:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744305458;
	bh=xINIg+qaeGf/DRdagSjHiaFjd/ETAsOMFZSkkPcQ1go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QA+15pizxrECElwJnfvDtG8EzbOcEDHqaJDD8i/gXHeZPteqA7Nk4UX+J7a0/RNZN
	 HH8JY8YmrNG+vW7KCM9NdUo0SrVhpsOLqN6aOy2J3So/VRrrKLQDC0DO7RbU91X6IC
	 f4rJ11gmZT9cnE7qzIA8drDJRwB8dSDT/5G7VNXg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZYRMk4BpBzV6m;
	Thu, 10 Apr 2025 19:17:38 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 3/3] selftests/landlock: Add PID tests for audit records
Date: Thu, 10 Apr 2025 19:17:23 +0200
Message-ID: <20250410171725.1265860-3-mic@digikod.net>
In-Reply-To: <20250410171725.1265860-1-mic@digikod.net>
References: <20250410171725.1265860-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit.thread tests to check that the PID tied to a domain is not a
thread ID but the thread group ID.  These new tests would not pass
without the previous TGID fix.

Extend matches_log_domain_allocated() to check against the PID that
created the domain.

Test coverage for security/landlock is 93.6% of 1524 lines according to
gcc/gcov-14.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/audit.h      |  21 ++-
 tools/testing/selftests/landlock/audit_test.c | 127 +++++++++++++++++-
 tools/testing/selftests/landlock/fs_test.c    |   3 +-
 3 files changed, 141 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index b9054086a0c9..18a6014920b5 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -300,15 +300,22 @@ static int audit_match_record(int audit_fd, const __u16 type,
 	return err;
 }
 
-static int __maybe_unused matches_log_domain_allocated(int audit_fd,
+static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
 						       __u64 *domain_id)
 {
-	return audit_match_record(
-		audit_fd, AUDIT_LANDLOCK_DOMAIN,
-		REGEX_LANDLOCK_PREFIX
-		" status=allocated mode=enforcing pid=[0-9]\\+ uid=[0-9]\\+"
-		" exe=\"[^\"]\\+\" comm=\".*_test\"$",
-		domain_id);
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" status=allocated mode=enforcing pid=%d uid=[0-9]\\+"
+		" exe=\"[^\"]\\+\" comm=\".*_test\"$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len =
+		snprintf(log_match, sizeof(log_match), log_template, pid);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
+				  domain_id);
 }
 
 static int __maybe_unused matches_log_domain_deallocated(
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 815c0f03e1fb..cfc571afd0eb 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/landlock.h>
+#include <pthread.h>
 #include <stdlib.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
@@ -104,7 +105,8 @@ TEST_F(audit, layers)
 				  matches_log_signal(_metadata, self->audit_fd,
 						     getppid(), &denial_dom));
 			EXPECT_EQ(0, matches_log_domain_allocated(
-					     self->audit_fd, &allocated_dom));
+					     self->audit_fd, getpid(),
+					     &allocated_dom));
 			EXPECT_NE(denial_dom, 1);
 			EXPECT_NE(denial_dom, 0);
 			EXPECT_EQ(denial_dom, allocated_dom);
@@ -156,6 +158,126 @@ TEST_F(audit, layers)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+struct thread_data {
+	pid_t parent_pid;
+	int ruleset_fd, pipe_child, pipe_parent;
+};
+
+static void *thread_audit_test(void *arg)
+{
+	const struct thread_data *data = (struct thread_data *)arg;
+	uintptr_t err = 0;
+	char buffer;
+
+	/* TGID and TID are different for a second thread. */
+	if (getpid() == gettid()) {
+		err = 1;
+		goto out;
+	}
+
+	if (landlock_restrict_self(data->ruleset_fd, 0)) {
+		err = 2;
+		goto out;
+	}
+
+	if (close(data->ruleset_fd)) {
+		err = 3;
+		goto out;
+	}
+
+	/* Creates a denial to get the domain ID. */
+	if (kill(data->parent_pid, 0) != -1) {
+		err = 4;
+		goto out;
+	}
+
+	if (EPERM != errno) {
+		err = 5;
+		goto out;
+	}
+
+	/* Signals the parent to read denial logs. */
+	if (write(data->pipe_child, ".", 1) != 1) {
+		err = 6;
+		goto out;
+	}
+
+	/* Waits for the parent to update audit filters. */
+	if (read(data->pipe_parent, &buffer, 1) != 1) {
+		err = 7;
+		goto out;
+	}
+
+out:
+	close(data->pipe_child);
+	close(data->pipe_parent);
+	return (void *)err;
+}
+
+/* Checks that the PID tied to a domain is not a TID but the TGID. */
+TEST_F(audit, thread)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	__u64 denial_dom = 1;
+	__u64 allocated_dom = 2;
+	__u64 deallocated_dom = 3;
+	pthread_t thread;
+	int pipe_child[2], pipe_parent[2];
+	char buffer;
+	struct thread_data child_data;
+
+	child_data.parent_pid = getppid();
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	child_data.pipe_child = pipe_child[1];
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	child_data.pipe_parent = pipe_parent[0];
+	child_data.ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, child_data.ruleset_fd);
+
+	/* TGID and TID are the same for the initial thread . */
+	EXPECT_EQ(getpid(), gettid());
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_audit_test,
+				    &child_data));
+
+	/* Waits for the child to generate a denial. */
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+	EXPECT_EQ(0, close(pipe_child[0]));
+
+	/* Matches the signal log to get the domain ID. */
+	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+					child_data.parent_pid, &denial_dom));
+	EXPECT_NE(denial_dom, 1);
+	EXPECT_NE(denial_dom, 0);
+
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &allocated_dom));
+	EXPECT_EQ(denial_dom, allocated_dom);
+
+	/* Updates filter rules to match the drop record. */
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_filter_drop(self->audit_fd, AUDIT_ADD_RULE));
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter,
+				      AUDIT_DEL_RULE));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	/* Signals the thread to exit, which will generate a domain deallocation. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	ASSERT_EQ(0, pthread_join(thread, NULL));
+
+	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+				&audit_tv_dom_drop, sizeof(audit_tv_dom_drop)));
+	EXPECT_EQ(0, matches_log_domain_deallocated(self->audit_fd, 1,
+						    &deallocated_dom));
+	EXPECT_EQ(denial_dom, deallocated_dom);
+	EXPECT_EQ(0, setsockopt(self->audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+				&audit_tv_default, sizeof(audit_tv_default)));
+}
+
 FIXTURE(audit_flags)
 {
 	struct audit_filter audit_filter;
@@ -270,7 +392,8 @@ TEST_F(audit_flags, signal)
 
 			/* Checks domain information records. */
 			EXPECT_EQ(0, matches_log_domain_allocated(
-					     self->audit_fd, &allocated_dom));
+					     self->audit_fd, getpid(),
+					     &allocated_dom));
 			EXPECT_NE(*self->domain_id, 1);
 			EXPECT_NE(*self->domain_id, 0);
 			EXPECT_EQ(*self->domain_id, allocated_dom);
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f819011a8798..73729382d40f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5964,7 +5964,8 @@ TEST_F(audit_layout1, refer_handled)
 	EXPECT_EQ(EXDEV, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
-	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, NULL));
+	EXPECT_EQ(0,
+		  matches_log_domain_allocated(self->audit_fd, getpid(), NULL));
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d3));
 
-- 
2.49.0

