Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CC1D88D7
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013949; cv=none; b=sLSEye4motGHmyOhTz/5vM04P1oZyuGEfuIehrg7FIjHnNpaxa7jVv99LgUsxiva4abRZJ6mgQ6EjthSI9db255GMWJ3kUgSa2CQv46Ui5nFFuHlhV7qunlseMrzbmrRXMtJp/sqe5xBcPWBFE5wlDFd/lWLhnRzbmj9zyfYgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013949; c=relaxed/simple;
	bh=l/rvVASUfB5T6fKHydlJpu9ZwCfBT8Np29Hx3flQmmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HvVajq+OLaDwFhaNe1dVppFwfwaV60cChhucQYvYGPZahrFfxKS/KrHvNi0hfzqZHQAzipsY6P/uZMTBGiKWr+It2zjJ72AwUelRUoFO+v/qLBC8s4LH0hmTGEDqAdCtNzmajbcidzuW8HVYWLtW3PpXsS5Btu7+bCSV8hmK0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCzk40QM; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCzk40QM"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662fa4a4470so2577189d50.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013947; x=1782618747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtvN+7p2XXtTZ7Qc/Dr4zrSdehbGOMVRBol5eVNLO38=;
        b=VCzk40QMX3jSddL8lTpktqsT24PjsKCAvIPmzMYvVC+1QFE0iPGoaO/OuLEoxbeIT2
         hqkmI5hKBYILUWuN8CfUQ+3U55+84DifILRBttXEGTRHcUmcu56uharHbmNXcUmsj8kL
         /no9bYxgTT0tKUrrtpBj+HMDIupnnqYn352+NmocH3ucezcxRsChkqcth/mUXjnj3LUd
         5X1BdbJems1kF7kx1PFfvYeNmsryhNMrD5uMxo+iZK91qGXhof78wlMcQlOx9HtfHt41
         7NpxiH7KCg2E/Rdl2wCdZC7MINudWaxrccCidl6wgxcjN23zY0A+e9As1WTlV9B1SY07
         LKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013947; x=1782618747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtvN+7p2XXtTZ7Qc/Dr4zrSdehbGOMVRBol5eVNLO38=;
        b=YOlOoPm4TD2NzOsAvljykhR3qG+PHSDqNG4U99fALM2OE0Bl3b6nHCcibCMNHXiU7O
         BRt3nsQYFnK69jhBaWTzkh+pAv+dhK7iV1AnIrZUIE14Q6VDebukI3Svbz6mvBCCw+Am
         QBJYLlSLx/x3+arItddSkEEX8QPEuHqRvi9z8BflrwGpxGwjz5JsVGjkgugs3OnFQVWx
         Gy9zN6pdcmi8YpYz/LieI9cd1tdpZQBW6+IQClfUuW23hxXdNnmxU6x60pramwKIuQet
         cyQRF6bOsFafJzm7MvySB6u+SBPc0EwJaT1vWy9KwSg/n1icgcpqQ6RrwdGj2nZVASbN
         Ol6w==
X-Gm-Message-State: AOJu0YzJpkwXHwkMz3n1D04rjUiBdw5TJCIFuPwcGvlbw0J6fYCeruIV
	4HOw8YR8eG+T3B8irg7/6GaJo1oRvAbJjAuVhyZDjTUFms7nQfleY4U1U08qYQ==
