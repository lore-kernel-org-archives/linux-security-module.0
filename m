Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD432227EB1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497661; cv=none; b=cvFi3OwbZwmH3oPpy21dgpo6b5X2+QR858pwHIJ3Ymhd7Qni2hMqxzCGyUw8h4O0KyNAx27dCv8ZqCmQMdQPv9ycbozU1FtQobkTOXisH7tILBudgfCPOTPnT5OQeWWV1UVuZcZMhtnawFecs3/m6i+yTN58P3xPsyexfbZKzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497661; c=relaxed/simple;
	bh=TS7HZ1tKjXQnVztsV6C3ej4LWIVlk+jcfBJsAi/DHNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmp5nG+RHkZcE7GyqsSM7acA5EEw3SlMrKVqugqU9TeLgGkKJCvAgXJS/2pPKSPVEixStHmhRLD+PeY50769iRXksPQoIctZAiZDyrp8iPrUsxuznTGBcBmSuYqmxhCpWHF+XTfs8cA2HGKEl3ufdsiCnjjCe7d5qEchm85o2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UGaKNES8; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UGaKNES8"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpJ6gqNznK;
	Thu, 20 Mar 2025 20:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497656;
	bh=Iln42cUtkMn9/d1YlfuMQNlo3p0jfKXK7NGjwJaBbRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGaKNES8SylO8RlSkJ12HpR/gWSiAHZBzLgEGTvBLBrQCmSh8Mu/s/5E6hdmvz5MA
	 h1w/65fflI1P6ArcUU/hFKB1cYyY42mwU5AblTckejO6RT1HGxDtF7zWzIKUU3+geh
	 cIJxjFzHe/YgnYtMqY3hb1r20ix5d8sDRJBD6PTA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpJ1F4WzCsL;
	Thu, 20 Mar 2025 20:07:36 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 08/28] landlock: Identify domain execution crossing
Date: Thu, 20 Mar 2025 20:06:57 +0100
Message-ID: <20250320190717.2287696-9-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend struct landlock_cred_security with a domain_exec bitmask to
identify which Landlock domain were created by the current task's bprm.
The whole bitmask is reset on each execve(2) call.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
- Add documentation and pack struct landlock_cred_security to minimize
  struct landlock_file_security.

Changes since v4:
- New patch.
---
 security/landlock/cred.c     | 26 ++++++++++++++++++++++----
 security/landlock/cred.h     | 32 +++++++++++++++++++++++++++++++-
 security/landlock/syscalls.c |  5 +++++
 3 files changed, 58 insertions(+), 5 deletions(-)

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
index eb691130dd67..3bf18551d7b8 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -10,17 +10,47 @@
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
 
+/**
+ * struct landlock_cred_security - Credential security blob
+ *
+ * This structure is packed to minimize the size of struct
+ * landlock_file_security.  However, it is always aligned in the LSM cred blob,
+ * see lsm_set_blob_size().
+ */
 struct landlock_cred_security {
+	/**
+	 * @domain: Immutable ruleset enforced on a task.
+	 */
 	struct landlock_ruleset *domain;
-};
+
+#ifdef CONFIG_AUDIT
+	/**
+	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
+	 * the current task's executed file (i.e. no new execve(2) since
+	 * landlock_restrict_self(2)).
+	 */
+	u16 domain_exec;
+#endif /* CONFIG_AUDIT */
+} __packed;
+
+#ifdef CONFIG_AUDIT
+
+/* Makes sure all layer executions can be stored. */
+static_assert(BITS_PER_TYPE(typeof_member(struct landlock_cred_security,
+					  domain_exec)) >=
+	      LANDLOCK_MAX_NUM_LAYERS);
+
+#endif /* CONFIG_AUDIT */
 
 static inline struct landlock_cred_security *
 landlock_cred(const struct cred *cred)
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index cf9e0483e542..b7b268f43a3b 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -510,5 +510,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
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
2.49.0

