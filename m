Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4501A9F96;
	Thu, 26 Feb 2026 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070767; cv=none; b=lnnW+eaeE5NoAFQXll1IqpTcQTGasnOhqkWLay2owOBC15/sus6QGvD1+8J/9gGaZ+areTJy62H+/NL8HZTbjBK80cNcWobM1/55hqI+omf5sR4sl7FXSOKxFQE9/VGXvoqbuwnmD4sqYdZGNXxLL5X3gngeBXUfj5Bu+cRVItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070767; c=relaxed/simple;
	bh=qAolWJ+0TYq7aLvDUvrQ3HoJdfbmrN5E+Hyfgvfr5NU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pTqq8PGvLk5WO5ozd/ofiIq0mw2DNPsmeqnVFcgjF0oTL/wfWxNugOXkwZlEbUR+FPfZ9kdGL5Zzg6wPW+LzZUdtUAUl8TvXxutozOq+0LK1F/clzL+D7cmPmlx/6o1fQ9NUz8G1VePQQ8uJz4Z0E1NL7C+9v6y8kw6UTqn8gMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NGpe6COZ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NGpe6COZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772070729;
	bh=jCmVgQi0CSghe/B2hscrfjT/9+ngz/JQJd90e9W5f4o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NGpe6COZ2bnjtj4zawVNa+Ye9LIEuQdZRJxthLbP5v8MDZPolz7HlSt5/bYnl9VuD
	 4wzOK++GfIkAEl1a5J4M5OUVJhZ1GPq0taIqxHm323sW0n7bkJHEB6Y04gu4JHIs4+
	 zZyFCnTk8N4skBpWEqEGXpr1a9azavJf3klSOS1M=
X-QQ-mid: zesmtpsz2t1772070721tfe115851
X-QQ-Originating-IP: ZNp9dKzulBwkftR1f3XbLq8dlfr/6ETn/yG4bd5ek5Y=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:51:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1505235285582666329
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Thu, 26 Feb 2026 09:51:51 +0800
Message-Id: <20260226015153.3157421-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MvyKdZyVtFx3dNbRokWx1ciWPeKU5OX4KpPSj+0ICbspAZUGb+LhxGqH
	HYdy9MYMorEZNGCG9CUayDhBYxh8XgajFCR7DRaUJTqKL6wv94K0zSl7nm/9AWBfx5py/+i
	DXlVFc0AQ1eqPiObJTXLw3rh1SbeY/R5hg1O+LKPi5luUD5G4KbaTSgdrZh0qgPkaTfKN+v
	gqbvcE1O/yL/MgmlpOYPt2bF//pm475DGsVdfnMiBZnYxmOwIvs1j1lACcjA++BLkzQoKFr
	vuSEJuOnJaTQf3DFAJrqKOvilRI5cySds0n+mvwRtaF4b/6bY+FVtTKAFsUMXjG9SIa2LpS
	zEPqq86SAUcaIbaPVDwx4qW6jo98LFieyWZqhvIKCLRPN2G2XvkLgyK5gwCBYbe+8sxO6sC
	wVGBrjUxWMOZyJiMRwsi0eILvSkzQu9L7jTIW35mRq+Z8g86xFNks7GMsrK5ZXL+31gZHiT
	WjttqOLYsjcof4ViAGIjw1mdgb5t0qwhhaBpF3mBEETdn5FIIU8IytJRdxQm8tE/DjF6UY4
	GV62TGlzJKj54Tc34zxOS/liYhYZ+olLH7dxBnaSQndRt4R/apl78/OEAvscdNyl00jINbT
	GZcaO3g6CcWZ5S+a+lxaHpCfH7NWaNBMGSa8p+t2Lu1zSoE6UtXhrLC8NLoy/9DWDUPm3ZN
	EQhLn9Kgs5igjqcMAEK3WBpVnZNxYjg9VR0TVk7CsG9vELwgjySzI65/5L7UKkspJ40am5U
	QUdTsjpf/XKpBLVx9E3tGr8fKGMmVBKb7w9As22oSRQTvwiLCsmEbjGKMvItW3O3mokbudl
	Of0PUNmLSJvHhWD7Fp763W/SxuOOjnhwLvWWzXzyigw9Ts3vjauRiIjlOYOstFvOESI7Clt
	BGAdFB5mRN0UG9DujQUQONWandhezhErwwHTvbNN0J32XgJkIwMyZSL/oNeRR0w0FYPuJg/
	J/8aWEu4kcUMRa7h+dmKcLhelReyq9x+Parn0rmGwl2xjFkwtuU3UwkOlpoBvNOXLRifpOt
	dz8juSSuFdp+nHjH05DXu7sJjOOrLfwIOVe+o2SA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Link to v2: https://lore.kernel.org/all/20260225024734.3024732-1-dingyihan@uniontech.com/
Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/

Yihan Ding (2):
  landlock: Serialize TSYNC thread restriction
  landlock: Clean up interrupted thread logic in TSYNC

 security/landlock/tsync.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
-- 
2.51.0
