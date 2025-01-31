Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFE1F0E56
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341091; cv=none; b=agehIkysjKsZtTJEZqQMaw3liqFXhFnZz13sM4IalWNp/3Vo1FFZpdQvNSnaDgRBG4YoIoHGGB+0+xHlfqYnuvkn9tPv7PJLpkijw8x6QrEBPsPyHf5PVcgUl9s44cZfVJRrcrDBACgYQNmJl41esTU+gcRY9Sa9HXbwGAKV//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341091; c=relaxed/simple;
	bh=OBOX7bwNED33r3zI/kL0r2VVNnqh/FiG5/8UNTSNigg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJWJiZIWJIN/aMdQP6JirpKeDiisIe5+YVpcEjEbxPCEB6wjRdfejSB4Jrk6lu/v2dVUPeA1lIS4k50o+Pebn6YDtF3+BBW9hbFSqqZVOi/vPqwsZl4Lq1/iip0dO9iDngWVHy8pRdS7TL21WYewgqS9iFlxZosLYwkWvuZv9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=W4DA137X; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="W4DA137X"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cG693KzVyH;
	Fri, 31 Jan 2025 17:31:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341086;
	bh=kZlB2Ny34Xj+TMoR7jNhDX0plnRS+4IxsxEaHY2C1+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4DA137XzSX4mq8EICI2Pe5hs2XqJVHtt65rZFb710GcwNugceJGaXI2NfaQXSsXD
	 +m9BIzGQj0ZhtH9qGd8g07/7BoH5Fq3cCs8LAZGQXxonkceHWvA0uUUrlr/gLrbqMw
	 nkqPoiyG7cxvIthXUa2yX41IPTP1JiauQz8ICpcI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cG0dh2zdcw;
	Fri, 31 Jan 2025 17:31:26 +0100 (CET)
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
Subject: [PATCH v5 08/24] landlock: Identify domain execution crossing
Date: Fri, 31 Jan 2025 17:30:43 +0100
Message-ID: <20250131163059.1139617-9-mic@digikod.net>
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

Extend struct landlock_cred_security with a domain_exec bitmask
identifying if the current task created its domain.  This is reset on
cross-execution.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-9-mic@digikod.net
---

Changes since v4:
- New patch.
---
 security/landlock/cred.c     | 26 ++++++++++++++++++++++----
 security/landlock/cred.h     | 15 +++++++++++++++
 security/landlock/syscalls.c |  5 +++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index db9fe7d906ba..a22756fe3b71 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -4,8 +4,10 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2025 Microsoft Corporation
  */
 
+#include <linux/binfmts.h>
 #include <linux/cred.h>
 #include <linux/lsm_hooks.h>
 
@@ -17,11 +19,12 @@
 static void hook_cred_transfer(struct cred *const new,
 			       const struct cred *const old)
 {
-	struct landlock_ruleset *const old_dom = landlock_cred(old)->domain;
+	const struct landlock_cred_security *const old_llcred =
+		landlock_cred(old);
 
-	if (old_dom) {
-		landlock_get_ruleset(old_dom);
-		landlock_cred(new)->domain = old_dom;
+	if (old_llcred->domain) {
+		landlock_get_ruleset(old_llcred->domain);
+		*landlock_cred(new) = *old_llcred;
 	}
 }
 
@@ -40,10 +43,25 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_ruleset_deferred(dom);
 }
 
+#ifdef CONFIG_AUDIT
+
+static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
+{
+	/* Resets for each execution. */
+	landlock_cred(bprm->cred)->domain_exec = 0;
+	return 0;
+}
+
+#endif /* CONFIG_AUDIT */
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
+
+#ifdef CONFIG_AUDIT
+	LSM_HOOK_INIT(bprm_creds_for_exec, hook_bprm_creds_for_exec),
+#endif /* CONFIG_AUDIT */
 };
 
 __init void landlock_add_cred_hooks(void)
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index fdbbaf66d151..47cdf0fa1a4e 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -9,18 +9,33 @@
 #ifndef _SECURITY_LANDLOCK_CRED_H
 #define _SECURITY_LANDLOCK_CRED_H
 
+#include <linux/container_of.h>
 #include <linux/cred.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
 #include "access.h"
+#include "limits.h"
 #include "ruleset.h"
 #include "setup.h"
 
 struct landlock_cred_security {
 	struct landlock_ruleset *domain;
+
+#ifdef CONFIG_AUDIT
+	u16 domain_exec;
+#endif /* CONFIG_AUDIT */
 };
 
+#ifdef CONFIG_AUDIT
+
+/* Makes sure all layer executions can be stored. */
+static_assert(BITS_PER_TYPE(typeof_member(struct landlock_cred_security,
+					  domain_exec)) >=
+	      LANDLOCK_MAX_NUM_LAYERS);
+
+#endif /* CONFIG_AUDIT */
+
 static inline struct landlock_cred_security *
 landlock_cred(const struct cred *cred)
 {
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a9760d252fc2..5129981fec8b 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -496,5 +496,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
+
+#ifdef CONFIG_AUDIT
+	new_llcred->domain_exec |= 1 << (new_dom->num_layers - 1);
+#endif /* CONFIG_AUDIT */
+
 	return commit_creds(new_cred);
 }
-- 
2.48.1

