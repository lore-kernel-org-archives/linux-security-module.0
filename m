Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240229AAE3;
	Wed, 25 Feb 2026 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987798; cv=none; b=G+6/rzjl0bBMFYM3J4gRjs4hbD4K1MJexfDjNZsfIdlEvfIhbeAQ82OlcvUYcvsxHwlPTKYQzpr9HDl2+EEncFz3bzWrLDjQGtpT7jmt0RO3ibdmFRHJvO27ci23S3UxLCF+pnOF9Q2Wd+dAmkGnYBuGLZQ+s2uxfCSqaTWOPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987798; c=relaxed/simple;
	bh=HunT1Q3oHTOhHLKaoqB3zpiZDgc8y4Xa4lNK/psSaj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyuhT2TAUImfZDBw5L0XVFPR54KWwpUwLT9VjuVX3bWsCaIfLhpXnVtsxhWbY6S99EY34MyQY5DbloEdiz6uDOWgTAg8YK1fSD/Q6FVOrlq7NEjrZK9yYL/JTduZEKxZJ+HXthdi8h7+agxNXCsiUwwvRu4PFCFKleiauQZKcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KX2HnaDs; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KX2HnaDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771987754;
	bh=MxK7oG8ca45J2GKKngreLzCSXfJmov6rHOvjJQyg4g0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KX2HnaDsV72sQKi+25yOJRZYkMKdVBJyyc6ROlnKfkjpeX8+cVngVbhjaMDl4EjBM
	 DhWx1ah/WgKG9MqroCtjEuhyzo8KA4vXjMlcPjm6cXc9LWzhyrktWa3JxWvdFNItcR
	 5UQKZxk16YUZj3fEDx4SqJ88ODkmpze0dsSjvrLs=
X-QQ-mid: zesmtpgz8t1771987738t7865982f
X-QQ-Originating-IP: 06MOFvhg4ASOlMRVgH5KDKP2IWxf+vP36S+rlPgtltU=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 10:48:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13392820973086466500
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
Subject: [PATCH v2 2/2] landlock: Clean up interrupted thread logic in TSYNC
Date: Wed, 25 Feb 2026 10:47:34 +0800
Message-Id: <20260225024734.3024732-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260225024734.3024732-1-dingyihan@uniontech.com>
References: <20260225024734.3024732-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MKbpLBOB35npCv5E3qszZEzTiM0bI3HgH/aBnH7MeSVLf0yR7lWy+WoU
	nBWMZwYWUnDHGJUcDJC8U04HyFlYuz/8Pw+JV18YHz4Qc68L5DP7cRYxfDeh++ygQYd8iP8
	a/j7QHhLk+DRBPxOSTAndUBhiHeJ6IRjp2opqpFsir/g0pM3JEE4GMmvWywxd3ttc+js1oA
	sXAFUeRxiiAyfJ4OYmT3GKSY9Rt5E5fqsjmXxkIhP/Vhso0tENNPpLtEhGTqAXIypQ+IW+W
	7IinPz9kbSwf0S5LQf2vMQv4CQ/aHV+627qFQcuU6b/ZLNT8UcqtJ7aJ6+Vw0FmqKPFD/Uo
	ry7fusLQPs9WIPSvy/pYkbE+wcpNOfIeuMpBt1+k3HuLUCvQlBDPhDMNZW+3wl+D3ljFgc4
	E8Ws5nzzZ+lGEzNDud28wAQ4IxS9/VMQHcJ3GF8A24ZLx8uKopS/UcC64zqoon1lqrxP3eF
	x6FU/q3W6t5dlyegbyGpvzYGmcU3C5V1e102ijiJg6DtXpu8+bxgZY4qXMGzb1w6kxP4cx6
	fvmRHecSpMDWgXsGFBwQc/tv3O1Ywvvfw345XVREM/ZGcI71CLOiyNz+HHalCo2/OGPn/E2
	PrvqKhXHAsL1rmZxoaoL/nPCMAX1fmF83JNek1qmRXMdXt9n7Pjlw/aA0Tk40xQUG0rCLSF
	FS+zuyyNtEhKiIVthiyJJbZSaF27H3FlbHWFLnX/uFh3hO0UHlAPLoOaw+QckUyK6gFwzfJ
	sWv9FArjgLq0M45qPmd57wHB+kAlH8k17XpeFd0SfzvXs316kAlB3rsNqWWFaFjbzPF45Fm
	oiQTxdsqB65C57v/mHsRHIEyIJPxkH1oBgC01Okcd5y2fnVLwkEWMGrO+5kORXDxCEKvn79
	6nlDFy7s0nxB5ri8dem873AqgHpqOjCMHJ7iyO05E+HQAWfiZn3ZdcZk0YIc99QVHRoOBPU
	PsOL1kLkKcWKJ8HhjUwMxTRn0mAo5zRCyMK4kphyv+TMur4N8mk0I0RIuOU3y0SxuvjhvI0
	x+oGHYfFgcUQbSatNa
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

In landlock_restrict_sibling_threads(), when the calling thread is
interrupted while waiting for sibling threads to prepare, it executes
a recovery path.

Previously, this path included a wait_for_completion() call on
all_prepared to prevent a Use-After-Free of the local shared_ctx.
However, this wait is redundant. Exiting the main do-while loop
already leads to a bottom cleanup section that unconditionally waits
for all_finished. Therefore, replacing the wait with a simple break
is safe, prevents UAF, and correctly unblocks the remaining task_works.

Clean up the error path by breaking the loop and updating the
surrounding comments to accurately reflect the state machine.

Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
Changes in v2:
- Replaced wait_for_completion(&shared_ctx.all_prepared) with a break
  statement based on the realization that the bottom wait for 'all_finished'
  already guards against UAF.
- Updated comments for clarity.
---
 security/landlock/tsync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 420fcfc2fe9a..9731ec7f329a 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -534,24 +534,28 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
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
+				 * Break the loop with error. The cleanup code after the loop
+				 * unblocks the remaining task_works.
 				 */
-				wait_for_completion(&shared_ctx.all_prepared);
+				break;
 			}
 		}
 	} while (found_more_threads &&
 		 !atomic_read(&shared_ctx.preparation_error));
 
 	/*
-	 * We now have all sibling threads blocking and in "prepared" state in the
-	 * task work. Ask all threads to commit.
+	 * We now have either (a) all sibling threads blocking and in
+	 * "prepared" state in the task work, or (b) the preparation error is
+	 * set. Ask all threads to commit (or abort).
 	 */
 	complete_all(&shared_ctx.ready_to_commit);
 
-- 
2.51.0


