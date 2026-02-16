Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121C23C368
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252990; cv=none; b=SBKDd5V1NRlDUD3cVObCCCWgOETuaG3VEFNfQaD+pNO8ZeDuXUZdCQ9ldA9iJItPOaGWEyWAW0vHdTsEp6+S+kF4HWeXG8m+h6PLITQBroorsr+I3EbEVQn+ZcB+TC51UvUovOlK++BYJjQeRQ8QRmUI16ak+65DZiUrV1+H4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252990; c=relaxed/simple;
	bh=Q0tacZVYlmMskwUKbv+g6lV7vllh5k8vyhO0Twm7x3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b61/7CpeSrxBOmfZbWpQtRx/Mb0bzsZ0XUH6xMjZUhTIfbbHSRGNCbdk/z81yYUANYS/QkD27Z3Eh9LDtx3EBrkmhYgTgIeyQLTCDr0ZXTG0tvRNFdBwUiPAnJh5RA2sOlAtG24bPvWrnv4ONJ0Y7OmTXtUB9Z3JMx0WXbCYdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=d8wTCf7g; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="d8wTCf7g"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fF4pg3CL4z92Q;
	Mon, 16 Feb 2026 15:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771252011;
	bh=96URuFMSU0ApMcG5zNadjMHaS5fh06LcbOmqm53ramg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8wTCf7gmOkTDrY7z8LENvS+g9/PqgZWQy4o8of8AcORGdyp9HqyQLi+3xug2UR1f
	 WbJFqAkNBKM9ODREFDKlmrZv6eflqmVbTCNLSJUyhuci4opk3BlbsTe2Tuy4vzG/6b
	 oOwV79LxXJ2f/WTp9/xNtST/DKrPyPAPRlTKGzcI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fF4pg0YqbzGHr;
	Mon, 16 Feb 2026 15:26:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v1 2/2] landlock: Improve TSYNC types
Date: Mon, 16 Feb 2026 15:26:39 +0100
Message-ID: <20260216142641.2100407-2-mic@digikod.net>
In-Reply-To: <20260216142641.2100407-1-mic@digikod.net>
References: <20260216142641.2100407-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Constify pointers when it makes sense.

Consistently use size_t for loops, especially to match works->size type.

Add new lines to improve readability.

Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/tsync.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 8e9b8ed7d53c..9a65e3e96186 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -256,13 +256,14 @@ static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
  * tsync_works_contains - checks for presence of task in s
  */
 static bool tsync_works_contains_task(const struct tsync_works *s,
-				      struct task_struct *task)
+				      const struct task_struct *task)
 {
 	size_t i;
 
 	for (i = 0; i < s->size; i++)
 		if (s->works[i]->task == task)
 			return true;
+
 	return false;
 }
 
@@ -284,6 +285,7 @@ static void tsync_works_release(struct tsync_works *s)
 
 	for (i = 0; i < s->capacity; i++)
 		kfree(s->works[i]);
+
 	kfree(s->works);
 	s->works = NULL;
 	s->size = 0;
@@ -295,7 +297,7 @@ static void tsync_works_release(struct tsync_works *s)
  */
 static size_t count_additional_threads(const struct tsync_works *works)
 {
-	struct task_struct *thread, *caller;
+	const struct task_struct *caller, *thread;
 	size_t n = 0;
 
 	caller = current;
@@ -334,7 +336,8 @@ static bool schedule_task_work(struct tsync_works *works,
 			       struct tsync_shared_context *shared_ctx)
 {
 	int err;
-	struct task_struct *thread, *caller;
+	const struct task_struct *caller;
+	struct task_struct *thread;
 	struct tsync_work *ctx;
 	bool found_more_threads = false;
 
@@ -415,10 +418,10 @@ static bool schedule_task_work(struct tsync_works *works,
  * shared_ctx->num_preparing and shared_ctx->num_unfished and mark the two
  * completions if needed, as if the task was never scheduled.
  */
-static void cancel_tsync_works(struct tsync_works *works,
+static void cancel_tsync_works(const struct tsync_works *works,
 			       struct tsync_shared_context *shared_ctx)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < works->size; i++) {
 		if (WARN_ON_ONCE(!works->works[i]->task))
-- 
2.53.0