X-Gm-Gg: AfdE7ckOq08fwOnA5qX4OpcmYv7Yqc3trANZxnkc9eM0WkB19IYV1NuFRYmjwgpkZ+O
	uSsXZIaA6JBeKfsrAvjE4vl2CZyi/z9vW9GuZZ+MA6qyPFOWIweTTO8jINCO/PRpXZAyaDA5Sin
	NGx0SkiNZ1UI8JyEUd/IQig88WD7UYokOmfvYym1PqEaUIgk/abWFEalCmsJW/x7zpyZMWUyuzA
	bD2qfQzzjIOd0ECZlCP4lKBBeCQ7/eNbVvuUMTGNpHwm5enEEVuJwQGnfaYYlzgDScPerHjHtMq
	v5kbd3UUCrQpzUtcOuK9JBkgZRf+rVq97a4y5U/Vuqst3yWJN+D0OKIua8GIYIi4efQ33X5PKEN
	l0xC6EaIEyCFIoJsao+WqiYpwBot5yhFBvWK4/XP1tjH0u0xTT09TogpJCh7bnYYXf+LXsXYyKe
	UfNiLRV0dsvcsZQf/kvmSDhAWq59N6PPViGUAYxP3klTnh0g==
X-Received: by 2002:a05:690c:c509:b0:7ff:f42:4f99 with SMTP id 00721157ae682-80135737e34mr100052177b3.40.1782013946501;
        Sat, 20 Jun 2026 20:52:26 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:25 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 0/9] Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat, 20 Jun 2026 23:52:13 -0400
Message-ID: <20260621035223.2651547-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is version 9 of the LANDLOCK_ADD_RULE_NO_INHERIT series, which
implements a new flag to suppress inheritance of access rights and
flags from parent objects.

The main change this version is the rebase onto mic/next, now that
Tingmao Wang's "quiet flag" series, which earlier revisions depended
on has been merged (congrats!).  This series is therefore no longer
based on it.

The rest is consolidation and hardening: the three path-walk patches
were squashed into one to avoid unused function build failures,
ancestor sealing and the removal hooks were factored into helpers, and
the topology seal was broadened to also deny hard links and
same-directory renames of a protected inode.  The KUnit suite was
trimmed to the tests that exercise the skip branch through realistic
rule application, and a new EINVAL case rejects the flag on a
ruleset that handles no filesystem access.

Overall the code is larger; but mostly from test coverage and the
hardlink gap being closed.

Ancestor sealing:

The other big change is the clear documentation of the consistency
guarantees associated with this flag. One notable property of the
way ancestor sealing has been done in this series thus far, is that
that a concurrent rename of a path that is underneath the current
position during the upward ancestor sealing walk will result in
a partially undersealed and/or oversealed hierarchy.

To make this clearer, in seal_ancestors, we walk upwards inserting
blank rules / updating existing ones with the has_no_inherit_descendent
marker. So if /a/b/c/d is tagged with LANDLOCK_ADD_RULE_NO_INHERIT,
we walk upward inserting this marker on /a/b/c, /a/b, /a and /.

Say we are in the middle of marking /a/b/ and /a/b/c is moved to
/foo. The result is we continue to walk upward towards /,
but /foo is unsealed with no marker.

It is of my opinion (and this is not my call obviously) that this
inconsistency is unavoidable. Even if we check against the rename_lock
and serialize on it, nothing stops an outside process from moving
/a/b/c to /foo even AFTER the rule is fully inserted, resulting in
the same exact state. So protecting against this concurrent rename
at insertion time wouldn't actually achieve anything.

The only way to truly close this would be costly; moving sealing to
runtime, and having to track the movement of the sealed inode outside
the domain. That seems to me unacceptable and inconsistent with
Landlock's threat model.

Thus my judgement is that this topology sealing is sufficient as is;
outside processes can already tamper with inodes in a landlock ruleset,
by removing inodes referenced by the ruleset, bind mounts, and all sorts
of things.

It is clear that there is no guarantee the filesystem and thus the ruleset
at ruleset creation time and enforcement time will be consistent.

We handle the -ENOMEM case similarly, if we run into memory pressure,
and can't finish sealing, it is left to userspace to catch the error
and discard the potentially unsealed ruleset, or retry rule insertion.

The only difference now is both of these gotchas are now explicitly
documented in the code and user documentation.

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

