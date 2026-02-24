Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73F1E3DF2;
	Tue, 24 Feb 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914526; cv=none; b=jzhKbrvvlkcXuyLNXgBmmd0WJMcvjGYCUzPZNKwVqZhj8WQDuAMQZfzwyKoW5OdQQ18uPnmP9+6d8b1pyI65Bo6BNSsdx/AODrRPUJQNrarTPkdmGaVcYchvdMES1vPFHQIbMpyOPKpPlOieuoJ2oyg/ZxfCwJwuYakM6z7ldOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914526; c=relaxed/simple;
	bh=ssdTypkf95WIjIR2G3xExhZix6AYU1TRYPWUXdRr+fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awrfnhJCjZV/dj2d7NJ8E9dzyAzqVtcdA6dpQYdyigPMJ4Jig0WhAe9CClCRsGPBabX+tHeQruNolZqPVX3kQ24c7BJuWi8IG5HNlb67GxPBfiPOXVUOI9gbIhYWoGcA4SrhLugGGwDmSbgbbOOVG+4oRyOGtxxvB47K8ZAK45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=g70woF2n; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="g70woF2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771914476;
	bh=TSmwE93KQD55x1ZswDe8TbcHAZBzVfGMLdAaso06Zso=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=g70woF2n7Up6nZirIWXdXZz2FUmxW3BgS+Zdub208Jo9FHUXYnYB4LchzZpNDbBfY
	 ImfJSEoj53v+lL1yVdMszQxluXYsD+3nOznlCgOYFPvk3sQZpvBiLMz2/egayhdMz6
	 Noj2KjNR09UkLPMBU80WHILuJFqEGkdllbYJi1cQ=
X-QQ-mid: zesmtpgz1t1771914459tefe2f9ed
X-QQ-Originating-IP: EKSQIoDKuP5Ac55xNvtuLfhOCa+CXcgxnTrd5I5UHvU=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 14:27:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4948026446942565648
EX-QQ-RecipientCnt: 8
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH] landlock: Fix deadlock in restrict_one_thread_callback
Date: Tue, 24 Feb 2026 14:27:29 +0800
Message-Id: <20260224062729.2908692-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260223.52c45aed20f8@gnoack.org>
References: <20260223.52c45aed20f8@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MPAlP4yRn0xgw057EAB+ncm80IwrJWEbEqbMy4H1yQ2Eg79J696PftX2
	LLJBxKKdj3zH8bOTdT1Ta/jumtMThV698nQKaaMRboWNJ++9f4aqIaoUMMnEwVRqZJ8/8bK
	11kOEozYJKfKI8eEBwGrkUY4dP9DuYAw9n53elL+HsqZ+HvhIq2I+BD3h37LlTf6JJjbQLA
	AYQ2i4DgglIh12y9eZs/hozMDVMsWXjcU7eTeedo9I9G9yDKjY+XoakW5iNCYcYjslpF3oV
	/EvffeDjkMEwIlv8zIGELeN85T63ytRwYhtHRrmZP1AF1DIfBVBzaz519x3NuUsOik0o1F+
	r8si1bTf3cjg+1vDCj5wYS0tlS4Ox6CNoLrHieqiZgQIiXxbxGhHi0AriRhHlUFhcJFyydy
	PAMqe34AvmfavTOBI9qiMehmTjBWpE/DmziVCPzOBVwDEHMh6X9SFWh/Mw2iMJGqxDALH0k
	4afLC77rTmxgHMlS4GnHOYAAlIXaFwoRdi88pEH7Z7aYGcMZKI/lnGmN9Ee2K1IrVZ3YToB
	XQ6I2+gAu2ULtwghWe9kj8+ksL48yXmK3dywHjKsKovgD2jHBA3OIl2IkkAWWNERS6dAZR8
	VulYzNwQ4KMHde3UrHprgSPM3GFeFivWj0IxgP9easHYezSD4tLLzVSK6c/XvHFAkJGX7jw
	B8+Znn8pOQuWgwq4APDDX1RfQYosJCQrvs16/10rHNUajUrFv2JLFYcmeMgWB5DAgsh0zQA
	cUCVQUJ2r71AkaWxsfzfbsCqWlhyuvj8a1n12Pxuk1fogxoMgyXGMP91WEPpnaUARMsDd1S
	2f9BL2hhw8y0BtuNxIegmhMbOJLN5cxtP4CY+HTfxGuOuarL5hp4KQ/Y07OkaCzsjjfNjMQ
	JqLD3cYBRzkc/IBuwliEx03pGFLV5Rc0O2E+tO9hu6xE0nOICPTFSq60AXpw/EXKUQvXcQ1
	KDhAG9+G1VRmXOkVr9VmoMgQeHTtXC2J2IRfW24k1+T7EipQOMq0c8jEr+jLfZUGSKVo5gN
	0yNiEUTWjzYRcbSLqoFbF4hXtzT74y6Ub2/G1joQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

syzbot found a deadlock in landlock_restrict_sibling_threads().
When multiple threads concurrently call landlock_restrict_self() with
sibling thread restriction enabled, they can deadlock by mutually
queueing task_works on each other and then blocking in kernel space
(waiting for the other to finish).

Fix this by serializing the TSYNC operations within the same process
using the exec_update_lock. This prevents concurrent invocations
from deadlocking.

Additionally, update the comments in the interrupt recovery path to
clarify that cancel_tsync_works() is an opportunistic cleanup, and
waiting for completion is strictly necessary to prevent a Use-After-Free
of the stack-allocated shared_ctx.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 security/landlock/tsync.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index de01aa899751..4e91af271f3b 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -447,6 +447,12 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	shared_ctx.new_cred = new_cred;
 	shared_ctx.set_no_new_privs = task_no_new_privs(current);
 
+	/*
+	 * Serialize concurrent TSYNC operations to prevent deadlocks
+	 * when multiple threads call landlock_restrict_self() simultaneously.
+	 */
+	down_write(&current->signal->exec_update_lock);
+
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
 	 * sibling threads.  In the task work, each thread:
@@ -527,14 +533,17 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 					   -ERESTARTNOINTR);
 
 				/*
-				 * Cancel task works for tasks that did not start running yet,
-				 * and decrement all_prepared and num_unfinished accordingly.
+				 * Opportunistic improvement: try to cancel task works
+				 * for tasks that did not start running yet. We do not
+				 * have a guarantee that it cancels any of the enqueued
+				 * task works (because task_work_run() might already have
+				 * dequeued them).
 				 */
 				cancel_tsync_works(&works, &shared_ctx);
 
 				/*
-				 * The remaining task works have started running, so waiting for
-				 * their completion will finish.
+				 * We must wait for the remaining task works to finish to
+				 * prevent a use-after-free of the local shared_ctx.
 				 */
 				wait_for_completion(&shared_ctx.all_prepared);
 			}
@@ -557,5 +566,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 
 	tsync_works_release(&works);
 
+	up_write(&current->signal->exec_update_lock);
+
 	return atomic_read(&shared_ctx.preparation_error);
 }
-- 
2.51.0

