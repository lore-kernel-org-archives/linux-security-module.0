Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD22116F6
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459493; cv=none; b=B+aajYXckIAPxsxkgu0wR+noTaKDQezQ/8xjNwXJXuEztybuh2x7/ac2Ll//W7Q23zrEfvq5OavpazZDEYEbsg/qZycdJwn6AI0aQv2Wm7AF71x2p5V77xit4AdC/NBRxCh2GK6BdS+FdFz+2A9uoCFq7nRB6myAnmVLkPB9fLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459493; c=relaxed/simple;
	bh=teYppnQilIsd+YguFxHHDZ7fudTUmR5JFh8koioF+Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmUqRhsjypl56D1+TXrWd5xLqwadbgZLORyKZf2us0qNW8Lt69lzzGGqtgh/YXnN8skjsf02bvqWppE9Deped6dFAxdR6lfqkpAjxZ5u3oywSa1+J4PlLktXswhilvV2YWOn1Ve5+LYMZRA4CTrUoq/nfKhwLR3pcmwMP5FI7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=W2elPVWU; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="W2elPVWU"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsR3XywzRxY;
	Sat,  8 Mar 2025 19:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459483;
	bh=SBOoMihG9Qi1HSfwunqx1u8g1OCHU2vV2AsORwv30PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2elPVWU/RH563idNt1A6X7lYeaViAOxMecM00vpIssQzd8pVorhXlKMpmmzRmQzO
	 kadlQsawyhhyQII5+6dIEIchhXvUTuzRBecsfDdABtHIzHOMJbaOPATaqTJ7TypgMX
	 IRKkAKACY9WmoW+wvX5QyJqTKVvtVY8UpBwIJfWM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsQ5WWxzqjc;
	Sat,  8 Mar 2025 19:44:42 +0100 (CET)
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
Subject: [PATCH v6 07/26] landlock: Prepare to use credential instead of domain for fowner
Date: Sat,  8 Mar 2025 19:44:03 +0100
Message-ID: <20250308184422.2159360-8-mic@digikod.net>
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

This cosmetic change that is needed for audit support, specifically to
be able to filter according to cross-execution boundaries.

struct landlock_file_security's size stay the same for now but it will
increase with struct landlock_cred_security's size.

Only save Landlock domain in hook_file_set_fowner() if the current
domain has LANDLOCK_SCOPE_SIGNAL, which was previously done for each
hook_file_send_sigiotask() calls.  This should improve a bit
performances.

Replace hardcoded LANDLOCK_SCOPE_SIGNAL with the signal_scope.scope
variable.

Use scoped guards for RCU read-side critical sections.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-8-mic@digikod.net
---

Changes since v5:
- Only call landlock_get_ruleset() when needed in
  hook_file_set_fowner().

Changes since v4:
- New patch.
---
 security/landlock/fs.c   | 26 ++++++++++++++++++++------
 security/landlock/fs.h   | 12 +++++++-----
 security/landlock/task.c | 25 ++++++++++++++++---------
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d5b153d29fcb..7dbfc6420e1b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1641,17 +1641,31 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *new_dom, *prev_dom;
+	static const struct access_masks signal_scope = {
+		.scope = LANDLOCK_SCOPE_SIGNAL,
+	};
+	const struct landlock_cred_security *new_subject;
+	struct landlock_cred_security *fown_subject;
+	struct landlock_ruleset *prev_dom;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
 	 * file_set_fowner LSM hook inconsistencies").
 	 */
 	lockdep_assert_held(&file_f_owner(file)->lock);
-	new_dom = landlock_get_current_domain();
-	landlock_get_ruleset(new_dom);
-	prev_dom = landlock_file(file)->fown_domain;
-	landlock_file(file)->fown_domain = new_dom;
+
+	fown_subject = &landlock_file(file)->fown_subject;
+	prev_dom = fown_subject->domain;
+	new_subject = landlock_get_applicable_subject(current_cred(),
+						      signal_scope, NULL);
+	if (new_subject) {
+		landlock_get_ruleset(new_subject->domain);
+		*fown_subject = *new_subject;
+	} else {
+		static const struct landlock_cred_security empty = {};
+
+		*fown_subject = empty;
+	}
 
 	/* Called in an RCU read-side critical section. */
 	landlock_put_ruleset_deferred(prev_dom);
@@ -1659,7 +1673,7 @@ static void hook_file_set_fowner(struct file *file)
 
 static void hook_file_free_security(struct file *file)
 {
-	landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
+	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index d445f411c26a..1449a90e92c7 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 
 #include "access.h"
+#include "cred.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -54,12 +55,13 @@ struct landlock_file_security {
 	 */
 	access_mask_t allowed_access;
 	/**
-	 * @fown_domain: Domain of the task that set the PID that may receive a
-	 * signal e.g., SIGURG when writing MSG_OOB to the related socket.
-	 * This pointer is protected by the related file->f_owner->lock, as for
-	 * fown_struct's members: pid, uid, and euid.
+	 * @fown_subject: Landlock credential of the task that set the PID that
+	 * may receive a signal e.g., SIGURG when writing MSG_OOB to the
+	 * related socket.  This pointer is protected by the related
+	 * file->f_owner->lock, as for fown_struct's members: pid, uid, and
+	 * euid.
 	 */
-	struct landlock_ruleset *fown_domain;
+	struct landlock_cred_security fown_subject;
 };
 
 /**
diff --git a/security/landlock/task.c b/security/landlock/task.c
index dbdfac11e015..da8f82c8054a 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -288,22 +288,29 @@ static int hook_task_kill(struct task_struct *const p,
 static int hook_file_send_sigiotask(struct task_struct *tsk,
 				    struct fown_struct *fown, int signum)
 {
-	const struct landlock_ruleset *dom;
+	const struct landlock_cred_security *subject;
 	bool is_scoped = false;
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_get_applicable_domain(
-		landlock_file(fown->file)->fown_domain, signal_scope);
+	subject = &landlock_file(fown->file)->fown_subject;
 
-	/* Quick return for unowned socket. */
-	if (!dom)
+	/*
+	 * Quick return for unowned socket.
+	 *
+	 * subject->domain has already been filtered when saved by
+	 * hook_file_set_fowner(), so there is no need to call
+	 * landlock_get_applicable_subject() here.
+	 */
+	if (!subject->domain)
 		return 0;
 
-	rcu_read_lock();
-	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(tsk),
-				     LANDLOCK_SCOPE_SIGNAL);
-	rcu_read_unlock();
+	scoped_guard(rcu)
+	{
+		is_scoped = domain_is_scoped(subject->domain,
+					     landlock_get_task_domain(tsk),
+					     signal_scope.scope);
+	}
 	if (is_scoped)
 		return -EPERM;
 
-- 
2.48.1

