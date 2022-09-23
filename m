Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A62C6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 15:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiIWPnN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIWPmv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 11:42:51 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07C147A1A
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 08:42:17 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYxGv0gDBzMrD2g;
        Fri, 23 Sep 2022 17:42:15 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYxGr12BgzMpnPf;
        Fri, 23 Sep 2022 17:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663947734;
        bh=N75BW+GstyhWgW+kRb+chbKBZv4Ko+YdgZx8zHl4tek=;
        h=From:To:Cc:Subject:Date:From;
        b=sLnZUbvEbwsykuHJ/+IeYY/8SZ6eyMPFWadBk3+sQZnJnvGfw+LIEXfz+1ColbyM1
         G3j/GhnbDzAeom3BTwUag/QulCowcGrwWcCP8a7jNkI4738DLUAPj+dVgdr5Fvn8t9
         ijUWwOcdBJgLfjP6c+NHpAotk+uvb3DTkF0cNOMA=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/3] Improve Landlock help
Date:   Fri, 23 Sep 2022 17:42:04 +0200
Message-Id: <20220923154207.3311629-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series improves the documentation as well as the sandboxer sample.

The documentation style changes were previously discussed:
https://lore.kernel.org/r/2f9c6131-3140-9c47-cf95-f7fa3cf759ee@digikod.net

This conflict with the ongoing truncate and network patch series but the
resolution should be simple, see my "next" branch merge:
https://git.kernel.org/mic/c/3d6723ed39cf13e6da69eee765d01c3bc1d315a5

Mickaël Salaün (3):
  samples/landlock: Print hints about ABI versions
  landlock: Slightly improve documentation and fix spelling
  landlock: Fix documentation style

 Documentation/security/landlock.rst      |  8 ++---
 Documentation/userspace-api/landlock.rst | 33 +++++++++----------
 include/uapi/linux/landlock.h            | 10 +++---
 samples/landlock/sandboxer.c             | 37 +++++++++++++++++-----
 security/landlock/fs.c                   |  2 +-
 security/landlock/syscalls.c             | 40 ++++++++++++------------
 6 files changed, 76 insertions(+), 54 deletions(-)


base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
-- 
2.37.2

