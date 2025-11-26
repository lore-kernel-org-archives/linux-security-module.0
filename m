Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93332548C
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159663; cv=none; b=JYH4lKsEPDD6Mzfr+gQWV6wNQC9+Z3MuO0EIt2BhYUbSPCZZTO7iTuN5X4RGBrthUVaVGVBWHt2l964Cmaf5TyGCXLGgfcaoaEV5iloLUhxSfYn4poCN3yZ3/rkpKoIQ13l1qwakLtNsZc4iD35YkegUrJJLa3X79ZEYTvttEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159663; c=relaxed/simple;
	bh=2E+g5p4cEprS/45HbUHjW0yxFWxK/bXqVJuVqw8gy3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNFdRU8QUCExULrxYSAYK0D4NbJc5TNTtEm2f9KOfoc/Qg6RA7QPNlL7ZAtSNEos1fuKSKY3V7ZPgnV33UfEkFkMdMulH22S99jPJM/TO+bfMB3ml6PznEm0c5m6My7xJTX8CaXySBHTwKxIcgTihBoeZq8wZUAl2LyByLK6aK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjkp14F+; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjkp14F+"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6420c08f886so7389408d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159659; x=1764764459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9Ab09/UcTrv1kpP/+RgwXAxpWxQ53AVhlGYLn/gPto=;
        b=Pjkp14F+hY7fJYnWmesHPiIFlDu4hJ3IpT4+os94/s6SmvGISLO0h+zTTmi7bPfpPp
         I1QsSgBsjVFmkGL3RsGBvgJb5LILKfiwTPsdjZJMwmIKu20HYNFroNGpWcNOq3U8/WbG
         yNLhzH5CquOjKmIKM+IVPKaNZw8KQjdcGPLzZveZd9ZP+qRuEc+HYsr+g3cYVPepLdhL
         fcFFmbcap49VTi14ib6J2Utc515ZJ2ftHVVsJAOBfWIqvDzvAGv7RAEcKjSv0mTuOfOf
         5oKps6ZQoCAsF9sa81ZUW7jRJOSGaaUTJp/M68vTNwVasAOzEudNO2ozRA0lD1LkD2u4
         FoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159659; x=1764764459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9Ab09/UcTrv1kpP/+RgwXAxpWxQ53AVhlGYLn/gPto=;
        b=Ua1zrSHzS6vUwYrkw7hn/5Ow6I31u+SNvg5KLn95dV7lqjexCoqKCekNZNNHAhEs65
         O+ePHeWdF/KlhbcGJUBCbCoKuoM2pRL+vqUsVkJymzMK1rsbc2/ZQWCCAyr6Egmt3SAy
         EoMBC64pdxTb5B8cED9oqdrWVARF5AkDoRKsfrll5fCRCgibSZ49qFYw3KJrdYfpsyIY
         /GgKT8UXEzyCxd8Q9EdNozryrTTqSoAPKhWj/aaCJQFcI+g2tolbLGE/EDilev8rhvjM
         i9QvA/JjtE5F05zP7WZdF6uSy5apaohBF1s169BsMrYcIxkC0csKxZsmwclHOYs+m43w
         vMBg==
X-Gm-Message-State: AOJu0YxOcjpye4Bm/kzAVmHNiazgeysWTLr35jPflhCWSj8EYKPO6Z5u
	U2l7337QGaD03VU7uGovi6nwSki3P4FN/mUeJ3FUwqkfYfsws2nh0H5eebBo5vJX
X-Gm-Gg: ASbGncsUpAayN5jJuu1p2Gv3+L9xlALdjbRq2pav8wCbAka+sCZh0aqjKWa6S9x4hsc
	0gkk9dIjzQkXPOlzUlTNQYoJdolN2/5YBGpR6mFmsrtSuo+DA6Cy9dtDpbhm0VTq/1Y/tEUtlFG
	VJZt5nzRkWCogMvKjfx8PT6fNysosvRCA5K6hJu/PIAM2ng/eQZ2moPvHwcKeljK/eAEhbHZj6G
	lHXM+WaQdVAvwJPFvyo2poHQk+H6aXnjuTqSfeW8gTM9dFQcOcQX3rHqy+WopQ4xhopJtGX/WEU
	HePeqODTPlYlB6PvPXszZV+pmPe38VTyLun29HxcGDvX3n1bCFU9Cyh1hrEgT2H3vTvQ2F+TEDn
	rbccwF2KnvCQ4G4ZyYftRTCiOUILM3VMtMaa6Jn49GOXhoV81Z9e2sSua8Nt/Vk0y6KtEIdU+JY
	bnNsktkV3ghlD4H9l6E2m+/FuJ9DFeE6S/TAGVJCJqrydAPvM7FFcsUT5ai0q5
