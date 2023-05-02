Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBDC7EE22
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjEBRSM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjEBRSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 13:18:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238410FE
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 10:18:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so25439775e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047879; x=1685639879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qki2g9Mb14rbBQdzJX6RPgJ2mA3yqsPZYHsNI+UG2NY=;
        b=LRgNgyt5is5EO7/FU758SAALBPFDXtM6DpEey8ZScImQECFzOrv+8TjtS0a5micguI
         aK6HE0jA2Sk4fqfV5FDlYX3J5T4QcEaMzyAudviADfo1/Ro++vbfs9TJ1tD2dxKckVR7
         uz3Oq1OVALtjeH6iv54uQZDlq3qtKQ0OEOzY7J2ckz5iNRipJYrOWr76IwtgQUlfuRGX
         WB0K161po13pzvwlJzTQva7AfsZ2vOE0K1/xEWpJKRkioB6BvyIyTvBHFtiGOLQruAlS
         Sqm9dvJO9mInc0RyuqKll8rLNY0tbeb0cfmcL2zUSAHmOjmcELVh2M2jxWzQ46XxVbWP
         K7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047879; x=1685639879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qki2g9Mb14rbBQdzJX6RPgJ2mA3yqsPZYHsNI+UG2NY=;
        b=L4eRYbFsrviUME1wF7TvgxYXfJCO8nno6sTpUd5VIGwzCcHE5NODNmczMw/4GNK/ye
         7mia7zFY91kOyVkOWAq9Ntzkyj0kSQHoHwErX4CAFWgKrUbvGPnGYxhJN0sLh1KYse6m
         NqiEJiPkWMCicJNuFwcTPIYaG3UygOZuig0vEBWdqsqJpS9UqRMNfv8K4uS/0YqQXqRs
         YxEo6LeB6x7kABt/2FgqbdPUSwOoqVLFp3JGS00Ixp4iX1IknJmw9FYXYkyU6kUgOBsK
         gR3fpfeOA3+LtIdJ5q77apDgb/ygedIkb9txCodDRd5Xz1Iox8WNWDxmxcTAg/0rXVMF
         joAg==
X-Gm-Message-State: AC+VfDzl1UJM0/AXrkBbF8N2ACea05UdHwokilZiWCa6Yyi6KvCcAetr
        v6f1qbK0hEO+dvwW6veNvM+Sp1DEfD0=
X-Google-Smtp-Source: ACHHUZ5r1nuDZzaL07DhNo9MNj8elE9fRGvSEjlrB9NzIh04yXRQhKIfrmcxgKgooXZDt0KBiALYNA==
X-Received: by 2002:a7b:cd18:0:b0:3f1:6fe2:c4b2 with SMTP id f24-20020a7bcd18000000b003f16fe2c4b2mr12865625wmj.23.1683047879122;
        Tue, 02 May 2023 10:17:59 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f1739a0116sm35916956wmj.33.2023.05.02.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:17:58 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC 0/4] Landlock: ioctl support
Date:   Tue,  2 May 2023 19:17:51 +0200
Message-Id: <20230502171755.9788-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

These patches add ioctl support to Landlock.

It's an early version - it potentially needs more tests and
documentation.  I'd like to circulate the patches early to discuss
whether this approach is feasible.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
of ioctl(2) on file descriptors.

We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between Landlock API and implementation
complexity and flexibility when the feature is used.

Notable implications of this approach
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Existing inherited file descriptors stay unaffected
  when a program enables Landlock.

  This means in particular that in common scenarios,
  the terminal's ioctls (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors acquired
  through means other than open(2).  Example: Network sockets.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=/ LL_FS_RW=. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
here, so we expect that newly opened files outside of $HOME don't work
with ioctl(2).

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the ioctl is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

Alternatives considered: Allow-listing specific ioctl requests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It would be technically possible to keep an allow-list of ioctl
requests and thereby control in more detail which ioctls should work.

I believe that this is not needed for the majority of use cases and
that it is a reasonable trade-off to make here (but I'm happy to hear
about counterexamples).  The reasoning is:

* Many programs do not need ioctl at all,
  and denying all ioctl(2) requests OK for these.

* Other programs need ioctl, but only for the terminal FDs.
  This is supported because these file descriptors are usually
  inherited from the parent process - so the parent process gets to
  control the ioctl(2) policy for them.

* Some programs need ioctl on specific files that they are opening
  themselves.  They can allow-list these file paths for ioctl(2).
  This makes the programs work, but it restricts a variety of other
  ioctl requests which are otherwise possible through opening other
  files.

Because the LANDLOCK_ACCESS_FS_IOCTL right is attached to the file
descriptor, programs have flexible options to control which ioctl
operations should work, without the implementation complexity of
additional ioctl allow-lists in the kernel.

Finally, the proposed approach is simpler in implementation and has
lower API complexity, but it does *not* preclude us from implementing
per-ioctl-request allow lists later, if that turns out to be necessary
at a later point.

Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [1] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee ABI backwards compatibility to the same
extent as Linux does, so it's easier for them to update these lists in
later versions.  It might not be a feasible approach for Linux though.

[1] https://man.openbsd.org/OpenBSD-7.3/pledge.2

Feedback I'm looking for
~~~~~~~~~~~~~~~~~~~~~~~~

Some specific points I would like to get your opinion on:

* Is this the right general approach to restricting ioctl(2)?

  It will probably be possible to find counter-examples where the
  alternative (see below) is better.  I'd be interested in these, and
  in how common they are, to understand whether we have picked the
  right trade-off here.

* Should we introduce a "landlock_fd_rights_limit()" syscall?

  We could potentially implement a system call for dropping the
  LANDLOCK_ACCESS_FS_IOCTL and LANDLOCK_ACCESS_FS_TRUNCATE rights from
  existing file descriptors (independent of the type of file
  descriptor, even).

  Possible use cases would be to (a) restrict the rights on inherited
  file descriptors like std{in,out,err} and to (b) restrict ioctl and
  truncate operations on file descriptors that are not acquired
  through open(2), such as network sockets.

  This would be similar to the cap_rights_limit(2) system call in
  FreeBSD's Capsicum.

  This idea feels somewhat orthogonal to the ioctl patch, but it would
  start to be more useful if the ioctl right exists.


Günther Noack (4):
  landlock: Increment Landlock ABI version to 4
  landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
  selftests/landlock: Test ioctl support
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL

 include/uapi/linux/landlock.h                | 19 ++++--
 samples/landlock/sandboxer.c                 | 12 +++-
 security/landlock/fs.c                       | 20 +++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   | 67 +++++++++++++++++++-
 7 files changed, 107 insertions(+), 17 deletions(-)


base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
2.40.1

