Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2363314A9
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244328; cv=none; b=QztFSlMj6BF5YMZnBUx6Buug+HgYJj8Iu74ViR4XvQ4ResaixfzzmrFUZWCmuzxS2jSChMevEBdyfjM7yUUA9Y6SdAcoFBSuFOIxQnMAShvHcawFRUyEfPuXUscpsuTgwRD7v0fcUTq2OyDE+Uduj5lHP4uGYFAkIpVRq6/DLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244328; c=relaxed/simple;
	bh=FraNQu6BullGlFwAO6uhSrvccDXGVK1IhPX21vu5aM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfbXMgfGPziVqkI5rxigAMjTnCDCJJdY8jQdT9K7uWGtMey6WDscHZHwMZX9KlGx4shMe+8xSq9WPaMpMO/23QhMEcy7RbHId0NMXYOOKz2/DOOCWFU1fYS7DqzEsM181Kqn0LCa6lzKVs3ppA0zZFqfpm68nX/AGgFrtfPuoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39/la5gf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39/la5gf"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so4186745e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764244324; x=1764849124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPiqeMXIUtdQb/QViVt624yxWv4PPX7x1djqLZ8ypUU=;
        b=39/la5gfn4okvsf+gMxOLbX72L7/rlHiRrwa+1+XDwBceRRCtkYsGahzQ7KqxnMPLF
         QBNUAxuQ1NiLd4ZBV4c4/bI4LVN1nw37SIPuPemK1OmMcwkq/SbkJhV3IuerPl5gbBNX
         dhFKZOus6L50MphPCIkZlOvJshx6Yv8M/lR62Q0ei4jSNCgtuYrkgCMl5Da8JHusuS8V
         N9s+swivd3mVVg30zP3AkvWcaouyzMxDmytvDewuSFCyTLJarl5LdKE1vTy8Tomcet5c
         HgMi2LUSACGmGw9nBfowCS+rBNC4Pu43Kb8L96GGEsyXdQ2S0VAW4v1bE6IcGQNtO+dr
         4KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244324; x=1764849124;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TPiqeMXIUtdQb/QViVt624yxWv4PPX7x1djqLZ8ypUU=;
        b=Ep6/9nfEF3u+Z/tu0FXV1IlIxbzaD6ROsJakf56M7vu2j6p+p19SmDSK7LpVXjORLt
         +8P3esJYwTtQ8tqKlSbNDBrnUaRHhZFNlA4WXWxwlTRqLHbUIgCTk3li6cW+BtvRdhcb
         iwPNAmAi1DmBoAVNiQ2l/5X+HApCNq4QKoIGaGwQyqacr9g1GA37+cke/0CCU9OsujXC
         IjsM6ZwcDCYGpsGT3YrM9MdExnc+O92OtuPwJ+NClkwZEhTH8fDXQKtXwSEU3AK256Bz
         nUJVK9lpswojUSD/tddXn/BURzJ5zCGe8ci3fJcKZ32lV9/9s0JpexO8hBGb/jThVTi2
         56DA==
X-Gm-Message-State: AOJu0YxOWWaKmOzV9vnUs4Sff74OsAGzuT6/4IhdjlhvPpMrdm1ix8EB
	YoGQc+KMUIRPOgiMiRq8bZe9DXOrE3M600p5dES4p6HgskkbfQQ1CeTCUMPJEa9mDBK9JavOEUd
	vgugSESwUw3sfLiiZ51V1nOo8wgc+IehKSfOBU6KMVNu86ECPlsTjKYNwePPGTbfQkVf7RX1fu7
	Ew5pupj666xXxV+Y0IUOoSFLSN615NLYkJTwdaovR+NQ1iuSNBg9cA9gEZ
