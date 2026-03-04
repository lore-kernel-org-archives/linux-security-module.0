Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C039FCC5;
	Wed,  4 Mar 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618258; cv=none; b=tmzR3Rklcg6FNlew093gS2q5yxtW/NvzuAZmdzO6tEZ5tjvJ69/FNZqdz+1oJ6vTVLLPkbP/uXZo5xkcTL+SdZS4jbzXBYdlS7mpOqnre8bc/FwuLdZOXB7+APYv6QhiBDO4HQcoYYGrWXL0ou7xbNVHMoKU5F/PzLy7jmiseXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618258; c=relaxed/simple;
	bh=1WzorIMueLN/WK+6SP4STNNUpo27uNR4U4Ufmj9Cl+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3CnbvHfKE7Q4HUpWKe+flwVf9HsIxGKQJ6478iC/eHTLGI8Pgp8kGPCgk5eUM0pAUCLjaNk0ACJ8Cy8ukPuqXLMJeffVMlM3cDmk6ABhkxsiJ+S2neLhr097ZpgelbUeE9pLU3DlpcGpnoWR0yHqY0aRpm/SgzrRpT8guNVMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JTTVvww9; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JTTVvww9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772618199;
	bh=X/S0ccgJVasPU5BTaHXIbvibQKnEVElQDSP6JGMKNXI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JTTVvww9UfBdbFIFPVt84hnq3xJm3jeJBSh59ZPkdEO6wW6INiwOOKQX936uaBOT8
	 xbAgkiNIjdG+yBvDbO0L4DTdZciAYuof6aaJmk8qN7Z1spRdXxlAHpu8Tzm+aA+AKw
	 qgoy1KnWDBq4q54vYnuTuxGdcEsfvUIyxGxjyRTE=
X-QQ-mid: esmtpgz11t1772618181t596c7605
X-QQ-Originating-IP: O8sZrnwpvE6iLzpJFSB8HOUq3QJRsbipWeO6zWlv2Xs=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 17:56:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15496339059802541385
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
Subject: [PATCH v4 1/2] landlock: Serialize TSYNC thread restriction
Date: Wed,  4 Mar 2026 17:54:17 +0800
Message-Id: <20260304095418.465594-2-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260304095418.465594-1-dingyihan@uniontech.com>
References: <20260304095418.465594-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: NWujniBqiFoNN9fOlCAERboXSzVvpkkc9cn+c4FcP3bu7rYDTGcSlszh
	PCarhBKqTp4dkpaTAP2jNXdl+ivelTo8B14DdTSO62ZJZYDU4Ot5w74TZRBQ5eypt23efLJ
	HnhsQjazEKIQz35U/q02/dpIv15ZEZD9VPj8dd1Bsi44cL9AM3/zEXbhVPFcWoI8c/9GW4r
	SxQXzbryPe3uzeuBkgUTqXlA4WKnbwwNjDvhY2NyM1lv3k5vjSAcIe+OKjfcG5gpzegreOK
	5O5EXbr8zw2/7Doc8hJgr62I/9yihHZgkh54mDGcxnbm0C4IUYe7vReHUMxbRLCET2vbyci
	PqhDrjCz0vXh1GA6C18qH29x/+Gzzlkyym5v6dqAIp/kO0GCieVjojrcl7++CsSACJP0Wou
	fnhF6npfFq1kf8lOz1s9hHPEk4Zxu1Z0TsFrephHKUAor3iI4ZRtpi0xC7KwYR0OJhRoXpI
	mfdSR5ar5Il3mlD+5NzTpO79ie1WThDaCk2g8ymHY4iN0+BsYdgSjcEZPPfXmHI3lJjCRoj
	O1Hf3G1saL+UJQ8lGKvi5oJysQ9bKLyczITJFKLjNk0A1WjPNN9WDvrvutyfKlth3w+ONBk
	f1cGD/R/8ASkvta5M12fRg35WZUrysDXnIzC1DjACn0JrOSQzAFp5Y75S54L+mWp0NkBuqN
	1bN2WsUp5sa3Cy4p9oSzO8cGX4YWxrpJLbLhL+76poRa45bSAgfAZtHoyzbeN9CVafGyICu
	h5bDqtYGQyVcuW9fujiIjTYPBdgUodY5BKSC81FRz7nG/OxPu7BJL8kYl/0xnuwtGGaGbmp
	7FL+cKy9evgOeT+1WPk30mbfmoWW8nwfsnT+j+51TjxAqNnmKz7sqS7VUOhTrTGJDjyq7lC
	V9wIJo/0ZDggmnYBz3FLRvbJgPmOj+aTltI6cGOq4/dN1BDqsIvr6vV4Sum655qYtgJR9X+
	F69xRtaqlQ5dXzSNIZGxlhonFVr6JJYXDMNm78CuOjxzV85B8Vz5j/42emqHOlkedk96Bkx
	z/JA2Gg1aVerLmVeD6uufn5SXtVIhZEgSYiWYEV7vx2wMymPJuJSXKTVwHxH8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

syzbot found a deadlock in landlock_restrict_sibling_threads().
When multiple threads concurrently call landlock_restrict_self() with
sibling thread restriction enabled, they can deadlock by mutually
queueing task_works on each other and then blocking in kernel space
(waiting for the other to finish).

Fix this by serializing the TSYNC operations within the same process
using the exec_update_lock. This prevents concurrent invocations
from deadlocking.

We use down_write_trylock() and return -ERESTARTNOINTR if the lock
cannot be acquired immediately. This ensures that if a thread fails
to get the lock, it will return to userspace, allowing it to process
any pending TSYNC task_works from the lock holder, and then
transparently restart the syscall.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
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
+		/*
+		 * Serialize concurrent TSYNC operations to prevent deadlocks when
+		 * multiple threads call landlock_restrict_self() simultaneously.
+		 * If the lock is already held, we gracefully yield by restarting the
+		 * syscall. This allows the current thread to process pending
+		 * task_works before retrying.
+		 */
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

