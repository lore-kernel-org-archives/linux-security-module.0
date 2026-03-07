Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8B2D3725
	for <linux-security-module@vger.kernel.org>; Sat,  7 Mar 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772860910; cv=none; b=HqoePrma2bEdLi8xyyGbkpqMjCYkqQpQjQ/JZRlacaf+sSn3iuxLv5EDEAH/IpIv+rpAgg25LNHSbK/gpu9Adh7acI2+oGzzKhowePOQ+l76/AlcYk4cWKCT/Iio7IlVHzMVrMdXV/bAnHkbB4i403M2i34JH8cWhaEwhiy++C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772860910; c=relaxed/simple;
	bh=ciRyFEAQO3d0mSiMgCyhBqPXkntgIHcfp1N7Szng84w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mr+Ge+7jzgzpHN1Fy9E6WQ7+v9WaBymGyfCdvd1UJ7fXHsZJUbdbKuMiqiygZA554xMlcjJ8UZz//WFnjznoNEGWvTeh/aBHNVc3ssE9PzbVbRByg4Oqy6XB8fRFKi5yJktUjtVQCrS8yXPC+fpuXNCJ8Vui+MKALRS/Ivp0Sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6275LWPc007847;
	Sat, 7 Mar 2026 14:21:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6275LVd1007844
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Mar 2026 14:21:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a96efa12-003b-46ed-9444-40b69d84fa05@I-love.SAKURA.ne.jp>
Date: Sat, 7 Mar 2026 14:21:32 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] landlock: add missing task != NULL check in
 cancel_tsync_works()
To: linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
References: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
Content-Language: en-US
Cc: syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting NULL pointer dereference at cancel_tsync_works(), for
tsync_works_release() checks for works->works[i]->task != NULL but
cancel_tsync_works() does not.

works->works[i]->task becomes NULL when tsync_works_provide() incremented
works->size and then task_work_add() returned an error. Therefore,
cancel_tsync_works() needs to check for works->works[i]->task != NULL.

Reported-by: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/landlock/tsync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index de01aa899751..8925acbef8a5 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -412,6 +412,8 @@ static void cancel_tsync_works(struct tsync_works *works,
 	int i;
 
 	for (i = 0; i < works->size; i++) {
+		if (!works->works[i]->task)
+			continue;
 		if (!task_work_cancel(works->works[i]->task,
 				      &works->works[i]->work))
 			continue;
-- 
2.53.0

