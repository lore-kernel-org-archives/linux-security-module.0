Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6541DFE33;
	Fri, 22 Nov 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286073; cv=none; b=mDp59V8C+fQxJmPsmmgXiM+WV4Kh0i7SBBQNY7ptELoJf/3i68FLkI4tqd4RNgC7XORZ+JdjeVTibP5CUsKyZ9q98sAM3vNUXeTgYPxrWbo7OoeBFgbJL2vlvz/LGbSZEUA6oEsPOPKLuStpjrZEW11CjDfVN2jw9tQ6r9xtOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286073; c=relaxed/simple;
	bh=bQqucovuqXsfcpnCRY6ioAvHAX0oJC0TChC0D8tZzOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpxRVGc89qNj+H1+SduWBFIs+AteWmdtVOOK/BNZubCCOJi1z97b0ekqJqzMOTc58AXKfjxalh8xt5x4JuxOfIl5SU1SkT6Mq/5gctjUGQZ5lgJcGbLFVzw5whtTbc9VEFoMWiq53rv23K8Sc01kOlt4DkZ13KbG71Mg3cpi3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PX2OshPo; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PX2OshPo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKd4sJ5zcvq;
	Fri, 22 Nov 2024 15:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286069;
	bh=9jecdmy7jrK2+6zmM20QZ0wgXA3NijoGLJiaDMUhMsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PX2OshPoniRIe+tqtSJRTa2QBiSu+SwASCo/3G9G/9AzmOJAa6S6uHDAm/zhDuQot
	 twlxyLum7gbhnZ2UeiPtErbEjdEvfOqdMiCnM6GnLutRYkBg7sgmtq2CD1eNQ5O3Xn
	 rLS5OKXYX90DFUTP1ws9/9sYb0LyYe4jZBYdKOqw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKc6YKKzn2K;
	Fri, 22 Nov 2024 15:34:28 +0100 (CET)
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
Subject: [PATCH v3 21/23] selftests/landlock: Extend tests for landlock_restrict_self()'s flags
Date: Fri, 22 Nov 2024 15:33:51 +0100
Message-ID: <20241122143353.59367-22-mic@digikod.net>
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

Add the restrict_self_flags test suite to check that
LANDLOCK_RESTRICT_SELF_LOGLESS is valid but not the next bit.  Some
checks are similar to restrict_self_checks_ordering's ones.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-22-mic@digikod.net
---

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/base_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index fbd687691b3c..4e0104f1efa0 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -233,6 +233,22 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_flags)
+{
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_LOGLESS));
+	ASSERT_EQ(EBADF, errno);
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 1U << 1));
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
2.47.0

