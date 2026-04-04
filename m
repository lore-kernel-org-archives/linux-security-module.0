Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431901FCFFC
	for <linux-security-module@vger.kernel.org>; Sat,  4 Apr 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292621; cv=none; b=qOaGcbt+PyWXv6P8qGEaiNaioIAxVtmgF5RsIG4TLn1FICGSXPrh/X4NhOXKfZNXr0YzdXrBThiD6Q6geUH+/QWU8amYcZYr/qWmXc7JxkuxYpFDVAlNtuQr3VAQw7ETMxPPu/PKyqN8DUlpgDGWlhfei1Dee1JFY0ZkXnVh4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292621; c=relaxed/simple;
	bh=xnQenmXYE5hgnU2UxLtdhHNYoTYo0J1/kQiKDDQEvW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l7BwoCSjSZivNN/61M3T1YI6luQHa9i4JR+vme9ValXIFrdVbFb9gLpoA+Or6o9lXqXkb+NEcGPm00r5vkimc5hHr+/doeN491wNiSU6lP45AxKVt8jOAhdBhloq11GHG1hG4kp8M2lUJ1Lj0IQBDW4mDMGeHXGlfow5y5MpEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hPaVxlfV; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hPaVxlfV"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fnq6T11ZZzMkN;
	Sat,  4 Apr 2026 10:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775292609;
	bh=qkZXkcmbq2XwyKAcJKC4wMcKLyFKer/3w3GgHHgddbA=;
	h=From:To:Cc:Subject:Date:From;
	b=hPaVxlfVHCdrQmwpCPkds6x49GKWNfRo2lcGL4EOZTzteFtBbsSaxATtMeIARGwjF
	 8yTZeIr/Ef4x1RqBMN8arQ0ju4X/B66I5sVh4Ay7bWOITuaNoVgN5CwZ7VttQcdQUK
	 Gp2p9rcn0KR1smvoXTnLvSqbXiraxC4Agc3WFlSY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fnq6S4Zh8zMY4;
	Sat,  4 Apr 2026 10:50:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance across fork()
Date: Sat,  4 Apr 2026 10:49:57 +0200
Message-ID: <20260404085001.1604405-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

hook_cred_transfer() only copies the Landlock security blob when the
source credential has a domain.  This is inconsistent with
landlock_restrict_self() which can set log_subdomains_off on a
credential without creating a domain (via the ruleset_fd=-1 path): the
field is committed but not preserved across fork() because the child's
prepare_creds() calls hook_cred_transfer() which skips the copy when
domain is NULL.

This breaks the documented use case where a process mutes subdomain logs
before forking sandboxed children: the children lose the muting and
their domains produce unexpected audit records.

Fix this by unconditionally copying the Landlock credential blob.
landlock_get_ruleset(NULL) is already a safe no-op.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/cred.c                      |  6 +-
 tools/testing/selftests/landlock/audit_test.c | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..cc419de75cd6 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
 	const struct landlock_cred_security *const old_llcred =
 		landlock_cred(old);
 
-	if (old_llcred->domain) {
-		landlock_get_ruleset(old_llcred->domain);
-		*landlock_cred(new) = *old_llcred;
-	}
+	landlock_get_ruleset(old_llcred->domain);
+	*landlock_cred(new) = *old_llcred;
 }
 
 static int hook_cred_prepare(struct cred *const new,
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 46d02d49835a..20099b8667e7 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -279,6 +279,94 @@ TEST_F(audit, thread)
 				&audit_tv_default, sizeof(audit_tv_default)));
 }
 
+/*
+ * Verifies that log_subdomains_off set via the ruleset_fd=-1 path (without
+ * creating a domain) is inherited by children across fork().  This exercises
+ * the hook_cred_transfer() fix: the Landlock credential blob must be copied
+ * even when the source credential has no domain.
+ *
+ * Phase 1 (baseline): a child without muting creates a domain and triggers a
+ * denial that IS logged.
+ *
+ * Phase 2 (after muting): the parent mutes subdomain logs, forks another child
+ * who creates a domain and triggers a denial that is NOT logged.
+ */
+TEST_F(audit, log_subdomains_off_fork)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+	struct audit_records records;
+	int ruleset_fd, status;
+	pid_t child;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	/*
+	 * Phase 1: forks a child that creates a domain and triggers a denial
+	 * before any muting.  This proves the audit path works.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(EPERM, errno);
+		_exit(0);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(true, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	/* The denial must be logged (baseline). */
+	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
+					NULL));
+
+	/* Drains any remaining records (e.g. domain allocation). */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+
+	/*
+	 * Mutes subdomain logs without creating a domain.  The parent's
+	 * credential has domain=NULL and log_subdomains_off=1.
+	 */
+	ASSERT_EQ(0, landlock_restrict_self(
+			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+
+	/*
+	 * Phase 2: forks a child that creates a domain and triggers a denial.
+	 * Because log_subdomains_off was inherited via fork(), the child's
+	 * domain has log_status=LANDLOCK_LOG_DISABLED.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(EPERM, errno);
+		_exit(0);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(true, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+
+	/* No denial record should appear. */
+	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
+					      getpid(), NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 FIXTURE(audit_flags)
 {
 	struct audit_filter audit_filter;
-- 
2.53.0

