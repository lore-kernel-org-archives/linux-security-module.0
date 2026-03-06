Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9F26A0C7
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788962; cv=none; b=QuQupLtWpXhLZ1ovoPoe84Xzry/Fw78QujQzmW6sO2oUQchk5V51KuATUMg1aELnJ2zJTtF7R0piO6s77TDJ3oPTAKLBh6YORY2CWbaMVZe+Rq4f1TMAkKo2qDvECSwHs0UleisgtRgzNt4UpvfLsHE+7seoWEHFNkbXAbEz/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788962; c=relaxed/simple;
	bh=lTecT4DKLT1WmywvCdSsb9s7tNwF/Os1ZO8e8vpPJ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDIJfDpgfgTBd3vQJBeq3j1l1HjJGOFDCAfTghAEzpUbH3mLA2G/qihmsqquPE+JTmK+Q5ti2m8E1hVf1HXTwOoyJClMWGqBhWjlv21kjmo8DH6JTrCnANQ0nJ1ula4waCa6pB7B9xzl8GaBAuoWbN2Eozl7HR5wZRrVbd0qSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPuRPre1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPuRPre1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772788957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d86057YBGz7gaVziFUXq1o08W4meztUZ6yiou8/evx8=;
	b=lPuRPre1OBaBW15D/0GRI5uqfOGS3urAoxPGCWRcyKzkKrVU8mLJJ3DwsVl8LsngLVbzyI
	3MGOScdAoe/1JIwQyAVFcMDxxMQGyAw7OEsUQTtySxcFezrxkJ1kz86rqREGw/ftctdGSS
	OXd2cJoRWBGiDPl8dEUFOvAOcmXn6ls=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-security-module@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] landlock/tsync: fix null-ptr-deref in cancel_tsync_works()
Date: Fri,  6 Mar 2026 17:22:13 +0800
Message-ID: <20260306092214.63179-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cancel_tsync_works() iterates over works->works[0..size-1] and calls
task_work_cancel() on each entry.  task_work_cancel() leads to
task_work_pending(), which dereferences task->task_works.  If
works->works[i]->task is NULL, this causes a null-ptr-deref:

KASAN: null-ptr-deref in range [0x00000000000009a0-0x00000000000009a7]
RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
RIP: 0010:task_work_cancel_match+0x86/0x250 kernel/task_work.c:124
RSP: 0018:ffffc90003597ba0 EFLAGS: 00010202
RAX: 0000000000000134 RBX: 0000000000000000 RCX: ffffc900106b1000
RDX: 0000000000080000 RSI: ffffffff81d13236 RDI: 0000000000000000
RBP: 1ffff920006b2f77 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff81d12dd0
R13: ffff88802c045100 R14: dffffc0000000000 R15: 00000000000009a0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3ea90c CR3: 0000000037f63000 CR4: 00000000003526f0
DR0: 0000000000000003 DR1: 00000000000001f8 DR2: 000000000000008e
DR3: 000000000000057a DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 task_work_cancel+0x23/0x30 kernel/task_work.c:187
 cancel_tsync_works security/landlock/tsync.c:415 [inline]
 landlock_restrict_sibling_threads+0xafe/0x1280 security/landlock/tsync.c:533
 __do_sys_landlock_restrict_self+0x5c9/0x9e0 security/landlock/syscalls.c:574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f859b39c629
RSP: 002b:00007f85991b2028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
RAX: ffffffffffffffda RBX: 00007f859b616270 RCX: 00007f859b39c629
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000003
RBP: 00007f859b432b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f859b616308 R14: 00007f859b616270 R15: 00007ffcff084488

The root cause is a race in schedule_task_work().  tsync_works_provide()
increments works->size and stores the task reference in ctx->task *before*
task_work_add() is called.  A thread can race to call do_exit() in the
window between the PF_EXITING check and task_work_add(), causing
task_work_add() to return -ESRCH.  The error path then drops the task
reference and sets ctx->task = NULL, but works->size remains incremented.
A subsequent call to cancel_tsync_works() iterates up to the stale size
and passes the NULL task pointer to task_work_cancel().

Fix this by decrementing works->size in the task_work_add() error path,
so the failed slot is rolled back and cancel_tsync_works() never iterates
over it.  The slot is naturally reused in subsequent iterations since
tsync_works_provide() always picks works->works[works->size].

As a defensive measure, also add a WARN_ONCE() guard in cancel_tsync_works()
to catch any future NULL task pointer before dereferencing it.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=911d99dc200feac03ea6
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 security/landlock/tsync.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0d2b9c646030..e6d742529484 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -381,14 +381,14 @@ static bool schedule_task_work(struct tsync_works *works,
 		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
 		if (err) {
 			/*
-			 * task_work_add() only fails if the task is about to exit.  We
-			 * checked that earlier, but it can happen as a race.  Resume
-			 * without setting an error, as the task is probably gone in the
-			 * next loop iteration.  For consistency, remove the task from ctx
-			 * so that it does not look like we handed it a task_work.
+			 * task_work_add() only fails if the task is about to exit.
+			 * We checked PF_EXITING earlier, but the thread can race to
+			 * exit between that check and task_work_add().  Roll back the
+			 * slot so cancel_tsync_works() never sees a NULL task pointer.
 			 */
 			put_task_struct(ctx->task);
 			ctx->task = NULL;
+			works->size--;
 
 			atomic_dec(&shared_ctx->num_preparing);
 			atomic_dec(&shared_ctx->num_unfinished);
@@ -412,6 +412,11 @@ static void cancel_tsync_works(struct tsync_works *works,
 	int i;
 
 	for (i = 0; i < works->size; i++) {
+		if (WARN_ONCE(!works->works[i]->task,
+			      "landlock: unexpected NULL task in tsync slot %d\n",
+			      i))
+			continue;
+
 		if (!task_work_cancel(works->works[i]->task,
 				      &works->works[i]->work))
 			continue;
-- 
2.43.0

