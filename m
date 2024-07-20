Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BE15E8C
	for <linux-security-module@vger.kernel.org>; Sat, 20 Jul 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467034; cv=none; b=SlVxeWqf4FwJxHSAvIu+c+r+egG+sumlfDcysZLwgV6UVXrFkE8Q5RkbsKzCXOiw0cFHuF804I0hSg28RRu4ES/rXzuM4MwgQmiH+1cOYb0ieD5HBDQhbDQVGcihPdc2pzZkpsBW5/ODsNM6Dob+wyBUZM5W8T66IZ3sXrdD73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467034; c=relaxed/simple;
	bh=zBlyMiZr5ZJ4NHeCLJ7YGyvosulwqESWN7yt2NzJulE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8jdGzwzhQwpjbmnHSkhfqXoWAdSKemHMch2XGL/k2FucZ84/fsWGNGzPl8kVygLSnfmx//rF4uPvj0XwOqo5ulM1gsMFGRs9WmqKIUjPlm3DEJidja2xrQmE7Bd9k8yvjgeMTMHfyWV2OrDHXqEgscF0YPV4Vsx/yyHGHFYrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WSPw5Pq8; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WSPw5Pq8"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WR11N18v0z5Vh;
	Sat, 20 Jul 2024 11:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721466520;
	bh=yjXRrqUcVbN8llmZR7ukkPu82dUi4AHWsqh4sofvfA4=;
	h=From:To:Cc:Subject:Date:From;
	b=WSPw5Pq8BN7GDzAmfamZNj4VM4tjQdIVs473U2DEYG41a5Tk5nLPhVy88bl4TnJMe
	 vtvIddwZtE6VTehr79VAVUBsILT6OFqwWHCe9AuLPbjWIkDg675z8eNESLTbHQOP99
	 jnfuMfwneFBcEuufdLB8z29D+T9hhcLcGKX+6pKg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WR11M2YRfzBsX;
	Sat, 20 Jul 2024 11:08:39 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.11
Date: Sat, 20 Jul 2024 11:08:34 +0200
Message-ID: <20240720090834.267835-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR simplifies code and improves documentation.

Please pull these changes for v6.11-rc1.  This commit merged cleanly with your
master branch.  The kernel code has been tested in the latest linux-next
releases.

Regards,
 Mickaël

--
The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.11-rc1

for you to fetch changes up to f4b89d8ce5a835afa51404977ee7e3889c2b9722:

  landlock: Various documentation improvements (2024-07-18 08:27:47 +0200)

----------------------------------------------------------------
Landlock updates for v6.11-rc1

----------------------------------------------------------------
Günther Noack (3):
      landlock: Use bit-fields for storing handled layer access masks
      landlock: Clarify documentation for struct landlock_ruleset_attr
      landlock: Various documentation improvements

 Documentation/userspace-api/landlock.rst |  2 +-
 include/uapi/linux/landlock.h            | 66 ++++++++++++++++++--------------
 security/landlock/limits.h               |  2 -
 security/landlock/ruleset.c              |  4 --
 security/landlock/ruleset.h              | 24 +++++-------
 security/landlock/syscalls.c             | 17 ++++----
 6 files changed, 56 insertions(+), 59 deletions(-)
