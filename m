Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857761A9FA4
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022346; cv=none; b=GMu0ITEjbvymC9k5bblmuB8OXgUDVaoFVkou51lsotiQP/z0b+vtrokeqDxcASN5Ey2OSv0jDg5JKrssh+G34TaucyMwhUqzfsJG9N8viPg00KWBh0cqlGnQNgfusNZAvupDPUfwdLZblS8l9JN3NaZbTHBS3VC99BArZrRs9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022346; c=relaxed/simple;
	bh=yw5tfiCGhnu6M1SAL0QjS4LB5FREg1qT/tFfu/147Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQAkMdyNJqj2U/joCUuv9hoWaUO7wazv/V36Ez99a5rEsEDfJlgEnPLhN5Ieo18R9i+dXrPn1zgZl22hgOhw8Un4uazqmlFmiZRxY4FEhaf4rQhxrdrdE6Zte1NbFtUdgSE2ne/0WK6avMi2JbCuA/QfA1hPcAc7YtK/l5tnK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soXKtS8d; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soXKtS8d"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a2ee65171so38048157b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022344; x=1776627144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/lgaoU9KTxQ3aanDpqBxSJ4YYsKT2wzhbPPwY2d8uk=;
        b=soXKtS8d0FKZUWa4paTwivQRRHepQ3n4jB6G4zw18mMSH3800HVlQUinPmQdJIiqkB
         P8v8wbCjGYv76zvSJGP3WtYKAfRPkgxdyq89q5cBnejMepIlo3DOMgivFgI+gzlWuLgW
         MNfRXJNIDge4CIye9VVqDrx9dEo55a7MXtr+IBPo9mmycthKeZd2R5CCjMZOd058F0OW
         NfHAy8o5NpjCBaRXl2AVIXZqQ0OVNu/NS6/y/0SaR8Nc4SVCyTUvv9U9PopK0aCEwehW
         F+Dyne5FtZpHv9IKKCiZNZziWjs7nR93XIaH2pFn4Iy6Ie8wN9/SJiC72kX86j+R1TZa
         8u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022344; x=1776627144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/lgaoU9KTxQ3aanDpqBxSJ4YYsKT2wzhbPPwY2d8uk=;
        b=pot6o44nYpJUsTfSKZEpQc5X628ab48QXqgN0/OOst28NITv1HBbCpwdaaErdz8W4x
         mZbFY+jTUlsZFurYxqJ1bBtyqSiWGsuSwxTbSApZOxxGsirH4/so54Neo/Vk78gXeShq
         PUdUY4EfiexkS2i/lywR8F/7IXlb8DDlpHK6WGXA7MXV4HAq/nnypN1ghcrfjP7ojiCI
         xPz7gaGZehtQ4LGrXC9ou1jqbh85O3b7RPqFurpIDImheRIfRoAn9eoOVlWw95LG3w6y
         qPng1HbunZf5/J9WxFU9Kwfo6d2llj20lIzT73hOux5O4lmWgITnUOeNQezF17x8cu1E
         w3Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8T17uvmG7R6Kop4SQOASQN6/5e9xBC3NmqJhA0gzIV6YahflwLy5tKmgr9QYYeTfdQPiBM6Mk8hmyFhEPeK3wzxzIiXtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNCzj7L1QtqlHBUJt5HuZCdB0WTgZ3Zo/nbW35f88OUyUGye5
	dH4ADN6F7iUfjgdN9qDAp4Uqy6mO3u6ylOr52Ogo6KHXxkjinyULkTqW
X-Gm-Gg: AeBDietnihGV7ZdpEPXxSno99ebRycEhGvanypaeG0zBKtR9rWKt5hRkERiPUxGzv/L
	ci+EB59Oe8CucP3BrZ45m4x/tkaRIMmlcDzbTKTdM9P4XS+3fce6U6cB2Ft2HKBvEwVWyQJIjIU
	mKh0QAxsS4I7tuqBTJ8HO12cxkxeGp4Cnr888XVOtpFpz+2MJoL2BbzuBKq9flxoFd7AYaI/ew4
	MnOKgJSBCxKUH+k6SEnI+xk+KjorDKv8GItS0TFHcJJOBIPM7wTVa8n03kCugqBH3aDxhGRpdnS
	/svGwh6gp7Nf/NzktH4L+YFJS98q2dGtyqfsmNS32toeQPd/l5g2wDk1rmi0P5gJ9N41DyX5gIv
	tbaTYfcuUkqcOi3fbsZMRcxS05q3d83It4DttK2GevX2j2e12p7vcAokCq5xe1VrtbQf87mopDr
	OzN62Qf0fQS/OurYb+8Pmn1cX2+gF+ckpPZaW0iW9NQSJZNHu799poK70US4mLDSsoXYXGOvsc
X-Received: by 2002:a05:690c:13:b0:79b:dfc1:9c4e with SMTP id 00721157ae682-7af7147823dmr121652957b3.27.1776022344362;
        Sun, 12 Apr 2026 12:32:24 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:24 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 00/10] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 12 Apr 2026 15:31:51 -0400
Message-ID: <20260412193214.87072-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is version 7 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This version of the series focuses again on cleanup, splitting out
some patches and fixing an edge case with disconnected directories.

Behavior of the flag is identical to the previous patch.

This series is rebased on v8 of Tingmao Wang's "quiet flag" series.

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

Changes since v6:

  1. The main implementation of NO_INHERIT was split into smaller more
     reviewable patches, separating the landlock_walk_path_up
     implementation, usages of landlock_walk_path_up, and the find_rule
     move to separate patches
  2. A small issue regarding disconnected directory handling, where rules
     inserted with NO_INHERIT only had protection up to a disconnected
     directory instead of the mountpoint was fixed. In practice, this
     isn't a problem at the current time since landlock forbids the mount
     syscall needed to move a mountpoint with MS_MOVE. However, for
     future-proofing in the case landlock allows some mount operations,
     restrictions on parent directories now apply to the real root.

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
quiet-flag v7:
  https://lore.kernel.org/linux-security-module/cover.1766330134.git.m@maowtm.org/
quiet-flag v8:
  https://lore.kernel.org/linux-security-module/cover.1775490344.git.m@maowtm.org/

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

Justin Suess (10):
  landlock: Add path walk helper
  landlock: Use landlock_walk_path_up for is_access_to_paths_allowed
  landlock: Use landlock_walk_path_up for collect_domain_accesses
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  landlock: Move find_rule definition above landlock_append_fs_rule
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst   |  17 +
 include/uapi/linux/landlock.h              |  29 +-
 samples/landlock/sandboxer.c               |  11 +
 security/landlock/fs.c                     | 342 +++++++---
 security/landlock/ruleset.c                | 125 +++-
 security/landlock/ruleset.h                |  26 +
 security/landlock/syscalls.c               |  15 +-
 tools/testing/selftests/landlock/fs_test.c | 705 +++++++++++++++++++++
 8 files changed, 1151 insertions(+), 119 deletions(-)

-- 
2.53.0

