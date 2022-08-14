Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2BC25B06
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 19:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiHNT0j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHNT0i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 15:26:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF415A26
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b96so7321204edf.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UhjhzI+pFRz41Ih8ZDq/XIK1frf0MVSJBgF9DvZXwAI=;
        b=Xr3BP2Jm5CK88ig34JSW8YCMbRJ250WDELQIKxCIRliZ0RRbfOYQLjL1gtmH0wtsoY
         5xlzcR8ffPCv2egQIWyMz4/TsZzple4tNVsIL3g1zWe3L9ZOGfcaIwpzVTkhv/TEgy4S
         yz8Lz648yXEofIYfLplgkrW7rih9iEwrkATBNt0e8OIM0wLocNqImmUd/pbWSgccDmBW
         5OVqsVB4uUGcpp7OPiQOfwjRnS5J2ac0jnmxv4BIpwgN9HD0r+9TwdQNsWGfjNbYAX9V
         ppgaHm1yMoMdPexl9TwyTl6MXbVkjdHbovkXZREWi6WH+fxih4dI9/NK+ppudw3cw9uK
         C0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UhjhzI+pFRz41Ih8ZDq/XIK1frf0MVSJBgF9DvZXwAI=;
        b=4OhLivuEPjt7C1zqhRKogiwo2ai4mrwXiKrNgZiaW9hEvXOsn1/tUMXSl89iSKYMfx
         kFD5Znb3KGI4cBCwTGkGBq1/Y+ZeNG55XKU1lf6/hU41a+ENY+N26q56iiKpYk2wwE2Q
         T02ABpCWs4UyKc4GyJE7cneTUNSogqh3uRkd2fPPPPzOlWV8TGE+7nM0rn1P3W+AWtEA
         wlz+RhOGsM8bbrSTY3aKE0Wt5q0f18wvMj1t7V7/CRRSeSRIGRWPTQMP+ggt7uNA3Wsu
         /Dy0OW5UUUe+WxWvMpIc37sxeASI6YqsX0pn/pOb9VY9HnoSvJgdbnMuJP8u1jjMHXa2
         0XPw==
X-Gm-Message-State: ACgBeo1KFP61vBJXCwncptCvXpC4kdApE/kts+ohAk8rILua+CLiwR9B
        4/cwQoZbM4sac5GbfsTC1RiQz0/JuEE=
X-Google-Smtp-Source: AA6agR4x9zPY2mXJz7pp8PhKemVdEn71ix7NJutWjDPLz3G3iKh8AfD2DImlvL6/fhZyVTS/ctu5xw==
X-Received: by 2002:a05:6402:194d:b0:43d:8001:984b with SMTP id f13-20020a056402194d00b0043d8001984bmr11572363edz.327.1660505196364;
        Sun, 14 Aug 2022 12:26:36 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bq24-20020a170906d0d800b0072b2ef2757csm3209066ejb.180.2022.08.14.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 12:26:35 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v4 0/4] landlock: truncate support
Date:   Sun, 14 Aug 2022 21:25:59 +0200
Message-Id: <20220814192603.7387-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
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

v4:
 * Documentation
   * Clarify wording and syntax as discussed in review.
   * Use a less confusing error message in the example.
 * selftests:
   * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
     (This is an intentionally uncommon error code, so that the source
     of the error is clear and the test can distinguish test setup
     failures from failures in the actual system call under test.)
 * samples/Documentation:
   * Use additional clarifying comments in the kernel backwards
     compatibility logic.

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
v3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/

Günther Noack (4):
  landlock: Support file truncation
  selftests/landlock: Selftests for file truncation support
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  52 ++++-
 include/uapi/linux/landlock.h                |  17 +-
 samples/landlock/sandboxer.c                 |  23 +-
 security/landlock/fs.c                       |   9 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 226 ++++++++++++++++++-
 8 files changed, 305 insertions(+), 28 deletions(-)


base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
--
2.37.2
