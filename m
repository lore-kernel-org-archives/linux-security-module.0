Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE7331A5E;
	Fri,  6 Mar 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763504; cv=none; b=W6Rxu5VzTRM/rNxZGOJQeEt3x2duM78mL0phTPKt8hL3KWm+4ZopknHCRVyBtnSho4FPqAZJZq+VgM5kufkXqMvDcUdxhRW82zTw3rAUzT+xp/wY0+SkMQfPK0Vs4jFYLFq08AHWpBzNkJKMV1rF3AlThZ7QCi3WCONHRKyXRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763504; c=relaxed/simple;
	bh=4FFsfrZFEcCJkEj03PiT6eEh7joQWCOPWcQx5zj3kO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfbLAQdrqAxgRETpXLT58Of0zO8W+mYSQjzIklPk7q401av4fKVezaCNQ16Bgfw54xlYggFzsIKbEOiOGz+ciiUqp7jwsPudjh6eydNhqmR5xOn977oWuzQwi5KHTzHrQKQUdyjf0t73eu4EsEHo62lHQBGW6Gpp4OuXzzQQDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mQIqpFDh; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mQIqpFDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772763441;
	bh=Z/uExSTqjB90Cv4XfLKYjxXEk/KU+MTGsWjOqiW1TQc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mQIqpFDhahJk0c2F7TmqfjFYoY6Mrq8NkFynwNzCHMso9bcQbNsAvtRjUGRCX1uMM
	 lc7Q3cwDyPoayqqb+2fcDgkLeyQnw+NEnDoIAnYIhp7Kvtyg6NBzJRJJdJvwysMx3J
	 JRfaAab6w+C6bA1ahjm3F7NlZzprEWL6Nl9f1mkg=
X-QQ-mid: esmtpgz16t1772763424tede956aa
X-QQ-Originating-IP: hF+RSFJqUDIeNGe7mJPwnY1Lh0QM7wpE6qilcO+yV/o=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 10:17:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17020885750232885752
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: gnoack3000@gmail.com
Cc: dingyihan@uniontech.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: [PATCH v5 1/2] landlock: Serialize TSYNC thread restriction
Date: Fri,  6 Mar 2026 10:16:50 +0800
Message-Id: <20260306021651.744723-2-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260306021651.744723-1-dingyihan@uniontech.com>
References: <20260306021651.744723-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MTmey8JzPeV9+TgYmrQJZq7AHlAMpXQ6YRRyjHG+KRQhZgEIclJofyw+
	KyxGz2KBg+KFQj1501FX8mIur80ZMaS4YYs8HfO3yLvDD7VXr0Z9JxBrbwADUnCekqNdAET
	iYTxoXRIgRuSyPxFVUORzZ34V/2svoXak7nBrFkMe1qhTyUsXhNrkIvjuop1hsZOGsS6YLF
	R32bMbhtchi8ds1v/2Zwpw7uBKaL4E3kK538LFLi1yvj66ZkxA3ERDs/D/6yaksjXy7geVY
	OjSfDYARqIAC7jd5655WyV8qXR5OEQbhS9Xx8F/lWGT87RuWAZ7C51IaARs7lfCRQhsm1Vm
	qkduCwKWluNhjm271fWcOg/XsXifitHZdGTy4hDfVDQcOAfiYK7gHppFZoO3ozeuPZYcBn7
	fDclYkjXo74UBvbRmb7IBCgncO8OHDEZl2DZ/Cm5nlQI/VV8vk65ljY+ML7NcF12vSDzD+h
	E/inbTf0G7QI6SQMRKuv7U0mpwJNjLG/+V05Lwy4I0FXbSstym0Jjc5ofkkk461Vg4ZRTBE
	x3g7HpEn6LJwpZu/mA2oY+QJELjUVsIma1oGz51JHGzs1SRxdMdYMqOjECP8D/AhQwHqKuk
	VEbHOMxQxQa7RUz0gwEiBhVpvNd/WV3eJoPHRMeZxN3Nq59m/CKOD+IXOHE01N8n5P3iSm1
	9ddYtZUf6aR2SEVoPInaTGoVBEMKQbi6xjwOhZ27rRD54U5FiUPEJDmoYQ0lqRpnuDIQUm/
	CJF0myy6ARE4hB0jBW+a7ezW6vOChbdWP1N4/qkJN6O4xaOa9vPwxGdvrE8UpjzhE56uv8R
	4JS+NzFUA9AS/afOjQeSL9Jqp5DTlkd4g6NI3DKsOcbChoCbhSWMBNpAKTzwTIudvU5LyMQ
	G1r5SZUrsH7eaEURIyEp9LE51cmIezf6n37jguiqkPTcsA4lhKiliQd+nwPPljZDXGCeady
	j5s6tZtElUcIUITRHlnitBZo9td54RA+ucQgzMB9zW95Z9iJnfAVOL5EW6ZNrjPYRdoW0gm
	R+By0uDm6Tif9NqZI3hwmb/ULx88SRPU/jIHwKiE46/1HuQXsZ
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

syzbot found a deadlock in landlock_restrict_sibling_threads().
When multiple threads concurrently call landlock_restrict_self() with
sibling thread restriction enabled, they can deadlock by mutually
queueing task_works on each other and then blocking in kernel space
(waiting for the other to finish).

Fix this by serializing the TSYNC operations within the same process
using the exec_update_lock. This prevents concurrent invocations
from deadlocking.

We use down_write_trylock() and restart the syscall if the lock
cannot be acquired immediately. This ensures that if a thread fails
to get the lock, it will return to userspace, allowing it to process
any pending TSYNC task_works from the lock holder, and then
transparently restart the syscall.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
Reported-by: Justin Suess <utilityemal77@gmail.com>
Closes: https://lore.kernel.org/all/aacKOr1wywSSOAVv@suesslenovo/
Suggested-by: Günther Noack <gnoack3000@gmail.com>
Suggested-by: Tingmao Wang <m@maowtm.org>
Tested-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
Changes in v5:
- Just simple formatting changes, no code changes.

Changes in v4:
- Use restart_syscall() instead of returning -ERESTARTNOINTR.
  This ensures the syscall is properly restarted without leaking the
  internal error code to userspace, fixing a test failure in
  tsync_test.competing_enablement. (Caught by Justin Suess, suggested
  by Tingmao Wang).

Changes in v3:
- Replaced down_write_killable() with down_write_trylock() and
  returned -ERESTARTNOINTR to avoid a secondary deadlock caused by
  blocking the execution of task_works. (Caught by Günther Noack).

---
 security/landlock/tsync.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index de01aa899751..1f460b9ec833 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -446,6 +446,15 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	shared_ctx.old_cred = old_cred;
 	shared_ctx.new_cred = new_cred;
 	shared_ctx.set_no_new_privs = task_no_new_privs(current);
+	/*
+	 * Serialize concurrent TSYNC operations to prevent deadlocks when
+	 * multiple threads call landlock_restrict_self() simultaneously.
+	 * If the lock is already held, we gracefully yield by restarting the
+	 * syscall. This allows the current thread to process pending
+	 * task_works before retrying.
+	 */
+	if (!down_write_trylock(&current->signal->exec_update_lock))
+		return restart_syscall();
 
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
@@ -556,6 +565,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		wait_for_completion(&shared_ctx.all_finished);
 
 	tsync_works_release(&works);
-
+	up_write(&current->signal->exec_update_lock);
 	return atomic_read(&shared_ctx.preparation_error);
 }
-- 
2.20.1

