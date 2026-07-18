Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023F800
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784369841; cv=none; b=l37tRilrZmgas4dhKV/WCOhngrqhCmA3nvz34xELqZwqCOg92FS0as6LnEePHICIcrWCyJVL5+dVFZt2RzUhTImdKqOG5BX6gTf6oL8EmUDBUpy51YXhY+prNX0FWStFH1WOFrlNTWPVzk/PjMrAwXioI2xcDRYCyFs6tjFRQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784369841; c=relaxed/simple;
	bh=7zVFnqj1IOlr1FIe6x9u1+yIsQlFpQzZsRLG5pL0ukE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBKlQNuewtram4X3Vo9PwTG/5mPGFvYrYKF655/azZcasPo7lSIN5DbXxeVn5vigaeO9xrxK6LuBmSxlJ37CIl5+wg14Mxc5A/nVq4rkcS0wmjTX0w8pvELPbMNfYkKs5TwRo8tCFRz0UhprJrwdvTEKdgHin9oOwvLHm8Eq6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPSbgkD9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPSbgkD9"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so4672333a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784369839; x=1784974639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OucpGeCg3o38qUxtqbNVrYsZh3geEUQhy4DnGK8pnV0=;
        b=iPSbgkD9hDDvA96sqAqB5Vkqn7llssU1aglrKUCqBTRK/TEO0Z9m5e3YZkiiDLaZZk
         EQe9OzQtw9JL6EzWFeB1VG7ICVdOYk6I1PnTS+nY1MOq7UIwdmx6paUCBrywfep9Ztsz
         9pUc1/tnOdzdISaaWQphLeZkCed3Kqd0b8BH/Zkayk6SMnE9HMRuelJYHDZvLzqHdsqX
         6CobL+QcrnQi8sCYmXKnVJuU5z1+WGY+dWQ8yfejiu2sgzcblwZaljmfT6juz9GujZH9
         Svrxy29gfJhhD3UtpFeroea9gKpUfAeH6BrSvMmxKyF5V51AEM/t38dKRt8lsMLvoJuj
         Wt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784369839; x=1784974639;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OucpGeCg3o38qUxtqbNVrYsZh3geEUQhy4DnGK8pnV0=;
        b=o+3ic7nupunE7jH1xtGGQ5Nyv3Ef8kUhApIp00YvLZnED3Tg6c/mWDTeEfbyd6vsZC
         BZaj0zdRUQPI19/zGgljdOQqmILd9Mjp9tpkALrrS5xjTpOYEA1E8ymiKCrC/CdzBjB3
         X4+8l2OoOKvLxgU7WLTSeD8NwNNX+0gufS1DAyk1676P1wZkZUU8+9mIppMoRmomvRNZ
         yw1yGlxRRZgt26SH778P66Lep5eKXYVjYH7XyU7fOPBAZlbYqLWXqbIxqFU2Jj+1bJO8
         AF4E2lpt8SN2GJxRrEYcvtn7H+VKB6slFPZqqpH8RBHAqKWwsevEMzPGUscHneRMzcLn
         cv+A==
X-Forwarded-Encrypted: i=1; AHgh+RpuUPCaHGgBKvfTW+mBTnh89iN9/CREYUL25cA9OuFKE9X1BVB+HE+82PxgAM9R5g0k+dd4w9M6JNPtfgGSZh4q3YKLk7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUfgJtZngB7KmXTI1iUn7eyas7Ex7SKyL/9HwzOGIxTCNAceu
	RCY6uiTx157n4rPKpy7xYhOF/2ZBrGsQ49mSDaSTSBH0yC3iHc/XL6j0
X-Gm-Gg: AfdE7cl5aLJv3rCvfw4OMASaots61TrQlSSJWtKr3AOxcFaPUau9lsDfDEkDeBsuK4c
	3jmu2G7wX63c6kWPt71NxMFeIZ3gxnj5ZZLcC57grUS9wroioJcuWOmqX3dyaItb6UDQmLJHURR
	qR8h5JWWsIqCwyd9xrpfZHa5aGOZdWUDti16Q86+hADQ6wZnv7AQIQCWOgBkK/NeUiPCs1svHgu
	c52CssRhWWNabuUxN3g3CUbv/WtjJo4/lEa4aQeQ+b++4yXHTzCpDT0vPJWKmhoUU3YGZHtv4lU
	tvLinUsuSZp30DzbripTSK5unhZ8aucDhkKIvZ74MBl0QL/mxwCqLNnXFFs8IGmUtST3F9WnVSY
	+6ZMh9MxxJGXFg5KgGj4eKUDVCqY0JSezZhPUrDBZBLRQMhZM8pmx4tdRM4d7Ez3GtwKexRCxlW
	xKd0QpEfk9CduetSYCSQ==
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3c3ad97155fmr6864882637.50.1784369839524;
        Sat, 18 Jul 2026 03:17:19 -0700 (PDT)
