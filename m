Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C672581
	for <linux-security-module@vger.kernel.org>; Wed,  1 Oct 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317502; cv=none; b=rgQV51sWrceehWQP3vu/BwoMSYB9UJe4AxFLn5G9gYKKvQLrvqiG/oPii0JaiSZ+s2VsDI6eLtGN/OWxioAE0mD8lezBR9HDH5I0r1OJikki2BJLnV/SCbLGBG5PFI5Z5LGNB2GnrM5AKu75pUiyqkZSjKO6KMDiSfDX1DZAAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317502; c=relaxed/simple;
	bh=YN5mcaa7boS5N9Mi4Obk6Cs2nDlSuFlMESPlQkkIJ74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qzyx1eAsp2wPOEJtfFFTzihM9GHFgrWyGs4XnFBw+QTrIIJk0OugUhshafLNXJK58RZ8t70LA5weGk2LIJyv4TiVMs6KzG9f0Rz8i9SIA1G4hE0B8auORBlmSSaywTOuC0VTUAnSnyQz39t8ITI7qsT5ozidNUXEa5Om4maxbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToHIvQyw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToHIvQyw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e407c600eso31033405e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 Oct 2025 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759317498; x=1759922298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDZ9xHih7No4jMj9IsgYlIXvPocY9BAJ0klGSy8+e54=;
        b=ToHIvQywYypLr5IuLCISn2G7t053a8n4izpFy4tlqZ3vVly1wKua9A+su7cTkldHhg
         HxcAVQNWh8X5ZK2tk/7h5/H4e9qnjkyYVFhqcfZFAt92fID6IlY+EbAQc2vyHZ6mbA8+
         xHH9BPlNHK+vLIh8AwqkR4ktmO9VJ/Y/TfPaXP1sicQs8iMUg/OjrDuS+eAUaR1LXEpi
         sfwoVooEcCjbkNcmJrv0jFwgIkwFnTWQyAZ4kTA5eXjgpbSL8nCEulboyyptgN+RDLa5
         UNuA6N5xLvTpRpgCyIhxpKZOVpn41AkSlPJcCkFaz/xI2yUjz/wq4+3k5gv/3956Lgku
         zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317498; x=1759922298;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDZ9xHih7No4jMj9IsgYlIXvPocY9BAJ0klGSy8+e54=;
        b=orLucF/9b/gEinb4SKaw1l2jHpit0gQSRa3jVYKVEC35pkwvA6rBkcuGjXBxGr6yac
         Mn0kkwv+KbyE+vgEAK61RKbPJv6PVo6tKlubMBSul6WCzpPVtCtgkqrY4c4JBjAsP6/8
         Mh1fy+2nLlc9ImTolpcNuORgLE0NEOngr8zdUKtCsBkdXSd1ZIDu1E83uQFauVQ1XY2B
         CHKFp6bBZcmkqzdhV0X/WQwcuMJ46tPsxiGFuXtft4p1A9VCSHl0nlwLHV4o4I7cjFm2
         aTfmLl9wivNZFPwi+RrJe4Em8bBXvHc8+w2g2xtFztVyFYxZftvq4Py9BynOsLW5bnFp
         biPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHgIWe4wK+yULu9s359QNOHoS2ihJI3KKi13TQKwnsVj8TxoFqhANYQA6l0BgqGgFRZ2yefxcc/o/S47bxGkcc72WNE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7tnIfpJJAyXFFihtmWnP03pdg/s7Fa/vX4FJ/S5CmqkhKGZQ
	0ecvPRlkCuF4KlEUUeremodJ9Hlmd8wQRUHEPr+hVe0//cB1oDEnYLimBk1qlq6qOb5wVT9We6F
	DUbUvrQ==
