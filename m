Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E31EEA35
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341154; cv=none; b=rO8PB51b492dx/ulh1zr3WlodnOpBS4i5NAKLmYwmwmHXVuLaMjA56XgXf4sg5bbIcSxXLtIUn11lmayIE1y8JORhosH2f6PD5YYubCESJfRUT7jsIJP1aGtvNJnTv18hgMhQZAMQS11BP97375YkSZv/5abXMj3BQ7rplU1OAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341154; c=relaxed/simple;
	bh=8BSBVjyjYZi7/hxUa0iLye8ppDGlNnH51o9/8nwEKog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgJa50d+Qv6EbfOFSu+i+1wNwBqMcJ4gPayseJepA9FFFhVMi0ihweRTpTi97DURe/oIvHNxyk9J+zkla7sf9aMz0NzphGqT5KpjyIXW90RjxKPzhwl7hcFOIgA3M0ekjV9aahOkfriSrRmxnIpJi8hiYkJi/Vr/Ww7s/iq6q8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZIFfktB9; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZIFfktB9"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1dT5N3PzBZ2;
	Fri, 31 Jan 2025 17:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341149;
	bh=V75AkmwKMcdn1WdQNzjUasVdnSxsTv0H3oaohrB53LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIFfktB9U+Y3Wu4et6Ml6jz9Ct0l91KHYr6cBGzHrmcPNZYG7zK1QoMaphYfipwIx
	 BLZM3wP5+kmihKkokwc91Ljt7eIasZAeDxqUzk+bpIxjWP69U0iQzEoS6jUPa6ogES
	 ra0RGjRkM4V+NybWWIBcB5Srgx753iSLAnViiEz8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1dS2Zpxz8jb;
	Fri, 31 Jan 2025 17:32:28 +0100 (CET)
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 23/24] selftests/landlock: Add audit tests for ptrace
Date: Fri, 31 Jan 2025 17:30:58 +0100
Message-ID: <20250131163059.1139617-24-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tests for all ptrace actions.  This improves all the ptrace tests by
making sure that the restrictions comes from Landlock, and with the
expected objects.  These extended tests are like enhanced errno checks
that make sure Landlock enforcement is consistent.

Test coverage for security/landlock is 93.4% of 1619 lines according to
gcc/gcov-14.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-24-mic@digikod.net
---

Changes since v3:
- Update test coverage.

Changes since v2:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 67 +++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 8f31b673ff2d..6f1551290450 100644
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
@@ -83,9 +85,27 @@ static int get_yama_ptrace_scope(void)
 	return ret;
 }
 
-/* clang-format off */
-FIXTURE(hierarchy) {};
-/* clang-format on */
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
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match);
+}
+
+FIXTURE(hierarchy)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
 
 FIXTURE_VARIANT(hierarchy)
 {
@@ -243,10 +263,16 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 
 FIXTURE_SETUP(hierarchy)
 {
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
 }
 
-FIXTURE_TEARDOWN(hierarchy)
+FIXTURE_TEARDOWN_PARENT(hierarchy)
 {
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
 }
 
 /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
@@ -259,6 +285,7 @@ TEST_F(hierarchy, trace)
 	char buf_parent;
 	long ret;
 	bool can_read_child, can_trace_child, can_read_parent, can_trace_parent;
+	struct audit_records records;
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
@@ -334,17 +361,29 @@ TEST_F(hierarchy, trace)
 		err_proc_read = test_ptrace_read(parent);
 		if (can_read_parent) {
 			EXPECT_EQ(0, err_proc_read);
+			EXPECT_EQ(-EAGAIN,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		} else {
 			EXPECT_EQ(EACCES, err_proc_read);
+			EXPECT_EQ(0,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		}
 
 		/* Tests PTRACE_ATTACH on the parent. */
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
 		if (can_trace_parent) {
 			EXPECT_EQ(0, ret);
+			EXPECT_EQ(-EAGAIN,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
+			EXPECT_EQ(can_read_parent ? -EAGAIN : 0,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		}
 		if (ret == 0) {
 			ASSERT_EQ(parent, waitpid(parent, &status, 0));
@@ -356,9 +395,16 @@ TEST_F(hierarchy, trace)
 		ret = ptrace(PTRACE_TRACEME);
 		if (can_trace_child) {
 			EXPECT_EQ(0, ret);
+			EXPECT_EQ(-EAGAIN,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
+			/* We should indeed see the parent process. */
+			EXPECT_EQ(can_read_child ? -EAGAIN : 0,
+				  matches_log_ptrace(_metadata, self->audit_fd,
+						     parent));
 		}
 
 		/*
@@ -406,17 +452,25 @@ TEST_F(hierarchy, trace)
 	err_proc_read = test_ptrace_read(child);
 	if (can_read_child) {
 		EXPECT_EQ(0, err_proc_read);
+		EXPECT_EQ(-EAGAIN,
+			  matches_log_ptrace(_metadata, self->audit_fd, child));
 	} else {
 		EXPECT_EQ(EACCES, err_proc_read);
+		EXPECT_EQ(0,
+			  matches_log_ptrace(_metadata, self->audit_fd, child));
 	}
 
 	/* Tests PTRACE_ATTACH on the child. */
 	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
 	if (can_trace_child) {
 		EXPECT_EQ(0, ret);
+		EXPECT_EQ(-EAGAIN,
+			  matches_log_ptrace(_metadata, self->audit_fd, child));
 	} else {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
+		EXPECT_EQ(can_read_child ? -EAGAIN : 0,
+			  matches_log_ptrace(_metadata, self->audit_fd, child));
 	}
 
 	if (ret == 0) {
@@ -432,6 +486,11 @@ TEST_F(hierarchy, trace)
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 }
 
 TEST_HARNESS_MAIN
-- 
2.48.1

