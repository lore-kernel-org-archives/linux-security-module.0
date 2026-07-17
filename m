Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFC3D9680
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325814; cv=none; b=HK+300/XSF+M2+k3qX64MNVpYqTow91qzJAZuQ/nRKN/hIr4x44RLlUJVuRN5rSJUoFUcO6WDkYeJ/4koELcSbg9mIj56hnETRzeKmLQt9WOvMnXb6Vnj5brDLLg9sg7/mS3maHDGpxIa2DzCWOT5VUH+EZcNJHtJa/1ACz+SII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325814; c=relaxed/simple;
	bh=Tr06TgVRa+MWduu5HOXY/09bGtYQpJWzDpIVVe7QQeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEkZTP9X/6E0QOekJdbma9nPA49vZFsgSZ6NuCan5jbMWcT+w0hw3b5NMZQ3tkrT4jLf0PAx0f0hzZq+J8QNhOLvQkwMg3XVNPqCLgyEYBt7mNkCZQTt+nxgK1BCkIpLqyC+rjcJLTBrsW1GcGb+WUjrbOA1x+9TfDU0RDCOPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxLL4M3u; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxLL4M3u"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66826484b67so3209616d50.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784325811; x=1784930611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zm+0aM2mDwgivCRHDxKtZ8YT8LqEvq7lvhw4cFbQwWA=;
        b=RxLL4M3uHQ2Rwux2EmIT0ioElPCFQ4UljaXR5/Ad7uiCxe0HDhxt0KxrYXf6kQiQmc
         AiNag2rcNQlo3Y104JAQOgl+B4vMr2PJRWN2vdT3bw0zf0F3qcD22UeX121oGcIWt7JR
         0OyPW2hG6OPxX/qcouIB8j7s7BBP6lGQTrTXw1izy2rFudFROFtS3kFCCeHGJ+ZiXWLd
         4yDVNK63qxFxNv0/BjWMzR9DDS7X1BZqeHYrc9G3vKphdcSXUQW4V0zQ5iZWCoDfKxNU
         9ljQnNjQjm8qn88pkJHsWrH9JptlJJHiIEwrtoqUkeigxI6C+pPE9cjcmzfkjOT5EBoP
         LnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325811; x=1784930611;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zm+0aM2mDwgivCRHDxKtZ8YT8LqEvq7lvhw4cFbQwWA=;
        b=SSkTBvIaC8BK92c3r12R0gdql0de6DRmcvDDo6IJok+XyNc+1XmFu2XEeLFA2OZ4Fo
         DIywSS/8rH1jXRy5PZc6uKGjb4p9a485RogsTjIfog9TYCLT9b47MzSVCGNRftZ7u6q4
         OLo1M8cxKPPtxdYT5MLfmbI8ZV1J+UZ2ulcfdU1H290p5zHo+51HIjqwUfNZfifJMB96
         9Yo+EVyKExqapL3Hq98g7wzlM3ZaqmUzl9i58y/Kqbx005r0ysOzP+m9iaWQtiaZyNHk
         iQ+RHaKiG2Nnzy8jJWTMjTPFF/mIjwRM5eX+7t4lj9bcnb6P/8+AE1MzSUb1pv+hMNST
         Ixkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6ESjRJxjZJKPoybAjrLz7zRbQvsmVtwqaw6hi7zsKgiTDemTHGLC0QaeoHwbebUt4qoNgKACQieOS/1up1QfNy731cVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpTk9iLwmHKP4skJB9GLPA7gB5T9aWMtLBQP7fKHlVEO3UuzA
	W/Nz8BWisDPdUCNvgUI35GwSJDNXkRCibldK2lMOE1Az/W0sR8Y2ks2K
X-Gm-Gg: AfdE7ckkemhy56xW9SjuznR8D75PGzyHeKyUx5nkHJoRQobGhkrAB6R6g40VAvJaG/9
	d8NgiNJbpGbNAaorhPibFcCdGpP9Uta3deCsR+oJXXR/VkQTQSSEP/bEwc8OKTZdwFMLdfDj1LX
	k1q4iPw7fBiXsykQW8WSSKKZp497JH3c+WXps9YjDeZfh94fmrroM+DNjylOpr+ziN+xhMQwOeI
	vFLCOCVMZZD0vmgcutU2yi2VguhBoYB3s4BCzI4zRmtUtgwvJf1hgHeGDqHI+c8VTW9xf0bC0tW
	OB50KhMxYa1XcLjscq8+MAVFHSYBJTaVtzhiI7Ekc6OmI29rpHzwqtFY6OK8BYgIFgeOIkMIbR4
	4jOCTz6YAM/jX05PcTPSBEYYFgflfkzOHtKzsZ7e2hDWGBP0tf1bNa0IV06fz1HdigUPeRFtGNj
	30GrBQ78Apzj5rIgLmfgJPimuB7qUquK1wESg=
X-Received: by 2002:a53:e035:0:b0:667:e9e1:f971 with SMTP id 956f58d0204a3-6683bb257e8mr1061106d50.4.1784325811088;
        Fri, 17 Jul 2026 15:03:31 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:ee56:9b10:53f4:188])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef401728asm20572037b3.9.2026.07.17.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:03:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 1/3] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Fri, 17 Jul 2026 18:03:17 -0400
Message-ID: <20260717220320.1030123-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717220320.1030123-1-utilityemal77@gmail.com>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
of the calling thread atomically with the enforcement of the ruleset:
no_new_privs is set if and only if the call succeeds.  This removes the
need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that a
failed enforcement leaves the attribute unchanged.

Because no_new_privs is set by the call itself, the no_new_privs /
CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
construction, and the related EPERM check is skipped.  As a consequence,
an unprivileged caller passing unknown flags along with this flag gets
EINVAL instead of EPERM.

The attribute is only set past the last point of failure, just before
committing the new credentials.  When combined with
LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
as well, in their commit phase, with the same atomicity.

Bump the Landlock ABI version to 11.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 13 +++++++++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/syscalls.c  | 28 +++++++++++++++++++++-------
 security/landlock/tsync.c     |  8 ++++++--
 security/landlock/tsync.h     |  4 +++-
 5 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 272f047df438..77820e430ab8 100644
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
+ *     Sets the no_new_privs attribute of the calling thread atomically with
+ *     the enforcement of the ruleset: no_new_privs is set if and only if
+ *     sys_landlock_restrict_self() succeeds.  This removes the need for a
+ *     prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS`` call, and with it the
+ *     %CAP_SYS_ADMIN requirement.  This flag requires a ruleset.  When
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
index 36b02892c62f..36b8a3fb506f 100644
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
+ * calling thread is set atomically with the enforcement of the ruleset, which
+ * fulfills the above requirement: no_new_privs is set if and only if the call
+ * succeeds.
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
@@ -529,6 +536,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	const bool set_no_new_privs =
+		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
 		prev_log_subdomains;
 
@@ -537,9 +546,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
+	 * returned.  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills this
+	 * requirement.
 	 */
-	if (!task_no_new_privs(current) &&
+	if (!set_no_new_privs && !task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -620,12 +630,16 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
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
+	if (set_no_new_privs)
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
-- 
2.54.0

