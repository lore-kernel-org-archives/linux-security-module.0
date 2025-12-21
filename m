Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D61FC101
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346192; cv=none; b=bdI8OtQ/4C6h79v2Do1AIsLsyN04rbRkVOTP+az6lfB6rpSf6gUCsOUYL6HMaHF+wtl1jl5IEKKKcY+1lHVkvQFWMmbW5oFAss/FjPOCexs6kLd5YIyySwtZ+xsRFSPhBoSTTYxTs9qy/SxI8RPoT5uuK5SZ0M0EZ+xQCqbrM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346192; c=relaxed/simple;
	bh=E4ryLuwRaUB6+Nk/9jJREPrNSf5/xHzzE9dCgOViT+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eb/QplJmefWQfTFQGyKrrXQliMKte/r00Ui1pgPbZP9jZ82KdPyW8oMHzv5Yv+E8aIE4LUzj9jgpOUHqRYO13ZeMNpld3C+so+F/M1C5gUu4qnNXxWY7kTxlEaGownk/MbsBV0fFFNRqXTxW2wA7/VLKtzckv06UMbqSp1CmsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/0qDH6G; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/0qDH6G"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78c6a53187dso26100807b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346188; x=1766950988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GctpRVvWLzNDhKjavWD61S0hk8FYU6x2KmHSRzOdwY=;
        b=F/0qDH6GWYB9a/ELBeOi8ncY+MlxBc6m8Y0XXYgvXTnCGRD0Ex4C6+PvBo8njoR3n0
         x298n1Tp7BIBWIOfAzwRKqlOo2P8anV7IgAJDctsnDO2p0gFsnFkhz8s22xy1PErz5CE
         NFXcGX52zDRBWdlToN+fadssLcpVS+a0yhv6d5ZlkubbtnC4rlP6MXQ0JfKjZCgn+0ZF
         AsCbycn4fj0lqUbkO0WK5lnwa4n/41+8zafowPvMxpPJg9MCNtT0ZAHsgwdIo8pjpDaU
         spnw7u7yVs53XfsW+I+KWDjg5QjKuwQ9PndkXn7bK7++m18HNCRI6HI8Oam4GgXDKmuv
         6uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346188; x=1766950988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GctpRVvWLzNDhKjavWD61S0hk8FYU6x2KmHSRzOdwY=;
        b=iy/k6QDppDcZNSTq/rSZlMl717NpFEhzGS1xkz6BCafwbWvRAkoWT7KUspAtvMxkq+
         jRMfNwIOOoVQoDQopiG56pMWD1+oF+9ie1uV5fcPzwfLYzmFqCRn+PQX22NrwbFjWuhP
         /484WhTOj6oLyApZZ+Ofef+JcZG7V6r5IJ7yZ1AqePBjHcpTiDd/W2/baeqjzFTm8oTO
         lVVPcllJM676I1NB2lvrpiFJD7X7k646mbT1QarDKNRtZE/oMWutrfHffLKZLgE4hNkM
         GqqTNCDfXO4YnTkKs8n4RWZQfuMHXaupIKj4BcXvVc0gS7ybePCxTkvBy6DinFu+BGr9
         AEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnNUQE0+ElsAmGcjxx2DQq6RIiPigcuMmm97SIOfa7pGDrkuiqTqLd6fU8RSNQs7KBxKRigPaNEpa08U5N3Sb0XuDbqvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwojT3XFK9bEh1Jclcb+JuWZrgyGo+L0A2jMbw0GSReOwkurh
	gJBn2A2tIr6OPnMJhdo2D8qOLQx6qsMdGo+SPDfA+553Eu+14qxCUjfX
X-Gm-Gg: AY/fxX5AVp5tv4TXD7nSAr5Ly4L0C88D0B3fafVZbRIcFfAph/0CvhewDLX3s9EmqNQ
	erSyJhNvhSe7+AMHGfXYjP95ye/p+IrXYc1DxMUtNONkNNG7dgOPbx9PA2ofcVnUjgYORAS7eF6
	1pjwtiHEdlhlIXZwxWr2NPDaELeLt/O7WPZsOfSZndIYF0tR/og52gb3RI4LwNxxI152ZQ/eRSs
	DrjPqhs7bSHBm4omIDAMszWhYfvGYLIcmKJl03a6fcNCvTYRb+zMnNSl8v2mz3QDl2fpkP3Mcj2
	zvVTrGet7WsX9HCTtGC7T3uE9c7QFnRL8ax3pR29KXql8frtqNwPhXCr0u51SxMIrTA4L3hU8Ea
	rMaAPw6QASs6kxFQdVBuFOcjyhU7bkrQp/vZFxpyF5ARGR+Mk9Q0sjhJyrfCT9/m8mi6SWa/m/b
	BV8nPzOwdwL8qlEXhGFgMELX9LMWX34fBEJg6j32RLTOgs/x6d2GvyI83KwVKS
