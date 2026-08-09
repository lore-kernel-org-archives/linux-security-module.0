Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D73403EB
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310709; cv=none; b=QOhl3IrklJ8dE63YNRtaAJY98nTsFzPG8VQQFllFxJmjuKgxmv+2v6j6HBg7fWzarXeAPpc53Rr7OeVq1F8GbxuCPqTuz4zxQhcfWM5dU8/kza4s+hUp9cmmP+yCxTmQYaDmJOAaZlMnNK8+X8qIdn1TSZ4HMfVCzm/7ZTfumuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310709; c=relaxed/simple;
	bh=Lcp8j2SUJLlQP7y2eZFQ8/UVa7Prfjafhf5LdQWkeMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeJhKvinOj4G3dsRAmtWKWzcnrPUOLXr0y607W2CmpMHESmAJjnofDEEn9zWb2kCM51dpnUvMx0yHsiNEsyHG5oRvRqsg1AjUGhb8bISbVl4LCSkoKXqBvK4Iays4I3UfVN9SDF+eQbYxWi4PtwLtFEy1KqfzHzdgjXL6t8bOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUrb5T+A; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUrb5T+A"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80c5cb9a888so13698797b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786310706; x=1786915506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwZIucPGJPCGDD6h9KBB2EiWbEKq4cSnPvNB4kuHRak=;
        b=PUrb5T+AuaP9N3lDCfkYFIo5p6D7bKZ0dXptK9rFidY22o5gXHkEfQ1ghB9BiJUkc7
         sACVuqhizzy7pmTvB3S1P6G0/we+IkiEP/MsvmwK0P1DCNe7qo5dyGnFbHY1NLGYsur8
         z/ANsYBJwp4mpzCtPlSYoev/gw+tBTVVyTUYRMxU7UzE1teTWQamMReFZpalX5S4+Vg6
         I0B2ruoIymME391RITkO4g7sf3IF+ip8PXBD99r0B/f5k5WCNBKmUk8AMFvcYcnXrGfX
         r0pG0bxxIdmnKugPT2q4OfVr/EQK6PExQFgNsvLXeWcbg8fmAg1x6fDqOVxAyVb1xDkr
         /cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310706; x=1786915506;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwZIucPGJPCGDD6h9KBB2EiWbEKq4cSnPvNB4kuHRak=;
        b=SKTcyFdFCE8HjbKiTxJ+aDGsnsRPDgFQmteQl8THbv5gI6G5a+1MrGU+bUDgm1uUxD
         O67rj2+URfYdq6lRfDJO0b5UE4DAH26/u6948Oo2bUKHONSlKvFJcoBIebVrGewP2TZZ
         Pgl7whCA+aBUGf9rfWvEV6QyRNkaPF3If2tbzK10C2nhSvvSPQAcVvXuuwctrBqmnw4X
         Jz9pNAx3lh/BKF5hPLKhOK098zG3fJVBSIYQIVFAttF7MwQbGEIvI530TskV9m9OJJhV
         UYmyP3iAdWKmUjjwzjmj08PcWBSvcWkKcKwljX+aRZ255kIePWNkFyY+NPQ0sCXuvxR8
         46sg==
X-Forwarded-Encrypted: i=1; AHgh+RqcPOVrbty5fOY6WNdIHxh9iwjSeAgO4i0KiixvYrZeDufiGa/RB5YEahAcF8eULpNh5fwslvl8FCp5xoPeph4iUUs+Ok4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4niBdodaVFK3WhTK73Y0YJxwYD3RQ0rLf0r7RtMIdZWCq24bR
	hCUeUld5KC6jhurZD9Hyh1gDuEw7TYKRG5X0+0h0y78f1WjGlMDEIflB
