Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3D20F081
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784690; cv=none; b=vCN/eNJJ0Lgp89Ya65aZ5VLYwTV8Sui4iwVQyk6090OiF3X8GyTnV10nZbyraQzn2X5pcz4L6AgcK/JC/woZnWkBuNHWPzivbUvw+93CQTKi5pjHbYC2nuStaeiaBehtua3B1d9zfuc4hmqPFdNoIhQVnbwmUCdoVLeWty8Jf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784690; c=relaxed/simple;
	bh=LItsfBw0I16gqPO98mGFtPa3+Rhc273VnfYQA/JUJcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugBhjEyz60Lt2zmPJ038KFdchtRqHLCkBwXcU2OuDYI5sxsvSmqUVHnjVl3xc/H6LEMHP/Z+QuI0Z7hpOIxTtpC+jyTSAgNyyrMuk2p5MjUXzVZ3b1AMrU6KHo7q/VZQs9ynqQpnzAoFh1Zo0/dONiwyRGYYvpxwKXwjcbAS5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pwDIZ4pe; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pwDIZ4pe"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWy1M2BR7zZSg;
	Mon, 13 Jan 2025 17:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736784679;
	bh=4FRg2PSB3yx9TpG22GBC4lfEXIQ5pXhzPNK1Dtg4S5k=;
	h=From:To:Cc:Subject:Date:From;
	b=pwDIZ4peKV42nyLKiG4GARwe6Z6PfLcy+JlKBoT9MncQgCSH6wpNOkthiJ7FeiKsH
	 7OzfyAA3aqkzuNEtJu+iDnfa4Io6x9C7dxHVLXM28FvvHUZa+F1v7sRi2GPlfLKRdt
	 +XnsT0+bt3eDbs25kW5SfQOPd1rgpWxXuPgVTao8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWy1K6N7tz1ML;
	Mon, 13 Jan 2025 17:11:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shervin Oloumi <enlightened@chromium.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/4] Use scoped guards on Landlock
Date: Mon, 13 Jan 2025 17:11:08 +0100
Message-ID: <20250113161112.452505-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Using scoped guards helps simplifying error handling by removing goto
statements.

Only one macro was missing for mutex_lock() calls with
SINGLE_DEPTH_NESTING.

Regards,

Mickaël Salaün (4):
  landlock: Use scoped guards for ruleset
  landlock: Use scoped guards for ruleset in landlock_add_rule()
  locking/mutex: Add mutex_nest_1() scoped guard
  landlock: Use scoped guards for mutex

 include/linux/mutex.h        |  2 +
 security/landlock/ruleset.c  | 74 +++++++++++++++---------------------
 security/landlock/ruleset.h  |  5 +++
 security/landlock/syscalls.c | 39 ++++++-------------
 4 files changed, 50 insertions(+), 70 deletions(-)


base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
-- 
2.47.1

