Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA171A0728
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274873; cv=none; b=F052Acg0obHckf0mRGJDICarvkG2MVTiQBHaPp7RnTnBjZtqHyJ5L4lkd8xuwRDNcCle9C1umIQ4lZBBKiR9iKTo6yuX6q/wVrVU+ZnK1m5+uPNPcX+kR9uYRsXjZ43FDjTJgNbgW0CX3ZqN5OAJ+2enHL0JUiVDVJqa2OQmshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274873; c=relaxed/simple;
	bh=OYHcLTbG5Y5fYfu1BY9fou3UlhQPt31jxKGUVpp+AWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bs54ptEuT/JWsbcMdx2z7GjFxXGG9D3l7eFeIZdyST+piiFtIt5eWYhZCnvu56iNzzyVKJUV4C7Iv7YUDTsOwvc7DnsvuNxS1OIj+wW/KxLaHdVtWri2B5GBbU07vcWW5GIDcvS6EAiLpDdUC1iMFodL2XJWBAu72yKiJFviUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlWYVK5n; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlWYVK5n"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7eff205947so1622950066b.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274869; x=1767879669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJMuzxndRxjPYb0Poo89Z3Qx/NTyD832i1GWlAenjMM=;
        b=WlWYVK5nzVRykkmDxO8dmEneURSF4KQJIDL9agO5KSYm/1a38GR2oZKgHRnbEG9v74
         rVwEGKOP63wzMK0DWKwZhiiVXfcJ/da9RB79gHovTuYzciwF/UWLvWbjiQcN40O7ychS
         7bWI4wjzrDMb53PwMh4A72p/3D1l4RpgpI/EqjXNmj6jFMWuYEkM7imfM5iy9e1u9w7m
         MWYLvAJhjHu/tlBXWcm7xnrVNXTKPYz5R+FAYlQc3vdai6i0Oq/dDlh9VoC0xbkhagX6
         vc7tiO4Ly6zzyZYImnGoLAiTTjTBQjD/QXTU8wI504xvOzkVSy8c7AXdlLh/HS7qBSlM
         7BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274869; x=1767879669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJMuzxndRxjPYb0Poo89Z3Qx/NTyD832i1GWlAenjMM=;
        b=QCQ24GVO3a4MFSIPfR2NGeDWkooMdPEwVINkjs6hYtoF+91HVltts4RE4c6iYN/yeQ
         9kSOe4qSg82O24xyN6y6Im4rm0vd51VtMe+yyuPMK2sNuZCPuclDhL7IvqAwmWCK8HEV
         f4+ueIL4zaG7Ltz/KchnKDYizNjzh4nqyNpioQTgujJksRcl/Z7C6oHFuqFLp9lp40DM
         NDZK4S4A/p9FwkfkluTW8Oh91M2pWNWDMpOo6M4wF5ZKNxrUJ9a0r7enaLxWj9r1/EFH
         4+MBeGvB/B8J9mAjJt2/xbzAntkqaEvisAAfGi0gk9KRt0dJBQcyxGnDFgqi3kkT7pz2
         FrMw==
X-Gm-Message-State: AOJu0YyU1zuWyzWVFX5vpihyTQyEV4cQK9REBxmla0Z0+WZBSKC192v+
	IXKSNu5E7m8wTlTUE6Ja5TMkLkPpP6gPv+S61U/WPJXAQaZQvrJdmhFC
X-Gm-Gg: AY/fxX76NEMM6ovjOBrsjvWCQhJrsLNQ6ERn9iH8uPl2c+q/ZIQUkkaWZ3Ea3bs7lM8
	0R1RAABYwSZK/wWl82n+dl7jMMg2/wZp39LP17YcDFezS2RcWZxzBy9bjKIOC8YmYC7NRQWFz2H
	Fkc+aogGOjHGq9MwtrlVtxlY0dT00908srAIWOVJBpSgp36MmO3X1alJET5gKrcjDumtqsiLWDc
	envMCbsvAd1bslxWHSZnz+PvnEbRq/CX75nBrm/c8Zv304R346XlUaAj+r2Xx8vuLKExTmq3+aB
	EWp74cGYJm92vA97TmPJcchYBfZ3e4BnfHH8WM2VxiRPZL28g9Qqgz7rgDzNPErfwaQEt6CSw+r
	HrsxiutWHWE/wSjnZP8nGDtTLY7bIBJ+6w7y9K+ABkxTQf/TrPcvLNRmdgs/lXvm8FRX5vwDMgS
	bX6p9t/Agfdz8Cm3nAM06veGXiUxmqCpXgwfCLK8SuN9ynkTI=
