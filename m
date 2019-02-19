Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EA4C10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2E2147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfBSRI0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBSRI0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0851983F44;
        Tue, 19 Feb 2019 17:08:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 954265BBCB;
        Tue, 19 Feb 2019 17:08:24 +0000 (UTC)
Subject: [PATCH 00/10] VFS: Provide new mount UAPI
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:08:23 +0000
Message-ID: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 17:08:26 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Here's a set of patches that creates a number of new system calls to allow
the creation and parameterisation of a filesystem context and the
subsequent use of that context to create or look up a superblock:

	fd = fsopen("afs");
	fsconfig(fd, FSCONFIG_SET_STRING,
		 "source", "#grand.central.org:root.cell.", 0);
	fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);

or reconfigure a superblock:

	fd = fspick(AT_FDCWD, "/nfs/foo", FSPICK_NO_AUTOMOUNT);
	fsconfig(fd, FSCONFIG_SET_FLAG, "noac", NULL, 0);
	fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

A mount object can then be created for the superblock which will be
attached to an O_PATH-equivalent file descriptor:

	mfd = fsmount(fd, MS_NODEV);

This can then be moved into place:

	move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

move_mount() can be used more generically too, e.g.:

	move_mount(AT_FDCWD, "/mnt/foo", AT_FDCWD, "/mnt/bar", 0);

to move mount subtrees around.

One more system call is available:

	mfd = open_tree(AT_FDCWD, "/mnt/foo", 0)
	mfd = open_tree(AT_FDCWD, "/mnt/foo", OPEN_TREE_CLONE)
	mfd = open_tree(AT_FDCWD, "/mnt/foo", OPEN_TREE_CLONE | AT_RECURSIVE)

This creates an O_PATH-equivalent file descriptor referring to a mount, a
copy of a mount or a copy of a mount subtree that move_mount() can then
move/paste into place.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

at tag:

	vfs-mount-syscalls

David
---
Al Viro (1):
      vfs: syscall: Add open_tree(2) to reference or clone a mount

David Howells (9):
      vfs: syscall: Add move_mount(2) to move mounts around
      teach move_mount(2) to work with OPEN_TREE_CLONE
      Make anon_inodes unconditional
      vfs: syscall: Add fsopen() to prepare for superblock creation
      vfs: Implement logging through fs_context
      vfs: syscall: Add fsconfig() for configuring and managing a context
      vfs: syscall: Add fsmount() to create a mount for a superblock
      vfs: syscall: Add fspick() to select a superblock for reconfiguration
      vfs: Add a sample program for the new mount API


 arch/arm/kvm/Kconfig                   |    1 
 arch/arm64/kvm/Kconfig                 |    1 
 arch/mips/kvm/Kconfig                  |    1 
 arch/powerpc/kvm/Kconfig               |    1 
 arch/s390/kvm/Kconfig                  |    1 
 arch/x86/Kconfig                       |    1 
 arch/x86/entry/syscalls/syscall_32.tbl |    6 
 arch/x86/entry/syscalls/syscall_64.tbl |    6 
 arch/x86/kvm/Kconfig                   |    1 
 drivers/base/Kconfig                   |    1 
 drivers/char/tpm/Kconfig               |    1 
 drivers/dma-buf/Kconfig                |    1 
 drivers/gpio/Kconfig                   |    1 
 drivers/iio/Kconfig                    |    1 
 drivers/infiniband/Kconfig             |    1 
 drivers/vfio/Kconfig                   |    1 
 fs/Makefile                            |    4 
 fs/file_table.c                        |    9 -
 fs/fs_context.c                        |  160 ++++++++++-
 fs/fsopen.c                            |  477 ++++++++++++++++++++++++++++++++
 fs/internal.h                          |    4 
 fs/namespace.c                         |  477 ++++++++++++++++++++++++++++----
 fs/notify/fanotify/Kconfig             |    1 
 fs/notify/inotify/Kconfig              |    1 
 include/linux/fs.h                     |    7 
 include/linux/fs_context.h             |   38 ++-
 include/linux/lsm_hooks.h              |    6 
 include/linux/module.h                 |    6 
 include/linux/security.h               |    7 
 include/linux/syscalls.h               |    9 +
 include/uapi/linux/fcntl.h             |    2 
 include/uapi/linux/mount.h             |   62 ++++
 init/Kconfig                           |   10 -
 samples/Kconfig                        |    9 -
 samples/Makefile                       |    2 
 samples/statx/Makefile                 |    7 
 samples/statx/test-statx.c             |  258 -----------------
 samples/vfs/Makefile                   |   10 +
 samples/vfs/test-fsmount.c             |  133 +++++++++
 samples/vfs/test-statx.c               |  267 ++++++++++++++++++
 security/security.c                    |    5 
 41 files changed, 1617 insertions(+), 380 deletions(-)
 create mode 100644 fs/fsopen.c
 delete mode 100644 samples/statx/Makefile
 delete mode 100644 samples/statx/test-statx.c
 create mode 100644 samples/vfs/Makefile
 create mode 100644 samples/vfs/test-fsmount.c
 create mode 100644 samples/vfs/test-statx.c

