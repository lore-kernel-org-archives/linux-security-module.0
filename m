Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AC35F178
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592131; cv=none; b=JafK3kleLXyY8zmTWEObw1ci6dkWqIx13q4vy+WMPlOkw06fKeqSCHiPBbUCIUlHxcuaV7tCvU4AoxROnFXHPrU921c8ncf5T6iMfJqwaNfVf02LMEeIhJcPmjNjYayyqjStkEgZ8fqOE8d+C4zYhU9b1o9T4zzI3Rm32dckA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592131; c=relaxed/simple;
	bh=DUJQPT4pI6d6O3nRTbSOEFVYfglO/X4iEmFEaVSGtWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRRINixQ8G0PMtoo9cSHjmLShWcugR6HKlfWFiVjIUsSuMvkJ/yf0/hr9RRY8T6dcDllMsqoDLlHugHC1oqwE31Ncl9lhOkCfGtmKdiQHDMGD4CTrCRBhmiDbln6Ag2tQNexC8V7dCnOY2AzkDNh7/w5vV7gRVm5xtaQBxZsOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/o0aP5g; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/o0aP5g"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6501c4857b2so3224472d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592128; x=1776196928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3hXiO0yfZprs+OVS+Ms3KTUqBIKUxwmTA7k1ZKLB/8=;
        b=S/o0aP5g195vtqeoTdhB3NtJNw86h4kQjxV8xcqBiQl4M0/Iul2KcxlE0WGZ5+ZTWW
         +aDnKZVD5IFztgUyEV5I42Rur8iPImwNb2YD+qSFrVhZRhOsYGd9IJMppiYQTcmG+eFD
         HZmDgDlWEnje9UL3M49aGTdKOpVt0QNPaVjONs6/MNnf9kwWq+U96iwXK4aci7GnL5C/
         wNbO6RdFUyKL0lF6B1v9pQbDHa1mU17V8cAAguEUsZtRXlHr1tnTdmJr33TgVtgLqICx
         u2Srv6YrHZ/65CS/G7xyl6WqMEYGQKFSEHSIPQEe5pMsfFXOELkm4Wx4KW6m4f8IwXae
         kIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592128; x=1776196928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3hXiO0yfZprs+OVS+Ms3KTUqBIKUxwmTA7k1ZKLB/8=;
        b=sPG6+8eY8Vzs4Ym/QQCtVOwIFBi8tDW7v8T6oz6N50ZRAdVuK2PvXdetFP9J9rncHt
         maoS8vbds4PS6EI0ILT4YYDFW3HiBQFFMo1HKXN/6CwhZaN0lK1C6vzpo4WgJyzr0JwE
         og88c0jPSxBn1XJtPeBrA9HY0EmiHt5v1D9JKvACZe5PmAyIUQHtymIZqUuAVFXEntCa
         E/5U9yRj0wFgC5mX1h0ZrwUPleEz3YjU+Mb7hSFZSFJl1TgxEExaqdjrlsKN9r5IhNWf
         U9vCe6h9uhT/5N21YF4ZGps3hW50H1+E61RHnTLgRgFrElXwTfm4bdL5x/dSPnA35ni/
         2b+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9okC1DVEQ9Uvi5sc5xTLfxRkb+Yd0v2K1lNMJOouYXKQeKGpREcYJ17rxQs5gARlfpnS4aPoGkpqyrxh1yxwjmow10Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJ0sJYtPuCvnd+vUuesXqdjMlX3a/BdKjTaoL8wbXR/qgREIh
	UGJSMTFuIgPlpZ0Q+9UwUsa+DHIKS1VKG73F4CBqZ9ITX79j9Hy5lpEb