X-Gm-Gg: AR+sD11HCQey5WFMEkAQudHylIRUyZowfJuuJKqZ50olSkmXly0rHS62sSVfJiv3rWW
	fdVPlU+smP+8N9FYXu9pavDCthsv6NspJSqHuov43HyBaGcFQNjYDPiK8lbn81ZuChL5VnuSztw
	05CKHVLaU7aRBgFI+sh5uMdTsiG8HHHKEmsNMb7If7Rqr5hAhFCsHiupsX+ciLH3ybzxgs+ueOA
	YOK5dbT8vWT3Lr4M+IbXlwoTRf/GoAsdE+2N8tr2RGNFfHWKBJuXV3Q1222zf6LyHREgCtJsd3L
	u+q3VMClbyEsaQdxZs5IAt9hn8rLOhY4ly/4MHiPXJVbAx+3VVKQdzng6lE5rNljkniAGlY+AsK
	C8N0Q6Op1aGocmtUiqadshfuicsJaSL5MICeI24fLQI8xGu7aTaW8K3YfHyXCilxyR4hOjxIOeu
	hTpiitWBelg+95n9w5Djk1ShrhuGa9DwMD3FwEhoau3SgSOqMcedwPtyWEKklCMRMZzZDRbepoP
	ktmwfIoQxCTPg3Raz2TLOlSKGgJCLgz+qU=
X-Received: by 2002:a05:690c:6e01:b0:820:132b:6309 with SMTP id 00721157ae682-8202b0835bemr230889597b3.35.1786310706433;
        Sun, 09 Aug 2026 14:25:06 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823efa07c0esm44883487b3.1.2026.08.09.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:25:05 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v4 2/5] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Sun,  9 Aug 2026 17:24:59 -0400
Message-ID: <20260809212459.2427878-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
of the calling thread only after enforcement of the ruleset:
no_new_privs is set if and only if the call succeeds.  This removes the
need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that
a failed enforcement leaves the attribute unchanged.

Because no_new_privs is set by the call itself, the no_new_privs /
CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
construction, and the related EPERM check is skipped.

Unlike LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, this flag always
requires a valid ruleset: with a ruleset_fd of -1, such a call would be
nothing more than a Landlock-flavored prctl(2) PR_SET_NO_NEW_PRIVS, and
there is no valid use case for setting no_new_privs (possibly with
LANDLOCK_RESTRICT_SELF_TSYNC) without also enforcing Landlock
restrictions.  Rejecting these calls also keeps the option of giving
them a meaning later.

The attribute is only set past the last point of failure, just before
committing the new credentials.  When combined with
LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
as well, in their commit phase, with the same ordering.

