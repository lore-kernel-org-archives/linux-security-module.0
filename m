Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78432040BE
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351063; cv=none; b=mv+Lu1dSLImEL0sMReJDr56fLoq0nu1SZqKfCjbXgx8xQsOR1S5crmP+KM40WDGCNyNjrmAL/w3pobKtksa1GkBre+qZN3pLUBYdFvxaG96jDaQVjTCbpgBF+GMc/m7aa/foITjI5VdcN+4iqJ0EnQPHgw/Bgap2QtInspxnfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351063; c=relaxed/simple;
	bh=ys0gfj0ZPhIrZ71rVw4Hj9YHndpMNBXQDbmI490dfc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY21x9HaBz26YGRlbA7YZVcXYHt7kwKqGwQkLRE2WzOpFcGID/BCixIfI9Z3isCBvkqY1V3QijW5i/+mrXZhWTVHk47mjLkrEkPjk4RFVpzHSBc0iGBpW2wcvLisByjTJKzypF97Tz+RUGjsrIEPh3w9ojVZTuEcFr41L4hxEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lMTL62Mr; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lMTL62Mr"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfV1Yt2zsKj;
	Wed,  8 Jan 2025 16:44:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351058;
	bh=ONxcSYqi3rxpAxp9apstv0/k6UVxQZhru1STqtTkwEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMTL62MryvWLepFqJJwgv3K7/MG/Xy8fxEzI/J/K14y9NIyKxUnnxaQkGo2ft00oO
	 eaWinTcw6lRUDG8XZudVeYLuJoZzaOswShJaO8zPqhxJT/qxJlfGVv/KcagLk3oHdg
	 B+BD+odm/MO1uXbt2KydVWBTi/3kMPXlbGQtxdcY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfT2msmz4Kh;
	Wed,  8 Jan 2025 16:44:17 +0100 (CET)
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
Subject: [PATCH v4 21/30] selftests/landlock: Add wrappers.h
Date: Wed,  8 Jan 2025 16:43:29 +0100
Message-ID: <20250108154338.1129069-22-mic@digikod.net>
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

Extract syscall wrappers to make them usable by standalone binaries (see
next commit).

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-22-mic@digikod.net
---

Changes since v3:
- New patch.
---
 tools/testing/selftests/landlock/common.h   | 37 +---------------
 tools/testing/selftests/landlock/wrappers.h | 47 +++++++++++++++++++++
 2 files changed, 48 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/wrappers.h

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 61056fa074bb..8391ab574f64 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -9,17 +9,15 @@
 
 #include <arpa/inet.h>
 #include <errno.h>
-#include <linux/landlock.h>
 #include <linux/securebits.h>
 #include <sys/capability.h>
 #include <sys/socket.h>
-#include <sys/syscall.h>
-#include <sys/types.h>
 #include <sys/un.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "wrappers.h"
 
 #define TMP_DIR "tmp"
 
@@ -30,34 +28,6 @@
 /* TEST_F_FORK() should not be used for new tests. */
 #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
-#ifndef landlock_create_ruleset
-static inline int
-landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
-			const size_t size, const __u32 flags)
-{
-	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
-}
-#endif
-
-#ifndef landlock_add_rule
-static inline int landlock_add_rule(const int ruleset_fd,
-				    const enum landlock_rule_type rule_type,
-				    const void *const rule_attr,
-				    const __u32 flags)
-{
-	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
-		       flags);
-}
-#endif
-
-#ifndef landlock_restrict_self
-static inline int landlock_restrict_self(const int ruleset_fd,
-					 const __u32 flags)
-{
-	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
-}
-#endif
-
 static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 {
 	cap_t cap_p;
@@ -250,11 +220,6 @@ struct service_fixture {
 	};
 };
 
-static pid_t __maybe_unused sys_gettid(void)
-{
-	return syscall(__NR_gettid);
-}
-
 static void __maybe_unused set_unix_address(struct service_fixture *const srv,
 					    const unsigned short index)
 {
diff --git a/tools/testing/selftests/landlock/wrappers.h b/tools/testing/selftests/landlock/wrappers.h
new file mode 100644
index 000000000000..32963a44876b
--- /dev/null
+++ b/tools/testing/selftests/landlock/wrappers.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock helpers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ * Copyright © 2021-2024 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#include <linux/landlock.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#ifndef landlock_create_ruleset
+static inline int
+landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
+			const size_t size, const __u32 flags)
+{
+	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
+}
+#endif
+
+#ifndef landlock_add_rule
+static inline int landlock_add_rule(const int ruleset_fd,
+				    const enum landlock_rule_type rule_type,
+				    const void *const rule_attr,
+				    const __u32 flags)
+{
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
+		       flags);
+}
+#endif
+
+#ifndef landlock_restrict_self
+static inline int landlock_restrict_self(const int ruleset_fd,
+					 const __u32 flags)
+{
+	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
+}
+#endif
+
+static inline pid_t sys_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
-- 
2.47.1

