Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1FB205AC7
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163501; cv=none; b=rML1scCw9/DYNOKfdSg3I20GfqNHleL+ed4+GfdiE9sPBQl3ZMKGCjR5uM5c4uPYsmGe3v84W/3QRZBYlibh+EjFWmvEJLPl35g0RycPVrRXD+BgBvCtKiupZbw975Fs7mL0hxnr7XKbdPHjkWQtsfIebUx0sXzn3099Dai8i+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163501; c=relaxed/simple;
	bh=N34LzUlZ5vwZa8WSNSMi6G9gFQ/sDGxg870X3H47PhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDRp9LtVnVOdtWa+Epo5S66wiEBpXDMr+mOqQEwg4SLNdPDFgpUwZhLhsJb8hnxczMlNBlwvMslNFDFZLKHldKzL6A5wr29rcRaC9ncYVzkm/wfRm2TQ0ffz57kWMhNp8HqsxRcWH2aPv86Z6W8rBVwgmRrESaMrIi2gtWBDJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcAAKqo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcAAKqo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4398738217aso21243435e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740163497; x=1740768297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAH0MR6JnMb7FwW0uQy0XwImpTnXdC80KKTp3Tp2BCo=;
        b=dfcAAKqoHJJesql+smU22h0Jc+yY02E9o0zO9r4OWFyKtaHRVOciErfB13Jj0YtkWT
         RVF3E+Ey2/zSMOs2eT4INFPZOKmhvibd11fd0TTbRg6vXnSxMYgaQZtqwlTXlQrn23h+
         BCKYdFpJAgh7ofvJ/MR7q96tkR7Gal8pM34AenShrzw8P3VMR6eLOR5+y6g6A2MjuYVx
         yPZ5QbQRO8eEAv0q+IW8oRHO76e3DIPsn5D/iGeF/v1enqVFOwi5oReXU3AeiZDKpd0y
         GAB/7SqLJGrJYwrrzKPgyveJu8+BkVssfM+8Hd7Q3RWqEISfNoh/J6YI/c4AYOYw7PrR
         utWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163497; x=1740768297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAH0MR6JnMb7FwW0uQy0XwImpTnXdC80KKTp3Tp2BCo=;
        b=ASVcDaAXLsaRSO1OM0r5ebEgTBDTsQ5oyfUh/2M0X0zInCSOHV83JEq7ZCRhkfco4Q
         UFdxLVadfaPVtK0y+Mgb+HPqQ+nI8Uil7lZDVbYW3cfLAY3ZJkV9Tk3SWvyg3FaWz31W
         nuQorcdqCWIfYb0sJIr/WhFVrA728EggCYRFGCCjhiJLuoeScyhvr1EU9s4y9wTLv4Ph
         VbjEynsrS4d2dXx20NZTUIfWa4zVepjlsJaC0ApDf6EPZs1Pr32dewl0ovnYoy6/q292
         9iOGMkNwwBLBwAJUtNPj60vFZLS0aRJ8vU/VQY2b1BJEOAyu0W5+sroOgWjcZJ4ZY7HV
         XnZw==
X-Gm-Message-State: AOJu0Yy5ku2h2nSEurNWmsSBhSiPwyDcyjUywak1pI2eEyg5o7xNm9jM
	y00WIse1N1BlL4upfjovFNRqVoeTHs0P2qcJ6ePzx27WwN2NOWc6hxNhTw==
X-Gm-Gg: ASbGnctAWGWdOd9zKdMgNWywF1xYuJ+Eed+5/v7hRmU+v2iEJkYVomGCTXZDrNyb8pX
	QAptzH9JtQ+AVu0J8gtZTH/CRdZLY7aHZafVSoc+QprwkPk3qc12HyJLU95XTlTDKMsxquEl9Wa
	FFz88rIDoP4h1gKiZ+u8YWSycG/jIFKcI1IcB5KowSvZjtrS4/V2WRu30kkD2adXH3dGdS307w2
	vU+KGaqnzaRR65gdllXz0nUSmdvQ9Onsx1z2ZRf5EwnmOUJq/U0vSHWP0bJKLJcuRyTwVvj6V5c
	WR2Lj4aApRMjmu4Ru4hqIZsHie4=
X-Google-Smtp-Source: AGHT+IEJMh3A6rhcdkVG5Z2Mch+fTDRFl7T1x0w9dZxNRChlRoygu58n4yiAr+gnWXS39qJLY5wU7g==
X-Received: by 2002:a05:6000:1ac8:b0:38f:3b59:2d80 with SMTP id ffacd0b85a97d-38f6e95e68bmr3855269f8f.19.1740163497252;
        Fri, 21 Feb 2025 10:44:57 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f8602sm24736354f8f.94.2025.02.21.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:44:56 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC 1/2] landlock: Multithreading support for landlock_restrict_self()