Changes since v8:

  1. Rebased onto mic/next now that Tingmao Wang's "quiet flag" series
     has been merged; this series is no longer based on it.
  2. Squashed the three landlock_walk_path_up() patches (add helper,
     use in is_access_to_paths_allowed(), use in
     collect_domain_accesses()) into a single patch.
  3. landlock_walk_path_up() now advances to the mount root before
     reporting an internal mount point, so the ancestor walk can
     follow_up() into the parent mount instead of stopping at a
     disconnected root. The sealing loop in landlock_append_fs_rule()
     handles this LANDLOCK_WALK_INTERNAL case explicitly.
  4. Added a preparatory patch moving log_fs_change_topology_dentry()
     above current_check_refer_path(), and reordered the user-API
     patch ahead of "Return inserted rule from landlock_insert_rule()".
  5. Extracted ancestor sealing into a seal_ancestors() helper and the
     unlink/rmdir hooks into a current_check_remove() helper, removing
     the duplicated subject-lookup/deny blocks and the out_unlock goto.
  6. Topology-change enforcement in current_check_refer_path() now
     covers hard links (link) and same-directory renames in addition
     to reparenting renames; deny_no_inherit_topology_change() short-
     circuits and logs on the first sealed layer.
  7. NO_INHERIT on a ruleset that handles no filesystem access is now
     rejected with -EINVAL, with matching base_test coverage.
  8. Selftests gained same-directory-rename and hard-link denial
     assertions, REFER handling in the layered test, and two rejection
     tests; the audit fixture dropped its redundant parent_is_logged
     variant.
  9. The KUnit suite was reduced from five tests to three, dropping the
     two cases that set the per-layer no_inherit bit synthetically and
     keeping those that exercise the skip branch through realistic rule
     application.
  10. Bumped the Landlock ABI to version 11 (updating base_test) and
      expanded the UAPI and userspace-api documentation (conservative
      seal, best-effort walk, threat model).

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
v8:
  https://lore.kernel.org/linux-security-module/20260529015210.500291-1-utilityemal77@gmail.com/

Example usage:

  # LL_FS_RO="/a/b/c" LL_FS_RW="/" LL_FS_NO_INHERIT="/a/b/c"
    landlock-sandboxer sh
  # touch /a/b/c/fi                    # denied; / RW does not inherit
  # rmdir /a/b/c                       # denied by ancestor protections
  # mv /a /bad                         # denied
  # mkdir /a/good; touch /a/good/fi    # allowed; unrelated path

All tests added by this series, and all other existing landlock tests,
are passing. This patch was also validated through checkpatch.pl --strict
with no complaints.

Special thanks to Tingmao Wang and Mickaël Salaün for your valuable
feedback.

Thank you for your time and review.

Regards,
Justin Suess

Justin Suess (9):
  landlock: Add and use landlock_walk_path_up() helper
  landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT user API
  landlock: Return inserted rule from landlock_insert_rule()
  landlock: Move log_fs_change_topology_dentry() above
    current_check_refer_path()
  landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
  samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to
    landlock-sandboxer
  selftests/landlock: Add selftests for LANDLOCK_ADD_RULE_NO_INHERIT
  landlock: Add KUnit tests for LANDLOCK_ADD_RULE_NO_INHERIT

 Documentation/userspace-api/landlock.rst     |  44 ++
 include/uapi/linux/landlock.h                |  35 ++
 samples/landlock/sandboxer.c                 |  16 +-
 security/landlock/access.h                   |   6 +
 security/landlock/fs.c                       | 366 ++++++++++++----
 security/landlock/net.c                      |   6 +-
 security/landlock/ruleset.c                  | 235 ++++++++--
 security/landlock/ruleset.h                  |  20 +-
 security/landlock/syscalls.c                 |  27 +-
 tools/testing/selftests/landlock/base_test.c |  60 ++-
 tools/testing/selftests/landlock/fs_test.c   | 425 +++++++++++++++++++
 11 files changed, 1100 insertions(+), 140 deletions(-)


base-commit: 1c236e7fe740a009ad8dd40a5ee0602ec402fffe
-- 
2.54.0

