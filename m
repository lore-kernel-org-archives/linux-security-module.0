Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A823024C
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497689; cv=none; b=JYqj9V87tKqsjyA1BN6E+2/0otK3COf83ImgGmXGaDxYpXfp51ZuQtCrtk0yNo3JduobwTHztugOgmgacfXZJHHCdlG1LYOLcFguVcDEQYb1CsanTlXmsOaDoKFwB1NefVOEIx8zYk849bnXO56xWeyqeTa9OH5h3r212Xjnyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497689; c=relaxed/simple;
	bh=WCiYi6/5YPW6GYBH6rdc3JFd7Vug8oKUjJEUZ0zOPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp6HdHcpoIuOKbtaIeaNM+v/ncZmU2/347zOnEO5nbSLqcp22DfX9PZO54X2XsS01ssErwRoUFT6Jnj5kY1EmAKe/S3VBT2w1bsoThb+C7ObPqagVPBeWHh+7xGrt7mv7Y7WXz2f0lAubEFEX2qSxrGmY+pmJA7OFALwW2r+YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=khZGcTxg; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="khZGcTxg"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpr1pnhzwdD;
	Thu, 20 Mar 2025 20:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497684;
	bh=48tyc0VLiY0MDywwnAC06mW/SWXf4hBircunrYD3qQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khZGcTxgm4DGoD8LH5ia1NkEw+chcr2cBa8sEWOa7fN+SWYFxDEXV842UjMgr/r4d
	 UXlZelzL6u/LO4BOjZW3ZHpX2xP/lgr3SzOXgPxUaPn0PukJkinVr8zB9u25cowSqg
	 Q0VBGsWERkiIxlK1rY9eb8h/3FuijgLPq2ihr9LI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpq2xyJzBht;
	Thu, 20 Mar 2025 20:08:03 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 25/28] selftests/landlock: Add audit tests for abstract UNIX socket scoping
Date: Thu, 20 Mar 2025 20:07:14 +0100
Message-ID: <20250320190717.2287696-26-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new scoped_audit.connect_to_child test to check the abstract UNIX
socket blocker.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Check audit_count_records() calls for audit errors.
- Simplify tests.

Changes since v5:
- New patch.
---
 .../landlock/scoped_abstract_unix_test.c      | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index a6b59d2ab1b4..6825082c079c 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -20,6 +20,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "audit.h"
 #include "common.h"
 #include "scoped_common.h"
 
@@ -267,6 +268,116 @@ TEST_F(scoped_domains, connect_to_child)
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
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	EXPECT_EQ(
+		0,
+		audit_match_record(
+			self->audit_fd, AUDIT_LANDLOCK_ACCESS,
+			REGEX_LANDLOCK_PREFIX
+			" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
+			"[0-9A-F]\\+$",
+			NULL));
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
2.49.0

