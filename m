Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644615B54C
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459815; cv=none; b=L0vHht8ICh3RM4kpxxCmwQt8xzeWySYqFzPuAFaoEIelYbZ+AjWTvTTE6Ur02uWHUHyX+V0y3sYEmVRDzAYFlORSN6ofgwDQyGUy6Fbs4S6GdWMHUYXUJK0qmSzHH+2c/yVkrFBfRkE1JG0nkXQmc6CmpqwbOlK21Fiz7RwDjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459815; c=relaxed/simple;
	bh=KYgdmaFLVxr4Nl1672jOHSH4mVTZf+6+AlybgZlnzJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqSehGK5e4tfhA5DphPRM1Zr/r3adgaRFA9S/luUS/pj8VpeVvChZEh6/FcNy+hklwPpsSiQQESbgmdOCZHk/t2m4IvnpTC++8+wDKWyEkJzIESEKUXN6iwcF0qdkTrImtwpuj9ygcjBxEigNJJfX4iX3h6oPAs3Obu8kGWmyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aUqX/Ixj; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aUqX/Ixj"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsS6JV8zNrt;
	Sat,  8 Mar 2025 19:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459484;
	bh=w+iB3Ja2zMoCMbnIyQGhhP5gE1y+T8FmeGt8Bxld6jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUqX/IxjbdUnsw8qS1fKlpM/OtrETjXdizkvKVl+kitbzI47tWrBVIPhLeN158XT9
	 3GAA5KzThdNlwdIWVdCTlARtHPeJXQTIHWmRtKP8pwvQSssM4CcRa3JwBD4WLAJKDa
	 bA+64M0VIg8sFESmERAQv5hXCKQ+LjdW2YZn9QY0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsS11vTzsl6;
	Sat,  8 Mar 2025 19:44:44 +0100 (CET)
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
Subject: [PATCH v6 08/26] landlock: Identify domain execution crossing
Date: Sat,  8 Mar 2025 19:44:04 +0100
Message-ID: <20250308184422.2159360-9-mic@digikod.net>
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

Extend struct landlock_cred_security with a domain_exec bitmask to
identify which Landlock domain were created by the current task's bprm.
This is reset on each execve(2) call.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-9-mic@digikod.net
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
index fdbbaf66d151..cf38caf77adc 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -9,17 +9,47 @@
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

