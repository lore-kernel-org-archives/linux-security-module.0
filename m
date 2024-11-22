Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D021E048D
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286076; cv=none; b=BxE1OqVc1ZAEWdfvx4Rx3gG2v1djgBTureDLqYzlulXa5fr8DItWWyRpW29aCIjb8tIEOdDkPCJC5YB/f/SHKYNC7YGc6v6IhTlVZivgu+vVw0sYXZYCCrJ6HgLlou2WQlmuUwmbfo+NDadBm5i0aA8J1Sx8Xj5aj5jAVi/oChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286076; c=relaxed/simple;
	bh=36b7Lyz3k8FScTc5AXG1dY/03AGd/FzjGBeIK5Rrh6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBG+QK0rT53eMLt3IsgCf1yUdYH53VSg+Dd//7PJGxugKNsL0Qnsvm+tqaERk3chjF7dKzVhf6AaIPQEZzvek9CPruFImmhNj4tcpsm/0VAbf+lpUYGwtvgNpk9DxmUz+Kr0QwOE30c3q3GU/QGMhHvhBJvFOFPkXmJLZhxo4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r8HHBOBo; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r8HHBOBo"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKh0XG5zj9g;
	Fri, 22 Nov 2024 15:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286071;
	bh=zplGSbTIB54PAhZp2mb0y83mOQueBGo/UaXX9cN25G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8HHBOBoxJTalyzqRRUChQvrA0j19XWI4RyAyrcpebIx7xf4wESqk0DXKKZkl4LgQ
	 1wGQ6ZyOWgHUsKYfI0cemIeuUpAY3dPntjxxGV0hi4kkd9zf/3jt5EUSHn+yKlTs77
	 6j2YYaixRFk3IgNmNoHtaOACW/LkCzcjnLA84vcQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKg2NbzzjZ6;
	Fri, 22 Nov 2024 15:34:31 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 23/23] selftests/landlock: Add audit tests for ptrace
Date: Fri, 22 Nov 2024 15:33:53 +0100
Message-ID: <20241122143353.59367-24-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tests for all ptrace actions.  This improve all the ptrace tests by
making sure that the restrictions comes from Landlock, and with the
expected objects.  These are like enhanced errno checks.

Test coverage for security/landlock is 93.3% of 1604 lines according to
gcc/gcov-14.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-24-mic@digikod.net
---

Changes since v2:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 62 +++++++++++++++++--
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..592927059cc3 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2019-2020 ANSSI
+ * Copyright © 2024 Microsoft Corporation
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
+			      struct audit_state *const state, const pid_t opid)
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
+	// TODO: return -errno with AUDIT_SYSCALL
+	return !audit_match_record(state, AUDIT_LANDLOCK_DENY, log_match);
+}
+
+FIXTURE(hierarchy)
+{
+	struct audit_state state;
+};
 
 FIXTURE_VARIANT(hierarchy)
 {
@@ -245,10 +265,15 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 
 FIXTURE_SETUP(hierarchy)
 {
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_init(&self->state));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
 }
 
-FIXTURE_TEARDOWN(hierarchy)
+FIXTURE_TEARDOWN_PARENT(hierarchy)
 {
+	EXPECT_EQ(0, audit_cleanup(NULL));
 }
 
 /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
@@ -261,6 +286,7 @@ TEST_F(hierarchy, trace)
 	char buf_parent;
 	long ret;
 	bool can_read_child, can_trace_child, can_read_parent, can_trace_parent;
+	struct audit_records records;
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
@@ -336,17 +362,26 @@ TEST_F(hierarchy, trace)
 		err_proc_read = test_ptrace_read(parent);
 		if (can_read_parent) {
 			EXPECT_EQ(0, err_proc_read);
+			EXPECT_EQ(0, matches_log_ptrace(_metadata, &self->state,
+							parent));
 		} else {
 			EXPECT_EQ(EACCES, err_proc_read);
+			EXPECT_EQ(1, matches_log_ptrace(_metadata, &self->state,
+							parent));
 		}
 
 		/* Tests PTRACE_ATTACH on the parent. */
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
 		if (can_trace_parent) {
 			EXPECT_EQ(0, ret);
+			EXPECT_EQ(0, matches_log_ptrace(_metadata, &self->state,
+							parent));
 		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
+			EXPECT_EQ(!can_read_parent,
+				  matches_log_ptrace(_metadata, &self->state,
+						     parent));
 		}
 		if (ret == 0) {
 			ASSERT_EQ(parent, waitpid(parent, &status, 0));
@@ -358,9 +393,15 @@ TEST_F(hierarchy, trace)
 		ret = ptrace(PTRACE_TRACEME);
 		if (can_trace_child) {
 			EXPECT_EQ(0, ret);
+			EXPECT_EQ(0, matches_log_ptrace(_metadata, &self->state,
+							parent));
 		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
+			/* We should indeed see the parent process. */
+			EXPECT_EQ(!can_read_child,
+				  matches_log_ptrace(_metadata, &self->state,
+						     parent));
 		}
 
 		/*
@@ -408,17 +449,25 @@ TEST_F(hierarchy, trace)
 	err_proc_read = test_ptrace_read(child);
 	if (can_read_child) {
 		EXPECT_EQ(0, err_proc_read);
+		EXPECT_EQ(0,
+			  matches_log_ptrace(_metadata, &self->state, child));
 	} else {
 		EXPECT_EQ(EACCES, err_proc_read);
+		EXPECT_EQ(1,
+			  matches_log_ptrace(_metadata, &self->state, child));
 	}
 
 	/* Tests PTRACE_ATTACH on the child. */
 	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
 	if (can_trace_child) {
 		EXPECT_EQ(0, ret);
+		EXPECT_EQ(0,
+			  matches_log_ptrace(_metadata, &self->state, child));
 	} else {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
+		EXPECT_EQ(!can_read_child,
+			  matches_log_ptrace(_metadata, &self->state, child));
 	}
 
 	if (ret == 0) {
@@ -434,6 +483,11 @@ TEST_F(hierarchy, trace)
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->exit_code = KSFT_FAIL;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(&self->state, &records);
+	EXPECT_EQ(0, records.deny);
+	EXPECT_EQ(0, records.info);
 }
 
 TEST_HARNESS_MAIN
-- 
2.47.0