X-Gm-Gg: AeBDieuBa9rJYnrNkrlXerWje/GU++IVTgaM1zgLddpnVZACNOjZsZI2Hfo9omP8fGQ
	vVWmaXo1Qelst1L6gqzkXDi0ZKBpamPpJRZG0/d1h5dmhtKTPvBARyIFDgyHhT2btj794t+pqEv
	lRb/aXgq2oyEB/xpkEUrAWVYebdYQBNqg49bnJ+kJD98hUwLp2MEkYenI6+PGXJReQiBPKzSSSU
	MiCBJIm9tts2OSg+aw2vF1a9MmOh5A3V75mPz79uQBPs2KIMoO3d3qqwzkK43n8klECnsPiRK3q
	7ijd0okY1Qe9r1Eo1LvBqwNiqct5xwPVSJjVkP7RJV5NX1oUYgqYGfL+rfzk7pb7qN+jc50d4x/
	Qum/vHugYmFUgY9osgU+mfLphc5qfMv6TYlG+HXca1YW6Mqa3lJDHgt8DrKTOsZGbfsf92atVqw
	JEdV5iRt6CfaaKLjyMugJoUixKdb6OWcZY83vKwIji0uRiUWSt4Mjv3vx3p6rIkySbHGFyKk7Q
X-Received: by 2002:a05:690e:138a:b0:650:4a79:f3db with SMTP id 956f58d0204a3-6504a79fcf0mr17361543d50.51.1775592127362;
        Tue, 07 Apr 2026 13:02:07 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:07 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 01/20] landlock: Move operations from syscall into ruleset code
Date: Tue,  7 Apr 2026 16:01:23 -0400
Message-ID: <20260407200157.3874806-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor syscall restriction code, associated constants and helpers,
into ruleset.h/c. This helps increase consistency by making syscall.c a
consumer of ruleset.h/c's logic. Subsequent patches in this series add
consumers of this logic.

Functions for getting and putting references on a landlock ruleset were
also exposed in the patch for the subsequent consumers, transitioning
them from static to linked functions with headers.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/landlock.h     |  92 ++++++++++++++++++
 security/landlock/ruleset.c  | 179 +++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h  |  19 ++--
 security/landlock/syscalls.c | 151 +++--------------------------
 4 files changed, 296 insertions(+), 145 deletions(-)
 create mode 100644 include/linux/landlock.h

