Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795A1863F
	for <linux-security-module@vger.kernel.org>; Mon, 18 Nov 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943595; cv=none; b=MrjsUH9cHjvEdsqW5gAtp/ew2ac35HLYW1Pfux9r3yRQyuE1lttcjdahpCJj0ASKoJ+jK9HYx3SSYfmGJalMxuOW1KuxFsTZi/L/x12cDR0NrJieWEux/iq3DurP9PNqw1lgsJq9bmxKKb7bmVtXBrlYcqjl1GLuO30/8RpZZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943595; c=relaxed/simple;
	bh=fPrzbIMZHF+KGmCfA5oOjgDxMGgSIXC30pd8ypgLgog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0I7mw6IgdEiudF2tGuZVDn1G2W8+Sqk8r/bkrSCHwHpmuTMgPW7OZYQCKYffo603vGXVZPeZ0o3ph7ynWG5mfl2zKY0jLInqXTFWp3wyAErt8Bp2GNE4LibB9enp0aTaGnujVGT/6yjvy8qYSYfWD4d3Rv5AiCeQhmasAAahUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqebZHNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqebZHNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFEFC4CECC;
	Mon, 18 Nov 2024 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731943595;
	bh=fPrzbIMZHF+KGmCfA5oOjgDxMGgSIXC30pd8ypgLgog=;
	h=Date:From:To:Cc:Subject:From;
	b=bqebZHNyWOVGLlvHiHsOTTIqCUfOdaqDvJgGQuOrbFnA8gAhu1OChaccD3JAZiQ2f
	 Ji6mV3vW67gOWi3ezmjVpG5nCv/G5IftB9uUnJ10W+xR+EBOJWNMl9OOuWKN4WJCaJ
	 dYLpQJdb/wZVY3ouoS3bYlicEGrrlRDcOxjGStkKVHFyvP8TosHhpUhY1Es41MHjEB
	 6lWdbfpYHLbHgS6TgAlfXdmuCHled7R/L+cuWt7i5V2tnj2A0FMVCxf5RCfM1+Ub35
	 AFXH/px08WHWhhUdYQTuGx5gAepg1l0ATLZWWOgP3JoedY+NtELx9phnmCGpWOlBPK
	 Dju1KeTcKVScg==
Date: Mon, 18 Nov 2024 15:26:31 +0000
From: sergeh@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] capabilities
Message-ID: <Zztcp-fm9Ln57c-t@lei>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-6.12-rc1

for you to fetch changes up to 54eb2cec2ed7aaf25524dd5ebeaa4f87ed5c6bd6:

  security: add trace event for cap_capable (2024-10-30 14:40:02 -0500)

This branch contains two patches:

1. Remove the cap_mmap_file() hook (Paul Moore), as it wasn't actually doing anything.
   de2433c608c2c2633b8a452dd4925d876f3d5add

2. Add a trace event for cap_capable (Jordan Rome).
   54eb2cec2ed7aaf25524dd5ebeaa4f87ed5c6bd6

Both patches have been sitting in linux-next for quite some time with no apparent
issues.

thanks,
-serge

----------------------------------------------------------------
Jordan Rome (1):
      security: add trace event for cap_capable

Paul Moore (1):
      capabilities: remove cap_mmap_file()

 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 security/commoncap.c              | 37 ++++++++++++++++++++++---------------
 3 files changed, 83 insertions(+), 15 deletions(-)
 create mode 100644 include/trace/events/capability.h
