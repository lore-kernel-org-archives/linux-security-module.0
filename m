Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BFAC19F21
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 19:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiHDTiB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiHDTiA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E606E2C3
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 12:37:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w19so1102889ejc.7
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iSDlUN3gIHdfL+T+Jd8PQ9lH81xfneY44PJpAP4thR0=;
        b=Ap1HpRGFu0Im0Fy39tYcWbCXEf36NXu7i9vThZjiuWfmtKT36JjybUvopB6MHUk9hr
         N+PmeeisJ1Xk8aCwdq4bS2r2lKtlslW1+WTn1dHJyCs967J2rgZlUoEI6tTUzF2JgvgZ
         vq4CrEJHSJGjjhNqPp86x8UP3rOy3SksqjvXDCnc8k5cDJvnHNbva5OKAFhqXifmMbuC
         xC3EJsbsWlpKurI4ROYub9eGVSjb/gpCg+Mx63W3HpXl0XdQ/TdEFXZoF/1Sm+zYuIHP
         TQWOB7SY6E+epO6MTTm5KI6fd1hGxCdyyF3SxtlXYtZDNZkjWftTlA7ReBEFWcn5Is8Z
         /40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iSDlUN3gIHdfL+T+Jd8PQ9lH81xfneY44PJpAP4thR0=;
        b=pN4qIU4kNdzJJnNxdUuZpqd3hbS0mbQNAAv65VjTe8FMvkbq2rsMmj+pCxNUjr/vbV
         JFwOT3dNR86UnF8+hAwQcnMe2OhjBUty5BhO+ciimwoBiWyhZD+vV+9TSJI534C0Ka7T
         cGn/xa/etfPDalBkTuNT1V7MlnAN9qitO5t/kTe4prLntGo73x1gfV6xnVBOWOUOrwsI
         FOHNBu3AtROdcRY5VigswSnnNzjhBFwQGFDCcuPr+m+Y9E/0Le8RhF5iuEFWw/TUZ34Z
         WdKYUWy4HBaH5v/Yawy2Zs/xXItXPedYz6d8/P0VpDvUSZe2kK2Y4yzTSkD8UmnZOBWY
         CwGw==
X-Gm-Message-State: ACgBeo3D0EGlu6ofixiuTXgO2Ytjg6fabdlgL2hhjy4Zkx5xvU+OatCL
        HJHXM67BcTj6NMRgDc9wOFb77/LRIZk=
X-Google-Smtp-Source: AA6agR5n8ZWRj4YRpUDc+cA4HJn9jEhPRyTLdSvI7iW+Yuzzo1300gF/y6lUkFT5MxvAB/7NGuDFGw==
X-Received: by 2002:a17:907:a424:b0:730:b777:d6e5 with SMTP id sg36-20020a170907a42400b00730b777d6e5mr2501943ejc.746.1659641877585;
        Thu, 04 Aug 2022 12:37:57 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072abb95c9f4sm631851ejh.193.2022.08.04.12.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:37:57 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 0/4] landlock: truncate support
Date:   Thu,  4 Aug 2022 21:37:42 +0200
Message-Id: <20220804193746.9161-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The goal of these patches is to work towards a more complete coverage
of file system operations that are restrictable with Landlock.

The known set of currently unsupported file system operations in
Landlock is described at [1]. Out of the operations listed there,
truncate is the only one that modifies file contents, so these patches
should make it possible to prevent the direct modification of file
contents with Landlock.

The patch introduces the truncation restriction feature as an
additional bit in the access_mask_t bitmap, in line with the existing
supported operations.

The truncation flag covers both the truncate(2) and ftruncate(2)
families of syscalls, as well as open(2) with the O_TRUNC flag.
This includes usages of creat() in the case where existing regular
files are overwritten.

Apart from Landlock, file truncation can also be restricted using
seccomp-bpf, but it is more difficult to use (requires BPF, requires
keeping up-to-date syscall lists) and it is not configurable by file
hierarchy, as Landlock is. The simplicity and flexibility of the
Landlock approach makes it worthwhile adding.

While it's possible to use the "write file" and "truncate" rights
independent of each other, it simplifies the mental model for
userspace callers to always use them together.

Specifically, the following behaviours might be surprising for users
when using these independently:

 * The commonly creat() syscall requires the truncate right when
   overwriting existing files, as it is equivalent to open(2) with
   O_TRUNC|O_CREAT|O_WRONLY.
 * The "write file" right is not always required to truncate a file,
   even through the open(2) syscall (when using O_RDONLY|O_TRUNC).

Nevertheless, keeping the two flags separate is the correct approach
to guarantee backwards compatibility for existing Landlock users.

These patches are based on version 5.19.

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

History:

v3:
 * selftests:
   * Explicitly test ftruncate with readonly file descriptors
     (returns EINVAL).
   * Extract test_ftruncate, test_truncate, test_creat helpers,
     which simplified the previously mixed usage of EXPECT/ASSERT.
   * Test creat() behaviour as part of the big truncation test.
   * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
     This simplifies the tests a bit. The kernel implementations are the
     same as for truncate(2) and ftruncate(2), so there is little benefit
     from testing them exhaustively. (We aren't testing all open(2)
     variants either.)
 * samples/landlock/sandboxer.c:
   * Use switch() to implement best effort mode.
 * Documentation:
   * Give more background on surprising truncation behaviour.
   * Use switch() in the example too, to stay in-line with the sample tool.
   * Small fixes in header file to address previous comments.
* misc:
  * Fix some typos and const usages.

v2:
 * Documentation: Mention the truncation flag where needed.
 * Documentation: Point out connection between truncation and file writing.
 * samples: Add file truncation to the landlock/sandboxer.c sample tool.
 * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
 * selftests: Exercise truncation syscalls when the truncate right
   is not handled by Landlock.

Previous versions:
v1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
v2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/

Günther Noack (4):
  landlock: Support file truncation
  selftests/landlock: Selftests for file truncation support
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  47 ++++-
 include/uapi/linux/landlock.h                |  17 +-
 samples/landlock/sandboxer.c                 |  21 +-
 security/landlock/fs.c                       |   9 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 211 ++++++++++++++++++-
 8 files changed, 283 insertions(+), 28 deletions(-)


base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
--
2.37.1
