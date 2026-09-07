Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4D5474E
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783706; cv=none; b=NFwbVbGp2BNo5ZZGj83EO5HAWaff9abg0EA3RdKcnDmIns4EnSG2hoC9gp+K6EGZS7F2HkKFbWb/4nEdugutu4TP2EMDA0C94M17+NhOzr6DCnz0iOpOooARSuiAxPcgiTim4Fhag9GrmclirORIIWQcrzqQ2tUb7Lav+YDdR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783706; c=relaxed/simple;
	bh=A1tKrPoWt6Aaf5VuWc1ENCek2B2QhPHEOe3WHYtoaHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGYij6L+o7IuOyVh90do2XQUIqlsNIPW415eM8HZYiSj+gOfa51w/vzEOpgHOupJ4cuLQ1pDoXkfEdwgjAYY++rEjovDnB7wS+pQQegJWjmDZL36Xk51qVN7H1p4uQsJtc9BcdzcgCq4n1aNBlTsXMWetEp3D6KHd/nWc/AUxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=z32x73Hv; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="z32x73Hv"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdk4r3jk7zm4y;
	Mon,  7 Sep 2026 12:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788777372;
	bh=wejE1KfIE296svmcG+z8dotOOtdCOJhIFAV4DHAI7vo=;
	h=From:To:Cc:Subject:Date:From;
	b=z32x73HvokpokvMQgIzyttw/ZE78Mk7zT0j3q5AJCyKhYpPoFu37DZnUKIYZcjG5Q
	 W9e9nDOkBVVGlnzgCky3I3QtAFXCfFphgPItXL6EUfzfHSTPlaJKcZrkV0TG+S2Ud1
	 JFA9F2gs3gJvkGEaf7t+Px79oMMqJlGIwKvtAjeM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdk4q6d1rzVj2;
	Mon,  7 Sep 2026 12:36:11 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Charles <dmcjisalive@gmail.com>
Subject: [PATCH v1] landlock: Clean up ruleset validation checks
Date: Mon,  7 Sep 2026 12:36:08 +0200
Message-ID: <20260907103609.113325-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

landlock_merge_ruleset() checks for a NULL ruleset after dereferencing
it in lockdep_assert_held().  Move the assertion after the check so the
defensive path remains effective.

The mask-validation comment originated in landlock_add_fs_access_mask()
to explain that its WARN_ON_ONCE() checked a caller invariant.  It
became self-referential when this helper and its network and scope
counterparts were inlined into landlock_create_ruleset().  Restate the
invariant without naming the caller.

Keep both as defensive callee checks.  Moving the assertion preserves
the NULL check's ability to warn and return -EINVAL, while invalid masks
remain warned about and masked.

Reported-by: Günther Noack <gnoack@google.com>
Closes: https://patch.msgid.link/aobYhIt3vcs2xN0b@google.com
Closes: https://patch.msgid.link/aobasxUDQ8b7GYXl@google.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.c  | 3 ++-
 security/landlock/ruleset.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 93c7104fd6b2..4031b581be07 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -439,10 +439,11 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 	int err;
 
 	might_sleep();
-	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!ruleset))
 		return ERR_PTR(-EINVAL);
 
+	lockdep_assert_held(&ruleset->lock);
+
 	if (parent) {
 		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
 			return ERR_PTR(-E2BIG);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 0d07707523cd..a5d135d085cb 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -58,7 +58,7 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 	new_ruleset->id = landlock_get_id_range(1);
 #endif /* CONFIG_TRACEPOINTS */
 
-	/* Should already be checked in landlock_create_ruleset(). */
+	/* The caller must only pass supported access rights and scopes. */
 	if (fs_access_mask) {
 		const access_mask_t mask = fs_access_mask &
 					   LANDLOCK_MASK_ACCESS_FS;
-- 
2.55.0