X-Google-Smtp-Source: AGHT+IHCWR6hr8ET+nundcG/kc3ppoHvron4pYkBE2/YEpDx512CXK61itaijFo/fL8X8SxUA1ATwQ==
X-Received: by 2002:a05:690c:e1f:b0:786:506c:3cc4 with SMTP id 00721157ae682-78a8b559ea1mr163788207b3.53.1764159658851;
        Wed, 26 Nov 2025 04:20:58 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:20:58 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 0/5] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed, 26 Nov 2025 07:20:33 -0500
Message-ID: <20251126122039.3832162-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is version 3 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This series is rebased on v5 of Tingmao Wang's "quiet flag" series.

The new flag enables policies where a parent directory needs broader
access than its children. For example, a sandbox may permit read-write
access to /home/user but still prohibit writes to ~/.bashrc or
~/.ssh, even though they are nested beneath the parent. Today this is
not possible because access rights always propagate from parent to
child within a layer.

When a rule is added with LANDLOCK_ADD_RULE_NO_INHERIT:

  * access rights on parent inodes are ignored for that inode and its
    descendants; and
  * operations that change the direct parent subtree of such objects
    (rename, rmdir, link) are denied up to the mountpoint; and
  * parent flags do not propagate below a NO_INHERIT rule (new in v3).

These parent-directory restrictions help mitigate sandbox-restart
attacks: a sandboxed process could otherwise move a protected
directory before exit, causing the next sandbox instance to apply its
policy to the wrong path.

Changes since v2:

  1. Add six new selftests for the new flag.
  2. Add an optimization to stop permission harvesting when all
     relevant layers are tagged with NO_INHERIT.
  3. Suppress inheritance of parent flags.
  4. Rebase onto v5 of the quiet-flag series.
  5. Remove the xarray structure used for flag tracking in favor of
     blank rule insertion, simplifying the implementation.
  6. Fix edge cases involving flag inheritance across multiple
     NO_INHERIT layers.
  7. Add documenting comments to new functions.

Links:

v1:
  https://lore.kernel.org/linux-security-module/20251105180019.1432367-1-utilityemal77@gmail.com/T/#t
v2:
  https://lore.kernel.org/linux-security-module/20251120222346.1157004-1-utilityemal77@gmail.com/T/#t
quiet-flag v5:
  https://lore.kernel.org/linux-security-module/cover.1763931318.git.m@maowtm.org/T/#t

Example usage:

  # LL_FS_RO="" LL_FS_RW="/" LL_FS_RO_NO_INHERIT="/a/b/c" landlock-sandboxer sh
  # touch /a/b/c/fi                    # denied; / RW does not inherit
  # rmdir /a/b/c                       # denied due to parent-directory protections
  # mv /a /bad                         # denied
  # mkdir /a/good; touch /a/good/fi    # allowed; unrelated path

If preferred, I'm happy to split the selftests into multiple commits.

I am particularly interested in feedback on:

  * The soundness of inserting blank rules in ensure_rule_for_dentry.
    A zero-access rule is lazily inserted into parent directories on
    first access to enforce topology-change protections. This replaces
    the prior xarray tracking, and should reduce complexity and improve
    performance.

  * Additional edge cases that should be covered by new tests.

  * Performance implications of the current design.

All existing Landlock selftests and KUnit tests, as well as the new
tests added in this series, are passing.

Thank you for your time and review.

Regards,
Justin Suess

Justin Suess (5):
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Implement selftests for
    LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT

 include/uapi/linux/landlock.h              |  29 +
 samples/landlock/sandboxer.c               |  37 +-
 security/landlock/audit.c                  |   4 +-
 security/landlock/domain.c                 |   4 +-
 security/landlock/fs.c                     | 592 ++++++++++++++++++++-
 security/landlock/ruleset.c                | 116 +++-
 security/landlock/ruleset.h                |  36 +-
 security/landlock/syscalls.c               |  14 +-
 tools/testing/selftests/landlock/fs_test.c | 459 +++++++++++++++-
 9 files changed, 1249 insertions(+), 42 deletions(-)


base-commit: 91d200c5385c926c8d1f2df33a8a4160924fa977
-- 
2.51.0

