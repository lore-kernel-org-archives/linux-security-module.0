Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122629A0
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644540; cv=none; b=mKGGkdlp6KXpvGBwFIRrudDY5LC7vLtXPzCjGYt9AKemXLWo4ZnUb2oJYkKA4xOYnLJY05aMJBvS+vghAdJV/7VIPgz5OLXkg4yZcY4l40pBnDdqVJpHEVla58YM0dPC44fB4la6SOzCHdeHmxQuUsGYr2P4RWxd82a9IIktYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644540; c=relaxed/simple;
	bh=14SF2zVGjquBVCZrvqvO4Pp2VtYQB4FXZC15Ij299Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=un1NN+cqIgqQwjerxqcWSh8rAv4ommLORIMUuK6VGja7pOHshwcAzjnu4qrqYPo3MtK1kBim5Ivw2+RGuJpo0LlsotzfxZuXcCn/Xz7pZRew3vu2U3GUWwsoiQff6J+y2jVn4I1zb7VnZ1fgV0v3I4URIVzbzz8IXox47HHGpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xMJnvgXb; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xMJnvgXb"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zt4Dn2FLxzLGb;
	Wed,  7 May 2025 20:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746644057;
	bh=E8IQ3mHBBfLfJXp4+cdVjhuQCJRi3UUanJwrUpE/BTU=;
	h=From:To:Cc:Subject:Date:From;
	b=xMJnvgXbZMSFXAOajYyc8huzAYYhcu/vu2V5GH9aKfDH2LBq2pYbPa5UpPYlmgdyN
	 lS6rEqsaNIiVWJTVnRak+0XqoO1t32asVGSGqCZpgxYHdFcm0dDLplolkpX9M0tp2q
	 K9hnXkVD4btGEFJpk9uAlTwdsBfn1kGGxag2j+dY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zt4Dm66Txzp6C;
	Wed,  7 May 2025 20:54:16 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Use bitops macros in audit code
Date: Wed,  7 May 2025 20:54:02 +0200
Message-ID: <20250507185404.1029055-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the BIT() and BIT_ULL() macros in the new audit code instead of
explicit shifts to improve readability.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c    | 2 +-
 security/landlock/id.c       | 5 +++--
 security/landlock/syscalls.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 58d5c40d4d0e..c52d079cdb77 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -437,7 +437,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 		return;
 
 	/* Checks if the current exec was restricting itself. */
-	if (subject->domain_exec & (1 << youngest_layer)) {
+	if (subject->domain_exec & BIT(youngest_layer)) {
 		/* Ignores denials for the same execution. */
 		if (!youngest_denied->log_same_exec)
 			return;
diff --git a/security/landlock/id.c b/security/landlock/id.c
index 11fab9259c15..552272307697 100644
--- a/security/landlock/id.c
+++ b/security/landlock/id.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/random.h>
 #include <linux/spinlock.h>
 
@@ -25,7 +26,7 @@ static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
 	 * Ensures sure 64-bit values are always used by user space (or may
 	 * fail with -EOVERFLOW), and makes this testable.
 	 */
-	init = 1ULL << 32;
+	init = BIT_ULL(32);
 
 	/*
 	 * Makes a large (2^32) boot-time value to limit ID collision in logs
@@ -105,7 +106,7 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
 	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
 	 * cost of draining all available IDs during the system's uptime.
 	 */
-	random_4bits = random_4bits % (1 << 4);
+	random_4bits = random_4bits % BIT(4);
 	step = number_of_ids + random_4bits;
 
 	/* It is safe to cast a signed atomic to an unsigned value. */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b9561e3417ae..33eafb71e4f3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -9,6 +9,7 @@
 
 #include <asm/current.h>
 #include <linux/anon_inodes.h>
+#include <linux/bitops.h>
 #include <linux/build_bug.h>
 #include <linux/capability.h>
 #include <linux/cleanup.h>
@@ -563,7 +564,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	new_llcred->domain = new_dom;
 
 #ifdef CONFIG_AUDIT
-	new_llcred->domain_exec |= 1 << (new_dom->num_layers - 1);
+	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
 #endif /* CONFIG_AUDIT */
 
 	return commit_creds(new_cred);
-- 
2.49.0

