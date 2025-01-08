Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D52046B5
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351067; cv=none; b=oqzgNaaKL5zSzCE+n3WknXcYUO3mlo2E59glGj2H3HLfHch9zOyhv04vRv7PpuI2e4ND6fO2aaZfv5ZOgp6XvGJLjfQw3Ucj5B8/e96VMHh2aNG9WfT7ydFjDCznRa/dz1Cis0bTH2kjO8rVVWk5yPuawTkgGSaquNB2ZgNAahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351067; c=relaxed/simple;
	bh=6XP/xC3WVZjggEPtm6+uY2nDqA5pCTb9WxLd8yXQQKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpZiTsJcNl2lm2niukx1XhZG5UQjcr6l0mm7zM1amyoHaTH+5+i1rW1FlAFN7rqOLq6CXBUAZCtUTIJa6KFGCenHfajKiK1B2h93+CoC3zV4yXcwlXvUU127pAdmqCz/0VeQZe7QnUO54kqlt1bkcYr2zIBokgsjQDyaDbCFUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=epRy4Xu+; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="epRy4Xu+"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfb6h7lzslV;
	Wed,  8 Jan 2025 16:44:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351063;
	bh=uFtzYGWF8xstOZnxCGiviNFcQ0C9xk8VJGsQEMF8W+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epRy4Xu++eO55XgPtBGDshLQNVX9f4ZtiTXgkZX7/tZQZ5ud4NobikIuboRS90l9U
	 NXH3in2SPI7rknrFGCi5oaXDUJFa7n7ruuIGdIbwJZZQL8d8kBhYOLqZ0bhAoeJKYh
	 afvijuGBU9mXotYkp0Cjm90gBjYqokln/CLebkW4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfb1Nd7zJKV;
	Wed,  8 Jan 2025 16:44:23 +0100 (CET)
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
Subject: [PATCH v4 25/30] selftests/landlock: Add audit tests for ptrace
Date: Wed,  8 Jan 2025 16:43:33 +0100
Message-ID: <20250108154338.1129069-26-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250108154338.1129069-26-mic@digikod.net
---

Changes since v3:
- Update test coverage.

Changes since v2:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 67 +++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..20a1ca7801aa 100644
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
@@ -85,9 +87,27 @@ static int get_yama_ptrace_scope(void)
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
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DENY, log_match);
+}
+
+FIXTURE(hierarchy)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
 
 FIXTURE_VARIANT(hierarchy)
 {
@@ -245,10 +265,16 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 
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
@@ -261,6 +287,7 @@ TEST_F(hierarchy, trace)
 	char buf_parent;
 	long ret;
 	bool can_read_child, can_trace_child, can_read_parent, can_trace_parent;
+	struct audit_records records;
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
@@ -336,17 +363,29 @@ TEST_F(hierarchy, trace)
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
@@ -358,9 +397,16 @@ TEST_F(hierarchy, trace)
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
@@ -408,17 +454,25 @@ TEST_F(hierarchy, trace)
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
@@ -434,6 +488,11 @@ TEST_F(hierarchy, trace)
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.deny);
+	EXPECT_EQ(0, records.info);
 }
 
 TEST_HARNESS_MAIN
-- 
2.47.1

