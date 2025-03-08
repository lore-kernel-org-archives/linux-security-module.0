Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF22192F0
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459513; cv=none; b=VwXOt/JB8xlQoXkUx4lfVYy6yFod1aQxj0NxqZkQlYldf3ony3vvfs44+0+5lm9P5x32bB9QZ9ekhyur1vdByiP5d/IcGNSkCqFuF/3liztcCAZ89dlfPjPxDBU2YVroj8wfA0o0sQb+4+ityJfUwiWjm/5BswosywYiJ0pm6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459513; c=relaxed/simple;
	bh=XRbz7lvEQY0aNuJMptZCxp+4ZgmpF8XcathU82NSabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROTiJqv2BkE46uHb8R+99yGWt3YPUKLKPm0dI7qFkMQWNmorR4k9ZZFSWdO+FqylHOvkbLyRzmezRKlxqeIrb1Bz3DJMD+xNBliRNg6G5UMEmiANUxGi4xSabhdfVMK5UAA15Ovj/T8Lb50rSfkfkNnc+liG2lMLLs7pB2kSHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P+9Yh/pw; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P+9Yh/pw"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsx1cJLzNqX;
	Sat,  8 Mar 2025 19:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459509;
	bh=xJtlNKGnSbmGPejBcDimlJU9c0REBHXBhUsr8iKogCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+9Yh/pwzfqGJxdn6sg+PeZ6o9WQDuP1Vn1nUpCEyMLGddGB4rlMT29IeHvFehmdK
	 CsqidCIo1aJMm/+Ff0GBY8f5CIpkaWqcshIY9KmaHUlppoDpdgvIm5crqcQAyZn/Vx
	 AVEWNkyEf/ElHq4JWBUH+AgpZy/s0y+5eqBNSk2w=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsw3Jg6zqjd;
	Sat,  8 Mar 2025 19:45:08 +0100 (CET)
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
Subject: [PATCH v6 24/26] selftests/landlock: Add audit tests for abstract unix socket scoping
Date: Sat,  8 Mar 2025 19:44:20 +0100
Message-ID: <20250308184422.2159360-25-mic@digikod.net>
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

Add a new scoped_uadit.connect_to_child test to check the abstract unix
socket blocker.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-25-mic@digikod.net
---

Changes since v5:
- New patch.
---
 .../landlock/scoped_abstract_unix_test.c      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index a6b59d2ab1b4..520b90d5f2f9 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -20,6 +20,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "audit.h"
 #include "common.h"
 #include "scoped_common.h"
 
@@ -267,6 +268,126 @@ TEST_F(scoped_domains, connect_to_child)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+FIXTURE(scoped_audit)
+{
+	struct service_fixture dgram_address;
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(scoped_audit)
+{
+	disable_caps(_metadata);
+
+	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
+	set_unix_address(&self->dgram_address, 1);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN_PARENT(scoped_audit)
+{
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+}
+
+/* python -c 'print(b"\0selftests-landlock-abstract-unix-".hex().upper())' */
+#define ABSTRACT_SOCKET_PATH_PREFIX \
+	"0073656C6674657374732D6C616E646C6F636B2D61627374726163742D756E69782D"
+
+static int matches_log_abstract_socket(struct __test_metadata *const _metadata,
+				       int audit_fd)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
+		"[0-9A-F]\\+$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+/*
+ * Simpler version of scoped_domains.connect_to_child, but with audit tests.
+ */
+TEST_F(scoped_audit, connect_to_child)
+{
+	pid_t child;
+	int err_dgram, status;
+	int pipe_child[2], pipe_parent[2];
+	char buf;
+	int dgram_client;
+	struct audit_records records;
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int dgram_server;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		/* Waits for the parent to be in a domain. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_LE(0, dgram_server);
+		ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
+				  self->dgram_address.unix_addr_len));
+
+		/* Signals to the parent that child is listening. */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		/* Waits to connect. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		EXPECT_EQ(0, close(dgram_server));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
+
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_LE(0, dgram_client);
+
+	/* Waits for the child to listen */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
+			    self->dgram_address.unix_addr_len);
+	EXPECT_EQ(-1, err_dgram);
+	EXPECT_EQ(EPERM, errno);
+
+	EXPECT_EQ(0, matches_log_abstract_socket(_metadata, self->audit_fd));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(dgram_client));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 FIXTURE(scoped_vs_unscoped)
 {
 	struct service_fixture parent_stream_address, parent_dgram_address,
-- 
2.48.1