diff --git a/include/linux/landlock.h b/include/linux/landlock.h
new file mode 100644
index 000000000000..fae7d138ef8b
--- /dev/null
+++ b/include/linux/landlock.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Internal cross subsystem header
+ *
+ * Copyright © 2026 Justin Suess <utilityemal77@gmail.com>
+ */
+
+#ifndef _LINUX_LANDLOCK_H
+#define _LINUX_LANDLOCK_H
+
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <uapi/linux/landlock.h>
+
+struct landlock_ruleset;
+
+#ifdef CONFIG_SECURITY_LANDLOCK
+
+/*
+ * Returns an owned ruleset from a FD. It is thus needed to call
+ * landlock_put_ruleset() on the returned value.
+ */
+struct landlock_ruleset *landlock_get_ruleset_from_fd(int fd, fmode_t mode);
+
+/*
+ * Acquires an additional reference to a ruleset if it is still alive.
+ */
+bool landlock_try_get_ruleset(struct landlock_ruleset *ruleset);
+
+/*
+ * Releases a previously acquired ruleset.
+ */
+void landlock_put_ruleset(struct landlock_ruleset *ruleset);
+
+/*
+ * Releases a previously acquired ruleset after an RCU-safe deferral.
+ */
+void landlock_put_ruleset_deferred(struct landlock_ruleset *ruleset);
+
+/*
+ * Restricts @cred with @ruleset and the supplied @flags.
+ *
+ * landlock_restrict_cred_precheck() must be called first.
+ *
+ * The caller owns @cred and is responsible for committing or aborting it.
+ * @ruleset may be NULL only with LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.
+ */
+int landlock_restrict_cred_precheck(__u32 flags, bool in_task_context);
+
+int landlock_restrict_cred(struct cred *cred, struct landlock_ruleset *ruleset,
+			   __u32 flags);
+
+#else /* !CONFIG_SECURITY_LANDLOCK */
+
+static inline struct landlock_ruleset *
+landlock_get_ruleset_from_fd(int fd, fmode_t mode)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline bool landlock_try_get_ruleset(struct landlock_ruleset *ruleset)
+{
+	return false;
+}
+
+static inline void landlock_put_ruleset(struct landlock_ruleset *ruleset)
+{
+}
+
+static inline void
+landlock_put_ruleset_deferred(struct landlock_ruleset *ruleset)
+{
+}
+
+static inline int landlock_restrict_cred(struct cred *cred,
+					 struct landlock_ruleset *ruleset,
+					 __u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int landlock_restrict_cred_precheck(__u32 flags,
+					 bool in_task_context)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* !CONFIG_SECURITY_LANDLOCK */
+
+#endif /* _LINUX_LANDLOCK_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 181df7736bb9..2333a3dc5f33 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -8,25 +8,204 @@
 
 #include <linux/bits.h>
 #include <linux/bug.h>
+#include <linux/capability.h>
 #include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "cred.h"
 #include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
+#include "setup.h"
+#include "tsync.h"
+
+static int fop_ruleset_release(struct inode *const inode,
+			       struct file *const filp)
+{
+	struct landlock_ruleset *ruleset = filp->private_data;
+
+	landlock_put_ruleset(ruleset);
+	return 0;
+}
+
+static ssize_t fop_dummy_read(struct file *const filp, char __user *const buf,
+			      const size_t size, loff_t *const ppos)
+{
+	/* Dummy handler to enable FMODE_CAN_READ. */
+	return -EINVAL;
+}
+
+static ssize_t fop_dummy_write(struct file *const filp,
+			       const char __user *const buf, const size_t size,
+			       loff_t *const ppos)
+{
+	/* Dummy handler to enable FMODE_CAN_WRITE. */
+	return -EINVAL;
+}
+
+/*
+ * A ruleset file descriptor enables to build a ruleset by adding (i.e.
+ * writing) rule after rule, without relying on the task's context.  This
+ * reentrant design is also used in a read way to enforce the ruleset on the
+ * current task.
+ */
+const struct file_operations ruleset_fops = {
+	.release = fop_ruleset_release,
+	.read = fop_dummy_read,
+	.write = fop_dummy_write,
+};
+
+/*
+ * Returns an owned ruleset from a FD. It is thus needed to call
+ * landlock_put_ruleset() on the return value.
+ */
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode)
+{
+	CLASS(fd, ruleset_f)(fd);
+	struct landlock_ruleset *ruleset;
+
+	if (fd_empty(ruleset_f))
+		return ERR_PTR(-EBADF);
+
+	/* Checks FD type and access right. */
+	if (fd_file(ruleset_f)->f_op != &ruleset_fops)
+		return ERR_PTR(-EBADFD);
+	if (!(fd_file(ruleset_f)->f_mode & mode))
+		return ERR_PTR(-EPERM);
+	ruleset = fd_file(ruleset_f)->private_data;
+	if (WARN_ON_ONCE(ruleset->num_layers != 1))
+		return ERR_PTR(-EINVAL);
+	landlock_get_ruleset(ruleset);
+	return ruleset;
+}
+
+void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset)
+		refcount_inc(&ruleset->usage);
+}
+
+bool landlock_try_get_ruleset(struct landlock_ruleset *const ruleset)
+{
+	return ruleset && refcount_inc_not_zero(&ruleset->usage);
+}
+
+int landlock_restrict_cred_precheck(const __u32 flags,
+				    const bool in_task_context)
+{
+	if (!landlock_initialized)
+		return -EOPNOTSUPP;
+
+	/*
+	 * LANDLOCK_RESTRICT_SELF_TSYNC requires that the current task is
+	 * the target of restriction.
+	 */
+	if ((flags & LANDLOCK_RESTRICT_SELF_TSYNC) && !in_task_context)
+		return -EINVAL;
+
+	/*
+	 * Similar checks as for seccomp(2), except that an -EPERM may be
+	 * returned.
+	 */
+	if (!task_no_new_privs(current) &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
+			return -EPERM;
+	}
+
+	if (flags & ~LANDLOCK_MASK_RESTRICT_SELF)
+		return -EINVAL;
+
+	return 0;
+}
+
+int landlock_restrict_cred(struct cred *const cred,
+			   struct landlock_ruleset *const ruleset,
+			   const __u32 flags)
+{
+	struct landlock_cred_security *new_llcred;
+	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
+		prev_log_subdomains;
+
+	/*
+	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF without
+	 * a ruleset, optionally combined with LANDLOCK_RESTRICT_SELF_TSYNC, but
+	 * no other flag must be set.
+	 */
+	if (!ruleset &&
+	    (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) !=
+		    LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)
+		return -EINVAL;
+
+	/* Translates "off" flag to boolean. */
+	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
+	/* Translates "on" flag to boolean. */
+	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+	/* Translates "off" flag to boolean. */
+	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+
+	new_llcred = landlock_cred(cred);
+
+#ifdef CONFIG_AUDIT
+	prev_log_subdomains = !new_llcred->log_subdomains_off;
+	new_llcred->log_subdomains_off = !prev_log_subdomains ||
+					 !log_subdomains;
+#endif /* CONFIG_AUDIT */
+
+	/*
+	 * The only case when a ruleset may not be set is if
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set, optionally combined
+	 * with LANDLOCK_RESTRICT_SELF_TSYNC.
+	 * We could optimize this case by not committing @cred if this flag was
+	 * already set, but it is not worth the complexity.
+	 */
+	if (ruleset) {
+		struct landlock_ruleset *const new_dom =
+			landlock_merge_ruleset(new_llcred->domain, ruleset);
+
+		if (IS_ERR(new_dom))
+			return PTR_ERR(new_dom);
+
+#ifdef CONFIG_AUDIT
+		new_dom->hierarchy->log_same_exec = log_same_exec;
+		new_dom->hierarchy->log_new_exec = log_new_exec;
+		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
+			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+#endif /* CONFIG_AUDIT */
+
+		landlock_put_ruleset(new_llcred->domain);
+		new_llcred->domain = new_dom;
+
+#ifdef CONFIG_AUDIT
+		new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
+#endif /* CONFIG_AUDIT */
+	}
+
+	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
+		const int tsync_err =
+			landlock_restrict_sibling_threads(current_cred(), cred);
+
+		if (tsync_err)
+			return tsync_err;
+	}
+
+	return 0;
+}
 
 static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 889f4b30301a..0facc5cb6555 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -11,6 +11,8 @@
 
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/landlock.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
@@ -20,6 +22,8 @@
 #include "limits.h"
 #include "object.h"
 
