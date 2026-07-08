Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AD3CDBD7
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508808; cv=none; b=C/twlh/V3k04oXfLCaqZOjYU33jbSR6x1KGsX9dZ+QvEEKB8tZ0qYcqZWSWDYYuDFPTx835ad5GL/8IU6yDqEKTIFu8F5fiM7nllcKqcZ4yW5SaTs0hTkr9kQ9ld/VTdLG1kaJ7bOEvhew7X8hm/7VybUGwTYdthukHBbgbCV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508808; c=relaxed/simple;
	bh=alYASHSfhhqL6wRpxfrvVHYeVACdeAtRr/VXV4xc52M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6+Jxfbil+bcgLRoYMZVnOZDu9+8/HIZ7gN4XcPnI/9eByEDLlxkuSqTtGFC8KazwGXBLDL2NI52PVKtX6mHJojaCU6YxswwxMUNPyanFmoabclADbxXqLAIqaPRmcEN3LOSVvK2TAvV/CBtovvgGvDAMac9FMs2JNGQpZ8j6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vnxk1mlg; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vnxk1mlg"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwFfB0jh0zZmV;
	Wed,  8 Jul 2026 13:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783508801;
	bh=oiULY1v9lXDB0MYVnEzqu53t4xeEI9pbPZumsYbHnn4=;
	h=From:To:Cc:Subject:Date:From;
	b=vnxk1mlg2nHrVTBsIoX/w/eOiDHYi4LyBa7vjZY80drxo16m1N+ntPVd+2odm5Vv4
	 /JmeN+3NP3V9+p/l8WH6Trbx1w/NmblbIIAF2U7R4SCcJzORZkqCNZnf5n6PktPfar
	 VIsuqpf3lUrUHSYBcHUrKeqgIGdvndiFO/SaP/74=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gwFf93t03zKgM;
	Wed,  8 Jul 2026 13:06:41 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v1] landlock: Update formatting
Date: Wed,  8 Jul 2026 13:06:33 +0200
Message-ID: <20260708110635.2083515-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Following commit 99df2a8eba34 ("clang-format: fix formatting of guard()
and scoped_guard() statements"), update scoped_guard() formatting.
Also, see the related fix [1].

Cc: Günther Noack <gnoack@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20260708105713.2073335-1-mic@digikod.net [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/task.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 7ddf211f75c3..360d226d0f51 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -95,8 +95,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 	if (!parent_subject)
 		return 0;
 
-	scoped_guard(rcu)
-	{
+	scoped_guard(rcu) {
 		const struct landlock_ruleset *const child_dom =
 			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
@@ -370,8 +369,7 @@ static int hook_task_kill(struct task_struct *const p,
 	if (!subject)
 		return 0;
 
-	scoped_guard(rcu)
-	{
+	scoped_guard(rcu) {
 		is_scoped = domain_is_scoped(subject->domain,
 					     landlock_get_task_domain(p),
 					     signal_scope.scope);
@@ -422,8 +420,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	if (task_tgid(tsk) == landlock_file(fown->file)->fown_tg)
 		return 0;
 
-	scoped_guard(rcu)
-	{
+	scoped_guard(rcu) {
 		is_scoped = domain_is_scoped(subject->domain,
 					     landlock_get_task_domain(tsk),
 					     signal_scope.scope);
-- 
2.54.0

