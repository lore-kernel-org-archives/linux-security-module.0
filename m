Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286081F5429
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341297; cv=none; b=PDwjPWfKGBJoXEQQayZf8srkuzeJ7W7ozZBG0tjL4kpbaqLW/4iG7QWnbwzD6W1swxypMnEgr9r+BjCDNJpTULFDGEBQS/tqsBCfTh105g8ppF1o5Wjj5y/iHL/tNpPRofQ+zI6Bk1mow2wm0E9ZUzTOHC/AKNWH4Rc5SIjZXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341297; c=relaxed/simple;
	bh=JIZrx2P4sFdB/j4y5yfJwFj7MYCJaTX9Y4en4SKzmmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYwZoyL8ttEsU803KnqVub63eFyfPUr2SLzrZo3wn91bjWmCTo2ezcoXNAEaBegD8Bj++fdiQpYzdZ3BbNGtSYY9WyZ4q0AA7ppL94X9nLk2ahPhRSddVPUFbP/4eIz2g6G4cR621oU4hKMCa5ysQenCFmRrXnKJihA88cT7wbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=C+aIqesc; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="C+aIqesc"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1hD2f1QzClS;
	Fri, 31 Jan 2025 17:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341292;
	bh=Xx+juO2KfIQ1O6rpRWETP3tCb19zqyq8bKMLZhU35cI=;
	h=From:To:Cc:Subject:Date:From;
	b=C+aIqescXA1kH3amZi0LTGxPNzac9GemBkWWKhjRccuIzYSBLOUbMZgDoJcxDTi/9
	 VPJ1y+BStO3k8qkRXq/WFnYA4WfExQ63cOBrIcnzv6qiNuF1z3ggQkBueco8QamuS/
	 ZGGtDxEnM7g2CLwjhmCJcXYt3w7u6RkJhZmXglNQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1hC41xZzjDl;
	Fri, 31 Jan 2025 17:34:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Tyler Hicks <code@tyhicks.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Expose Landlock domain IDs via pidfd
Date: Fri, 31 Jan 2025 17:34:44 +0100
Message-ID: <20250131163447.1140564-1-mic@digikod.net>
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

Landlock enables users to create unprivileged nested security sandboxes
(i.e. domains).  Each of these domains get a unique ID, which is used to
identify and compare different domains.  With the audit support, these
IDs will be used in logs, but users also need a way to map these IDs to
processes and directly read domain IDs of arbitrary tasks.

pidfd is a reference to a task that enables users to interact with it
and read some of its properties with the PIDFD_GET_INFO IOCTL.  This
patch series extend this interface with two new properties:
PIDFD_INFO_LANDLOCK_LAST_DOMAIN and PIDFD_INFO_LANDLOCK_FIRST_DOMAIN.

Being able to read tasks' domain IDs is useful for telemetry, debugging, and
tests.  It enables users:
- to know if a task is well sandboxed;
- to know which tasks are part of the same sandbox;
- to map Landlock audit logs to running processes.

Furthermore, thanks to recvmsg(2)'s SCM_PIDFD, it is also possible to reliably
identify a peer's sandbox.

This patch series is based on the audit support patch series v5:
https://lore.kernel.org/all/20250108154338.1129069-1-mic@digikod.net/

I'll talk about this feature at FOSDEM:
https://fosdem.org/2025/schedule/event/fosdem-2025-6071-sandbox-ids-with-landlock/

Regards,

Mickaël Salaün (3):
  landlock: Add landlock_read_domain_id()
  pidfd: Extend PIDFD_GET_INFO with PIDFD_INFO_LANDLOCK_*_DOMAIN
  samples/landlock: Print domain ID

 fs/pidfs.c                   | 24 +++++++++++-
 include/linux/landlock.h     | 26 +++++++++++++
 include/uapi/linux/pidfd.h   |  4 ++
 samples/landlock/sandboxer.c | 29 +++++++++++++-
 security/landlock/Makefile   | 12 ++++--
 security/landlock/domain.c   |  2 -
 security/landlock/domain.h   |  8 ++--
 security/landlock/ruleset.c  |  2 +
 security/landlock/syscalls.c | 75 ++++++++++++++++++++++++++++++++++++
 9 files changed, 169 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/landlock.h


base-commit: a4b76d5e6800121372b88c85628a7867a5fdc707
-- 
2.48.1

