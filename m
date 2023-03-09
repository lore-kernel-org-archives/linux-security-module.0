Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A25C76186
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Mar 2023 17:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCIRBF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjCIRAk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Mar 2023 12:00:40 -0500
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47222DB6DA
        for <linux-security-module@vger.kernel.org>; Thu,  9 Mar 2023 08:55:40 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PXb0V2x4kzMrBsq;
        Thu,  9 Mar 2023 17:55:38 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PXb0S4yJxz28qt;
        Thu,  9 Mar 2023 17:55:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678380938;
        bh=ogM5pzTOPJ57a+lItppwvkB6tXtQU91aX+WE5VtmmcE=;
        h=From:To:Cc:Subject:Date:From;
        b=CVXMq/rQbiuM9zOgGARjrSOVIjtO1kgaAhwvBp8NUHE3mNkiQ/2xHLdfd0MUJvTIg
         7v0YEpQaMbG6AGVYpDPVBHqvrjtay+Yzp78DwLMrN8ui7hppXKT7z4HkTYuYsTvjRp
         ZXF3Ti6YH59tZhuUZi8ONTjjDxyd1oH5LNrvy6fA=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/5] Landlock support for UML
Date:   Thu,  9 Mar 2023 17:54:50 +0100
Message-Id: <20230309165455.175131-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Commit cb2c7d1a1776 ("landlock: Support filesystem access-control")
introduced a new ARCH_EPHEMERAL_INODES configuration, only enabled for
User-Mode Linux.  The reason was that UML's hostfs managed inodes in an
ephemeral way: from the kernel point of view, the same inode struct
could be created several times while being used by user space because
the kernel didn't hold references to inodes.  Because Landlock (and
probably other subsystems) ties properties (i.e. access rights) to inode
objects, it wasn't possible to create rules that match inodes and then
allow specific accesses.

This patch series fixes the way UML manages inodes according to the
underlying filesystem.  They are now properly handles as for other
filesystems, which enables to support Landlock (and probably other
features).

Backporting these patches requires some selftest harness patches
backports too.

Regards,

Mickaël Salaün (5):
  hostfs: Fix ephemeral inodes
  selftests/landlock: Don't create useless file layouts
  selftests/landlock: Add supports_filesystem() helper
  selftests/landlock: Make mounts configurable
  selftests/landlock: Add tests for pseudo filesystems

 arch/Kconfig                               |   7 -
 arch/um/Kconfig                            |   1 -
 fs/hostfs/hostfs.h                         |   1 +
 fs/hostfs/hostfs_kern.c                    | 213 ++++++------
 fs/hostfs/hostfs_user.c                    |   1 +
 security/landlock/Kconfig                  |   2 +-
 tools/testing/selftests/landlock/config    |   8 +-
 tools/testing/selftests/landlock/fs_test.c | 381 +++++++++++++++++++--
 8 files changed, 472 insertions(+), 142 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

