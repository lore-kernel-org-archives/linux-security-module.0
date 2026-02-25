Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54827280F;
	Wed, 25 Feb 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987794; cv=none; b=sUCFlw6+Yoic4JLY5hv0+U0UbhupMoeHQ/2rTpqXrSv2vwv/cJ08Z3jARufl1A7+fxOm2x5aYB381h0I9woMwi08mHxiwwGBTAgYubmdZ4fjWJq2C8yogT+CYYBX0rR+nEpF2Me9sJ4rPj6dfSllY7VAPvcPA+XcX42gpEFLk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987794; c=relaxed/simple;
	bh=G+xtbzT0Jit9gznTRTlgA3Ch7eth+fyjUvGQ8ItHatA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD3WfU5seRXAFQa85i3uOw5yoJF8E1uWRnx6J7sWtaUa3v9D+fGrrsfkRfCZjUnMhyIziX7aU366f2aWh9Hxa7dxX+pBeIndUVcgiJ7nOl5hmcyfVIZHup0tWIfMCcpR6rT6g3TvxkO9Yak5SVBdcXidT/fyS528XavALWCovLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BcAam2MT; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BcAam2MT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771987741;
	bh=CM+iM+nnuHSGhZDGqjSLZ7tW86deFitywd+FiQnBYXc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BcAam2MTSfpw8lt0HaR1OJqfRV/Xt3aHxb8K8pE1ZkwrQ9pw78L/ymdQRjFHvj+HR
	 piKz188brMMkFumfqm9NeShTUwBvSsX9Dua+OyDx29BH6bnIiwCsOn/NwPFip4Q85E
	 rMaeERXNnnBY7H85rl8OrSiUYfkD7yr0Q3BGXjJo=
X-QQ-mid: zesmtpgz8t1771987726t9282cb38
X-QQ-Originating-IP: 6qKmemgcBPoJeRq4cbrrIOUDclK7Ia1b221C0/AF7kA=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 10:48:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12023568224237598104
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
Subject: [PATCH v2 1/2] landlock: Serialize TSYNC thread restriction
Date: Wed, 25 Feb 2026 10:47:33 +0800
Message-Id: <20260225024734.3024732-2-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: MglA7JX7t2v3+7F/MKBo7kKmEl+UUwnLRwB2BQjRigurbnQem7CAI6zY
	D6IpEhQ5dsiibIxZZPws1J4rHIkrLXTxA4OgmjYmJHRrWWt3KvDBcgY5gE9aG+teI4wI83m
	682qi5vqD4SdFO1WZkMFawsH4x+1ULnGqdM1q9LI6J7Q3HkJW7pZ4rsVOu5ccXhrwp0OGKD
	gZ/CzKgQC6eOSvJ0g/OH4Secr5h/a3NMGcKta9bvlFN5HxfFWU8AiRDRWqD3HDhou4MrZJs
	1DuZScOgZtmWqX2L4EpAgC5TlWLEtl72bcY0FMFNzY6TuGEn9jnVe7A+zecw+s7AUNmLLs8
	zX+KtiGHwNFZ8uPv0Qb+5xbPsmp6ZqDy6gVZFW4RvkBTu6gqamH7DNmWCYrvtoyEljDvVSn
	ucK94mYWrmh3FpYvkouDTjzeIloDNffeqpeQbrK/Pv9lKHAd53LrbFbG+Kulv38VQsDK8TG
	XLU2bMp351vLqmw958be561a2ifV9kojkBS9QVbC08sGAkKbolZKSdJFIJVzDvlmzxtrugg
	wvwbW8QVIdbB75qJRCeHEYuJ+LD1W8oJ/7JXPX5vEdLwLC44atKdG0ZPy11CN6Be17lEuEZ
	4/GmHkgP3rT5wDvxenc1WMwaGfatVNFuVA5LXYX9ou1dLtH9TVPrz70w8fO54YHwFFCN4zS
	7V3RH4o1OotyJf8wpAt+g9uY4Eq4CbC77n+zcGtKazMj1GsKAourGFB3Zd9r8h/EK7JEu9b
	SEauEiPheEwmlB0rUHeV9z35CvYJDCsvVKwcsYnCimOSEi1lgrepAb2SMgTvskukBiETIgR
	q5PrkDB6HK1c7O/Kr2t3zoaHyaaeHnZH2ynmP0R+mU2fkd3UdhAa8mQP5DrjsIsL3A3UWZx
	G0wMRsInNnwCWY/jMF6BWI9RGvc+8lUaWjHBQ86Gf7DK4zw3TivMRfRieMuK9oPV7WjcGgR
	8fw1ta5hdHjJ5t3D2bv0N21gKa+nQ0jGA2fqo3cSFdNIws6AoGx5CGL9yVqLFYeEEUNqrLI
	d1NlOfvjsi5JUganhwM9nP6WwTQHcp8it3oyU4Mzupf79nbbf4S9bgHbC4Deg=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

syzbot found a deadlock in landlock_restrict_sibling_threads().
When multiple threads concurrently call landlock_restrict_self() with
sibling thread restriction enabled, they can deadlock by mutually
queueing task_works on each other and then blocking in kernel space
(waiting for the other to finish).

Fix this by serializing the TSYNC operations within the same process
using the exec_update_lock. This prevents concurrent invocations
from deadlocking. We use down_write_killable() to ensure the thread
remains responsive to fatal signals while waiting for the lock.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 security/landlock/tsync.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index de01aa899751..420fcfc2fe9a 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	shared_ctx.new_cred = new_cred;
 	shared_ctx.set_no_new_privs = task_no_new_privs(current);
 
+	/*
+	 * Serialize concurrent TSYNC operations to prevent deadlocks
+	 * when multiple threads call landlock_restrict_self() simultaneously.
+	 */
+	if (down_write_killable(&current->signal->exec_update_lock))
+		return -EINTR;
+
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
 	 * sibling threads.  In the task work, each thread:
@@ -556,6 +563,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		wait_for_completion(&shared_ctx.all_finished);
 
 	tsync_works_release(&works);
+	up_write(&current->signal->exec_update_lock);
 
 	return atomic_read(&shared_ctx.preparation_error);
 }
-- 
2.51.0

