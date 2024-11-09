Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7B154BEB
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731150918; cv=none; b=UYxMyLW/4suOpc2AgqRVVTpfIXilXJBlzcjfwWOTFZKk+oRqpYdPvZCH/FZ49IX7lWHAwOcJ58mUTk+SzT0HNE2Pdoj+gK2UyAie1KajGvLIrlRwQw7xsqfHdGCZsfIHlzEFB/PXsyHEafprH8z7h5VoFIfiXIZ8VyfWGb5Hjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731150918; c=relaxed/simple;
	bh=B3C1QePv8fC71z0Q10ApzjWz/s5Z40930CTXEhqZ4rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9S5YJjZbWi2/RKOV7r3BVPHCUe/OnYpKMaH8pl4qmrRmgMC/EInkbVQyYfiprCds4wEF+kaMcAIe6J/b5WPxvByZCL+QKqGTURpaStJAgSz1gWSMigMg4y954aTUgxuZLvc39WW/vw1eeZ/meh5mLV8/+xkEnCtd4qAljpaSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fXowEyyw; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fXowEyyw"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltNd2r3Bz73X;
	Sat,  9 Nov 2024 12:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150545;
	bh=1K5VAMOUt+cFZmiu/YQwXOJJdvhzdZS4If1pmDVNtow=;
	h=From:To:Cc:Subject:Date:From;
	b=fXowEyywx/SzmSczM6SyTdiqfaOckybLooMW1enpY3oz0iem8ZDt8KZItdQNYsFmo
	 /cv2rjX05V/2mvCS+/y4q2odPZqt7DksGTXnhrh/scIKpldzRC7iQDLz22ofWGOmtz
	 cUBK+qlj2uLQsz5qpFME6EiNRNvP5NfrQC0e3mtg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltNc5tWnzjhC;
	Sat,  9 Nov 2024 12:09:04 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/3] Refactor Landlock access mask management
Date: Sat,  9 Nov 2024 12:08:53 +0100
Message-ID: <20241109110856.222842-1-mic@digikod.net>
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
- landlock_union_access_masks()
- landlock_get_applicable_domain()

This fourth version mainly rename these helpers.

The last patch uses these helpers to optimize Landlock scope management
like with filesystem and network access checks.

[1] https://lore.kernel.org/r/3433b163-2371-e679-cc8a-e540a0218bca@huawei-partners.com

Previous version:
v3: https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net
v2: https://lore.kernel.org/r/20241014124835.1152246-1-mic@digikod.net
v1: https://lore.kernel.org/r/20241001141234.397649-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Refactor filesystem access mask management
  landlock: Refactor network access mask management
  landlock: Optimize scope enforcement

 security/landlock/fs.c       | 31 ++++-----------
 security/landlock/net.c      | 28 +++-----------
 security/landlock/ruleset.h  | 73 ++++++++++++++++++++++++++++++++----
 security/landlock/syscalls.c |  2 +-
 security/landlock/task.c     | 18 +++++++--
 5 files changed, 95 insertions(+), 57 deletions(-)


base-commit: dad2f20715163e80aab284fb092efc8c18bf97c7
-- 
2.47.0

