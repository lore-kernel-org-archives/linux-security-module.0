Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1EC433B4
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 02:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308F4613D8
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 02:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhD1C7L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Apr 2021 22:59:11 -0400
Received: from namei.org ([65.99.196.166]:54052 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235839AbhD1C7L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 22:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 94D85A1D;
        Wed, 28 Apr 2021 02:54:22 +0000 (UTC)
Date:   Wed, 28 Apr 2021 12:54:22 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Al Viro <viro@ftp.linux.org.uk>
Subject: [GIT PULL][Security] Add new Landlock LSM
Message-ID: <11a1adfd-d2e8-2181-81a-529792e4b6e5@namei.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-1848305378-1619577521=:601019"
Content-ID: <fe93242b-25d9-40d7-f5e-a49713347e@namei.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1848305378-1619577521=:601019
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <48825c2c-fe1c-8b9f-c86e-1cc7ed1c8ec@namei.org>

Hi Linus,

This patchset adds a new LSM called Landlock, from Mickaël Salaün.

Briefly, Landlock provides for unprivileged application sandboxing.

From Mickaël's cover letter:

  The goal of Landlock is to enable to restrict ambient rights (e.g.
  global filesystem access) for a set of processes.  Because Landlock is a
  stackable LSM [1], it makes possible to create safe security sandboxes
  as new security layers in addition to the existing system-wide
  access-controls.  This kind of sandbox is expected to help mitigate the
  security impact of bugs or unexpected/malicious behaviors in user-space
  applications.  Landlock empowers any process, including unprivileged
  ones, to securely restrict themselves.

  Landlock is inspired by seccomp-bpf but instead of filtering syscalls
  and their raw arguments, a Landlock rule can restrict the use of kernel
  objects like file hierarchies, according to the kernel semantic.
  Landlock also takes inspiration from other OS sandbox mechanisms: XNU
  Sandbox, FreeBSD Capsicum or OpenBSD Pledge/Unveil.

  In this current form, Landlock misses some access-control features.
  This enables to minimize this patch series and ease review.  This series
  still addresses multiple use cases, especially with the combined use of
  seccomp-bpf: applications with built-in sandboxing, init systems,
  security sandbox tools and security-oriented APIs [2].

  [1] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/
  [2] https://lore.kernel.org/lkml/f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net/

The cover letter and v34 posting is here:
https://lore.kernel.org/linux-security-module/20210422154123.13086-1-mic@digikod.net/

See also: https://landlock.io/

This code has had extensive design discussion and review over several 
years. The v33 code has been in next since April 9, and was updated last 
week to v34 with a relatively simple change. If you prefer to pull v33 
instead, please pull "tags/landlock_v33" instead, and we'll push the 
change through after merging.

There's a merge conflict in the syscall tables, with resolution by 
Stephen Rothwell:
https://lore.kernel.org/linux-next/20210409143954.22329cfa@canb.auug.org.au/

Al Viro raised some issues re. the VFS in v31:
https://lore.kernel.org/linux-security-module/YGUslUPwp85Zrp4t@zeniv-ca.linux.org.uk/

which were addressed in comments and in v33:
https://lore.kernel.org/linux-security-module/5f4dfa1-f9ac-f31f-3237-dcf976cabbfc@namei.org/


Please pull.

---

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/landlock_v34

for you to fetch changes up to 3532b0b4352ce79400b0aa68414f1a0fc422b920:

  landlock: Enable user space to infer supported features (2021-04-22 12:22:11 -0700)

----------------------------------------------------------------
Add Landlock, a new LSM from Mickaël Salaün <mic@linux.microsoft.com>

----------------------------------------------------------------
Casey Schaufler (1):
      LSM: Infrastructure management of the superblock

Mickaël Salaün (12):
      landlock: Add object management
      landlock: Add ruleset and domain management
      landlock: Set up the security framework and manage credentials
      landlock: Add ptrace restrictions
      landlock: Support filesystem access-control
      fs,security: Add sb_delete hook
      arch: Wire up Landlock syscalls
      landlock: Add syscall implementations
      selftests/landlock: Add user space tests
      samples/landlock: Add a sandbox manager example
      landlock: Add user and kernel documentation
      landlock: Enable user space to infer supported features

 Documentation/security/index.rst               |    1 +
 Documentation/security/landlock.rst            |   85 +
 Documentation/userspace-api/index.rst          |    1 +
 Documentation/userspace-api/landlock.rst       |  311 +++
 MAINTAINERS                                    |   15 +
 arch/Kconfig                                   |    7 +
 arch/alpha/kernel/syscalls/syscall.tbl         |    3 +
 arch/arm/tools/syscall.tbl                     |    3 +
 arch/arm64/include/asm/unistd.h                |    2 +-
 arch/arm64/include/asm/unistd32.h              |    6 +
 arch/ia64/kernel/syscalls/syscall.tbl          |    3 +
 arch/m68k/kernel/syscalls/syscall.tbl          |    3 +
 arch/microblaze/kernel/syscalls/syscall.tbl    |    3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl      |    3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl      |    3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl      |    3 +
 arch/parisc/kernel/syscalls/syscall.tbl        |    3 +
 arch/powerpc/kernel/syscalls/syscall.tbl       |    3 +
 arch/s390/kernel/syscalls/syscall.tbl          |    3 +
 arch/sh/kernel/syscalls/syscall.tbl            |    3 +
 arch/sparc/kernel/syscalls/syscall.tbl         |    3 +
 arch/um/Kconfig                                |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl         |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl         |    3 +
 arch/xtensa/kernel/syscalls/syscall.tbl        |    3 +
 fs/super.c                                     |    1 +
 include/linux/lsm_hook_defs.h                  |    1 +
 include/linux/lsm_hooks.h                      |    4 +
 include/linux/security.h                       |    4 +
 include/linux/syscalls.h                       |    7 +
 include/uapi/asm-generic/unistd.h              |    8 +-
 include/uapi/linux/landlock.h                  |  137 ++
 kernel/sys_ni.c                                |    5 +
 samples/Kconfig                                |    7 +
 samples/Makefile                               |    1 +
 samples/landlock/.gitignore                    |    1 +
 samples/landlock/Makefile                      |   13 +
 samples/landlock/sandboxer.c                   |  238 ++
 security/Kconfig                               |   11 +-
 security/Makefile                              |    2 +
 security/landlock/Kconfig                      |   21 +
 security/landlock/Makefile                     |    4 +
 security/landlock/common.h                     |   20 +
 security/landlock/cred.c                       |   46 +
 security/landlock/cred.h                       |   58 +
 security/landlock/fs.c                         |  692 ++++++
 security/landlock/fs.h                         |   70 +
 security/landlock/limits.h                     |   21 +
 security/landlock/object.c                     |   67 +
 security/landlock/object.h                     |   91 +
 security/landlock/ptrace.c                     |  120 +
 security/landlock/ptrace.h                     |   14 +
 security/landlock/ruleset.c                    |  473 ++++
 security/landlock/ruleset.h                    |  165 ++
 security/landlock/setup.c                      |   40 +
 security/landlock/setup.h                      |   18 +
 security/landlock/syscalls.c                   |  451 ++++
 security/security.c                            |   51 +-
 security/selinux/hooks.c                       |   58 +-
 security/selinux/include/objsec.h              |    6 +
 security/selinux/ss/services.c                 |    3 +-
 security/smack/smack.h                         |    6 +
 security/smack/smack_lsm.c                     |   35 +-
 tools/testing/selftests/Makefile               |    1 +
 tools/testing/selftests/landlock/.gitignore    |    2 +
 tools/testing/selftests/landlock/Makefile      |   24 +
 tools/testing/selftests/landlock/base_test.c   |  266 +++
 tools/testing/selftests/landlock/common.h      |  183 ++
 tools/testing/selftests/landlock/config        |    7 +
 tools/testing/selftests/landlock/fs_test.c     | 2791 ++++++++++++++++++++++++
 tools/testing/selftests/landlock/ptrace_test.c |  337 +++
 tools/testing/selftests/landlock/true.c        |    5 +
 72 files changed, 6986 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/security/landlock.rst
 create mode 100644 Documentation/userspace-api/landlock.rst
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 samples/landlock/.gitignore
 create mode 100644 samples/landlock/Makefile
 create mode 100644 samples/landlock/sandboxer.c
 create mode 100644 security/landlock/Kconfig
 create mode 100644 security/landlock/Makefile
 create mode 100644 security/landlock/common.h
 create mode 100644 security/landlock/cred.c
 create mode 100644 security/landlock/cred.h
 create mode 100644 security/landlock/fs.c
 create mode 100644 security/landlock/fs.h
 create mode 100644 security/landlock/limits.h
 create mode 100644 security/landlock/object.c
 create mode 100644 security/landlock/object.h
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h
 create mode 100644 security/landlock/setup.c
 create mode 100644 security/landlock/setup.h
 create mode 100644 security/landlock/syscalls.c
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c
--1665246916-1848305378-1619577521=:601019--
