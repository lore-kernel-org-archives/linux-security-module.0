Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599960;
	b=xweCnRgZiqMBZflgDkpacC1WUlGUuGImBsJLd0cLYolXLR3RuJ/EykhQ2s+gzH8c61Tw
	 VQQZXWd9YR1BDRHEFYIgvzl5KlomzMbKzHNVqdH4gLMUdhPUBBn1k9P9nJ/ia24zsZwSt
	 3ElXyT2RPGkHpEaQU8EFWBna9r7ZBhvhTJ5yamOm9Y86rLZklvNigw7UIHn9clnDfvaVZ
	 Z/E22Mv3/BBpzPMN3MRMR+oUYByMZJZz8VwfNNfWlan1CYTxFAtoRjtuY0jyOHCBP8+NT
	 8Uv2LhnpMYQPCH9DtLXlFHgwzQH/kiMFmhk/KZLzg5gr4sYjLCgpVXTgM2DL96u3ziQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599960;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=6aYN/2On4n7HGoJvZTU3OurKvF7SDr35YC5v5eCOowc=;
	b=Ia+mnVxfobBCuPNbzh3b/Jzntj5jAvRFVL2tZogNvunOYObPzIWFeAfBt/zgGPc0HHvQ
	 6kv7fVOj8XFKTM87s/MR/iRi0O3Kb1uU2XGbC3UH81/ALRk8uIMVZzEalzTHhtTG2Lyhx
	 NoNJKeUOEHz+Tq/NBzeDEmA/j1OXAIjzll7DEWpvz6g8B+x88F1fFirbqlDxOG2P9T3ui
	 vEEHdtLR7RgRCQKj+ZzF3ZucfXuJ5/8mP7oNc9rz1MfSX8TVriQp/4Xb7oL5lUJLjo6BT
	 /FcU1gvAyJYEtneKx1I+TEksbVx5/uwo7EzNo0HFZd3DwTh5P/zBusMXDQ3YizSLcSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EC2wy3Vz;
	arc=none smtp.remote-ip=185.125.25.8
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81B606A31B
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 16:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA81B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EC2wy3Vz
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j8vlx1G6dz13rn;
	Wed, 21 Oct 2026 18:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792599948;
	bh=6aYN/2On4n7HGoJvZTU3OurKvF7SDr35YC5v5eCOowc=;
	h=From:To:Cc:Subject:Date:From;
	b=EC2wy3Vz68NDCTpFJUzbNOPF0ExyqXqmkSSqPJKxsLmkFIaggjI9bgDaYHrXnsE7X
	 he7TUnCvrwDqBOVaHcBYMyJ28azv87LBzc1dKEFzZ1SAImW3SH+waaIOxKlIcfXsIK
	 EkkkpTFPrIBd2qBiCXR5XsDsgTs1EGqiRbBd6+TI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j8vlv58Kvz2Fl;
	Wed, 21 Oct 2026 18:25:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Haofeng Li <lihaofeng@kylinos.cn>,
	Paul Moore <paul@paul-moore.com>,
	Tingmao Wang <m@maowtm.org>,
	Wang Yan <wangyan01@kylinos.cn>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [GIT PULL] Landlock update for v7.4-rc1
Date: Wed, 21 Oct 2026 18:25:38 +0200
Message-ID: <20261021162538.1852602-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

The main change adds composable Landlock controls for namespace types
and Linux capabilities, thanks to new LSM hooks (merged via the LSM
tree).  A umount race condition is also fixed.

Please pull these changes for v7.4-rc1 .  These commits merge cleanly
with your master branch.  Kernel changes have been tested in the
latest linux-next releases, and I recently fixed a new merge conflict
(see the related merge commit message).

Test coverage for security/landlock is 91.8% of 2864 lines according to
LLVM 23, and it was 91.6% of 2625 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc1

for you to fetch changes up to 3e271a27c46fd591d1011c7de5a644a41e2010f1:

  landlock: Fix superblock use-after-free in release_inode() (2026-10-20 16:47:24 +0200)

----------------------------------------------------------------
Landlock update for v7.4-rc1

----------------------------------------------------------------
Christian Brauner (2):
      ns: Free anonymous mount namespaces via ns_common_free()
      lsm: add LSM blob and hooks for namespaces

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Jann Horn (1):
      cred: clarify that task_struct::cred is only for the current task