X-Google-Smtp-Source: AGHT+IETv1FoaCYMFTd8UBPO52a521/SVd75i7ILL+utflCprDQPdv/sDZ/rsqIVRQSrL3eT2RCg7hZCQL0=
X-Received: from wmcq1.prod.google.com ([2002:a05:600c:c101:b0:46e:37d6:c1a6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468f:b0:46e:447d:858e
 with SMTP id 5b1f17b1804b1-46e612dce3dmr27953415e9.28.1759317498611; Wed, 01
 Oct 2025 04:18:18 -0700 (PDT)
Date: Wed,  1 Oct 2025 13:18:06 +0200
In-Reply-To: <20251001111807.18902-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001111807.18902-1-gnoack@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001111807.18902-2-gnoack@google.com>
Subject: [PATCH v2 1/2] landlock: Multithreading support for landlock_restrict_self()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
given Landlock ruleset is applied to all threads of the calling
process, instead of only the current one.

Without this flag, multithreaded userspace programs currently resort
to using the nptl(7)/libpsx hack for multithreaded policy enforcement,
which is also used by libcap and for setuid(2).  Using this scheme,
the threads of a process enforce the same Landlock ruleset, but the
resulting Landlock domains are still separate, which makes a
difference for Landlock's "scoped" access rights, where the domain
identity and nesting is used.  As a result, when using
LANLDOCK_SCOPE_SIGNAL, signaling between sibling threads stops
working.  This is a problem for programming languages and frameworks
which are inherently multithreaded (e.g. Go).

Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h |   4 +
 security/landlock/cred.h      |  12 +
 security/landlock/limits.h    |   2 +-
 security/landlock/syscalls.c  | 433 +++++++++++++++++++++++++++++++++-
 4 files changed, 448 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..7c6c7f004a41 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -117,11 +117,15 @@ struct landlock_ruleset_attr {
  *     future nested domains, not the one being created. It can also be us=
ed
  *     with a @ruleset_fd value of -1 to mute subdomain logs without creat=
ing a
  *     domain.
+ *
+ * %LANDLOCK_RESTRICT_SELF_TSYNC
+ *    Apply the given ruleset atomically to all threads of the current pro=
cess.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
+#define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c82fe63ec598..eb28eeade760 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -65,6 +65,18 @@ landlock_cred(const struct cred *cred)
 	return cred->security + landlock_blob_sizes.lbs_cred;
 }
=20
+static inline void landlock_cred_copy(struct landlock_cred_security *dst,
+				      const struct landlock_cred_security *src)
+{
+	if (dst->domain)
+		landlock_put_ruleset(dst->domain);
+
+	*dst =3D *src;
+
+	if (dst->domain)
+		landlock_get_ruleset(src->domain);
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
index 0116e9f93ffe..5ba14d641c11 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -14,6 +14,7 @@
 #include <linux/capability.h>
 #include <linux/cleanup.h>
 #include <linux/compiler_types.h>
+#include <linux/completion.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -25,6 +26,7 @@
 #include <linux/security.h>
 #include <linux/stddef.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
@@ -445,6 +447,416 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset=
_fd,
=20
 /* Enforcement */
=20
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
+	/* An error encountered in preparation step, or 0. */
+	atomic_t preparation_error;
+
+	/*
+	 * Barrier after preparation step in the inner loop.
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
+	int res;
+	struct cred *cred =3D NULL;
+	const struct cred *current_cred =3D current_cred();
+
+	if (current_cred =3D=3D ctx->old_cred) {
+		/*
+		 * As a shortcut, switch out old_cred with new_cred, if
+		 * possible.
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
+	res =3D atomic_read(&ctx->preparation_error);
+	if (res) {
+		abort_creds(cred);
+		goto out;
+	}
+
+	/* If needed, establish enforcement prerequisites. */
+	if (!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
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
+ * Returns:
+ *   -ENOMEM if the (re)allocation fails
+ *   0       if the allocation succeeds, partially succeeds, or no realloc=
ation was needed
+ */
+static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flag=
s)
+{
+	int i;
+	size_t new_capacity =3D s->capacity + n;
+	struct tsync_work **works;
+
+	if (new_capacity <=3D s->capacity)
+		return 0;
+
+	works =3D krealloc_array(s->works, new_capacity, sizeof(s->works[0]),
+			       flags);
+	if (IS_ERR(works))
+		return PTR_ERR(works);
+
+	s->works =3D works;
+
+	for (i =3D s->capacity; i < new_capacity; i++) {
+		s->works[i] =3D kzalloc(sizeof(*s->works[i]), flags);
+		if (IS_ERR(s->works[i])) {
+			/*
+			 * Leave the object in a consistent state,
+			 * but return an error.
+			 */
+			s->capacity =3D i;
+			return PTR_ERR(s->works[i]);
+		}
+	}
+	s->capacity =3D new_capacity;
+	return 0;
+}
+
+/*
+ * tsync_works_contains - checks for presence of task in s
+ */
+static bool tsync_works_contains_task(struct tsync_works *s,
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
+ * tsync_works_free - free memory held by s and drop all task references
+ */
+static void tsync_works_free(struct tsync_works *s)
+{
+	int i;
+
+	for (i =3D 0; i < s->size; i++)
+		put_task_struct(s->works[i]->task);
+	for (i =3D 0; i < s->capacity; i++)
+		kfree(s->works[i]);
+	kfree(s->works);
+	s->works =3D NULL;
+	s->size =3D 0;
+	s->capacity =3D 0;
+}
+
+/*
+ * restrict_sibling_threads - enables a Landlock policy for all sibling th=
reads
+ */
+static int restrict_sibling_threads(const struct cred *old_cred,
+				    const struct cred *new_cred)
+{
+	int res;
+	struct task_struct *thread, *caller;
+	struct tsync_shared_context shared_ctx;
+	struct tsync_works works =3D {};
+	size_t newly_discovered_threads;
+	bool found_more_threads;
+	struct tsync_work *ctx;
+
+	atomic_set(&shared_ctx.preparation_error, 0);
+	init_completion(&shared_ctx.all_prepared);
+	init_completion(&shared_ctx.ready_to_commit);
+	atomic_set(&shared_ctx.num_unfinished, 0);
+	init_completion(&shared_ctx.all_finished);
+	shared_ctx.old_cred =3D old_cred;
+	shared_ctx.new_cred =3D new_cred;
+
+	caller =3D current;
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
+	 */
+	do {
+		found_more_threads =3D false;
+
+		/*
+		 * The "all_prepared" barrier is used locally to the inner loop,
+		 * this use of for_each_thread().  We can reset it on each loop
+		 * iteration because all previous loop iterations are done with
+		 * it already.
+		 *
+		 * num_preparing is initialized to 1 so that the counter can not
+		 * go to 0 and mark the completion as done before all task works
+		 * are registered.  (We decrement it at the end of this loop.)
+		 */
+		atomic_set(&shared_ctx.num_preparing, 1);
+		reinit_completion(&shared_ctx.all_prepared);
+
+		/* In RCU read-lock, count the threads we need. */
+		newly_discovered_threads =3D 0;
+		rcu_read_lock();
+		for_each_thread(caller, thread) {
+			/* Skip current, since it is initiating the sync. */
+			if (thread =3D=3D caller)
+				continue;
+
+			/* Skip exited threads. */
+			if (thread->flags & PF_EXITING)
+				continue;
+
+			/* Skip threads that we have already seen. */
+			if (tsync_works_contains_task(&works, thread))
+				continue;
+
+			newly_discovered_threads++;
+		}
+		rcu_read_unlock();
+
+		if (newly_discovered_threads =3D=3D 0)
+			break; /* done */
+
+		res =3D tsync_works_grow_by(&works, newly_discovered_threads,
+					  GFP_KERNEL_ACCOUNT);
+		if (res) {
+			atomic_set(&shared_ctx.preparation_error, res);
+			break;
+		}
+
+		rcu_read_lock();
+		for_each_thread(caller, thread) {
+			/* Skip current, since it is initiating the sync. */
+			if (thread =3D=3D caller)
+				continue;
+
+			/* Skip exited threads. */
+			if (thread->flags & PF_EXITING)
+				continue;
+
+			/* Skip threads that we already looked at. */
+			if (tsync_works_contains_task(&works, thread))
+				continue;
+
+			/*
+			 * We found a sibling thread that is not doing its
+			 * task_work yet, and which might spawn new threads
+			 * before our task work runs, so we need at least one
+			 * more round in the outer loop.
+			 */
+			found_more_threads =3D true;
+
+			ctx =3D tsync_works_provide(&works, thread);
+			if (!ctx) {
+				/*
+				 * We ran out of preallocated contexts -- we
+				 * need to try again with this thread at a later
+				 * time!  found_more_threads is already true
+				 * at this point.
+				 */
+				break;
+			}
+
+			ctx->shared_ctx =3D &shared_ctx;
+
+			atomic_inc(&shared_ctx.num_preparing);
+			atomic_inc(&shared_ctx.num_unfinished);
+
+			init_task_work(&ctx->work,
+				       restrict_one_thread_callback);
+			res =3D task_work_add(thread, &ctx->work, TWA_SIGNAL);
+			if (res) {
+				/*
+				 * Remove the task from ctx so that we will
+				 * revisit the task at a later stage, if it
+				 * still exists.
+				 */
+				put_task_struct_rcu_user(ctx->task);
+				ctx->task =3D NULL;
+
+				atomic_set(&shared_ctx.preparation_error, res);
+				atomic_dec(&shared_ctx.num_preparing);
+				atomic_dec(&shared_ctx.num_unfinished);
+			}
+		}
+		rcu_read_unlock();
+
+		/*
+		 * Decrement num_preparing for current, to undo that we
+		 * initialized it to 1 at the beginning of the inner loop.
+		 */
+		if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
+			wait_for_completion(&shared_ctx.all_prepared);
+	} while (found_more_threads &&
+		 !atomic_read(&shared_ctx.preparation_error));
+
+	/*
+	 * We now have all sibling threads blocking and in "prepared" state in
+	 * the task work. Ask all threads to commit.
+	 */
+	complete_all(&shared_ctx.ready_to_commit);
+
+	if (works.size)
+		wait_for_completion(&shared_ctx.all_finished);
+
+	tsync_works_free(&works);
+
+	return atomic_read(&shared_ctx.preparation_error);
+}
+
 /**
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
@@ -454,12 +866,20 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset=
_fd,
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
+ * If %LANDLOCK_RESTRICT_SELF_TSYNC is specified in @flags, all other thre=
ads of
+ * the process will be brought into the exact same Landlock configuration =
as the
+ * calling thread.  This includes both the enforced ruleset and logging
+ * configuration, and happens irrespective of previously established rules=
ets
+ * and logging configurations on these threads.  If required, this operati=
on
+ * also enables the no_new_privs flag for these threads.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot=
 time;
@@ -484,6 +904,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, rule=
set_fd, const __u32,
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
 		prev_log_subdomains;
+	int res;
=20
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -566,5 +987,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, rul=
eset_fd, const __u32,
 	new_llcred->domain_exec |=3D BIT(new_dom->num_layers - 1);
 #endif /* CONFIG_AUDIT */
=20
+	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
+		res =3D restrict_sibling_threads(current_cred(), new_cred);
+		if (res !=3D 0) {
+			abort_creds(new_cred);
+			return res;
+		}
+	}
+
 	return commit_creds(new_cred);
 }
--=20
2.51.0.618.g983fd99d29-goog

