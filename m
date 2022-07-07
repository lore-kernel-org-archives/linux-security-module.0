Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DAC43334
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 20:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGGUHQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiGGUHP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E885C97A
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 13:07:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so18754600eda.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyLCv6GFZyRrT8PyPfSfjKuUQbWmAns4RxbWXOJiOAA=;
        b=NVWojgaiOlNhKq4J8EOO0rle1VvYJJxmh6WUyFJe+4oqAG7tjEXMgxjdmKClchgCco
         2pJPMIrUO7jnD2OQ9Y+fnODK1gS3OuyG+GTIhiiGzEJAGnsIOM84fKS7LczTwds+IeLl
         V9K1cPPrVKL9h3pZJxG0QvYb48VftfgHH6iN4bQrWRnERQZp/Jvh17WNSmwaPERqKUnJ
         R5xMxlBJkHzGIXVCcIhnZGyfRCU9EAMO4N54nMpNn4eSv0fzwhB/HlByoGAqX6kcRPeI
         iUS8zbkupwRLLmSy2BpqLEIU8n6bnJzjT0H7FXgeo7sRuJx4dXkZ449QBgS1SzTKlCB6
         91Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QyLCv6GFZyRrT8PyPfSfjKuUQbWmAns4RxbWXOJiOAA=;
        b=hcs/TCjYmSPMwvYrWnrWcne+fgoD8C8VDzCxO9JKkGo1/OcpAJsIKlOiZc4MzDO6Hg
         ELZfPdaSVWRkzdt8cRYKvN3Of0nDdaafY1ESKovdOXd/YZ32BAvHvc8RMjdULRBVY0lh
         3o+0muAtHKZGLmGrY8ovq7tg8pKEX1WaUF8ENYJLWnf/umKBmJG+dVNena+0Wfy1KqYi
         0G5Rjgnxdb8WEsIfcTHmVLOLwxnEwfe1uUX34oGdsGzKQNyHuDvf0OE+4r/ipM/lWu3H
         N5weWv/5NZ5vX+qChpKop5kgVk0YzpVrrNHb5fmXUiWMaWeLtAMKacF47vIfeS1FjKsd
         R6bg==
X-Gm-Message-State: AJIora/GUBP1rVgUdCqsCrv6GlZ1rO0Cqn5J412thz7dQN6lAhtpjVZM
        VD9NthX6iRYd7YNgOCwKPymmYWt5dHs=
X-Google-Smtp-Source: AGRyM1tsHqe9023sdyYwgfSy6hPcNY0MMpNsYYVaw/ELuKtZTUGAg10kphHQQZ8tEsfpDYDk61U+yQ==
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id i11-20020a05640242cb00b0043a5df2bb5dmr31694775edc.36.1657224432192;
        Thu, 07 Jul 2022 13:07:12 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402020d00b0043a71775903sm8397959edv.39.2022.07.07.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:11 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 0/2] landlock: truncate(2) support
Date:   Thu,  7 Jul 2022 22:06:11 +0200
Message-Id: <20220707200612.132705-1-gnoack3000@gmail.com>
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

The patch introduces the truncate(2) restriction feature as an
additional bit in the access_mask_t bitmap, in line with the existing
supported operations.

Apart from Landlock, the truncate(2) and ftruncate(2) family of system
calls can also be restricted using seccomp-bpf, but it is a
complicated mechanism (requires BPF, requires keeping up-to-date
syscall lists) and it also is not configurable by file hierarchy, as
Landlock is. The simplicity and flexibility of the Landlock approach
makes it worthwhile adding.

I am aware that the documentation and samples/landlock/sandboxer.c
tool still need corresponding updates; I'm hoping to get some early
feedback this way.

These patches are based on version 5.19-rc5.
The patch set can also be browsed on the web at [2].

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
[2] https://github.com/gnoack/linux/tree/landlock-truncate

Günther Noack (2):
  landlock: Support truncate(2).
  landlock: Selftests for truncate(2) support.

 include/uapi/linux/landlock.h                |  2 +
 security/landlock/fs.c                       |  9 +-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   | 87 +++++++++++++++++++-
 6 files changed, 97 insertions(+), 7 deletions(-)

--
2.37.0
