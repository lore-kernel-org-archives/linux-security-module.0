Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3A35E943
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019541; cv=none; b=mD1h+v0AFEEGeBqSeeIPano/W7bSYj5lLDlHJSsysUCT0NMXYfal7guvKYjfIbHfJZXk2NzOSUvW+wJJ7tNvOQVJN87vBN3fZ2Qzf7c53cmlhd9DOCNXz9GTjix06CnkJeJBOky8/VXWw0nECumKc3pj2ygbaQ0gxVD7d5oC1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019541; c=relaxed/simple;
	bh=Sfy5lBI2UpD8hPcmETRVPhoT8P++bnalyeydPh43z0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHrai6ekc4HPvu5Xhye/Ni+gptmz+qOkT1HSzOq2mtBXaLXCu0/ZcM61x3YnLvBxxHYNnmekC7SALSHnw2Z8CN7QMLC0AkFAHu03zjGah6AUtXUHt8xJtguEdRo2dO2mr86X9FsAHcb/7HpkTNeb+hWwrdEqyf65AmWKzBdf3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVJ3dRi7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVJ3dRi7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ca947f9b00so131999687b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019538; x=1780624338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9le/T9kFIjXWUzy+CDF583KFs3CKgVSv+9SQA6Gxb9c=;
        b=qVJ3dRi7kmosacJeVI+lJUttIgkRRhireSygIQqyQgbY5KgvWyVx6nelRsRA525GJv
         HafhVeMRYbFRTmveqL3O0o2Z9ykbD+E7ngSNe/P+aeOeWRsaMHKi1TDoLVsHUJlQW49W
         PlwIdaAjOMLWk7uHsYbZBC1yutk0oyE6F/fYOBogKm2AjS6DryvEkYA8Nv2mV6r8j8mz
         K6VQnrOGoeoqOruYARQ2CxJfrMeF0wwZl59GuekOIsbVSK7pBWlB5gHbEWH2eX/diSyi
         NSWBUnsiuipBMZrdbCnWUBwl5L7ngXkkW5cpGwBfiwpzk1TJj0kCz/ttzhqJn93kXpnY
         CZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019538; x=1780624338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9le/T9kFIjXWUzy+CDF583KFs3CKgVSv+9SQA6Gxb9c=;
        b=frYI7OGHPQO07XgSRKC0RHTiTHEp796g1PFUByFe9yqA7St2y6IQFY8JlsGeqsstuF
         DRzYVXYtHkbSLNIwCGwEsNGKjDN1bLYGbl8chkw34jR+tVj1UZbR3onPbzR7/xcNi+35
         cX3x8uZEoa1h8miitwQGzolQhpeDQW2EAf6xTbnsAhGOCjd0/lUkdTUttRV+sQpjm/91
         vy4Tn6w/OiNJlLJkAiynFXFO2Kw+4WV2xSqikrPUvBrz5jUuSX0aLSta85y/JXSn2XJG
         CaaJffnakZDxczZhiiFX2piLbpoWnPax1J2kaJ/tYgL3M6FolIhRn7UhZfUBnlxG9FDo
         x6XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iINLRe/zwOSewN6hnsxNSUuQfoF+LlnWthhvv3UfiVBmvfYlPgEIjwo9AWc3Yz6TtmHudAKSJpJUONEffPI/bgLjlqDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfXDjuAS1JfxQPR1YjqmOWHUHT5Jr/Vis8QwWtXBFEM3MklIv
	CvOTq2sApNgLE94UUs3cibfxCILDjg3yCNEdiXF3g6AIjUDnZOrnvxMF