X-Google-Smtp-Source: AGHT+IH7DLtfpukJfr1gPAQS1Y26Vi4cqCKRfz6JZyIFmwS+HJjZTyKlUOBADOYK5QaB385x8GQUCw==
X-Received: by 2002:a17:907:940a:b0:b2d:830a:8c01 with SMTP id a640c23a62f3a-b80371df334mr3727756566b.61.1767274869227;
        Thu, 01 Jan 2026 05:41:09 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a604f5sm4297178966b.11.2026.01.01.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:08 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Date: Thu,  1 Jan 2026 14:40:57 +0100
Message-ID: <20260101134102.25938-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Happy New Year!

This patch set introduces a file-system-based Landlock restriction
mechanism for connecting to Unix sockets.

## Motivation

Currently, landlocked processes can connect() to named UNIX sockets
through the BSD socket API described in unix(7), by invoking socket(2)
followed by connect(2) with a suitable struct sockname_un holding the
socket's filename.  This can come as a surprise for users (e.g. in
[1]) and it can be used to escape a sandbox when a Unix service offers
command execution (some scenarios were listed by Tingmao Wang in [2]).

These patches are built on Justin Suess's patch which adds the LSM
hook:
https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/

I am keeping this tagged as "RFC" since Justin's patch is RFC as well
so far.

The original feature request is at [4].

## Alternatives and Related Work

### Alternative: Use existing LSM hooks

The existing hooks security_unix_stream_connect(),
security_unix_may_send() and security_socket_connect() do not give
access to the resolved file system path.

Resolving the file system path again within Landlock would in my
understanding produce a TOCTOU race, so making the decision based on
the struct sockaddr_un contents is not an option.

It is tempting to use the struct path that the listening socket is
bound to, which can be acquired through the existing hooks.
Unfortunately, the listening socket may have been bound from within a
different namespace, and it is therefore a path that can not actually
be referenced by the sandboxed program at the time of constructing the
Landlock policy.  (More details are on the Github issue at [6]).

### Related work: Scope Control for Pathname Unix Sockets

The motivation for this patch is the same as in Tingmao Wang's patch
set for "scoped" control for pathname Unix sockets [2], originally
proposed in the Github feature request [5].

In my reply to this patch set [3], I have discussed the differences
between these two approaches.  On the related discussions on Github
[4] and [5], there was consensus that the scope-based control is
complimentary to the file system based control, but does not replace
it.  Mickael's opening remark on [5] says:

> This scoping would be complementary to #36 which would mainly be
> about allowing a sandboxed process to connect to a more privileged
> service (identified with a path).

## Credits

The feature was originally suggested by Jann Horn in [7].

Tingmao Wang and Demi Marie Obenour have taken the initiative to
revive this discussion again in [1], [4] and [5] and Tingmao Wang has
sent the patch set for the scoped access control for pathname Unix
sockets [2].

Justin Suess has sent the patch for the LSM hook in [8].

Ryan Sullivan has started on an initial implementation and has brought
up relevant discussion points on the Github issue at [4] that lead to
the current approach.

[1] https://lore.kernel.org/landlock/515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com/
[2] Tingmao Wang's "Implemnet scope control for pathname Unix sockets"
    https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
[3] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/
[4] Github issue for FS-based control for named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/36
[5] Github issue for scope-based restriction of named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/51
[6] https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
[7] https://lore.kernel.org/linux-security-module/CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com/
[8] Patch for the LSM hook:
    https://lore.kernel.org/linux-security-module/CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com/

Günther Noack (5):
  landlock/selftests: add a missing close(srv_fd) call
  landlock: Control connections to pathname UNIX sockets by path
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_CONNECT_UNIX
  landlock/selftests: test LANDLOCK_ACCESS_FS_CONNECT_UNIX
  landlock: Document LANDLOCK_ACCESS_FS_UNIX_CONNECT

 Documentation/userspace-api/landlock.rst     | 14 ++-
 include/uapi/linux/landlock.h                |  3 +
 samples/landlock/sandboxer.c                 | 11 ++-
 security/landlock/access.h                   |  2 +-
 security/landlock/audit.c                    |  1 +
 security/landlock/fs.c                       |  9 +-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   | 94 ++++++++++++++++----
 10 files changed, 113 insertions(+), 27 deletions(-)

-- 
2.52.0