Date: Fri, 21 Feb 2025 19:44:17 +0100
Message-ID: <20250221184417.27954-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221184417.27954-2-gnoack3000@gmail.com>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
given Landlock ruleset is applied to all threads of the calling
process, instead of only the current one.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h |  10 ++
 security/landlock/syscalls.c  | 232 +++++++++++++++++++++++++++++++++-
 2 files changed, 237 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f7875..fb971e4e0fb2b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -62,6 +62,16 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
 /* clang-format on */
 
+/*
+ * sys_landlock_restrict_self() flags:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_TSYNC: Apply the given ruleset to all threads of
+ *    the current process.
+ */
+/* clang-format off */
+#define LANDLOCK_RESTRICT_SELF_TSYNC			(1U << 0)
+/* clang-format on */
+
 /**
  * enum landlock_rule_type - Landlock rule type
  *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a9760d252fc2d..63792a6cde5ca 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/stddef.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
@@ -425,17 +426,233 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 /* Enforcement */
 
+/*
+ * Shared state between multiple threads which are enforcing Landlock rulesets
+ * in lockstep with each other.
+ */
+struct landlock_tsync_shared_context {
+	/* Expected existing Landlock domain on every thread. */
+	struct landlock_ruleset *old_dom;
+
+	/* Replacement Landlock domain to be applied if prerequisites are met */
+	struct landlock_ruleset *new_dom;
+
+	/* Barrier after preparation step. */
+	atomic_t num_preparing;
+	struct completion all_prepared;
+
+	/* An error encountered in preparation step, or 0. */
+	atomic_t preparation_error;
+
+	/*
+	 * Barrier after commit step (used by syscall impl to wait for
+	 * completion).
+	 */
+	atomic_t num_unfinished;
+	struct completion all_finished;
+};
+
+struct landlock_tsync_context {
+	struct callback_head work;
+	struct landlock_tsync_shared_context *ctx;
+};
+
+static struct cred *
+landlock_prepare_creds(const struct landlock_ruleset *old_dom,
+		       struct landlock_ruleset *new_dom)
+{
+	struct cred *new_cred;
+	struct landlock_cred_security *new_llcred;
+
+	/*
+	 * Similar checks as for seccomp(2), except that an -EPERM may be
+	 * returned.
+	 */
+	if (!task_no_new_privs(current) &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
+
+	/* Prepares new credentials. */
+	new_cred = prepare_creds();
+	if (!new_cred)
+		return ERR_PTR(-ENOMEM);
+
+	new_llcred = landlock_cred(new_cred);
+	if (new_llcred->domain != old_dom) {
+		abort_creds(new_cred);
+		return ERR_PTR(-ESRCH);
+	}
+
+	/* Replaces the old (prepared) domain. */
+	landlock_put_ruleset(new_llcred->domain);
+	landlock_get_ruleset(new_dom);
+	new_llcred->domain = new_dom;
+
+	return new_cred;
+}
+
+/*
+ * restrict_one_thread - update a thread's Landlock domain in lockstep with the
+ * other threads in the same process.
+ *
+ * When this is run, the same function gets run in all other threads in the same
+ * process.  The concurrently running function invocations coordinate to wait
+ * until they are all done with the preparation step and have reported back
+ * errors from the preparation step, if necessary.
+ *
+ * Afterwards, depending on the presence of an error, all threads either commit
+ * or abort the prepared credentials.  The commit operation can not fail any more.
+ */
+static void restrict_one_thread(struct landlock_tsync_shared_context *ctx)
+{
+	int res;
+	struct cred *cred = landlock_prepare_creds(ctx->old_dom, ctx->new_dom);
+
+	/* On error, set the error and continue. (Do not return early.) */
+	if (IS_ERR(cred))
+		atomic_set(&ctx->preparation_error, PTR_ERR(cred));
+
+	/*
+	 * Barrier: Wait until all threads are done preparing.
+	 * After this point, we can have no more failures.
+	 */
+	if (atomic_dec_return(&ctx->num_preparing) == 0)
+		complete_all(&ctx->all_prepared);
+	wait_for_completion(&ctx->all_prepared);
+
+	/*
+	 * Abort the commit if any of the threads had an error.
+	 * (It might also be this thread.)  Otherwise, commit.
+	 */
+	res = atomic_read(&ctx->preparation_error);
+	if (res) {
+		if (!IS_ERR(cred))
+			abort_creds(cred);
+	} else {
+		commit_creds(cred);
+	}
+
+	/* Notify the calling thread once all threads are done */
+	if (atomic_dec_return(&ctx->num_unfinished) == 0)
+		complete_all(&ctx->all_finished);
+}
+
+/*
+ * restrict_one_thread_callback - task_work callback for restricting a thread
+ *
+ * Calls restrict_one_thread with the struct landlock_shared_tsync_context
+ * and frees up the per-work_task landlock_tsync_context afterwards.
+ */
+static void restrict_one_thread_callback(struct callback_head *work)
+{
+	struct landlock_tsync_context *ctx =
+		container_of(work, struct landlock_tsync_context, work);
+	struct landlock_tsync_shared_context *sctx = ctx->ctx;
+
+	restrict_one_thread(sctx);
+	kfree(ctx);
+}
+
+/*
+ * restrict_all_threads - enables a Landlock policy for all threads
+ */
+static int restrict_all_threads(const int ruleset_fd)
+{
+	int res;
+	struct task_struct *thread, *caller;
+	struct landlock_tsync_shared_context sctx;
+	struct landlock_ruleset *ruleset;
+
+	/*
+	 * XXX: Need to double check race conditions and deadlocks before
+	 * merging this upstream. We probably need additional locking.
+	 */
+
+	/* Starting with 1, as we're already counting current. */
+	atomic_set(&sctx.num_preparing, 1);
+	atomic_set(&sctx.num_unfinished, 1);
+	init_completion(&sctx.all_prepared);
+	init_completion(&sctx.all_finished);
+	atomic_set(&sctx.preparation_error, 0);
+	sctx.old_dom = landlock_get_current_domain();
+
+	/* Gets and checks the ruleset. */
+	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	/*
+	 * We pre-merge the domain for all threads,
+	 * so that all threads end up with exactly the same domain.
+	 */
+	sctx.new_dom = landlock_merge_ruleset(sctx.old_dom, ruleset);
+	landlock_put_ruleset(ruleset);
+	if (IS_ERR(sctx.new_dom))
+		return PTR_ERR(sctx.new_dom);
+
+	landlock_get_ruleset(sctx.old_dom);
+
+	caller = current;
+	for_each_thread(caller, thread) {
+		/* Skip current, since it is initiating the sync. */
+		if (thread == caller)
+			continue;
+
+		/* Skip exited threads. */
+		if (thread->flags & PF_EXITING)
+			continue;
+
+		/* Deallocation is done by the task_work itself. */
+		struct landlock_tsync_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+		if (!ctx) {
+			/*
+			 * On error, keep already started threads from
+			 * accidentally committing.  Do not start additional
+			 * threads.
+			 */
+			atomic_set(&sctx.preparation_error, -ENOMEM);
+			break;
+		}
+
+		ctx->ctx = &sctx;
+		atomic_inc(&sctx.num_preparing);
+		atomic_inc(&sctx.num_unfinished);
+		init_task_work(&ctx->work, restrict_one_thread_callback);
+		res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
+		if (res) {
+			atomic_set(&sctx.preparation_error, res);
+			atomic_dec(&sctx.num_preparing);
+			atomic_dec(&sctx.num_unfinished);
+		}
+	}
+
+	/* and do the same on the current thread */
+	restrict_one_thread(&sctx);
+
+	res = atomic_read(&sctx.preparation_error);
+	wait_for_completion(&sctx.all_finished);
+	landlock_put_ruleset(sctx.new_dom);
+	landlock_put_ruleset(sctx.old_dom);
+	return res;
+}
+
 /**
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
  * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
- * @flags: Must be 0.
+ * @flags: Flags to modify the behavior.
  *
- * This system call enables to enforce a Landlock ruleset on the current
- * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
+ * This system call enforces a Landlock ruleset on the current thread.
+ * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
+ * If %LANDLOCK_RESTRICT_SELF_TSYNC is specified in @flags, the ruleset will be
+ * applied to all threads of the current process.  For this, all threads must be
+ * in the same Landlock domain and fulfill the normal requirements for enforcing
+ * a Landlock ruleset.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -447,6 +664,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *   %CAP_SYS_ADMIN in its namespace.
  * - %E2BIG: The maximum number of stacked rulesets is reached for the current
  *   thread.
+ * - %ESRCH: When called with %LANDLOCK_RESTRICT_SELF_TSYNC, the processes'
+ *   threads were in different Landlock domains.
  */
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
@@ -467,10 +686,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* No flag for now. */
-	if (flags)
+	/* TSYNC is the only supported flag. */
+	if (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC)
 		return -EINVAL;
 
+	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC)
+		return restrict_all_threads(ruleset_fd);
+
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 	if (IS_ERR(ruleset))
-- 
2.48.1

