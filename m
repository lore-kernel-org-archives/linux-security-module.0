Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72A2C325C
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jun 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858122; cv=none; b=B2Ol1RS/11OgBMIxkcwGyukVRTk5JUl3ki5pYh3b/6017hOdfVL9lVqaDDwKJDriCOIVZChT1CeDznk4KXFV82z4S/J9pCpXMZmCX53K+ywJkm8vADeD1owRbZU9hQMhlFUMlLe3dmDhPm4DRyhfiav0Z94cUqhxvozlAqFMzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858122; c=relaxed/simple;
	bh=Qc6+P7NMASagmZJH5H42DGf8wKSdnqGf1bK6Uqz8TNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YKqphXPgY3PLqoLTH8UFsNCjniS6bM/x/FVleJyqKSxIaswYJOsZ+rGNXZxQciYGSdN8kkpO/jn/K2KeKIbn4EI7d6a5+oiJzESBNh7ubANR14PGN/AZNm2SodESl8mtzzCVgalH7hlOdyZVw1v2IasTP3Mv96aP3O5oZu09I8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZdeHRuLA; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZdeHRuLA"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghWB847xWzd1V;
	Fri, 19 Jun 2026 10:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781858112;
	bh=kj8KQV8QbLYa/lU/Tl7Z6AjgYC9dbtpdvn/0ghEKM4U=;
	h=From:To:Cc:Subject:Date:From;
	b=ZdeHRuLAxBDFt/UbzVZVpWT/T5b3QLRjpVV/EXKITVCMVoMvkglR+ochylq4asVSh
	 SbbJ1PIJULoT88hc2Zgyo4HtO8ph/w9P3ZbsNr3I3ApndFGR/B9R1m4bI3rBlJuT6G
	 TE38/aVdZanQqe6a9Al5VGxu0fRR44srM+Txq7Yg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghWB75Ntnzsnw;
	Fri, 19 Jun 2026 10:35:11 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Maximilian Heyne <mheyne@amazon.de>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v7.2-rc1
Date: Fri, 19 Jun 2026 10:35:04 +0200
Message-ID: <20260619083504.1779997-1-mic@digikod.net>
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

This PR adds new Landlock access rights to control UDP bind and
connect/send operations, and a new "quiet" feature to mute specific
audit logs (and other future observability events).  A few commits also
fix Landlock issues.

Please pull these changes for v7.2-rc1 .  These commits merge cleanly
with your master branch.  Most kernel changes have been tested in the
latest linux-next releases for some weeks, and I waited a bit more since
last week to make sure the changes brought by the recently squashed
fixes are ok.

Test coverage for security/landlock is 91.5% of 2351 lines according to
LLVM 22, and it was 90.9% of 2176 lines before this PR.

syzkaller changes have been developed to cover these new features:
https://github.com/google/syzkaller/pull/7493

Regards,
 Mickaël

--
The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc1

for you to fetch changes up to 1c236e7fe740a009ad8dd40a5ee0602ec402fffe:

  selftests/landlock: Add tests for invalid use of quiet flag (2026-06-14 20:17:25 +0200)

----------------------------------------------------------------
Landlock update for v7.2-rc1

----------------------------------------------------------------
Bryam Vargas (2):
      landlock: Fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
      selftests/landlock: Test SCOPE_SIGNAL on the SIGIO/fowner pgid path

Matthieu Buffet (7):
      landlock: Fix unmarked concurrent access to socket family
      landlock: Add UDP bind() access control
      landlock: Add UDP send+connect access control
      selftests/landlock: Add tests for UDP bind/connect
      selftests/landlock: Add tests for UDP send
      samples/landlock: Add sandboxer UDP access control
      landlock: Add documentation for UDP support

Maximilian Heyne (1):
      selftests/landlock: Explicitly disable audit in teardowns

Mickaël Salaün (5):
      selftests/landlock: Filter dealloc records in audit_count_records()
      selftests/landlock: Increase default audit socket timeout
      landlock: Set audit_net.sk for socket access checks
      landlock: Account all audit data allocations to user space
      landlock: Demonstrate best-effort allowed_access filtering

Tingmao Wang (9):
      landlock: Add a place for flags to layer rules
      landlock: Add API support and docs for the quiet flags
      landlock: Suppress logging when quiet flag is present
      samples/landlock: Add quiet flag support to sandboxer
      selftests/landlock: Replace hard-coded 16 with a constant
      selftests/landlock: Add tests for quiet flag with fs rules
      selftests/landlock: Add tests for quiet flag with net rules
      selftests/landlock: Add tests for quiet flag with scope
      selftests/landlock: Add tests for invalid use of quiet flag

 Documentation/admin-guide/LSM/landlock.rst         |   13 +-
 Documentation/userspace-api/landlock.rst           |  145 +-
 include/uapi/linux/landlock.h                      |   97 +-
 samples/landlock/sandboxer.c                       |  175 +-
 security/landlock/access.h                         |   44 +-
 security/landlock/audit.c                          |  292 ++-
 security/landlock/audit.h                          |    3 +-
 security/landlock/domain.c                         |   66 +-
 security/landlock/domain.h                         |   16 +-
 security/landlock/fs.c                             |  171 +-
 security/landlock/fs.h                             |   29 +-
 security/landlock/limits.h                         |    5 +-
 security/landlock/net.c                            |  185 +-
 security/landlock/net.h                            |    5 +-
 security/landlock/ruleset.c                        |   49 +-
 security/landlock/ruleset.h                        |   29 +-
 security/landlock/syscalls.c                       |   73 +-
 security/landlock/task.c                           |   11 +
 tools/testing/selftests/landlock/audit.h           |  140 +-
 tools/testing/selftests/landlock/audit_test.c      |   33 +-
 tools/testing/selftests/landlock/base_test.c       |  122 +-
 tools/testing/selftests/landlock/common.h          |    2 +
 tools/testing/selftests/landlock/fs_test.c         | 2445 +++++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c        | 1392 ++++++++++-
 tools/testing/selftests/landlock/ptrace_test.c     |    1 +
 .../selftests/landlock/scoped_abstract_unix_test.c |   78 +-
 .../selftests/landlock/scoped_signal_test.c        |  182 ++
 27 files changed, 5368 insertions(+), 435 deletions(-)
