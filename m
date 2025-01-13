Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B720AF68
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784691; cv=none; b=dgm6MFOq0c7eIaoLtJvgqX1WetZwp9dWlvEGX4LK8qw8Kh7yovSPM1i1/MyaGWwv8aPNizdVcPwar1fEK8EDGSr9ullHHG6pw1/XgD/TIqONemK9H+a3qaD0D1wrpu1JcSitDZKsIo9kBaPDwJqqh/sce/zi4HT1xT1QUH7GPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784691; c=relaxed/simple;
	bh=FXG6ScdiLWonWuoDMzl1VnnlmIVi/bobbhJ2XoREFVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKVckETCgSsIDtrHLEUIJeOV/CqiG9c53MzpEbaY5lGx0jd4o/TTFpVSJRvEf+rw6x0icWq4d0MZAaU7THXUMOMC0/bBvqeIUBxwzKRXN4lvndcznGQVcuWPuIkLJ2FHZlfpAgfALRgEYTM+/Rpo1yd7mN9/vk8qxhLSXlWh+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lin+IqWH; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lin+IqWH"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWy1N4s5fz147F;
	Mon, 13 Jan 2025 17:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736784680;
	bh=KA51zQCLP85BlI9Xb+JJNLsY2yl57zzkKQZ7FZ9fVzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lin+IqWHsiJGe4CWe37+MPlKOrYYksTafmx6dUoViHz2u6Rme3goPm0a0HV9Py7XR
	 v9tUcASxGrWjuE0gSROsyr3lm/SucEJ+XmCSfq7rU/0LkFBlg13wmJeJ2VYs7SXRQZ
	 gzQKHvNcZ5NQRYsNq1DBA3r5Qj4O5Ze6IePljtKY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWy1N0RRbzVJk;
	Mon, 13 Jan 2025 17:11:20 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shervin Oloumi <enlightened@chromium.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/4] landlock: Use scoped guards for ruleset
Date: Mon, 13 Jan 2025 17:11:09 +0100
Message-ID: <20250113161112.452505-2-mic@digikod.net>
In-Reply-To: <20250113161112.452505-1-mic@digikod.net>
References: <20250113161112.452505-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Simplify error handling by replacing goto statements with automatic
calls to landlock_put_ruleset() when going out of scope.

This change will be easy to backport to v6.6 if needed, only the
kernel.h include line conflicts.  As for any other similar changes, we
should be careful when backporting without goto statements.

Add missing include file.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250113161112.452505-2-mic@digikod.net
---
 security/landlock/ruleset.c  | 22 ++++++++++------------
 security/landlock/ruleset.h  |  5 +++++
 security/landlock/syscalls.c | 25 ++++++++-----------------
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a93bdbf52fff..f27b7bdb19b9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -8,11 +8,13 @@
 
 #include <linux/bits.h>
 #include <linux/bug.h>
+#include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
@@ -537,7 +539,7 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset)
 {
-	struct landlock_ruleset *new_dom;
+	struct landlock_ruleset *new_dom __free(landlock_put_ruleset) = NULL;
 	u32 num_layers;
 	int err;
 
@@ -557,29 +559,25 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	new_dom = create_ruleset(num_layers);
 	if (IS_ERR(new_dom))
 		return new_dom;
+
 	new_dom->hierarchy =
 		kzalloc(sizeof(*new_dom->hierarchy), GFP_KERNEL_ACCOUNT);
-	if (!new_dom->hierarchy) {
-		err = -ENOMEM;
-		goto out_put_dom;
-	}
+	if (!new_dom->hierarchy)
+		return ERR_PTR(-ENOMEM);
+
 	refcount_set(&new_dom->hierarchy->usage, 1);
 
 	/* ...as a child of @parent... */
 	err = inherit_ruleset(parent, new_dom);
 	if (err)
-		goto out_put_dom;
+		return ERR_PTR(err);
 
 	/* ...and including @ruleset. */
 	err = merge_ruleset(new_dom, ruleset);
 	if (err)
-		goto out_put_dom;
-
-	return new_dom;
+		return ERR_PTR(err);
 
-out_put_dom:
-	landlock_put_ruleset(new_dom);
-	return ERR_PTR(err);
+	return no_free_ptr(new_dom);
 }
 
 /*
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 631e24d4ffe9..70e5b53d1c71 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -11,6 +11,8 @@
 
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
@@ -252,6 +254,9 @@ landlock_create_ruleset(const access_mask_t access_mask_fs,
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 
+DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
+	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
+
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 4ed8e70c25ed..5a7f1f77292e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -10,6 +10,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/build_bug.h>
 #include <linux/capability.h>
+#include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
@@ -456,10 +457,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
-	struct landlock_ruleset *new_dom, *ruleset;
+	struct landlock_ruleset *new_dom,
+		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
-	int err;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -483,10 +484,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	/* Prepares new credentials. */
 	new_cred = prepare_creds();
-	if (!new_cred) {
-		err = -ENOMEM;
-		goto out_put_ruleset;
-	}
+	if (!new_cred)
+		return -ENOMEM;
+
 	new_llcred = landlock_cred(new_cred);
 
 	/*
@@ -495,21 +495,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	 */
 	new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
 	if (IS_ERR(new_dom)) {
-		err = PTR_ERR(new_dom);
-		goto out_put_creds;
+		abort_creds(new_cred);
+		return PTR_ERR(new_dom);
 	}
 
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
-
-	landlock_put_ruleset(ruleset);
 	return commit_creds(new_cred);
-
-out_put_creds:
-	abort_creds(new_cred);
-
-out_put_ruleset:
-	landlock_put_ruleset(ruleset);
-	return err;
 }
-- 
2.47.1

