Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6652163AF;
	Sat,  8 Mar 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459505; cv=none; b=D7Fk1A/Yx1ioZ+8anX8RR7+jYSQ7ymBEDHpASBgAeIUe2kZjnZRZ7xF1PrUBpEC2jnOe09RNmjuM2sa24dME0FFD1+zg37eYq3ZnJz0+bZBL55ZxbycGccn6LhGmi4PmlLj642T/bHu8HHBP6suBcoQRT0rEBUqsGSZDpV7TKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459505; c=relaxed/simple;
	bh=+mEtiRH9mg2PBl1dWGMUlkUQPx/inb4Y4ygUZfCMhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i97jE84Y6BUC1XVY2CoDzD9vLazUw/2c+nnbrv4jFK9jzdS9qT/+1jzPLj9aKD29YzI8RAe0nmEAF5qG9o62Q1hK9PdW/vaqG3owheAfsKpnX/h0Mke8odCYDWXDwW8rJyzwHnKd3PXyPQ5lYfzM8NZRUarfy0HJAW0SBSTwqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FKW0l1ej; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FKW0l1ej"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsn6jSbzRWl;
	Sat,  8 Mar 2025 19:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459501;
	bh=eX6a/Otpuw4To8WlM9lxQqOqmo1WzQUlapzGb7manJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKW0l1ejWpVNelD5NPCKfyjChf9JgbkWqsOr/Yb4Lbl77RO5xN4UUJzsBgSa9hTCT
	 q63HDz8llx0MgIZLsTkylPO0yjymGEP0DdStov+Q1Eabwmw6Lff5FjFN6bSwwyd2jG
	 p9XtrjTr7OxR54dXwxH8T2aRSMxGViNsCok7g2gU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsn0lNwzHQJ;
	Sat,  8 Mar 2025 19:45:01 +0100 (CET)
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
Subject: [PATCH v6 19/26] selftests/landlock: Add test for invalid ruleset file descriptor
Date: Sat,  8 Mar 2025 19:44:15 +0100
Message-ID: <20250308184422.2159360-20-mic@digikod.net>
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

To align with fs_test's layout1.inval and layout0.proc_nsfs which test
EBADFD for landlock_add_rule(2), create a new base_test's
restrict_self_fd which test EBADFD for landlock_restrict_self(2).

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-20-mic@digikod.net
---

Changes since v5:
- New standalone patch (that can be backported).
---
 tools/testing/selftests/landlock/base_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index fbd687691b3c..9059045ae8b6 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -233,6 +233,17 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_fd)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.48.1