X-Gm-Gg: Acq92OF1mnSbMHB+RXWZ0zugMIC2Id1wcgVY95IHKBJS39KCokSQ4ZDxKzIcmWOH/VM
	SozWcCZQuCjEupa8JUyusRWDt2OUOKb1NGtdOT/+KiczgYeiABIj1PjrhdwOdW2JNFPT0CwoE+M
	YxckkohPoORxRH1HVNrTKtiH6x8PzBPJV2Ca2txsgnjuDEnAGfgNXmR3vY6LEvU8R/Jm+eIZOIB
	QF48lKqlkvBiHxsW2b0edlollfwWadccZTqBPvnFYSxcBcErCfxDeTej99kmwfBPqOId68W/2mb
	lZ16VJrlCsMGiNPuaDiAQJmWpTH7oPlSOKwy26X1HW9MV/RcV/UcU0ndlPoaGomiSjSltp/Q7e2
	CdUobU+S0BunZpyViD5ZbjGyNmFgRTVx1f3dwsvMTY6XJDT5cEJQ9IiXQDvVl2iH1HOtx+jaAzv
	BRI64NGZKiVAOyiaOZqtWfGmPtHvj+CA8QfoTK0/44ysI2Nvoh5CiuYEGVNkCSFZYffmskQtkjS
	MrGpOLi350=
X-Received: by 2002:a05:690c:e344:b0:7dc:2161:825e with SMTP id 00721157ae682-7de44faa2bfmr7635097b3.19.1780019537834;
        Thu, 28 May 2026 18:52:17 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:17 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 00/10] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 28 May 2026 21:51:59 -0400
Message-ID: <20260529015210.500291-1-utilityemal77@gmail.com>
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

This is version 8 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

This version is mostly cleanup: a preparatory patch was replaced to
avoid needing to move find_rule(), the no_inherit bookkeeping was
folded into the existing per-layer mask, syscall flag validation was
centralized, and the selftest coverage was reorganized around
fixtures and variants to cut roughly 290 lines of near-duplicate test
code while keeping equivalent coverage.

Behavior of the flag is identical to the previous version.

This series remains rebased on v9 of Tingmao Wang's "quiet flag"
series.

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

Changes since v7:

  1. Replaced the v7 "Move find_rule definition above
     landlock_append_fs_rule" preparatory patch with a new
     preparatory patch that makes landlock_insert_rule() return the
     inserted struct landlock_rule * via ERR_PTR(). The core
     implementation patch now tags ancestor rules directly from the
     return value, removing the find_rule() round trip after
     insertion.
  2. Folded the no_inherit / has_no_inherit_descendant bookkeeping
     into the existing struct layer_mask as a single per-layer
     no_inherit bit. The separate collected_rule_flags fields
     (no_inherit_masks, no_inherit_desc_masks) are gone;
     landlock_unmask_layers() now skips layers whose mask already has
     no_inherit set, and landlock_init_layer_masks() clears the new
     bit on initialization.
  3. has_no_inherit_descendant is now auto-set on the rule's own
     object when LANDLOCK_ADD_RULE_NO_INHERIT is passed, sealing it
     against topology changes without requiring a separate blank-rule
     insertion.
  4. Centralized flag validation in sys_landlock_add_rule(): a single
     mask check rejects unknown flags, and NO_INHERIT on any rule
     type other than path-beneath is rejected at the syscall entry
     point. The redundant per-rule-type NO_INHERIT check in
     add_rule_net_port() was removed.
  5. collect_domain_accesses() now takes a single struct path *
     instead of separate mnt_root/dir parameters, matching
     is_access_to_paths_allowed(). The disconnected-directory stop
     condition was tightened with an explicit !d_unhashed() check at
     the mount root.
  6. deny_no_inherit_topology_change() dropped its override_layers
     accumulator (it was always 0 in practice) and now just
     OR-collects sealed layers.
  7. Selftest coverage in fs_test.c was reorganized around fixtures
     and variants: the v7 layout1 tests collapse into a
     layout1_no_inherit fixture with five variants and three shared
     tests; the four v7 layout4 mount tests collapse into a single
     variant + test; and a new audit_no_inherit fixture replaces the
     ad hoc audit case. Net change: 705 added lines in v7 -> 419
     added lines in v8, with equivalent coverage.
  8. The single KUnit test was expanded into five focused tests
     covering propagation, skip, both-set, multi-layer, and
     sequential-walk behavior of the per-layer no_inherit bit.
  9. UAPI and userspace-api documentation reworded for clarity. The
     new EINVAL case (NO_INHERIT on unsupported rule types) is
     documented in the syscall kernel-doc.
  10. Various commit messages reworded; switch arms in
      is_access_to_paths_allowed() reordered so the fast path comes
      first.

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
v6:
  https://lore.kernel.org/linux-security-module/20260118000000.000000-1-utilityemal77@gmail.com/