X-Google-Smtp-Source: AGHT+IEBzAhCbz0sh2sqafXlzVpJ6Mgc/35ugr3XmQZ4FphbT1R2TDRz1hA+Hr4joynoX4Yq3usVhg==
X-Received: by 2002:a05:690c:680c:b0:78c:2d26:a53e with SMTP id 00721157ae682-78fb4003f33mr82906797b3.45.1766346187642;
        Sun, 21 Dec 2025 11:43:07 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:07 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 0/6] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 21 Dec 2025 14:42:55 -0500
Message-ID: <20251221194301.247484-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is version 6 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This version of the series focuses again on simplification and
cleanup.

Behavior of the flag is identical to the previous patch.

This series is rebased on v7 of Tingmao Wang's "quiet flag" series.

Previous patch summary:

The new flag enables policies where a parent directory needs broader
access than its children. For example, a sandbox may permit read-write
access to /home/user but still prohibit writes to ~/.bashrc or
~/.ssh, even though they are nested beneath the parent. Today this is
not possible because access rights always propagate from parent to
child inodes.

When a rule is added with LANDLOCK_ADD_RULE_NO_INHERIT:

  * access rights on parent inodes are ignored for that inode and its
    descendants; and
  * operations that reparent, rename, or remove the tagged inode or
    its ancestors (via rename, rmdir, link) are denied up to the VFS
    root; and
  * parent flags do not propagate below a NO_INHERIT rule.

These parent-directory restrictions help mitigate sandbox-restart
attacks: a sandboxed process could otherwise move a protected
directory before exit, causing the next sandbox instance to apply its
policy to the wrong path.

Changes since v5:

  1. Retain existing documentation for path traversal in
     is_access_to_paths_allowed.
  2. Change conditional for path walk in is_access_to_paths_allowed
     removing possibility of infinite loop and renamed constant.
  3. Remove (now) redundant mnt_root parameter from
     collect_domain_accesses.
  4. Change path parameter to a dentry for
     deny_no_inherit_topology_change because only the dentry was needed.
  5. Remove duplicated tree diagram comment from selftests.
  6. Minor documentation fixes.

  Credit to Tingmao Wang for pointing out 1, 2, 3, 4, and 6.

Changes since v4:

  1. Trimmed 120 lines from core implementation in fs.c.
  2. Centralized path traversal logic with a helper function
     landlock_walk_path_up.
  3. Fixed bug in test on applying LANDLOCK_ADD_RULE_NO_INHERIT on
     a file, giving it valid access rights.
  4. Restructured commits to allow independent builds.
  5. Adds userspace API documentation for the flag.

Changes since v3:

  1. Trimmed core implementation in fs.c by removing redundant functions.
  2. Fixed placement/inclusion of prototypes.
  3. Added 4 new selftests for bind mount cases.
  4. Protections now apply up to the VFS root instead of the mountpoint
     root.

Links:

v1:
  https://lore.kernel.org/linux-security-module/20251105180019.1432367-1-utilityemal77@gmail.com/
v2:
  https://lore.kernel.org/linux-security-module/20251120222346.1157004-1-utilityemal77@gmail.com/
v3:
  https://lore.kernel.org/linux-security-module/20251126122039.3832162-1-utilityemal77@gmail.com/
v4:
  https://lore.kernel.org/linux-security-module/20251207015132.800576-1-utilityemal77@gmail.com/
v5:
  https://lore.kernel.org/linux-security-module/20251214170548.408142-1-utilityemal77@gmail.com/
quiet-flag v6:
  https://lore.kernel.org/linux-security-module/cover.1765040503.git.m@maowtm.org/

Example usage:

  # LL_FS_RO="/a/b/c" LL_FS_RW="/" LL_FS_NO_INHERIT="/a/b/c"
    landlock-sandboxer sh
  # touch /a/b/c/fi                    # denied; / RW does not inherit
  # rmdir /a/b/c                       # denied by ancestor protections
  # mv /a /bad                         # denied
  # mkdir /a/good; touch /a/good/fi    # allowed; unrelated path

All tests added by this series, and all other existing landlock tests,
are passing. This patch was also validated through checkpatch.pl.

Special thanks to Tingmao Wang and Mickaël Salaün for your valuable
feedback.

Thank you for your time and review.

Regards,
Justin Suess

Justin Suess (6):
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst   |  17 +
 include/uapi/linux/landlock.h              |  29 +
 samples/landlock/sandboxer.c               |  13 +-
 security/landlock/fs.c                     | 250 ++++++--
 security/landlock/ruleset.c                | 108 +++-
 security/landlock/ruleset.h                |  28 +-
 security/landlock/syscalls.c               |  16 +-
 tools/testing/selftests/landlock/fs_test.c | 704 +++++++++++++++++++++
 8 files changed, 1102 insertions(+), 63 deletions(-)


base-commit: 1c618dbb98a3d2346940bddc890a49a5cd7dcbdc
-- 
2.51.0

