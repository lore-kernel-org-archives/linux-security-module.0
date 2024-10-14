Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273616F0D0
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910133; cv=none; b=BYmFcB4lgrO7Kv33u3JUSl/MUBCgdMfhmzrWfx1Qqp/QOy9HweLttWOSk9g9Y/LWzeyFzWnKa46T1XgLIMhQUalgOp5v9tuup0QraISBh1xyQVbqr6d8cPqNF+8dkx6Lq8JkyNpWqNzhisugnlfYN04gyiZsxGU2UdHZaxsYbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910133; c=relaxed/simple;
	bh=hLtkiqSywlYZvlwrPXWH0j9RSZ0YZYU47JYe6X8/FwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLx+XVvL302mHYLJYi3210VQelp918KR7J21MDvL4fww0TNixZG66qh/ZIC3mMilxRU3IKYOwtAWQHK95y7NY7CgJI28dpH70kpuWR3JPNhtZWEg/nLZtszYSfemlLi6sPqXpStAgH2ThydBUAiHO541DBf90KFyVlptix81Qoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Jvau3Lm/; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Jvau3Lm/"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRxqZ1rbqz2S9;
	Mon, 14 Oct 2024 14:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728910122;
	bh=igkjtZjoJun/n3oBSbQmleemd6nT12buGKccwWvs89o=;
	h=From:To:Cc:Subject:Date:From;
	b=Jvau3Lm/wKHWVbFxjiqUg0X/3UZS8I54OrlFvidYWiTpPdgEw2XagBcUpr2ct5y3F
	 ua7dVa0zUWEnCiRxArDN7WD/QGN8PxKT9AS7pW8vrZbBQgpJDf4LIdcXAR1/BCKaaw
	 k4EshVrE1ZPjvC4b0XiZKJ4VybfzcZLXd0+2HR1I=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRxqY2J3NzBn3;
	Mon, 14 Oct 2024 14:48:41 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/3] Refactor Landlock access mask management
Date: Mon, 14 Oct 2024 14:48:32 +0200
Message-ID: <20241014124835.1152246-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

To simplify code for new access types [1], add 2 new helpers:
- landlock_merge_access_masks()
- landlock_match_ruleset()

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Previous version:
v1: https://lore.kernel.org/r/20241001141234.397649-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 21 +++---------
 security/landlock/net.c      | 21 +++---------
 security/landlock/ruleset.h  | 66 +++++++++++++++++++++++++++++-------
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 22 ++++++++++--
 5 files changed, 82 insertions(+), 50 deletions(-)


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.47.0

