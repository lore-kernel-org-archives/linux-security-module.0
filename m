Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54826C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 21:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiGLVOR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGLVOQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 17:14:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B466F7C0
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so10514841ejc.11
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnza/TjQ7QeLiCmPalDtqdBTF9zncr1x2refxXYD3HM=;
        b=Prx0XhE88I2EKI8II/4iWAiHg7t3/QhFkXhNvHaJhPZQ8f7a10H1PeducjauL2UNqi
         BklLFKKw+UAKUFFFmdNJCAjs90/IymvLp4w1EnZD7Ik84glAo/9pDAmJpc/vc1GGGihr
         aP8DsssfB+tDuJco4nH8BJKOaCi/AONgHoEzlxoYrNuHP5FVUQBm3lnsJ5ngyqUrVQ6r
         jPloKSOfervXHzG6GZNxiijOd7SJiLMcmC2xU/SNz0Fhm5yLLxaNSAIFPnCkAx3W4kyu
         AbKF+BhrwsD2Pe8IudVY/ESvMRitOr9RZnYJ5emBg4yRYPiFedv1Gbf3pzZuF1gbN8e+
         FV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnza/TjQ7QeLiCmPalDtqdBTF9zncr1x2refxXYD3HM=;
        b=UkgWMs54xSLJnXeXoEtbfbfKbWR5BjLUqrg7UVXY9KjHl8Gb3Pa+gMQVqLCd2JyN6H
         Hppr86vg4mSwcimXsgtOco33UPm86Xr5uBGtXWW3uoXfy2rK+L3HM4JbO/Ca+k+xi037
         G18Z7s/hIQvNIsFGq7QU6IwmySASoaLa1K62vBtwqnBw5yVO+CAVPfR3rBQbUZzWVs5l
         Na7ORRGp7x2MRov+sEIuFzJrQ/eqrINHl0Ui7XgbkHdGt0OvuitkJx7Y6i/b4sozzwPX
         DeCm1Guz1hDwrlfH1W/4Nlf6uQyR9CzvQfgl4l/tEj3n6KB2akyDMd05d+IL8+fcpByJ
         IzmA==
X-Gm-Message-State: AJIora+k9EZt0RKSZUiqe87rwXB9X5amBVhLn/4VSHe5kBMS0BfPIQKq
        ABuEVSTL5F1jgWwkxhw+mhNuTR1vvig=
X-Google-Smtp-Source: AGRyM1uuTfGQcAI7LZexX47whluAjd8ZLAyERIjO/XJKxpSOEAFjr9IhbxGVtAO+6c2+NOL7h1mDBw==
X-Received: by 2002:a17:907:2814:b0:72a:3758:e948 with SMTP id eb20-20020a170907281400b0072a3758e948mr100133ejc.8.1657660454266;
        Tue, 12 Jul 2022 14:14:14 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e41-20020a056402332900b0042de3d661d2sm6679296eda.1.2022.07.12.14.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:14:13 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 0/4] landlock: truncate support
Date:   Tue, 12 Jul 2022 23:14:01 +0200
Message-Id: <20220712211405.14705-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
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
This includes uses of creat() that overwrite existing regular files.

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

These patches are based on version 5.19-rc6.

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

History
v2:
 * Documentation: Mention the truncation flag where needed.
 * Documentation: Point out connection between truncation and file writing.
 * samples: Add file truncation to the landlock/sandboxer.c sample tool.
 * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
 * selftests: Exercise truncation syscalls when the truncate right
   is not handled by Landlock.

Previous versions:
v1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/

Günther Noack (4):
  landlock: Support file truncation
  selftests/landlock: Selftests for file truncation support
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  24 +-
 include/uapi/linux/landlock.h                |  13 +-
 samples/landlock/sandboxer.c                 |  15 +-
 security/landlock/fs.c                       |   9 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 245 ++++++++++++++++++-
 8 files changed, 294 insertions(+), 18 deletions(-)

--
2.37.0
