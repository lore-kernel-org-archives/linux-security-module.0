Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFD2036F0
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351060; cv=none; b=MG3gDHTFq3R8v2HMyU/i8lDk/xu1L2RLl0rapuPJDIoB2G8dEcXuvyEXUOeYe2TrFt/nClQ4B1ewUyKw6f8lvAgFf25kqDnlq+7c1BYkp85mFedPVRPbtvGLdUrRBFrZndGGKJ55vJL5mcyDant6uAYTAUGUbJiareh552vX+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351060; c=relaxed/simple;
	bh=y/wtqJxZmkGaNNbxtbWPEhGfGtFUdjlHTa/P+YkzL4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHOeOl5i2HeEI5NaxD/EDbF7JtqBFfbG6TimeViAtgTkl2vCkAsK3lKaTnpkE+v+CKOc9mPX7lKiY9RszFbvrdLPJxyCgJdOWrTW/urrZ4xvsiLM4/cycmfOs742t18XWMPwGLwPuWycaXnFOgFL+F4jdZJ0yjjHAOP66iI773k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XaQBz8Xn; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XaQBz8Xn"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfS4s6pz7Bw;
	Wed,  8 Jan 2025 16:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351056;
	bh=mk13RvEuPQJ/sgasE14gboAmV4076jIAJAJ4kAt2QAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaQBz8XnskIBQ6GYys95KRNToEY4Oe2nQDcNQSTetTkHWkhMRiaRGnaF+9ohJmEIq
	 abudOrENn3fYyR8VJqNbW1L0hUljXGovj1wCXAyIhCogA78wiskmewKFyRhf5QQVZm
	 lg7g5IYtzJSW8jrRD677CFB1ObGfDSRDi/bbVH1g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfR5Fl8zsJG;
	Wed,  8 Jan 2025 16:44:15 +0100 (CET)
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
Subject: [PATCH v4 20/30] selftests/landlock: Fix error message
Date: Wed,  8 Jan 2025 16:43:28 +0100
Message-ID: <20250108154338.1129069-21-mic@digikod.net>
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

The global variable errno may not be set in test_execute().  Do not use
it in related error message.

Cc: Günther Noack <gnoack@google.com>
Fixes: e1199815b47b ("selftests/landlock: Add user space tests")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-21-mic@digikod.net
---

Changes since v3:
- New patch.
---
 tools/testing/selftests/landlock/fs_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 42ce1e79ba82..a359c0d3107f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2011,8 +2011,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	ASSERT_EQ(1, WIFEXITED(status));
 	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
 	{
-		TH_LOG("Unexpected return code for \"%s\": %s", path,
-		       strerror(errno));
+		TH_LOG("Unexpected return code for \"%s\"", path);
 	};
 }
 
-- 
2.47.1

