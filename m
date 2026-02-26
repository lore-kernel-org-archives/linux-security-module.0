Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB84374193;
	Thu, 26 Feb 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071203; cv=none; b=sHDbpoV0eAsjq9VAicHFY7vdpNHevezpEElV7uChXzJ11QWuL67/e+plHuhf8r3qjlND60MSauVXvALSuiNt2Gge2xbzEeRegt3LYdzts2j1ohi+nJjQndhlo2zXikGCBs1FLPSbgN5lvYncBW1IZOTtX0oobsRdAJI/A2BQ/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071203; c=relaxed/simple;
	bh=qAolWJ+0TYq7aLvDUvrQ3HoJdfbmrN5E+Hyfgvfr5NU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZPqYTR4naUGT9Jv7GGtOQ9qLWgtMcivhKEtRFi2t3/8XTjYiU6rSHcVYR5BB45ZvawpmaNPYMHRJi3fqpqyQ+5HZfHyfV4u57lzfK1jqpK9vcHkUSaNJYqWKspNxB+9+YY+k4LiQzeTPuIztoB6Q74x2IAigaq+TIPddnjhhuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lTlIIRRw; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lTlIIRRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772071157;
	bh=jCmVgQi0CSghe/B2hscrfjT/9+ngz/JQJd90e9W5f4o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lTlIIRRwSIk1h7IFiYz650aEeHeWWitEiJRk5394uICQyjyBCI7NpSZq6qBIfN1V+
	 Wy9EkSJn6ItK2eTNW/BAYw1q7UTAe4rvro0EnhFLxaAR37yr0aI/Gpa+SiZ5S9bwG+
	 4HWvij7fA6FOxWGls41iTm2pyJLWFpVZt1UCPzag=
X-QQ-mid: esmtpgz13t1772071149t32f539cc
X-QQ-Originating-IP: SNLO3RDOCdnPX5Ps3hKPqESMXdPqSizppOSjox9DWM4=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:59:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2030672822402651089
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Thu, 26 Feb 2026 09:59:01 +0800
Message-Id: <20260226015903.3158620-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: NERKeRCBC/NYA+QS6rs+zLZhUns3hk8Ha7UhD0dx/iqyJPhbo8bMK05w
	PbqwbSpycjsDj5NcXdvXrEAUlq0j646MY4tLoT4oN3f0dfX1+CKm03fPzHczVyhD2P1Ap5d
	x9f7RjgiBLXXtA04bSRA0bYW4AXd1A2PlXIVRuBP/Kgd9CM++89C3JxvbQXJDsCOa+UqUmX
	xE0uOzQsiEgF2elDV4C0EvcjEkupLpgUkFwKg3dB27WMQ7imdJa0sSh7tz/J42CA4v32XE0
	WNs8W/wBhz3ia6TMvP3y4DT/EdszYDRL7/2GcPbcvztxV6KeF1NhBrzrNV039d865U3xD/3
	BSoD8BeGwHz6ozknYjj0AAyd04NhnYTONbDNBnVNVFA/XGbxG/rIMW0w0ORJyHDIMxoLgCl
	0tQdjNjVRgvMvSFXMppqzm32H+TdUWWK2tDc/AM2KPA9I3AAExtmOBAzZlkH57vgKEWi5ky
	1miZTG70Gzyt3KNdf0OVKlcJgOb42tZGkYyqe9SrOI98KXWtmQZ5SQI4XIT9qG6WahyQnfN
	EhsHo2SA61S+tJM71Dsqp4FQJNo2fGy4kn++K1ZAh2j06cWcpt2um+0N9VzK4OvxNy2OVY/
	I7cOM7ZQhvue1akz6zFWylPbXIMA3Qq+CpVsg+7GKOkQ/Sc/KKADOkrUYE7Qot+eTTS0yT7
	WKHuxvTKt1J1nPqlGnDBR475+Q+4E2xVwS8M+LVgQsAwWtGBSQW1QB2F9I1Qm1Qu7lV7J9M
	VESohu5n0Vg/joVcryMtwgdlcf//tSMpHp14n30ng2wOxyOHA9moduBJX9EKBXVgVtLqK3f
	akZFRWaamadZX4Qv8oBlPUFzTRh4W7vctxYfM6mVn9HUM7a9N7nxZZhNFwKBqZVATyh+NTW
	tvPtt0Eb0qxRUUauZfGwkBTxSIs32DPIOH2F9CKW6x6cJ+S39YSTseA0rNek7byuEmhwvrA
	Cz1Y1g7FImZzdLRtwKkig0R5NuCEVwXhnUFLcNG9wc6UX+fYo6iq++54PryHAkEKHu6nqTp
	Hq/h2hXhaUIPoyh08c8jJuvQ+z4t651mBL7SNlQbX4fbcLEA+29+bEIvnwboVw4jI8eflx9
	BVd7BV7Ak961dtWdNO443Et3U7iaoZ7JvC7T3+9/AGqme1xn4+LMM3m5KaaIwfgahDUVlsz
	KppUHQOTBgD4UI0=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
