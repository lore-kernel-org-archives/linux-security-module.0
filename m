Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF538BF7F;
	Sat, 22 Aug 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787410531; cv=none; b=DF65Klwe1RW1ZfxENrbE8pFbysUkUisEthCAvO7xcYUk3UBvTwYUKPBUxY1s2zAYOAPhQSlHzHDjESJWrLGjtPUYu3ohq0+6GH0g+UEkz+v3IVwKQGchPBN4D5bimTelnb44hwjQ82qBSnKp94xLqg6ZwWnG7nO6c2LmRhS4ZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787410531; c=relaxed/simple;
	bh=BkOdoc0yaVIBJPNeaj0UGfnzjXY7YpCZK8QLwfbikKA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gM8QWvdiLcrscNkQ45i0BW5fy6JGBaleExbqRdeNc9TcSDFkRg6GyrnC4Fk0mnEbTZGqL/0VYwRq8zUBzTrV/NLEWbo2wAdzJ80w7onZXqUOfI2ohDUDl+8sMWzS+EKL/gVavwe80UeJtmvRJtAF3B/0zxOqq6yj/5/VHVmlOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=Uy5jshSg; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="Uy5jshSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1787410203; bh=BkOdoc0yaVIBJPNeaj0UGfnzjXY7YpCZK8QLwfbikKA=;
	h=Date:From:To:Subject:From;
	b=Uy5jshSgRY2mBWvL2kgmNnz49QM8JcBcoK0FRbAWtAmpTpUAaM8NC92C/ebXORNTI
	 fO1NIDcuwfBhMdI+jSDdLg+UqYMdiib3+pPv30k4xIwyrf9w8vKlgTXAuVJ7ZWb1at
	 Ic0Y8AbJp/MF3YkDqjZGa/12IgxjZC9mfATfH/szE+aOepnHDBM+PsHTxBklfg6h7G
	 sn011Jh8J6w1x/b32j0EBBKgBYHAKGE74rThDRXaK616+eIIqHfyJnJUY1KtiSuQnS
	 UcWU/tghjBaMTu+AUPd9neAGzApOUCg8JE1U/LhJ1lStuq5JswFZwlnEjLpKCetaDp
	 P+IqJQbtGKU7g==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 42E44104D; Sat, 22 Aug 2026 09:50:03 -0500 (CDT)
Date: Sat, 22 Aug 2026 09:50:03 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] capabilities update for v7.3
Message-ID: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just one trivial patch fixing up documentation.

thanks,
-serge

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260820

for you to fetch changes up to 9b0ee13b80798feb0e6a83a6d69e915f23fcb6bc:

  capability: remove non-kernel-doc comments (2026-07-24 07:35:47 -0500)

----------------------------------------------------------------
Capabilities update for 7.3

This branch contains just one trivial patch:

   capability: remove non-kernel-doc comments

which corrects two comments to avoid kernel-doc warnings.  It's available at

git@git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-20260820

on top of commit 1590cf0329716306e948a8fc29f1d3ee87d3989f (tag: v7.2-rc4)

----------------------------------------------------------------
Randy Dunlap (1):
      capability: remove non-kernel-doc comments

 include/uapi/linux/capability.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

