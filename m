Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA8245029
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331584; cv=none; b=AhzIRICuA7UBL8tuFv6kfJZifawa8DKVAJVgTBA+IO7yJYoWizOmg5UCDEydmJpQiJWgreiOhmIOWge9RFCTkQcjYi9dzP31Mx/gMM4DlZ1GYPUvqE5Nqb+w66VWmPti1mqOQYBat7gxBAITK9zvqeAA3X64WrKNGSqU9m7x7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331584; c=relaxed/simple;
	bh=KafqT0XV92ihkfDe5sYHgMTzfE9QPbQNJ8QV6fTpglw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g193DaO/rXu9AJOqgzO3jsSN91c6Q8I3EDs3/iyGIOX03YC6Kor+iDZAUc6+LiBYboD/0Xr7jrwYXcVo/wQSgS+SUrMBkHcACASiZnRmIt49J0mQjg6tt9NrGIwrC7cqvWX5qupD/InpvoMxaa9T9RGXn0N9F9JuWF9oBsnQ1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WUEuRRDc; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WUEuRRDc"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFf2M3hM7zw1W;
	Tue, 17 Feb 2026 13:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771331035;
	bh=lgS8MkCDYwES3NpPSa0v3GZZV6ShcSwPrQxabXdRdts=;
	h=From:To:Cc:Subject:Date:From;
	b=WUEuRRDczITgXXFYXu8ETZUYYZu2/LevMExngPA+jqsdwVBn0/OsYy7EmA+2prhCh
	 f0bgY0ei0khw2kVBegbLpI4hv0x3zLDKEt/Pc3q/OiUew1ht+MxnFFflnf3ZPBbT5D
	 0LfICfZEN/28ItzP1YcRIC6uke24lv/oLGEm3aLk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFf2M0LkpzRPr;
	Tue, 17 Feb 2026 13:23:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 1/2] landlock: Fully release unused TSYNC work entries
Date: Tue, 17 Feb 2026 13:23:39 +0100
Message-ID: <20260217122341.2359582-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

If task_work_add() failed, ctx->task is put but the tsync_works struct
is not reset to its previous state.  The first consequence is that the
kernel allocates memory for dying threads, which could lead to
user-accounted memory exhaustion (not very useful nor specific to this
case).  The second consequence is that task_work_cancel(), called by
cancel_tsync_works(), can dereference a NULL task pointer.

Fix this issues by keeping a consistent works->size wrt the added task
work.  This is done in a new tsync_works_trim() helper which also cleans
up the shared_ctx and work fields.

As a safeguard, add a pointer check to cancel_tsync_works() and update
tsync_works_release() accordingly.

Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/all/20260216142641.2100407-1-mic@digikod.net/
- Move the return/release logic into a new tsync_works_trim() helper
  (suggested by Günther).
- Reset the whole ctx with memset().
- Add an unlinkely(err).
---
 security/landlock/tsync.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0d2b9c646030..42cc0ef0c704 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -203,6 +203,40 @@ static struct tsync_work *tsync_works_provide(struct tsync_works *s,
 	return ctx;
 }
 
+/**
+ * tsync_works_trim - Put the last tsync_work element
+ *
+ * @s: TSYNC works to trim.
+ *
+ * Put the last task and decrement the size of @s.
+ *
+ * This helper does not cancel a running task, but just reset the last element
+ * to zero.
+ */
+static void tsync_works_trim(struct tsync_works *s)
+{
+	struct tsync_work *ctx;
+
+	if (WARN_ON_ONCE(s->size <= 0))
+		return;
+
+	ctx = s->works[s->size - 1];
+
+	/*
+	 * For consistency, remove the task from ctx so that it does not look like
+	 * we handed it a task_work.
+	 */
+	put_task_struct(ctx->task);
+	memset(ctx, 0, sizeof(*ctx));
+
+	/*
+	 * Cancel the tsync_works_provide() change to recycle the reserved memory
+	 * for the next thread, if any.  This also ensures that cancel_tsync_works()
+	 * and tsync_works_release() do not see any NULL task pointers.
+	 */
+	s->size--;
+}
+
 /*
  * tsync_works_grow_by - preallocates space for n more contexts in s
  *
@@ -276,7 +310,7 @@ static void tsync_works_release(struct tsync_works *s)
 	size_t i;
 
 	for (i = 0; i < s->size; i++) {
-		if (!s->works[i]->task)
+		if (WARN_ON_ONCE(!s->works[i]->task))
 			continue;
 
 		put_task_struct(s->works[i]->task);
@@ -379,16 +413,14 @@ static bool schedule_task_work(struct tsync_works *works,
 
 		init_task_work(&ctx->work, restrict_one_thread_callback);
 		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
-		if (err) {
+		if (unlikely(err)) {
 			/*
 			 * task_work_add() only fails if the task is about to exit.  We
 			 * checked that earlier, but it can happen as a race.  Resume
 			 * without setting an error, as the task is probably gone in the
-			 * next loop iteration.  For consistency, remove the task from ctx
-			 * so that it does not look like we handed it a task_work.
+			 * next loop iteration.
 			 */
-			put_task_struct(ctx->task);
-			ctx->task = NULL;
+			tsync_works_trim(works);
 
 			atomic_dec(&shared_ctx->num_preparing);
 			atomic_dec(&shared_ctx->num_unfinished);
@@ -412,6 +444,9 @@ static void cancel_tsync_works(struct tsync_works *works,
 	int i;
 
 	for (i = 0; i < works->size; i++) {
+		if (WARN_ON_ONCE(!works->works[i]->task))
+			continue;
+
 		if (!task_work_cancel(works->works[i]->task,
 				      &works->works[i]->work))
 			continue;
-- 
2.53.0

