Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410A139579
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952866; cv=none; b=cM4YKbUP99Ao0B/fBNhPbQRErcUPmJoabn/KeOi8dgy+6h1WBI24MSshfKmH9f/Ul8ixLWjyS/CLm8EWfb262TNKVzY/KuSOv7CVGAKwiYxsolGEJy2Gc7DdyAX2KVJID5/GxqT7feyLikid3WbX/PgNpBKK2vvzSO7tTvbqOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952866; c=relaxed/simple;
	bh=SL5MVsK1XmCnLH1EcD2ZksK86SXEJOhX56LincCzx6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jzTM6aXDMya3PC0J/RMXoIbg/u7iMQGSzdXZXEOBFEiOpkaU5HHfoAO+jA8klLtBQ2RLJtYtT04poi3SXGADdwSu+lhxawxNb+LwMhS2Op56QK0bx0FyegNVrOXXjxXLX18swG2UTH8BaAa0f+6VF5LTt+OfNp2anM+LmxGxy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EcwzGoE6; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EcwzGoE6"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YY8CW6690zX2V;
	Wed, 15 Jan 2025 15:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736952855;
	bh=k8Fi1MaMn/YCYoXT2YTlhmpK9IYqOUl7lGoOnB560gU=;
	h=From:To:Cc:Subject:Date:From;
	b=EcwzGoE66LsdBaWwYUEYS5DWWjpu/Nt0TuC/Lp6jPFUkAGpLyoLYlxjWAl4tf88EF
	 ShnZr7KtLHJxJx2UrByLppaZ+CQ7aHwTn2/3ha+oaoJ5VSz2CckOYvWBo4HSkiXNr2
	 f1uepa3nA/TQifFdJ+DNJRurh4irQhxCt674fI/4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YY8CW2WrszjHh;
	Wed, 15 Jan 2025 15:54:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v1] selftests/landlock: Fix build with non-default pthread linking
Date: Wed, 15 Jan 2025 15:54:07 +0100
Message-ID: <20250115145409.312226-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Old toolchains require explicit -lpthread (e.g. on Debian 11).

Cc: Günther Noack <gnoack@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 348e2dbdb4e0..480f13e77fcc 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true
 
 # Short targets:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
 
 include ../lib.mk
 
 # Targets with $(OUTPUT)/ prefix:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
-- 
2.48.1

