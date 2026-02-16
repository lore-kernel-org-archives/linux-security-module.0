Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470531064B
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252021; cv=none; b=VSUt5L01v7BZu7C0ZFGh9V1u/vKyK6sDB19hedl44fTa06/vb4wK0v0XZntc1/uHZg1HcQXB1vvf3Foa4BKn4+1pq7909pwHCDYPlHJXbXsCYNiQvw5FnUkR+zL1NkhEjQdEaFEl1VTds5DqVY2u/3Qfvg5i0UPj4fS83+e6+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252021; c=relaxed/simple;
	bh=0HAvE7l2n/Dl+Qo25/j+vzRpzalaaLYt/Xf0eHMyXuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RQwbU14lmZqYqsBWvFLgccGiceW6onmuLedTZu4nFtsIPZhZ9IZrXiM9xDRB3g/jKn/0RgWq8XNGfsFaK47e2vhTahWRQ4XeSKnrex3SPVVYNELd3MWzpoOu0iZoLhwBHTGFJGxGLT8mXYlgEqVzDy7saPn4IRStKUjac4+drF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hXgac+O6; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hXgac+O6"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fF4pd4hV1zV8P;
	Mon, 16 Feb 2026 15:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771252009;
	bh=GuawniUif7IqO46f/ikJ2aTi0hSjO4kYmULtrntwDOg=;
	h=From:To:Cc:Subject:Date:From;
	b=hXgac+O6feCeYRgXaYyKxo5JzZ5NdYM0dbmTWbzPYLkApnZXuIc+zIw7Kh1sL3oAD
	 OcI0m64LfnxCBxnw+04YQ1ZJhJCl3P9oohyZdZgmlyzNNIr3FJJtLQ3ZhnzXst1fJe
	 1Qdbpg9Un4N1aW2l4GT8fnNavdPrF3lyDLzvLghg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fF4pd1tw1z1wj;
	Mon, 16 Feb 2026 15:26:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Date: Mon, 16 Feb 2026 15:26:38 +0100
Message-ID: <20260216142641.2100407-1-mic@digikod.net>
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
work.  For completeness, clean up ctx->shared_ctx dangling pointer as
well.

As a safeguard, add a pointer check to cancel_tsync_works() and update
tsync_works_release() accordingly.

Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/tsync.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0d2b9c646030..8e9b8ed7d53c 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -276,7 +276,7 @@ static void tsync_works_release(struct tsync_works *s)
 	size_t i;
 
 	for (i = 0; i < s->size; i++) {
-		if (!s->works[i]->task)
+		if (WARN_ON_ONCE(!s->works[i]->task))
 			continue;
 
 		put_task_struct(s->works[i]->task);
@@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
 			 */
 			put_task_struct(ctx->task);
 			ctx->task = NULL;
+			ctx->shared_ctx = NULL;
+
+			/*
+			 * Cancel the tsync_works_provide() change to recycle the reserved
+			 * memory for the next thread, if any.  This also ensures that
+			 * cancel_tsync_works() and tsync_works_release() do not see any
+			 * NULL task pointers.
+			 */
+			works->size--;
 
 			atomic_dec(&shared_ctx->num_preparing);
 			atomic_dec(&shared_ctx->num_unfinished);
@@ -412,6 +421,9 @@ static void cancel_tsync_works(struct tsync_works *works,
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