Mickaël Salaün (10):
      lsm: add LSM_AUDIT_DATA_NS for namespace audit records
      Merge branch 'lsm/dev' into master
      landlock: Rename quiet_masks to quiet_access
      landlock: Wrap per-layer access masks in struct layer_config
      landlock: Enforce namespace use restrictions
      landlock: Enforce capability restrictions
      selftests/landlock: Add namespace restriction tests
      selftests/landlock: Add capability restriction tests
      samples/landlock: Add capability and namespace restriction support
      landlock: Add documentation for capability and namespace restrictions

Paul Moore (1):
      lsm: update the BUILD_BUG_ON() in audit_log_lsm_data()

Wang Yan (1):
      selftests/landlock: Fix snprintf truncation checks in test files

 Documentation/admin-guide/LSM/landlock.rst     |   46 +-
 Documentation/security/landlock.rst            |  177 +-
 Documentation/trace/events-landlock.rst        |   66 +-
 Documentation/userspace-api/landlock.rst       |  243 ++-
 fs/namespace.c                                 |    3 +-
 include/linux/cred.h                           |   17 +-
 include/linux/landlock.h                       |   29 +-
 include/linux/lsm_audit.h                      |    5 +
 include/linux/lsm_hook_defs.h                  |    3 +
 include/linux/lsm_hooks.h                      |    1 +
 include/linux/ns/ns_common_types.h             |    3 +
 include/linux/sched.h                          |    8 +-
 include/linux/security.h                       |   20 +
 include/trace/events/landlock.h                |  244 ++-
 include/uapi/linux/landlock.h                  |  139 +-
 include/uapi/linux/nsfs.h                      |    1 +
 init/init_task.c                               |    2 +-
 kernel/auditsc.c                               |    5 +-
 kernel/cred.c                                  |    2 +-
 kernel/nscommon.c                              |   17 +-
 kernel/nsproxy.c                               |    6 +
 samples/Kconfig                                |   13 +-
 samples/landlock/Makefile                      |    5 +
 samples/landlock/sandboxer.c                   |  269 ++-
 security/landlock/Makefile                     |    4 +-
 security/landlock/access.h                     |   61 +-
 security/landlock/audit.c                      |   32 +-
 security/landlock/cap.c                        |  159 ++
 security/landlock/cap.h                        |   48 +
 security/landlock/cred.h                       |    2 +-
 security/landlock/domain.c                     |   13 +-
 security/landlock/domain.h                     |   97 +-
 security/landlock/fs.c                         |   12 +-
 security/landlock/limits.h                     |    9 +
 security/landlock/log.c                        |   53 +-
 security/landlock/log.h                        |   10 +-
 security/landlock/net.c                        |    2 +-
 security/landlock/ns.c                         |  241 +++
 security/landlock/ns.h                         |   18 +
 security/landlock/ruleset.c                    |   27 +-
 security/landlock/ruleset.h                    |   33 +-
 security/landlock/setup.c                      |    4 +
 security/landlock/syscalls.c                   |  217 +-
 security/landlock/trace.c                      |   27 +-
 security/lsm_audit.c                           |    6 +-
 security/lsm_init.c                            |    5 +-
 security/security.c                            |   72 +
 tools/testing/selftests/landlock/audit_test.c  |    2 +-
 tools/testing/selftests/landlock/base_test.c   |   21 +-
 tools/testing/selftests/landlock/cap_test.c    | 1370 ++++++++++++
 tools/testing/selftests/landlock/common.h      |   13 +
 tools/testing/selftests/landlock/config        |    5 +
 tools/testing/selftests/landlock/fs_test.c     |   13 +-
 tools/testing/selftests/landlock/net_test.c    |    4 +-
 tools/testing/selftests/landlock/ns_test.c     | 2647 ++++++++++++++++++++++++
 tools/testing/selftests/landlock/ptrace_test.c |    2 +-
 tools/testing/selftests/landlock/trace.h       |   52 +-
 tools/testing/selftests/landlock/trace_test.c  |    8 +-
 tools/testing/selftests/landlock/wrappers.h    |   29 +
 59 files changed, 6437 insertions(+), 205 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h
 create mode 100644 tools/testing/selftests/landlock/cap_test.c
 create mode 100644 tools/testing/selftests/landlock/ns_test.c
