Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B020330
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159861; cv=none; b=o/llBUJkWNvJ9CV4SVbOoCydbKc2APEKpzj7LN9hq9kOk7Ip2pV1IGj6Q6i7yMQo9YQqEAT5Km454Pg4LP6kpcDv5+3jQKl2Qv3rXCzVrMsdASpXNRH0t5PQccdwUkQ7PpSlKn4hL1UJALIekKHFN2xIzVN3aBTxERivTlXacGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159861; c=relaxed/simple;
	bh=T9V5WHyL8W19lQeEcP9YTbAx/x8UndmLypIBNim9M9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5W2qSa5ZZ1xZ8MU0wvL4JNyd+Uc4vFWXxZf3AGocrFrFBfO+xVJPF7bRUwueIFacPuYKmLpkStxqp5FBX22cMu9HdhNteqDAV7bvlomulbzRKHNto5sN/JkHvmaa9n8zG0RNuJMfuEvCn0s0wxdeW5KCJENE/cDxeYkO3f3ffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqi8eI20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqi8eI20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057E6C4CEE7;
	Thu,  5 Jun 2025 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749159860;
	bh=T9V5WHyL8W19lQeEcP9YTbAx/x8UndmLypIBNim9M9U=;
	h=From:To:Cc:Subject:Date:From;
	b=Dqi8eI200yZ0CxjOKwDJ0FmnncEvcDU7kKYvUoEUtyu8rxVgAOXWebB0Wo9dsZKTn
	 LmaEg0/9lWa9L5fRwYP1SwsvbRXsFnTqhRsV/NDJlCQJyGSJ3eGSRJAD6GhuBA4PCz
	 Lm2WtMnGARpGxpog2xNXCfwut08HS1q3R+PPLo/NZ1Z7qn3zBp8h7uE38rHisHGUIR
	 luJ/wlGLNIjLc/8/xtRIjFNPOWzaKv1FJwwZbrvz80HXlGXnP7tCGhOGG++4iV909H
	 Te+a0IslDfwMPfGqZuz8vLNeQoovtILJeMAu/oIw9V2gKBwSVz71uAKFp7heSpJdw7
	 2lM2YoE8tNo4A==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] selftests/landlock: Fix build of audit_test
Date: Thu,  5 Jun 2025 14:44:16 -0700
Message-ID: <20250605214416.1885878-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are hitting build error on CentOS 9:

audit_test.c:232:40: error: ‘O_CLOEXEC’ undeclared (...)

Fix this by including fcntl.h.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/landlock/audit_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index cfc571afd0eb..46d02d49835a 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -7,6 +7,7 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <linux/landlock.h>
 #include <pthread.h>
-- 
2.47.1

