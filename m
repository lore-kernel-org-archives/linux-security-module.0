Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4101FE477
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351076; cv=none; b=dD2ybIvkixburJUxIGAfzsFnJ1GPw2Mn/Loi4G0+qUJu5Rq55EouybYb2xEw3zc/CSPm7qIFXl/1+59bGOy+i2xzwopUpqicdy3mlGmxtAYcIwm7Rb1mOa717AQmIfAIR1OxcpKhwlySlll3slvOnfJhASVZrZdxBAwJfHXuatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351076; c=relaxed/simple;
	bh=r5WlgHY5ekmzAaYDQq4vreiTxEwpar8BE5d+CF5hpSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z95WgobeAeMbHh0Y1z9ZKzLhJ1C+nWCKABEyaw8cyL/UIpN97Yd7akT+qHnnM/BNaplfPxdJnAaNnyq4LAQ4l72WZAmaRgOUJEr9Jlc2Y/htyjVGgFgpLvjL2HRJT+8TirXYM0xsvwGuFQ2heJwttVK6UasGomXhULLF1clLhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IEl8243x; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IEl8243x"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfm4SSBzCbs;
	Wed,  8 Jan 2025 16:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351072;
	bh=L8IBiXUuwC1//+udMff7eh2pXQ6UeLqKYGPADF3RxT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEl8243x6fZmwoZSWNsdBZuf6HXEjefSGABSrAkfHnQAq5cQzG8C8TbV9FmYdJq1f
	 ByUgb0fcvzVp7blT0iNH0ZjsVOS+7RHPytcPKGiU8+U61l7ShNZGPtxQBM3ax4PZhA
	 3NXymRzDIzlBx4sSnaTQg0dBsOM0TQiUV3a0jEco=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfl4G3tzKQl;
	Wed,  8 Jan 2025 16:44:31 +0100 (CET)
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
Subject: [PATCH v4 30/30] selftests/landlock: Test compatibility with audit rule lists
Date: Wed,  8 Jan 2025 16:43:38 +0100
Message-ID: <20250108154338.1129069-31-mic@digikod.net>
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

Add compatibility.lists tests to make sure AUDIT_EXE_LANDLOCK_DENY is
only allowed for AUDIT_FILTER_EXCLUDE, AUDIT_FILTER_EXIT, and
AUDIT_FILTER_URING_EXIT.

Test coverage for security/landlock is 93.5% of 1635 lines according to
gcc/gcov-14.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-31-mic@digikod.net
---

Changes since v3:
- New patch.
---
 tools/testing/selftests/landlock/audit_test.c | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 921f316ddbf8..d9f227680641 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -308,4 +308,82 @@ TEST_F(audit_rule, exe_landlock_deny)
 	ASSERT_EQ(0, WEXITSTATUS(status));
 }
 
+FIXTURE(compatibility)
+{
+	struct audit_filter filter_self;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(compatibility)
+{
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->filter_self);
+	EXPECT_LE(0, self->audit_fd)
+	{
+		const char *error_msg;
+
+		/* kill "$(auditctl -s | sed -ne 's/^pid \([0-9]\+\)$/\1/p')" */
+		if (self->audit_fd == -EEXIST)
+			error_msg = "socket already in use (e.g. auditd)";
+		else
+			error_msg = strerror(-self->audit_fd);
+		TH_LOG("Failed to initialize audit: %s", error_msg);
+	}
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN(compatibility)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->filter_self));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+TEST_F(compatibility, lists)
+{
+	struct audit_filter filter_test;
+	size_t num_ok = 0;
+	__u32 list;
+
+	EXPECT_EQ(0, audit_init_filter_exe(AUDIT_EXE_LANDLOCK_DENY,
+					   &filter_test, NULL));
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	for (list = 0; list < AUDIT_NR_FILTERS; list++) {
+		int err;
+
+		switch (list) {
+		case AUDIT_FILTER_EXIT:
+		case AUDIT_FILTER_EXCLUDE:
+		case AUDIT_FILTER_URING_EXIT:
+			num_ok++;
+			err = 0;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Testing AUDIT_FILTER_ENTRY prints "auditfilter:
+		 * AUDIT_FILTER_ENTRY is deprecated" in kernel logs.
+		 */
+		EXPECT_EQ(err, audit_filter_exe(self->audit_fd, &filter_test,
+						AUDIT_ADD_RULE, list))
+		{
+			TH_LOG("Unexpected result for list %u", list);
+		}
+		EXPECT_EQ(err, audit_filter_exe(self->audit_fd, &filter_test,
+						AUDIT_DEL_RULE, list))
+		{
+			TH_LOG("Unexpected result for list %u", list);
+		}
+	}
+
+	/* Makes sure the three accepted lists are checked. */
+	EXPECT_EQ(3, num_ok);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.1