X-Google-Smtp-Source: AGHT+IHQAW4eAAviG21FSzcVZ8OEejuSMfUcS6x1wjPgyU38njqgBn5GvFpx6cudUh1kc3O3T99UQp7tUxI=
X-Received: from wrtl3.prod.google.com ([2002:a5d:4bc3:0:b0:42c:c2d6:294])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:26cf:b0:42b:3e0a:649e
 with SMTP id ffacd0b85a97d-42cc1ced8cdmr22439721f8f.13.1764244323619; Thu, 27
 Nov 2025 03:52:03 -0800 (PST)
Date: Thu, 27 Nov 2025 12:51:34 +0100
In-Reply-To: <20251127115136.3064948-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127115136.3064948-1-gnoack@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251127115136.3064948-2-gnoack@google.com>
Subject: [PATCH v3 1/3] landlock: Multithreading support for landlock_restrict_self()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, "Andrew G. Morgan" <morgan@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
given Landlock ruleset is applied to all threads of the calling
process, instead of only the current one.

Without this flag, multithreaded userspace programs currently resort
to using the nptl(7)/libpsx hack for multithreaded policy enforcement,
which is also used by libcap and for setuid(2).  Using this
userspace-based scheme, the threads of a process enforce the same
Landlock policy, but the resulting Landlock domains are still
separate.  The domains being separate causes multiple problems:

* When using Landlock's "scoped" access rights, the domain identity is
  used to determine whether an operation is permitted.  As a result,
  when using LANLDOCK_SCOPE_SIGNAL, signaling between sibling threads
  stops working.  This is a problem for programming languages and
  frameworks which are inherently multithreaded (e.g. Go).

* In audit logging, the domains of separate threads in a process will
  get logged with different domain IDs, even when they are based on
  the same ruleset FD, which migth confuse users.

