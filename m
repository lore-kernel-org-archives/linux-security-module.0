Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4341F4710;
	Fri, 31 Jan 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341120; cv=none; b=c0H4BvRLOE5S5CIlCu5XKZm/idd6yRwraJRpTZS3k8yfaIm/VAqKJ3eeudBVZVEQgHQBzF14S3U/1Hu1VbaRPspZWl2k71NYSMOwhvNmKSw5RX3Knf8M+LehRIQsRO+Hxn0QbK5Q3c/jUbFXNE1p+R59CXbKB+QCMRJyeZMB45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341120; c=relaxed/simple;
	bh=EnJ9ES/PQSv6HORXZ0wYFtPhfknF3AEcFDYqCUqAPws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKGtUmh6ERlovIOZCYLUSi3O1R/0OT2gU1A1mvI9vo73Wqm10TLHGZ4+PTKRWLWEwzgDXlb7IQjBv+fW8qupcNqEBDtgn2XbdeeXtqW5TLQEEUVnrDWzppQmyNIaWglJLEQZXl6mUw1r3GUb7Nnjnvlkn8U03K2aBdfK06QttlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PEpv1sf5; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PEpv1sf5"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cr6D5KzWRr;
	Fri, 31 Jan 2025 17:31:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341116;
	bh=1szZTiMI9fN5r9m+Li6kq8QVNGxlrzk95HS2iBcSqm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEpv1sf5xtGb7LZDaJtofbOC3muB0vRuD3sqy0+T09vX/QEFVHrpgYX4wTGaQHTms
	 Q5C6IZA9M8M4pjHeaZzngZ6tIeWorUC4sFuN89MZCWju2gxsgVdTKTVf22gfEXO5n6
	 Oso6d7QT7fBU/3kZt+RVkrLLX/ufSpQ/PHO04qXA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cp4sD2zcrQ;
	Fri, 31 Jan 2025 17:31:54 +0100 (CET)
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
Subject: [PATCH v5 20/24] selftests/landlock: Extend tests for landlock_restrict_self()'s flags
Date: Fri, 31 Jan 2025 17:30:55 +0100
Message-ID: <20250131163059.1139617-21-mic@digikod.net>
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

Add the restrict_self_flags test suite to check that
LANDLOCK_RESTRICT_SELF_QUIET, LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS,
and LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC are valid but not the next
bit.  Also test flags incompatibility.  Some checks are similar to
restrict_self_checks_ordering's ones.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-21-mic@digikod.net
---

Changes since v4:
- Update with LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS, and
  LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC.

Changes since v3:
- Use a last_flag variable.

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/base_test.c | 41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index fbd687691b3c..9e21f7535ab6 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -233,6 +233,47 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_flags)
+{
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC;
+
+	/* Tests valid flag combinations. */
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_QUIET));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_QUIET |
+				      LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC));
+	ASSERT_EQ(EBADF, errno);
+
+	/* Tests invalid flag combinations. */
+
+	ASSERT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_QUIET |
+				      LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.48.1

