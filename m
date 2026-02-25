Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4B22B5AD;
	Wed, 25 Feb 2026 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987757; cv=none; b=kheICqfmY663T5S+ffinNls4mGXmkSnvLsrQGqfwGA03c6x3YFCaSW5w8Kx4APRD0Y+/Lt7EWEEKTAl8FjqX/xtCTSiSsMSGqsvOdxhgomcef4goydZZpC1U/S+B7DKsZFkoIf1iPqCGo4JdU+XUvEAHXc/+UkExkN3yUQ2Mi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987757; c=relaxed/simple;
	bh=cYWS0cez5qX9vQMLoC5zNCFi6I+BYRcuNiKGeI7IwQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RQHZM1126bnQJNiiBDnia/VRQCT4CJ2phQwFnk+MX7RzPPd5XiWdnj/lBDDEkxGBHCv4NaXbyjBp9d9ZM/4aA+LtxXomdosmEICO+0HHy43kkVKBTNQx1YUE6uQ6xiq9yL5O8mioVxOKAv/gA9WkCjSO/a64y6qzmwi8m7Vuisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cgJPfAYg; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cgJPfAYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771987714;
	bh=TzO2h+BWcVvZdPIrZukjMQ+4hix25SKZi0ryFAMoPy4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cgJPfAYgYUi/YTSMVLPaovrCwnVzYhwi5Ro4lFvn6g/nMBu7GK1UFpP+GCqTwH7ED
	 Az3uDT77Qh3SSHk+/IHk6PEPwRQu2ZHqV+QwYXiNKZMpvGg1iEnFwQ6hySfmpTbwp7
	 KoWiUy06yKHI227qrNHZTZjXf8N7wSXYdYm02zuY=
X-QQ-mid: zesmtpgz8t1771987697t639461a6
X-QQ-Originating-IP: qVUvUPl/mQn+6iYSa95PYXXGwoVpIT3RPtF42AgcGS0=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 10:47:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12339813733210593435
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
Subject: [PATCH v2 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Wed, 25 Feb 2026 10:47:32 +0800
Message-Id: <20260225024734.3024732-1-dingyihan@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MdNGkMEzaP5wX7rRdkqVjJebqENI8vEqAbHM7xpYNKmLq7FQQiOjgG97
	gHIqBpZMIQDSwUEJ8UjDXzbrmekRRcHVAUB4wprmfRwjfvgb1G20t49E2+EiOgkUCh1/s1C
	Ly+xroleN0lpViFMS7xnXoTTOh8tPofW3XdxmrozPDuCJ4XGB7zwAb3QwQZb0kopidylTV+
	Qi2PaIZwkoAFyaBlmh7KgVzrLTxRlK1vtLWH8RX+T1qkg2lf1rVdogAUZuyXtRxGpkvacvN
	hUhaj7QItHfh+d8rJTNJjc8QmskCD/Idyh5k/FuWtlR7Re9WuaOBqP9yFLv1HsOwBdmTSAr
	xZUpaHPYLTCRUxMekKwHSb/5sg5fcWz18sVZYwiOkODTTXnYtXIQvG04qcQnrBobswc/khN
	eipUsZz6fsaJubBpMoZckZb/YnBDy5LLqoEqdrKj2V10YOSgisgf0RRW2+1exJZ+PJxE2J8
	znr58bR0tneevR2tyv5rY64RKRHOTFwMuvN0d0YmQb/4O0+01kdV4dw9+QOJjZC5BNYp4OT
	nYZ94oi5SqxwJE8Oqad1u0lZNc+o0F0wjomecs+mZxMyOsQscNAIoQrLhW+cmgX0PX67oW8
	VUiHCEwj37gN1WdDMSDrM7potpgq9pixIJfLLhb3t0qACvigHb/GgAVII8O9BcXFN/FEsJ6
	eUNNXvF5DTqjmqXuRofZRcMWP1STcsYibxeBQewRuHySPDzICFMwINNQTkbGg4ZVZWmlT6q
	OsUyb3+KgPAEmiKYL2vPYy9mlB5tNY8lqSb7fZbJuaTuO1TUDLkBw046ouT4cFzuANBjnkn
	Qv7rJNR8QVAjHVOKXXXVIcN6czaZyylzOn10rISA+ArfXeIePIL0tSsQprS+YFhyVk5Zuz1
	qTkh0ycuQGUUHZMRMEQvos0VHdDY4B83WLee0PECcfVmMUT24y7h9beR7g3XSmjTiWdOS5n
	MCXIW7fXn0aJ4Bq52rppYLtvg3m1MeOVsjjzscElJdW7E2InW0ZMyWzAm/jIbPbaMPih4jB
	2UDxfQE7FxgGx1GkcV5LDzwyBQFDo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

Changes in v2:
- Split the changes into a 2-patch series for clearer logical separation.
- Patch 1: Adopted down_write_killable() instead of down_write() to 
  ensure responsiveness to fatal signals (suggested by Günther Noack).
- Patch 2: Removed wait_for_completion(&shared_ctx.all_prepared) and 
  replaced it with a `break`. The function's bottom wait for 
  'all_finished' already provides the necessary UAF protection 
  (suggested by Günther Noack).

Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/

Yihan Ding (2):
  landlock: Serialize TSYNC thread restriction
  landlock: Clean up interrupted thread logic in TSYNC

 security/landlock/tsync.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

-- 
2.51.0