Cc: Andrew G. Morgan <morgan@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                |  13 +
 security/landlock/Makefile                   |   2 +-
 security/landlock/cred.h                     |  12 +
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |  66 ++-
 security/landlock/tsync.c                    | 555 +++++++++++++++++++
 security/landlock/tsync.h                    |  16 +
 tools/testing/selftests/landlock/base_test.c |   2 +-
 8 files changed, 638 insertions(+), 30 deletions(-)
 create mode 100644 security/landlock/tsync.c
 create mode 100644 security/landlock/tsync.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..a60793767c4b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -117,11 +117,24 @@ struct landlock_ruleset_attr {
  *     future nested domains, not the one being created. It can also be us=
ed
  *     with a @ruleset_fd value of -1 to mute subdomain logs without creat=
ing a
  *     domain.
+ *
+ * The following flag supports policy enforcement in multithreaded process=
es:
+ *
+ * %LANDLOCK_RESTRICT_SELF_TSYNC
+ *     Applies the new Landlock configuration atomically to all threads of=
 the
+ *     current process, including the Landlock domain and logging
+ *     configuration. This overrides the Landlock configuration of sibling
+ *     threads, irrespective of previously established Landlock domains an=
d
+ *     logging configurations on these threads.
+ *
+ *     If the calling thread is running with no_new_privs, this operation
+ *     enables no_new_privs on the sibling threads as well.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
+#define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 3160c2bdac1d..74122f814cf6 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) :=3D landlock.o
=20
-landlock-y :=3D setup.o syscalls.o object.o ruleset.o \
+landlock-y :=3D setup.o syscalls.o tsync.o object.o ruleset.o \
 	cred.o task.o fs.o
=20
 landlock-$(CONFIG_INET) +=3D net.o
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c82fe63ec598..c10a06727eb1 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -26,6 +26,8 @@
  * This structure is packed to minimize the size of struct
  * landlock_file_security.  However, it is always aligned in the LSM cred =
blob,
  * see lsm_set_blob_size().
+ *
+ * When updating this, also update landlock_cred_copy() if needed.
  */
 struct landlock_cred_security {
 	/**
@@ -65,6 +67,16 @@ landlock_cred(const struct cred *cred)
 	return cred->security + landlock_blob_sizes.lbs_cred;
 }
=20
+static inline void landlock_cred_copy(struct landlock_cred_security *dst,
+				      const struct landlock_cred_security *src)
+{
+	landlock_put_ruleset(dst->domain);
+
+	*dst =3D *src;
+
+	landlock_get_ruleset(src->domain);
+}
+
 static inline struct landlock_ruleset *landlock_get_current_domain(void)
 {
 	return landlock_cred(current_cred())->domain;
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..eb584f47288d 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -31,7 +31,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
=20
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_=
OFF
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - =
1)
=20
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..22b6200283f3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -36,6 +36,7 @@
 #include "net.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "tsync.h"
=20
 static bool is_initialized(void)
 {
@@ -161,7 +162,7 @@ static const struct file_operations ruleset_fops =3D {
  * Documentation/userspace-api/landlock.rst should be updated to reflect t=
he
  * UAPI change.
  */
-const int landlock_abi_version =3D 7;
+const int landlock_abi_version =3D 8;
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -454,9 +455,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_=
fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
+ *         - %LANDLOCK_RESTRICT_SELF_TSYNC
  *
- * This system call enables to enforce a Landlock ruleset on the current
- * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN =
in its
+ * This system call enforces a Landlock ruleset on the current thread.
+ * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
@@ -484,6 +486,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, rule=
set_fd, const __u32,
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
 		prev_log_subdomains;
+	int err;
=20
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -538,33 +541,42 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ru=
leset_fd, const __u32,
 	 * We could optimize this case by not calling commit_creds() if this flag
 	 * was already set, but it is not worth the complexity.
 	 */
-	if (!ruleset)
-		return commit_creds(new_cred);
+	if (ruleset) {
+		/*
+		 * There is no possible race condition while copying and
+		 * manipulating the current credentials because they are
+		 * dedicated per thread.
+		 */
+		new_dom =3D landlock_merge_ruleset(new_llcred->domain, ruleset);
+		if (IS_ERR(new_dom)) {
+			abort_creds(new_cred);
+			return PTR_ERR(new_dom);
+		}
=20
-	/*
-	 * There is no possible race condition while copying and manipulating
-	 * the current credentials because they are dedicated per thread.
-	 */
-	new_dom =3D landlock_merge_ruleset(new_llcred->domain, ruleset);
-	if (IS_ERR(new_dom)) {
-		abort_creds(new_cred);
-		return PTR_ERR(new_dom);
+#ifdef CONFIG_AUDIT
+		new_dom->hierarchy->log_same_exec =3D log_same_exec;
+		new_dom->hierarchy->log_new_exec =3D log_new_exec;
+		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
+			new_dom->hierarchy->log_status =3D LANDLOCK_LOG_DISABLED;
+#endif /* CONFIG_AUDIT */
+
+		/* Replaces the old (prepared) domain. */
+		landlock_put_ruleset(new_llcred->domain);
+		new_llcred->domain =3D new_dom;
+
+#ifdef CONFIG_AUDIT
+		new_llcred->domain_exec |=3D BIT(new_dom->num_layers - 1);
+#endif /* CONFIG_AUDIT */
 	}
=20
-#ifdef CONFIG_AUDIT
-	new_dom->hierarchy->log_same_exec =3D log_same_exec;
-	new_dom->hierarchy->log_new_exec =3D log_new_exec;
-	if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
-		new_dom->hierarchy->log_status =3D LANDLOCK_LOG_DISABLED;
-#endif /* CONFIG_AUDIT */
-
-	/* Replaces the old (prepared) domain. */
-	landlock_put_ruleset(new_llcred->domain);
-	new_llcred->domain =3D new_dom;
-
-#ifdef CONFIG_AUDIT
-	new_llcred->domain_exec |=3D BIT(new_dom->num_layers - 1);
-#endif /* CONFIG_AUDIT */
+	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
+		err =3D landlock_restrict_sibling_threads(current_cred(),
+							new_cred);
+		if (err !=3D 0) {
+			abort_creds(new_cred);
+			return err;
+		}
+	}
=20
 	return commit_creds(new_cred);
 }
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
new file mode 100644
index 000000000000..a8db75259a8c
--- /dev/null
+++ b/security/landlock/tsync.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Cross-thread ruleset enforcement
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/task_work.h>
+
+#include "cred.h"
+#include "tsync.h"
+
+/*
+ * Shared state between multiple threads which are enforcing Landlock rule=
sets
+ * in lockstep with each other.
+ */
+struct tsync_shared_context {
+	/* The old and tentative new creds of the calling thread. */
+	const struct cred *old_cred;
+	const struct cred *new_cred;
+
+	/* True if sibling tasks need to set the no_new_privs flag. */
+	bool set_no_new_privs;
+
+	/* An error encountered in preparation step, or 0. */
+	atomic_t preparation_error;
+
+	/*
+	 * Barrier after preparation step in restrict_one_thread.
+	 * The calling thread waits for completion.
+	 *
+	 * Re-initialized on every round of looking for newly spawned threads.
+	 */
+	atomic_t num_preparing;
+	struct completion all_prepared;
+
+	/* Sibling threads wait for completion. */
+	struct completion ready_to_commit;
+
+	/*
+	 * Barrier after commit step (used by syscall impl to wait for
+	 * completion).
+	 */
+	atomic_t num_unfinished;
+	struct completion all_finished;
+};
+
+struct tsync_work {
+	struct callback_head work;
+	struct task_struct *task;
+	struct tsync_shared_context *shared_ctx;
+};
+
+/*
+ * restrict_one_thread - update a thread's Landlock domain in lockstep wit=
h the
+ * other threads in the same process
+ *
+ * When this is run, the same function gets run in all other threads in th=
e same
+ * process (except for the calling thread which called landlock_restrict_s=
elf).
+ * The concurrently running invocations of restrict_one_thread coordinate
+ * through the shared ctx object to do their work in lockstep to implement
+ * all-or-nothing semantics for enforcing the new Landlock domain.
+ *
+ * Afterwards, depending on the presence of an error, all threads either c=
ommit
+ * or abort the prepared credentials.  The commit operation can not fail a=
ny more.
+ */
+static void restrict_one_thread(struct tsync_shared_context *ctx)
+{
+	int err;
+	struct cred *cred =3D NULL;
+
+	if (current_cred() =3D=3D ctx->old_cred) {
+		/*
+		 * Switch out old_cred with new_cred, if possible.
+		 *
+		 * In the common case, where all threads initially point to the
+		 * same struct cred, this optimization avoids creating separate
+		 * redundant credentials objects for each, which would all have
+		 * the same contents.
+		 *
+		 * Note: We are intentionally dropping the const qualifier here,
+		 * because it is required by commit_creds() and abort_creds().
+		 */
+		cred =3D (struct cred *)get_cred(ctx->new_cred);
+	} else {
+		/* Else, prepare new creds and populate them. */
+		cred =3D prepare_creds();
+
+		if (!cred) {
+			atomic_set(&ctx->preparation_error, -ENOMEM);
+
+			/*
+			 * Even on error, we need to adhere to the protocol and
+			 * coordinate with concurrently running invocations.
+			 */
+			if (atomic_dec_return(&ctx->num_preparing) =3D=3D 0)
+				complete_all(&ctx->all_prepared);
+
+			goto out;
+		}
+
+		landlock_cred_copy(landlock_cred(cred),
+				   landlock_cred(ctx->new_cred));
+	}
+
+	/*
+	 * Barrier: Wait until all threads are done preparing.
+	 * After this point, we can have no more failures.
+	 */
+	if (atomic_dec_return(&ctx->num_preparing) =3D=3D 0)
+		complete_all(&ctx->all_prepared);
+
+	/*
+	 * Wait for signal from calling thread that it's safe to read the
+	 * preparation error now and we are ready to commit (or abort).
+	 */
+	wait_for_completion(&ctx->ready_to_commit);
+
+	/* Abort the commit if any of the other threads had an error. */
+	err =3D atomic_read(&ctx->preparation_error);
+	if (err) {
+		abort_creds(cred);
+		goto out;
+	}
+
+	/*
+	 * Make sure that all sibling tasks fulfill the no_new_privs
+	 * prerequisite.  (This is in line with Seccomp's
+	 * SECCOMP_FILTER_FLAG_TSYNC logic in kernel/seccomp.c.)
+	 */
+	if (ctx->set_no_new_privs)
+		task_set_no_new_privs(current);
+
+	commit_creds(cred);
+
+out:
+	/* Notify the calling thread once all threads are done */
+	if (atomic_dec_return(&ctx->num_unfinished) =3D=3D 0)
+		complete_all(&ctx->all_finished);
+}
+
+/*
+ * restrict_one_thread_callback - task_work callback for restricting a thr=
ead
+ *
+ * Calls restrict_one_thread with the struct landlock_shared_tsync_context=
.
+ */
+static void restrict_one_thread_callback(struct callback_head *work)
+{
+	struct tsync_work *ctx =3D container_of(work, struct tsync_work, work);
+
+	restrict_one_thread(ctx->shared_ctx);
+}
+
+/*
+ * struct tsync_works - a growable array of per-task contexts
+ *
+ * The zero-initialized struct represents the empty array.
+ */
+struct tsync_works {
+	struct tsync_work **works;
+	size_t size;
+	size_t capacity;
+};
+
+/*
+ * tsync_works_provide - provides a preallocated tsync_work for the given =
task
+ *
+ * This also stores a task pointer in the context and increments the refer=
ence
+ * count of the task.
+ *
+ * This function may fail in the case where we did not preallocate suffici=
ent
+ * capacity.  This can legitimately happen if new threads get started afte=
r we
+ * grew the capacity.
+ *
+ * Returns:
+ *   A pointer to the preallocated context struct, with task filled in.
+ *
+ *   NULL, if we ran out of preallocated context structs.
+ */
+static struct tsync_work *tsync_works_provide(struct tsync_works *s,
+					      struct task_struct *task)
+{
+	struct tsync_work *ctx;
+
+	if (s->size >=3D s->capacity)
+		return NULL;
+
+	ctx =3D s->works[s->size];
+	s->size++;
+
+	ctx->task =3D get_task_struct(task);
+	return ctx;
+}
+
+/*
+ * tsync_works_grow_by - preallocates space for n more contexts in s
+ *
+ * On a successful return, the subsequent n calls to tsync_works_provide()=
 are
+ * guaranteed to succeed.  (size + n <=3D capacity)
+ *
+ * Returns:
+ *   -ENOMEM if the (re)allocation fails
+ *   0       if the allocation succeeds, partially succeeds, or no realloc=
ation was needed
+ */
+static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flag=
s)
+{
+	size_t i;
+	size_t new_capacity;
+	struct tsync_work **works;
+	struct tsync_work *work;
+
+	if (check_add_overflow(s->size, n, &new_capacity))
+		return -EOVERFLOW;
+
+	/* No need to reallocate if s already has sufficient capacity. */
+	if (new_capacity <=3D s->capacity)
+		return 0;
+
+	works =3D krealloc_array(s->works, new_capacity, sizeof(s->works[0]),
+			       flags);
+	if (!works)
+		return -ENOMEM;
+
+	s->works =3D works;
+
+	for (i =3D s->capacity; i < new_capacity; i++) {
+		work =3D kzalloc(sizeof(*work), flags);
+		if (!work) {
+			/*
+			 * Leave the object in a consistent state,
+			 * but return an error.
+			 */
+			s->capacity =3D i;
+			return -ENOMEM;
+		}
+		s->works[i] =3D work;
+	}
+	s->capacity =3D new_capacity;
+	return 0;
+}
+
+/*
+ * tsync_works_contains - checks for presence of task in s
+ */
+static bool tsync_works_contains_task(const struct tsync_works *s,
+				      struct task_struct *task)
+{
+	size_t i;
+
+	for (i =3D 0; i < s->size; i++)
+		if (s->works[i]->task =3D=3D task)
+			return true;
+	return false;
+}
+
+/*
+ * tsync_works_release - frees memory held by s and drops all task referen=
ces
+ *
+ * This does not free s itself, only the data structures held by it.
+ */
+static void tsync_works_release(struct tsync_works *s)
+{
+	size_t i;
+
+	for (i =3D 0; i < s->size; i++) {
+		if (!s->works[i]->task)
+			continue;
+
+		put_task_struct(s->works[i]->task);
+	}
+
+	for (i =3D 0; i < s->capacity; i++)
+		kfree(s->works[i]);
+	kfree(s->works);
+	s->works =3D NULL;
+	s->size =3D 0;
+	s->capacity =3D 0;
+}
+
+/*
+ * count_additional_threads - counts the sibling threads that are not in w=
orks
+ */
+static size_t count_additional_threads(const struct tsync_works *works)
+{
+	struct task_struct *thread, *caller;
+	size_t n =3D 0;
+
+	caller =3D current;
+
+	guard(rcu)();
+
+	for_each_thread(caller, thread) {
+		/* Skip current, since it is initiating the sync. */
+		if (thread =3D=3D caller)
+			continue;
+
+		/* Skip exited threads. */
+		if (thread->flags & PF_EXITING)
+			continue;
+
+		/* Skip threads that we have already seen. */
+		if (tsync_works_contains_task(works, thread))
+			continue;
+
+		n++;
+	}
+	return n;
+}
+
+/*
+ * schedule_task_work - adds task_work for all eligible sibling threads
+ *                      which have not been scheduled yet
+ *
+ * For each added task_work, atomically increments shared_ctx->num_prepari=
ng and
+ * shared_ctx->num_unfinished.
+ *
+ * Returns:
+ *     true, if at least one eligible sibling thread was found
+ */
+static bool schedule_task_work(struct tsync_works *works,
+			       struct tsync_shared_context *shared_ctx)
+{
+	int err;
+	struct task_struct *thread, *caller;
+	struct tsync_work *ctx;
+	bool found_more_threads =3D false;
+
+	caller =3D current;
+
+	guard(rcu)();
+
+	for_each_thread(caller, thread) {
+		/* Skip current, since it is initiating the sync. */
+		if (thread =3D=3D caller)
+			continue;
+
+		/* Skip exited threads. */
+		if (thread->flags & PF_EXITING)
+			continue;
+
+		/* Skip threads that we already looked at. */
+		if (tsync_works_contains_task(works, thread))
+			continue;
+
+		/*
+		 * We found a sibling thread that is not doing its task_work
+		 * yet, and which might spawn new threads before our task work
+		 * runs, so we need at least one more round in the outer loop.
+		 */
+		found_more_threads =3D true;
+
+		ctx =3D tsync_works_provide(works, thread);
+		if (!ctx) {
+			/*
+			 * We ran out of preallocated contexts -- we need to try
+			 * again with this thread at a later time!
+			 * found_more_threads is already true at this point.
+			 */
+			break;
+		}
+
+		ctx->shared_ctx =3D shared_ctx;
+
+		atomic_inc(&shared_ctx->num_preparing);
+		atomic_inc(&shared_ctx->num_unfinished);
+
+		init_task_work(&ctx->work, restrict_one_thread_callback);
+		err =3D task_work_add(thread, &ctx->work, TWA_SIGNAL);
+		if (err) {
+			/*
+			 * task_work_add() only fails if the task is about to
+			 * exit.  We checked that earlier, but it can happen as
+			 * a race.  Resume without setting an error, as the task
+			 * is probably gone in the next loop iteration.  For
+			 * consistency, remove the task from ctx so that it does
+			 * not look like we handed it a task_work.
+			 */
+			put_task_struct(ctx->task);
+			ctx->task =3D NULL;
+
+			atomic_dec(&shared_ctx->num_preparing);
+			atomic_dec(&shared_ctx->num_unfinished);
+		}
+	}
+
+	return found_more_threads;
+}
+
+/*
+ * cancel_tsync_works - cancel all task works where it is possible
+ *
+ * Task works can be canceled as long as they are still queued and have no=
t
+ * started running.  If they get canceled, we decrement
+ * shared_ctx->num_preparing and shared_ctx->num_unfished and mark the two
+ * completions if needed, as if the task was never scheduled.
+ */
+static void cancel_tsync_works(struct tsync_works *works,
+			       struct tsync_shared_context *shared_ctx)
+{
+	int i;
+
+	for (i =3D 0; i < works->size; i++) {
+		if (!task_work_cancel(works->works[i]->task,
+				      &works->works[i]->work))
+			continue;
+
+		/* After dequeueing, act as if the task work had executed. */
+
+		if (atomic_dec_return(&shared_ctx->num_preparing) =3D=3D 0)
+			complete_all(&shared_ctx->all_prepared);
+
+		if (atomic_dec_return(&shared_ctx->num_unfinished) =3D=3D 0)
+			complete_all(&shared_ctx->all_finished);
+	}
+}
+
+/*
+ * restrict_sibling_threads - enables a Landlock policy for all sibling th=
reads
+ */
+int landlock_restrict_sibling_threads(const struct cred *old_cred,
+				      const struct cred *new_cred)
+{
+	int err;
+	struct tsync_shared_context shared_ctx;
+	struct tsync_works works =3D {};
+	size_t newly_discovered_threads;
+	bool found_more_threads;
+
+	atomic_set(&shared_ctx.preparation_error, 0);
+	init_completion(&shared_ctx.all_prepared);
+	init_completion(&shared_ctx.ready_to_commit);
+	atomic_set(&shared_ctx.num_unfinished, 1);
+	init_completion(&shared_ctx.all_finished);
+	shared_ctx.old_cred =3D old_cred;
+	shared_ctx.new_cred =3D new_cred;
+	shared_ctx.set_no_new_privs =3D task_no_new_privs(current);
+
+	/*
+	 * We schedule a pseudo-signal task_work for each of the calling task's
+	 * sibling threads.  In the task work, each thread:
+	 *
+	 * 1) runs prepare_creds() and writes back the error to
+	 *    shared_ctx.preparation_error, if needed.
+	 *
+	 * 2) signals that it's done with prepare_creds() to the calling task.
+	 *    (completion "all_prepared").
+	 *
+	 * 3) waits for the completion "ready_to_commit".  This is sent by the
+	 *    calling task after ensuring that all sibling threads have done
+	 *    with the "preparation" stage.
+	 *
+	 *    After this barrier is reached, it's safe to read
+	 *    shared_ctx.preparation_error.
+	 *
+	 * 4) reads shared_ctx.preparation_error and then either does
+	 *    commit_creds() or abort_creds().
+	 *
+	 * 5) signals that it's done altogether (barrier synchronization
+	 *    "all_finished")
+	 *
+	 * Unlike seccomp, which modifies sibling tasks directly, we do not need
+	 * to acquire the cred_guard_mutex and sighand->siglock:
+	 *
+	 * * As in our case, all threads are themselves exchanging their own
+	 *   struct cred through the credentials API, no locks are needed for
+	 *   that.
+	 * * Our for_each_thread() loops are protected by RCU.
+	 * * We do not acquire a lock to keep the list of sibling threads stable
+	 *   between our for_each_thread loops.  If the list of available
+	 *   sibling threads changes between these for_each_thread loops, we
+	 *   make up for that by continuing to look for threads until they are
+	 *   all discovered and have entered their task_work, where they are
+	 *   unable to spawn new threads.
+	 */
+	do {
+		/* In RCU read-lock, count the threads we need. */
+		newly_discovered_threads =3D count_additional_threads(&works);
+
+		if (newly_discovered_threads =3D=3D 0)
+			break; /* done */
+
+		err =3D tsync_works_grow_by(&works, newly_discovered_threads,
+					  GFP_KERNEL_ACCOUNT);
+		if (err) {
+			atomic_set(&shared_ctx.preparation_error, err);
+			break;
+		}
+
+		/*
+		 * The "all_prepared" barrier is used locally to the loop body,
+		 * this use of for_each_thread().  We can reset it on each loop
+		 * iteration because all previous loop iterations are done with
+		 * it already.
+		 *
+		 * num_preparing is initialized to 1 so that the counter can not
+		 * go to 0 and mark the completion as done before all task works
+		 * are registered.  We decrement it at the end of the loop body.
+		 */
+		atomic_set(&shared_ctx.num_preparing, 1);
+		reinit_completion(&shared_ctx.all_prepared);
+
+		/* In RCU read-lock, schedule task work on newly discovered sibling task=
s. */
+		found_more_threads =3D schedule_task_work(&works, &shared_ctx);
+
+		/*
+		 * Decrement num_preparing for current, to undo that we
+		 * initialized it to 1 a few lines above.
+		 */
+		if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
+			if (wait_for_completion_interruptible(
+				    &shared_ctx.all_prepared)) {
+				/*
+				 * In case of interruption, we need to retry the
+				 * system call.
+				 */
+				atomic_set(&shared_ctx.preparation_error,
+					   -ERESTARTNOINTR);
+
+				/*
+				 * Cancel task works for tasks that did not
+				 * start running yet, and decrement all_prepared
+				 * and num_unfinished accordingly.
+				 */
+				cancel_tsync_works(&works, &shared_ctx);
+
+				/*
+				 * The remaining task works have started
+				 * running, so waiting for their completion will
+				 * finish.
+				 */
+				wait_for_completion(&shared_ctx.all_prepared);
+			}
+		}
+	} while (found_more_threads &&
+		 !atomic_read(&shared_ctx.preparation_error));
+
+	/*
+	 * We now have all sibling threads blocking and in "prepared" state in
+	 * the task work. Ask all threads to commit.
+	 */
+	complete_all(&shared_ctx.ready_to_commit);
+
+	/*
+	 * Decrement num_unfinished for current, to undo that we initialized it
+	 * to 1 at the beginning.
+	 */
+	if (atomic_dec_return(&shared_ctx.num_unfinished) > 0)
+		wait_for_completion(&shared_ctx.all_finished);
+
+	tsync_works_release(&works);
+
+	return atomic_read(&shared_ctx.preparation_error);
+}
diff --git a/security/landlock/tsync.h b/security/landlock/tsync.h
new file mode 100644
index 000000000000..b85586db8b51
--- /dev/null
+++ b/security/landlock/tsync.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Cross-thread ruleset enforcement
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#ifndef _SECURITY_LANDLOCK_TSYNC_H
+#define _SECURITY_LANDLOCK_TSYNC_H
+
+#include "cred.h"
+
+int landlock_restrict_sibling_threads(const struct cred *old_cred,
+				      const struct cred *new_cred);
+
+#endif /* _SECURITY_LANDLOCK_TSYNC_H */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 7b69002239d7..f4b1a275d8d9 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
--=20
2.52.0.177.g9f829587af-goog

