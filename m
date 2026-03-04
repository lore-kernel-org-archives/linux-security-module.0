Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7139FCA5;
	Wed,  4 Mar 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618244; cv=none; b=iMkXv1INgijq4ngqGmWEP/GqC3nelnnf/bm2WuY12JnIlgjfFMY1tiqxnjzmTtjlmEC4fMXviUbtzqW5Lqe/ejC9dpTF0RSsdC8wPlK4Q+NbbrplsnMKImvS0i+z8YKJWPvpepdG/sWvFNExb5KPVUJ8AlcM+UjzjubNmMQfJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618244; c=relaxed/simple;
	bh=mquJZIX+nauzwEkrdpZMr49Ff+51pi2boEVPMY3ZMzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ekfqlj3IXXQIIkyEdf5JFmc6gdFJowy2vbbnOv4OmpREVKfdUHKEN3OTpoWqw8bNtuwb+zz2+tsH1TWJXBtABDlysisTt6rNWlbhZLop0jQIg/+rEgRFTzNBLIWDnkLaR7tIugaEdSS6CMxizQq/jFvPfvV8EoJjCOgtCIruieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NS3SIJP8; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NS3SIJP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772618194;
	bh=B1cuihAukWyEjcBZxu/fubhtqgR/EO8+w6RWiAT9AQU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NS3SIJP8vqn4Mo+1Db3XjVZ7XX4JZkQUvTEX2bWnGQwfXiNaNWBYdZJQCxxZEIiKs
	 3t9UNtgKq7EhFBrgDlpsdCICjBen7RDjkiTOEGrxZaVQ1ebfcQFl2XmQspSyIsQ7tW
	 RoxwtuJDduprecrcNYgLvPDyDivRsHtakmsW9A18=
X-QQ-mid: esmtpgz11t1772618177ta3e9eb26
X-QQ-Originating-IP: 9Nnw7Clk+5/1KTGMlrEbJ/V2AkUz/LoJfJwPPRYiLmM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 17:56:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12237183056582169884
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
Subject: [PATCH v4 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Wed,  4 Mar 2026 17:54:16 +0800
Message-Id: <20260304095418.465594-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-XMAILINFO: N4WhQbLQyIqSWaCPABcY5VGC0BgYMtVI3+07YKLFrDPifQenRPM2LxWH
	UPUQKLsK68nf2XHqyJ35muBSqhVgMcRM9fYhBDQizsllT636YL/cTelAoG575DFz4EWXW9K
	EIWCLrfQodZFmAOGm3wklhE02cIYt+5iG5Jy29b9NloMoDhoVKpvD2nKzO4DCVdI7Bo5ZbV
	2uMYAwbhdnzxVhHCMcCuEGb7IqEjbKI5nL3rK/Sn/jcwochJTd5y0bmgGnkDi+Q3oXD030V
	G7xr9r2PPnJF/T6BEuzFQKhricF0rJNjpwt87xbyys/ewRfRkXrtuJleD+7RBE+GV4963sG
	JRst7YUybyQ5CZxquN8KSB8NwI0lanZxUhMn+jPz6WzNbx9117J0azdO43upByUtejLDB0B
	/5bZG0CyLCFcLkBskCARIVBPl7jD3dE16SC7v5SgeCFvqHcIKZAi0ewcSLs/oEq7qFwJIXp
	Cdav+dhjMyGjgZ1wUgAgT/td74KzwTUqfmA2iMcHBBLFRGNvbP5qaNYPbhl4PUE9uEAYl96
	QdkrH+Lv5wL9oFPyfr+Xmj3a1CTvKXQaNOmuQe0fhGBYei94YRrU4lt9Y+v+rEWKjWTBgOJ
	sZSEbTWZYVjHwYA4Afnk8qiIx6GtYbfQMfpmW0+15eyXRKdiIBslbVSisJj2nSoIK5ipat+
	HO4Uke32AqNJg8tTSAs+77P6BS1KeabP2zQWdrNckTCGbNGP+je3H07P1JJQvd0YNy6JaQs
	HR8lUeGC3gW7CfF/1Vp4w3WhaBdv8eLaQjhyd/hE4Lao5b7irziPzV44SF3Uzd5sWiDQ7Ax
	guq9FSBn5oMJ7eP+AZrFb86r4EDQgBVzEeyil99Frj7Q4Dlf2DzCYQWscFQTsoNozcNnjeA
	thKrH7hGIXFFBzlJEr9LASSshJuawYHZGifCRyJq+IuiMqItVJYbENxMGu7ZqyaGuu9eISv
	fwrCOy+SsKK/fL8ST8KUit6avlk7TOu8tyDIgcNrQaOxWgraGdl7XQFrWjw/ew9MOgZk6EQ
	y3HD4fqDYvoak/xJWr9iEXwWf45SSIyNCBrLwzalwdupKL8oNtJdduNZm7KrRy91DnvBaZl
	g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0


Hello,

This patch series fixes a deadlock in the Landlock TSYNC multithreading 
support, originally reported by syzbot, and cleans up the associated 
interrupt recovery path.

The deadlock occurs when multiple threads concurrently call 
landlock_restrict_self() with sibling thread restriction enabled, 
causing them to mutually queue task_works on each other and block 
indefinitely.

* Patch 1 fixes the root cause by serializing the TSYNC operations 
  within the same process using the exec_update_lock.
* Patch 2 cleans up the interrupt recovery path by replacing an 
  unnecessary wait_for_completion() with a straightforward loop break, 
  avoiding Use-After-Free while unblocking remaining task_works.

Changes in v4:
- Patch 1: Use restart_syscall() instead of returning -ERESTARTNOINTR.
  This ensures the syscall is properly restarted without leaking the
  internal error code to userspace, fixing a test failure in
  tsync_test.competing_enablement. (Caught by Justin Suess, suggested
  by Tingmao Wang).
- Patch 1 and 2: Wrap comments to fit in 80 columns

Changes in v3:
- Patch 1: Changed down_write_killable() to down_write_trylock() and
  return -ERESTARTNOINTR on failure. This avoids a secondary deadlock 
  where a blocking wait prevents a sibling thread from waking up to 
  execute the requested TSYNC task_work. (Noted by Günther Noack. 
  down_write_interruptible() was also suggested but is not implemented 
  for rw_semaphores in the kernel).
- Patch 2: No changes.

Changes in v2:
- Split the changes into a 2-patch series.
- Patch 1: Adopted down_write_killable() instead of down_write().
- Patch 2: Removed wait_for_completion(&shared_ctx.all_prepared) and 
  replaced it with a `break` to prevent UAF.
  
Link to v3: https://lore.kernel.org/all/20260226015903.3158620-1-dingyihan@uniontech.com/
Link to v2: https://lore.kernel.org/all/20260225024734.3024732-1-dingyihan@uniontech.com/
Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/

Yihan Ding (2):
  landlock: Serialize TSYNC thread restriction
  landlock: Clean up interrupted thread logic in TSYNC

 security/landlock/tsync.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.20.1