v7:
  https://lore.kernel.org/linux-security-module/20260412193214.87072-1-utilityemal77@gmail.com/
quiet-flag v6:
  https://lore.kernel.org/linux-security-module/cover.1765040503.git.m@maowtm.org/
quiet-flag v7:
  https://lore.kernel.org/linux-security-module/cover.1766330134.git.m@maowtm.org/
quiet-flag v8:
  https://lore.kernel.org/linux-security-module/cover.1775490344.git.m@maowtm.org/
quiet-flag v9:
  https://lore.kernel.org/linux-security-module/cover.1779843375.git.m@maowtm.org/

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
  landlock: Add landlock_walk_path_up() helper
  landlock: Use landlock_walk_path_up() in is_access_to_paths_allowed()
  landlock: Use landlock_walk_path_up() in collect_domain_accesses()
  landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT user API
  landlock: Return inserted rule from landlock_insert_rule()
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Add selftests for LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add KUnit tests for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst   |  18 ++
 include/uapi/linux/landlock.h              |  24 ++
 samples/landlock/sandboxer.c               |  13 +-
 security/landlock/access.h                 |   4 +
 security/landlock/fs.c                     | 290 ++++++++++++++------
 security/landlock/net.c                    |   8 +-
 security/landlock/ruleset.c                | 280 ++++++++++++++++---
 security/landlock/ruleset.h                |  20 +-
 security/landlock/syscalls.c               |  14 +-
 tools/testing/selftests/landlock/fs_test.c | 419 +++++++++++++++++++++++++++++
 10 files changed, 966 insertions(+), 124 deletions(-)

--
2.53.0

Justin Suess (10):
  landlock: Add landlock_walk_path_up() helper
  landlock: Use landlock_walk_path_up() in is_access_to_paths_allowed()
  landlock: Use landlock_walk_path_up() in collect_domain_accesses()
  landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT user API
  landlock: Return inserted rule from landlock_insert_rule()
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Add selftests for LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add KUnit tests for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst   |  18 +
 include/uapi/linux/landlock.h              |  24 ++
 samples/landlock/sandboxer.c               |  13 +-
 security/landlock/access.h                 |   4 +
 security/landlock/fs.c                     | 290 ++++++++++----
 security/landlock/net.c                    |   8 +-
 security/landlock/ruleset.c                | 280 ++++++++++++--
 security/landlock/ruleset.h                |  20 +-
 security/landlock/syscalls.c               |  14 +-
 tools/testing/selftests/landlock/fs_test.c | 419 +++++++++++++++++++++
 10 files changed, 966 insertions(+), 124 deletions(-)


base-commit: fe7832557561ed6312563368854d5f8df1fa55e3
prerequisite-patch-id: e3aaf6d74feae4e831f7ecf033987028f2b9fa89
prerequisite-patch-id: c0fe2c5da8481b5712e4289ed969e5374a8d3d14
prerequisite-patch-id: 7af9880bb7747f3b4e1dc38c405ea84256ffb853
prerequisite-patch-id: 707ec2e5bb927ab78302e2500ca9c4ed0af74c26
prerequisite-patch-id: 4fc670726f25b501ed244ad6177e24ec833642bc
prerequisite-patch-id: 90971f3bce38e63ab6c829c1daf34e0f343003dd
prerequisite-patch-id: cf58f275348749ab5adf03ccba5fd6f11a349fce
prerequisite-patch-id: 34a66721c66f731e7aa45a7ccab6eacb24e0218e
prerequisite-patch-id: 3d5eb906e6e923a85b9b9eeb12ed3bc3b69ee366
-- 
2.53.0