Bump the Landlock ABI version to 11, and include the minimal related
test changes to keep the tests bisectable.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v3->v4:
        - Rebase on the new preparatory patch: the flags-before-privileges
          ordering (and its EINVAL/EPERM visible change) is now handled
          there.
        - Drop the set_no_new_privs variable and check the flag directly at
          both use sites, per Mickaël's feedback.
        - Fold in the minimal selftest changes (ABI version, last-flag, and
          checks-ordering updates) to keep the series bisectable, following
          the commit tweaked by Mickaël.
        - Reword the flag kdoc: "call (or %CAP_SYS_ADMIN use)" instead of
          "call, and with it the %CAP_SYS_ADMIN requirement".

 include/uapi/linux/landlock.h                | 13 ++++++++++
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 | 27 +++++++++++++++-----
 security/landlock/tsync.c                    |  8 ++++--
 security/landlock/tsync.h                    |  4 ++-
 tools/testing/selftests/landlock/base_test.c | 12 +++++++--
 6 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 27ae3f39cafb..cceda3b3b961 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -191,12 +191,25 @@ struct landlock_ruleset_attr {
  *
  *     If the calling thread is running with no_new_privs, this operation
  *     enables no_new_privs on the sibling threads as well.
+ *
+ * The following flag ties the no_new_privs attribute to the ruleset
+ * enforcement:
+ *
+ * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+ *     Sets the no_new_privs attribute of the calling thread only once the
+ *     enforcement of the ruleset succeeded: no_new_privs is set if and only
+ *     if sys_landlock_restrict_self() succeeds.  This removes the need for a
+ *     prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS`` call (or
+ *     %CAP_SYS_ADMIN use).  This flag requires a ruleset.  When
+ *     combined with %LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the
+ *     sibling threads as well.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 08d5f2f6d321..1a7c5fb8f6fd 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -34,7 +34,7 @@
 #define LANDLOCK_NUM_ACCESS_MAX \
 	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index e3ef7b980c82..e5f65a1c35ff 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 10;
+const int landlock_abi_version = 11;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -502,21 +502,28 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *         - %LANDLOCK_RESTRICT_SELF_TSYNC
+ *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  *
  * This system call enforces a Landlock ruleset on the current thread.
  * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
+ * With %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, the no_new_privs attribute of the
+ * calling thread is set only once the enforcement of the ruleset succeeded,
+ * which fulfills the above requirement: no_new_privs is set if and only if the
+ * call succeeds.
+ *
  * Return: 0 on success, or -errno on failure.  Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: @flags contains an unknown bit.
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
- * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
- *   current thread is not running with no_new_privs, or it doesn't have
- *   %CAP_SYS_ADMIN in its namespace.
+ * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or
+ *   %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is not set while the current thread
+ *   is not running with no_new_privs and doesn't have %CAP_SYS_ADMIN in its
+ *   namespace.
  * - %E2BIG: The maximum number of stacked rulesets is reached for the current
  *   thread.
  *
@@ -541,9 +548,11 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
+	 * returned.  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills this
+	 * requirement.
 	 */
-	if (!task_no_new_privs(current) &&
+	if (!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
+	    !task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -620,12 +629,16 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
 		const int err = landlock_restrict_sibling_threads(
-			current_cred(), new_cred);
+			current_cred(), new_cred, flags);
 		if (err) {
 			abort_creds(new_cred);
 			return err;
 		}
 	}
 
+	/* Sets no_new_privs past the last point of failure. */
+	if (flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
+		task_set_no_new_privs(current);
+
 	return commit_creds(new_cred);
 }
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index c5730bbd9ed3..0b71e158c3f5 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/task_work.h>
+#include <uapi/linux/landlock.h>
 
 #include "cred.h"
 #include "tsync.h"
@@ -466,7 +467,8 @@ static void cancel_tsync_works(const struct tsync_works *works,
  * restrict_sibling_threads - enables a Landlock policy for all sibling threads
  */
 int landlock_restrict_sibling_threads(const struct cred *old_cred,
-				      const struct cred *new_cred)
+				      const struct cred *new_cred,
+				      const u32 restrict_flags)
 {
 	int err;
 	struct tsync_shared_context shared_ctx;
@@ -481,7 +483,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	init_completion(&shared_ctx.all_finished);
 	shared_ctx.old_cred = old_cred;
 	shared_ctx.new_cred = new_cred;
-	shared_ctx.set_no_new_privs = task_no_new_privs(current);
+	shared_ctx.set_no_new_privs =
+		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
+		task_no_new_privs(current);
 
 	/*
 	 * Serialize concurrent TSYNC operations to prevent deadlocks when
diff --git a/security/landlock/tsync.h b/security/landlock/tsync.h
index ef86bb61c2f6..2ae4f938ca00 100644
--- a/security/landlock/tsync.h
+++ b/security/landlock/tsync.h
@@ -9,8 +9,10 @@
 #define _SECURITY_LANDLOCK_TSYNC_H
 
 #include <linux/cred.h>
+#include <linux/types.h>
 
 int landlock_restrict_sibling_threads(const struct cred *old_cred,
-				      const struct cred *new_cred);
+				      const struct cred *new_cred,
+				      u32 restrict_flags);
 
 #endif /* _SECURITY_LANDLOCK_TSYNC_H */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index f3c126d5c003..288d6bc19232 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
@@ -265,6 +265,14 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
 	ASSERT_EQ(EPERM, errno);
+	/*
+	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills the no_new_privs /
+	 * CAP_SYS_ADMIN requirement but requires a ruleset, so the FD is
+	 * checked next.
+	 */
+	ASSERT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	ASSERT_EQ(EBADF, errno);
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
@@ -310,7 +318,7 @@ TEST(restrict_self_fd_logging_flags)
 
 TEST(restrict_self_logging_flags)
 {
-	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 
 	/* Tests invalid flag combinations. */
 
-- 
2.55.0