+extern const struct file_operations ruleset_fops;
+
 struct landlock_hierarchy;
 
 /**
@@ -194,6 +198,8 @@ landlock_create_ruleset(const access_mask_t access_mask_fs,
 			const access_mask_t access_mask_net,
 			const access_mask_t scope_mask);
 
+void landlock_get_ruleset(struct landlock_ruleset *ruleset);
+
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 
@@ -204,6 +210,13 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access);
 
+int landlock_restrict_cred_precheck(const __u32 flags,
+				    const bool in_task_context);
+
+int landlock_restrict_cred(struct cred *const cred,
+			   struct landlock_ruleset *const ruleset,
+			   const __u32 flags);
+
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
@@ -212,12 +225,6 @@ const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id);
 
-static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
-{
-	if (ruleset)
-		refcount_inc(&ruleset->usage);
-}
-
 /**
  * landlock_union_access_masks - Return all access rights handled in the
  *				 domain
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..c710e8b16150 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -121,42 +121,6 @@ static void build_check_abi(void)
 
 /* Ruleset handling */
 
-static int fop_ruleset_release(struct inode *const inode,
-			       struct file *const filp)
-{
-	struct landlock_ruleset *ruleset = filp->private_data;
-
-	landlock_put_ruleset(ruleset);
-	return 0;
-}
-
-static ssize_t fop_dummy_read(struct file *const filp, char __user *const buf,
-			      const size_t size, loff_t *const ppos)
-{
-	/* Dummy handler to enable FMODE_CAN_READ. */
-	return -EINVAL;
-}
-
-static ssize_t fop_dummy_write(struct file *const filp,
-			       const char __user *const buf, const size_t size,
-			       loff_t *const ppos)
-{
-	/* Dummy handler to enable FMODE_CAN_WRITE. */
-	return -EINVAL;
-}
-
-/*
- * A ruleset file descriptor enables to build a ruleset by adding (i.e.
- * writing) rule after rule, without relying on the task's context.  This
- * reentrant design is also used in a read way to enforce the ruleset on the
- * current task.
- */
-static const struct file_operations ruleset_fops = {
-	.release = fop_ruleset_release,
-	.read = fop_dummy_read,
-	.write = fop_dummy_write,
-};
-
 /*
  * The Landlock ABI version should be incremented for each new Landlock-related
  * user space visible change (e.g. Landlock syscalls).  This version should
@@ -264,31 +228,6 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
-/*
- * Returns an owned ruleset from a FD. It is thus needed to call
- * landlock_put_ruleset() on the return value.
- */
-static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
-						    const fmode_t mode)
-{
-	CLASS(fd, ruleset_f)(fd);
-	struct landlock_ruleset *ruleset;
-
-	if (fd_empty(ruleset_f))
-		return ERR_PTR(-EBADF);
-
-	/* Checks FD type and access right. */
-	if (fd_file(ruleset_f)->f_op != &ruleset_fops)
-		return ERR_PTR(-EBADFD);
-	if (!(fd_file(ruleset_f)->f_mode & mode))
-		return ERR_PTR(-EPERM);
-	ruleset = fd_file(ruleset_f)->private_data;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1))
-		return ERR_PTR(-EINVAL);
-	landlock_get_ruleset(ruleset);
-	return ruleset;
-}
-
 /* Path handling */
 
 /*
@@ -437,7 +376,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+	ruleset = landlock_get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -487,33 +426,13 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
-	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
-	struct landlock_cred_security *new_llcred;
-	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
-		prev_log_subdomains;
-
-	if (!is_initialized())
-		return -EOPNOTSUPP;
-
-	/*
-	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
-	 */
-	if (!task_no_new_privs(current) &&
-	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
-	    LANDLOCK_MASK_RESTRICT_SELF)
-		return -EINVAL;
+	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
+	int err;
 
