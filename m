Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCC230997
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497691; cv=none; b=BHyrue6B5Cam0yVeuMR+OMRwWnoVozPBpqaXqQMeclpbEFnNlpEqht8NPkP+pGZMxBdhxmr+L04gzEPGohXh0OcRHnnCnB+ZUJS1AQ+LtBe3CFvEqCtaADm7CXkqrton4U5CaU2kMqjxgQP/6f2YcFSInEXpoYFdzqSdnF6yatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497691; c=relaxed/simple;
	bh=9jm/fVQH5DSTmdbX/gjZWrtsX+ZVQAWl9ZgeRFitps0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGUfSglywqb10eeI+u0I4qYP4Rk8Moe88C08oawGi5t32//6SnFRom2WYwZaMGYBwkn5IOOPmbzhJd3MADtI2lyaFLLeiBVkfB4/+fnY58rPSYUuWJ6lltrIHIz5B8MarB4vFn2uXlPN+IcPFltIxsfwTkOoOO+B5+fZewG+37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pkNOobP3; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pkNOobP3"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpv4pjJzJP8;
	Thu, 20 Mar 2025 20:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497687;
	bh=WZT6kpQUDFzOAgE+Auo1PXERCsbfJlcfMs2hdUUSSV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkNOobP3nES6xL9vX8dESrlUKmokFtnR6DC2TBlZ8NZ83T6e5hDyFdJVC2FENtVFp
	 7EyGKq9xx+BYz+jnZgG1KVk2P0XFmCnqU6SmSpWxh1pOS85Zomh7MqZ9t6ULTeuAoK
	 XxzDVgSbzxN2oO4RYiJYAvPAikC2QH3wXfEXYgaE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpt4zJ0z6Fh;
	Thu, 20 Mar 2025 20:08:06 +0100 (CET)
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
Subject: [PATCH v7 27/28] selftests/landlock: Add audit tests for network
Date: Thu, 20 Mar 2025 20:07:16 +0100
Message-ID: <20250320190717.2287696-28-mic@digikod.net>
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

Test all network blockers:
- net.bind_tcp
- net.connect_tcp

Test coverage for security/landlock is 94.0% of 1430 lines according to
gcc/gcov-14.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- New patch.
---
 tools/testing/selftests/landlock/net_test.c | 132 ++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index d9de0ee49ebc..2a45208551e6 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -20,6 +20,7 @@
 #include <sys/syscall.h>
 #include <sys/un.h>
 
+#include "audit.h"
 #include "common.h"
 
 const short sock_port_start = (1 << 10);
@@ -1868,4 +1869,135 @@ TEST_F(port_specific, bind_connect_1023)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+static int matches_log_tcp(const int audit_fd, const char *const blockers,
+			   const char *const dir_addr, const char *const addr,
+			   const char *const dir_port)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=%s %s=%s %s=1024$";
+	/*
+	 * Max strlen(blockers): 16
+	 * Max strlen(dir_addr): 5
+	 * Max strlen(addr): 12
+	 * Max strlen(dir_port): 4
+	 */
+	char log_match[sizeof(log_template) + 37];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
+				 blockers, dir_addr, addr, dir_port);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+FIXTURE(audit)
+{
+	struct service_fixture srv0;
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_VARIANT(audit)
+{
+	const char *const addr;
+	const struct protocol_variant prot;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv4) {
+	/* clang-format on */
+	.addr = "127\\.0\\.0\\.1",
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv6) {
+	/* clang-format on */
+	.addr = "::1",
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+	},
+};
+
+FIXTURE_SETUP(audit)
+{
+	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	setup_loopback(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	disable_caps(_metadata);
+};
+
+FIXTURE_TEARDOWN(audit)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+TEST_F(audit, bind)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv0));
+	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.bind_tcp", "saddr",
+				     variant->addr, "src"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
+TEST_F(audit, connect)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
+	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.connect_tcp",
+				     "daddr", variant->addr, "dest"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0

