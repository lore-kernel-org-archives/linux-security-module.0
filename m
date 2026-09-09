Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EB5632A0
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967905; cv=none; b=NPCvkY/jHBnVnYAUPT3CWBz3rWHGKQgk44DqZiMr1+qhNNb3eGDJHLaqc/b8K91X3phUM2uL3O2/tZu98U73h8RdfcXe7+ttqQRdxdHllM8bf1ncXNHsqn9HN1FHFUUaM/Dcw/hsJi31adc8sCAwr8rbNTwPQRY2jmCN8tJGP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967905; c=relaxed/simple;
	bh=4xu7P+Ok2DEsJO8rCqVkGv/bOIR3n14IO/ixqglQwlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AjhAlGIeeFX1SICphiRRQk/UHUmqxQl1ZM/F9W+qfAbitoquTUCOUD5YlALm+krIGa8//qcMkOsd45p1mB4X+ycm+Zuh02HiHqBm9wo6sVv9h3mbLRncSa4SMDOwlT9TpXKQwJhRvxhCBmi3M3RLzfiFyz1bmbgakJpjuADyP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G908QrEN; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G908QrEN"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hg4Xj0B2WzBtx;
	Wed,  9 Sep 2026 17:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788967892;
	bh=XghtDDw38xkG4QZmgFfj5So2FgOTVfPx3aNeREMiTD8=;
	h=From:To:Cc:Subject:Date:From;
	b=G908QrENGJsU7dKlUa4OtC0fXBLBuSeKkOFYKcJYLAq2JOtFerdxwdp5cwdqVULJB
	 bXF+UvZ8rudrTW9TvGXUCWj/gv/byqxWgY/2UpNRPcREF73eSrTdOVdQQNNjhEFdP5
	 GyQtn/WPQyEjPZkPKWDGgXwE2EPzBap2RYPeyjsw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hg4Xh17MnzJdg;
	Wed,  9 Sep 2026 17:31:32 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Norbert Szetei <norbert@doyensec.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v7.3-rc3
Date: Wed,  9 Sep 2026 17:31:18 +0200
Message-ID: <20260909153118.361748-1-mic@digikod.net>
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

This PR fixes an UAF and a lockdep assert NULL dereferencing, and it
properly truncates too-long strings printed by a Landlock tracepoint.
Most of the changes are brought by new tests.

Please pull these changes for v7.3-rc3 .  These commits have been tested
in the latest linux-next releases and merge cleanly with your master
branch.

Test coverage for security/landlock is 91.6% of 2574 lines according to
LLVM 22, and it was 91.5% of 2571 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc3

for you to fetch changes up to d41d0021a6ea3e9fcd14126a00fead47f981c46e:

  landlock: Test trace path output boundaries (2026-09-08 11:49:39 +0200)

----------------------------------------------------------------
Landlock fix for v7.3-rc3

----------------------------------------------------------------
Mickaël Salaün (4):
      selftests/landlock: Test abstract socket trace name limits
      landlock: Clean up ruleset validation checks
      landlock: Bound escaped trace path output
      landlock: Test trace path output boundaries

Norbert Szetei (1):
      landlock: Fix use-after-free of the source's parent directory

 include/trace/events/landlock.h                    |  70 ++++++--
 security/landlock/.kunitconfig                     |   2 +
 security/landlock/domain.c                         |   3 +-
 security/landlock/fs.c                             |  18 +-
 security/landlock/ruleset.c                        |   2 +-
 security/landlock/trace.c                          | 182 +++++++++++++++++++++
 .../selftests/landlock/scoped_abstract_unix_test.c |  76 ++++++---
 tools/testing/selftests/landlock/trace_fs_test.c   | 160 ++++++++++++++++++
 8 files changed, 466 insertions(+), 47 deletions(-)
