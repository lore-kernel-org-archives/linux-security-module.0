Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6D14830F
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jan 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410956; cv=none; b=VEqZWy/PsxQ0mLIpkCZo0wVYNNy4gX2oa63lxXlbFVIo84h/3RGJ/Xn4IEcH2Q3+Dt633S/XWYdu/5HSqLMbLa11l2AnyzreTiIHxhUfMDWptLmM3aip7uXseV6k0pqZ6UKS+kucT9OwUavlnJWL4waDEn4feME4o7/rMCgaSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410956; c=relaxed/simple;
	bh=FV/67HZH3yNug29ctKmLECh2O7GpzoLVGdeDHvIGxT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qIIxVaEYnH61vuAcFhZJ8eCQ3yeoRZNnq8B5XL0w6dVrdKPWiIVR/OBx6/MfECA5ryy9Za1WTgF4C9gMexE84bNV924+aVfI00nMNGzCbPYeQ9cv2JXPSBLv3OBw8bIqsVm5RmxOOAH4dkv4PZorphPSaZlrbJDQ0Vmq3zc7LI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D1EFA664; Mon, 20 Jan 2025 15:59:44 -0600 (CST)
Date: Mon, 20 Jan 2025 15:59:44 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] capabilities changes for 6.14-rc1
Message-ID: <20250120215944.GA16878@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-6.13-rc1

for you to fetch changes up to d48da4d5ed7b4a022a4e54f210575baac71f58af:

  security: add trace event for cap_capable (2024-12-04 20:59:21 -0600)

----------------------------------------------------------------
capabilities patches for 6.14-rc1

This branch contains basically the same two patches as last time:

1. A patch by Paul Moore to remove the cap_mmap_file() hook, as it simply
   returned the default return value and so doesn't need to exist.
2. A patch by Jordan Rome to add a trace event for cap_capable(), updated
   to address your feedback during the last cycle.

Both patches have been sitting in linux-next since 6.13-rc1 with no
issues.

Signed-off-by: Serge E. Hallyn <serge@hallyn.com>

----------------------------------------------------------------
Jordan Rome (1):
      security: add trace event for cap_capable

Paul Moore (1):
      capabilities: remove cap_mmap_file()

 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 57 ++++++++++++++++++++++++++++++++++++
 security/commoncap.c              | 61 ++++++++++++++++++++++++++-------------
 3 files changed, 99 insertions(+), 20 deletions(-)
 create mode 100644 include/trace/events/capability.h
