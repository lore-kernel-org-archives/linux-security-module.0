Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EA20468A;
	Wed,  8 Jan 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351064; cv=none; b=dNhDQencfIx+Npuxe2MHNyFA/kmI1HGro8XWmq+ganUBgkiiv3H/tTerQ38/abP7LOgDBa09spgAJASeyGRFu/ySbFvQkcBuQbEcjM//IjrJ09GdnLHl1YTK0QsrNYmBp4aQ3gr0smZ1rZ559ZSTvevKThvE2dBq+vihq5cZPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351064; c=relaxed/simple;
	bh=IboU/Wm9SZHUTyx08YQifUSsKwvzN4FxDa3AKSp11oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syfXJa4QRKx8hGp/HRkqjukm80mAJ2dX+D9nz+wiMr7n4yhezN4uCsGH5lErFvoMzKtOytdk8N53hPgVOGtLwE1yRfgeWGGO6XQiObajV7dSa27wzLpVhvBHrsbjuIs5eq7hk8/z7mrNTvXVDdwT96sLkJdrWKo/h4b+cr7qYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vtxmQ40i; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vtxmQ40i"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfX74l7zth3;
	Wed,  8 Jan 2025 16:44:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351060;
	bh=dwOmXNqU5p6Noat4m8y+zwep0NNuioOqubwUKCTUcV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vtxmQ40ijxDf7pYSN5CcFWEHm0f7+9wAmw45J984HaDShYTJJ2VEweGEiCUmOFCFu
	 RQDfdMUH37LBfNKv4itELweLPqCpSteryUEPLcFDnObLXBlYdHDEAqrG2ywIEV71IK
	 IbkjAWRiAjGwN/bq0gLQNjM9hBH7MizV/Q/cHxqg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfX1pnmzGqD;
	Wed,  8 Jan 2025 16:44:20 +0100 (CET)
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
Subject: [PATCH v4 23/30] selftests/landlock: Extend tests for landlock_restrict_self()'s flags
Date: Wed,  8 Jan 2025 16:43:31 +0100
Message-ID: <20250108154338.1129069-24-mic@digikod.net>
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

Add the restrict_self_flags test suite to check that
LANDLOCK_RESTRICT_SELF_QUIET is valid but not the next bit.  Some checks
are similar to restrict_self_checks_ordering's ones.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-24-mic@digikod.net
---

Changes since v3:
- Use a last_flag variable.

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/base_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index fbd687691b3c..1a1603ff178b 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -233,6 +233,23 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_flags)
+{
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_QUIET;
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_QUIET));
+	ASSERT_EQ(EBADF, errno);
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
2.47.1

