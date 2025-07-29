Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1B15CD74;
	Tue, 29 Jul 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816998; cv=none; b=UuE3rcnhKgGZEVnC4v5iMgi5rdnN248cWp0Qr3dvWDctVsVXQU/8FIOVonyJSXqeGK44hKpUK9fsf/S0s2USon8Y8VTZ4pcwxzGpPpNoSN2X7w15H9kbcAn8t8O7tDrEaavKOlrSnGMErVKILrAFe+Z1nBiFT3x6++r+8Yydrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816998; c=relaxed/simple;
	bh=tESYes4CBbGhjj+QoEtkK22SGJNai96WlfNjjGO27lU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0w+wbLuCsbgYwiQxU0kDGE0z0+L2ZVZF233dUNKK900b9wsXVtuuwYAjQtuWQHgamrV6wXNjHUYQiiKO3NyfJvNTyxWRQ6Gcz8Avbu/HditdrB+Fn1P5HS6h2FHEajAQd/kBE0kqVzVCE1RMIcu22ZaBn2CBXRfBktJ4RYXeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 22BDA652; Tue, 29 Jul 2025 14:23:07 -0500 (CDT)
Date: Tue, 29 Jul 2025 14:23:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>
Subject: [GIT PULL] capabilities update for v6.17-rc1
Message-ID: <aIkfm1AGBoINgSRF@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250729

for you to fetch changes up to cdd73b1666079a73d061396f361df55d59fe96e6:

  uapi: fix broken link in linux/capability.h (2025-07-04 19:21:53 -0500)

----------------------------------------------------------------
Capabilities update for 6.17

This branch contains two patches:

  cdd73b1666079a73d061396f361df55d59fe96e6 uapi: fix broken link in linux/capability.h

This updates documentation in capability.h.

  337490f0007f910968f828e46501db3091b1a4f8 exec: Correct the permission check for unsafe exec

This is not a trivial patch, but fixes a real problem where during
exec, different effective and real credentials were assumed to mean
changed credentials, making it impossible in the no-new-privs case
to keep different uid and euid.

These are available at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-pr-20250729

on top of commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 (tag: v6.16-rc1)


----------------------------------------------------------------
Ariel Otilibili (1):
      uapi: fix broken link in linux/capability.h

Eric W. Biederman (1):
      exec: Correct the permission check for unsafe exec

 include/uapi/linux/capability.h |  5 +++--
 security/commoncap.c            | 20 ++++++++------------
 2 files changed, 11 insertions(+), 14 deletions(-)