Received: from vivek-LOQ-15IRX9 ([2401:4900:8ff9:29ed:7266:cb8f:1472:70bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm16271280eec.10.2026.07.18.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 03:17:19 -0700 (PDT)
From: Vivek Parikh <viv0411.parikh@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Vivek Parikh <viv0411.parikh@gmail.com>
Subject: Landlock: mount_setattr(2) is unmediated by LSMs (ro-mount confinement bypass)
Date: Sat, 18 Jul 2026 15:44:50 +0530
Message-ID: <20260718101540.309387-1-viv0411.parikh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Christian,

Note: this was found with AI assistance, so I am treating it as public per
Documentation/process/security-bugs.

While auditing Landlock's filesystem-topology restrictions I found that
mount_setattr(2) is not mediated by any LSM. It only matters for a
sandboxed task that holds CAP_SYS_ADMIN in its own user namespace -- the
rootful-container / userns-root profile that landlock_restrict_self()
explicitly supports (security/landlock/syscalls.c). Fully unprivileged
callers are not affected.

do_mount_setattr() (fs/namespace.c:4928) -> mount_setattr_prepare() has no
security_* hook anywhere on its path, whereas mount(2), move_mount(2),
umount(2), remount and pivot_root(2) all do (security_sb_mount,
security_move_mount, security_sb_umount, security_sb_remount,
security_sb_pivotroot). Landlock hooks exactly those five in
security/landlock/fs.c (hook_sb_mount, hook_move_mount, hook_sb_umount,
hook_sb_remount, hook_sb_pivotroot) but cannot see mount_setattr(2).

Documentation/userspace-api/landlock.rst ("Filesystem topology
modification") states that sandboxed threads cannot modify filesystem
topology, but such a task can still, via mount_setattr(2):

  1. Clear MOUNT_ATTR_RDONLY on a read-only (bind) mount and write through
     it -- subverting the common ro-bind-mount confinement pattern.
  2. Change mount propagation (shared/private/slave/unbindable).
  3. Request MOUNT_ATTR_IDMAP changes (narrower in practice: gated by
     can_idmap_mount()).

This is a mediation/coverage gap, not a rule-evaluation bug: Landlock's
filesystem access-rights checks still apply on top. The issue is that the
ro-mount / propagation / idmap layer of a confinement -- which sandbox
setups rely on -- is changeable despite the documented topology
restriction. It affects every LSM, not just Landlock (SELinux, AppArmor
and Smack cannot mediate mount_setattr(2) either).

A self-contained unprivileged reproducer (userns+mountns, no external
privilege) is available on request; I am not inlining it here. Its output,
on 7.0.0-27-generic (host) and reproduced on 7.2.0-rc3 (QEMU guest,
CONFIG_SECURITY_LANDLOCK=y):

  [1] write via ro mount before Landlock: Read-only file system (expected)
  [2] Landlock enforced (all fs accesses allowed via rule on /)
  [3] mount(2) under Landlock: Operation not permitted (expected EPERM)
  [4] mount_setattr(rw-flip) under Landlock: SUCCESS  <-- gap
  [5] write via formerly-ro mount: SUCCEEDED  <-- confinement subverted

mount(2) is correctly denied (step 3) while the equivalent attribute
change via mount_setattr(2) succeeds (step 4) and makes the previously
read-only tree writable (step 5).

I could not find an existing LSM hook for this in v7.2-rc3. If this is a
known and accepted limitation (the v30 Landlock series was synchronized
with mount_setattr(2)), then documenting it in landlock.rst -- the
"Filesystem topology modification" section currently names only mount(2)
and pivot_root(2) -- would already help. Otherwise, the consistent fix
would be to add a security_sb_mount_setattr() LSM hook in
do_mount_setattr() and wire Landlock's topology denial to it, mirroring
hook_sb_remount(). I am happy to prepare that patch (plus a
tools/testing/selftests/landlock/ test) if you agree with the direction.

Thanks,
Vivek
