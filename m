Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE281EA73
	for <linux-security-module@vger.kernel.org>; Sat, 19 Jul 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923999; cv=none; b=mgIEgSct/CSLnQce7bMciP+1aIdVPaiIOPflbYtnVCrTfaeG/sDHz9CmeKbp/cwaMCcX13uIUANwNtWlZcf0bVi41mPaZL7A3b4GfGUKH1sLSSr8PDAswnFjTZ2MPe4PxEE3aMDkaFUxHq1bX66eT4I2Abtz2eiaFYLMbOFjuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923999; c=relaxed/simple;
	bh=tIv9MurlzcZHF50rQBBXRq/faBKzJgUQ+yHuLS1ZI9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=At2nMKIgzzh1kC80BzepCiABKJ/ix69BI6Cvu/ldfVgpvFwNLaGo8J7D389jTeewf8bpY/yUuOMQkQ7GqIEie4d/o6ro08ciqPJWAR1zMy/a32oqbL0DZjvGJw2vNRHLHQSWtLUOS1Kd70nZE1dglBcui4vFv0nm6NS+U6okrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OMrNiGXF; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OMrNiGXF"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bkjsC3gGXzpKq;
	Sat, 19 Jul 2025 12:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752921727;
	bh=5nAx1xig8wtOHLk/iAF6tnu7aDEknVmEXFeRG/F8lnc=;
	h=From:To:Cc:Subject:Date:From;
	b=OMrNiGXFL+TfSANrkWtlJKO22+QrTbzMqmd6gzQNxeYlMDQaGnJuniFAY3q6PiRRU
	 Ug3CvLYAKviXQIbqDCFXaOaC/YJj6d74ad7vrWkgMYB2EN8Jcg/ZUdmOEuVzk12szH
	 wNSDVTr8cnwLvnHx7youZ4JGeQAYA3PTBATJIew0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bkjsB5jJGzCwX;
	Sat, 19 Jul 2025 12:42:06 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/4] Landlock: Disconnected directory handling
Date: Sat, 19 Jul 2025 12:41:59 +0200
Message-ID: <20250719104204.545188-1-mic@digikod.net>
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

This patch series fixes and test Landlock's handling of disconnected
directories.

This third version mostly fixes a race condition spotted by Tingmao, and
adds more comments.

Previous versions:
v2: https://lore.kernel.org/r/20250711191938.2007175-1-mic@digikod.net
v1: https://lore.kernel.org/r/20250701183812.3201231-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Fix cosmetic change
  landlock: Fix handling of disconnected directories
  selftests/landlock: Add disconnected leafs and branch test suites

Tingmao Wang (1):
  selftests/landlock: Add tests for access through disconnected paths

 fs/namei.c                                 |    2 +-
 include/linux/fs.h                         |    1 +
 security/landlock/errata/abi-1.h           |   16 +
 security/landlock/fs.c                     |  192 ++-
 tools/testing/selftests/landlock/fs_test.c | 1317 +++++++++++++++++++-
 5 files changed, 1491 insertions(+), 37 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

-- 
2.50.1