-	/* Translates "off" flag to boolean. */
-	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
-	/* Translates "on" flag to boolean. */
-	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
-	/* Translates "off" flag to boolean. */
-	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+	err = landlock_restrict_cred_precheck(flags, true);
+	if (err)
+		return err;
 
 	/*
 	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
@@ -525,7 +444,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
 		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
 		/* Gets and checks the ruleset. */
-		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
+		ruleset = landlock_get_ruleset_from_fd(ruleset_fd,
+						       FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
 			return PTR_ERR(ruleset);
 	}
@@ -535,57 +455,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!new_cred)
 		return -ENOMEM;
 
-	new_llcred = landlock_cred(new_cred);
-
-#ifdef CONFIG_AUDIT
-	prev_log_subdomains = !new_llcred->log_subdomains_off;
-	new_llcred->log_subdomains_off = !prev_log_subdomains ||
-					 !log_subdomains;
-#endif /* CONFIG_AUDIT */
-
-	/*
-	 * The only case when a ruleset may not be set is if
-	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set (optionally with
-	 * LANDLOCK_RESTRICT_SELF_TSYNC) and ruleset_fd is -1.  We could
-	 * optimize this case by not calling commit_creds() if this flag was
-	 * already set, but it is not worth the complexity.
-	 */
-	if (ruleset) {
-		/*
-		 * There is no possible race condition while copying and
-		 * manipulating the current credentials because they are
-		 * dedicated per thread.
-		 */
-		struct landlock_ruleset *const new_dom =
-			landlock_merge_ruleset(new_llcred->domain, ruleset);
-		if (IS_ERR(new_dom)) {
-			abort_creds(new_cred);
-			return PTR_ERR(new_dom);
-		}
-
-#ifdef CONFIG_AUDIT
-		new_dom->hierarchy->log_same_exec = log_same_exec;
-		new_dom->hierarchy->log_new_exec = log_new_exec;
-		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
-			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
-#endif /* CONFIG_AUDIT */
-
-		/* Replaces the old (prepared) domain. */
-		landlock_put_ruleset(new_llcred->domain);
-		new_llcred->domain = new_dom;
-
-#ifdef CONFIG_AUDIT
-		new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
-#endif /* CONFIG_AUDIT */
-	}
-
-	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
-		const int err = landlock_restrict_sibling_threads(
-			current_cred(), new_cred);
-		if (err) {
-			abort_creds(new_cred);
-			return err;
-		}
+	err = landlock_restrict_cred(new_cred, ruleset, flags);
+	if (err) {
+		abort_creds(new_cred);
+		return err;
 	}
 
 	return commit_creds(new_cred);
-- 
2.53.0

