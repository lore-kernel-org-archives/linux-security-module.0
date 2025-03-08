Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F8202F9A
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459507; cv=none; b=MIUBSGoqyLmYIRhKeWjzZG/7F/NZAEZPFJCic73E9sPYC3m4YmsDLktvdHj0Bj8HMFxoGuYPqgVic4bAKnWq7vuH1eSMGqWykyABQ6QrQOJMNCggZye1QkWSJQkvajZyZETpv8K+zJAhvCYjsGqAweB5l1AHnlpKAiUZ21xAmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459507; c=relaxed/simple;
	bh=d1ahUO9jDK5pg7d/9PAjmipszcgEPlus3+ZqkBxJNkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZB2/VKPXD+IXwp8tSEz+GtTdJxMuR3Tp/FpOEEij6ZERXp4+PsoqglMcAA3Pl+B8DbM0vMtc3b3ulAgXCBZ45C/74kIgTwvx0l+DcgapsO36yWo9FqlW1NjtxO0hGrIUqj1eNpWDcYX3ZpN+9YrcF6TnAldmAXkenL7Kv6pXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Faw3SRV2; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Faw3SRV2"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsq2VkczLMc;
	Sat,  8 Mar 2025 19:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459503;
	bh=9AetjI08iDywqjQ4EG14lhpkZUde1COiJ/To5plRgo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Faw3SRV2wWKnSnl+Mhykh6nMk946Tk+q9WV+WHXmYxHyCJ0wmPzlIuQsDm+PJct0P
	 W5li2iobh8e7l8VAQx+lG56/JS5e32K6RiIUzcdv5TGg9If4TlFT3QBo5XVp9u5qVI
	 SNg79LDFyybYDIpL1BBH7D+2TFU7vQnNv2OEutEg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsp3rTqzJyQ;
	Sat,  8 Mar 2025 19:45:02 +0100 (CET)
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
Subject: [PATCH v6 20/26] selftests/landlock: Extend tests for landlock_restrict_self(2)'s flags
Date: Sat,  8 Mar 2025 19:44:16 +0100
Message-ID: <20250308184422.2159360-21-mic@digikod.net>
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

Add the base_test's restrict_self_fd_flags tests to align with previous
restrict_self_fd tests but with the new
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF flag.

Add the restrict_self_flags tests to check that
LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, and
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF are valid but not the next
bit.  Some checks are similar to restrict_self_checks_ordering's ones.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-21-mic@digikod.net
---

Changes since v5:
- Rename restrict flags.
- Update LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF test to pass with -1
  as ruleset FD, and flag ordering.
- Add restrict_self_fd_flags tests.

Changes since v4:
- Update with LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS, and
  LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC.

Changes since v3:
- Use a last_flag variable.

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/base_test.c | 71 ++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 9059045ae8b6..ab00afe1fc25 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -244,6 +244,77 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
 
+TEST(restrict_self_fd_flags)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF accepts -1 but not any file
+	 * descriptor.
+	 */
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST(restrict_self_flags)
+{
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF;
+
+	/* Tests invalid flag combinations. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
+	EXPECT_EQ(EINVAL, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, -1));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Tests valid flag combinations. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, 0));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1,
+			  LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1,
+			  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
+	EXPECT_EQ(EBADF, errno);
+
+	/* Tests with an invalid ruleset_fd. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -2, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(0, landlock_restrict_self(
+			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.48.1

