Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91BCC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Oct 2022 17:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJDROd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJDROd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Oct 2022 13:14:33 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02815E318
        for <linux-security-module@vger.kernel.org>; Tue,  4 Oct 2022 10:14:29 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MhkpC3gK8zMqLgs;
        Tue,  4 Oct 2022 19:14:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MhkpC1d61zMpqBK;
        Tue,  4 Oct 2022 19:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664903667;
        bh=O1Eep5R1Uhm24Ad2jxVeSqkWoP3tf66+7U1e7K0UzTk=;
        h=From:To:Cc:Subject:Date:From;
        b=DtqOoLFC4cI0WV0k5pqaZ5btMl32HUJq+SRLiCjYAG04czucOPuJvJ+QT+uEA9dBd
         xzorlzP5WHYmqxecqbu/jYV+VRuPi//Auy8Oaaxvwvw8m+KoMp+gxpy45tpLCoyJaO
         BB/tfBScQkO7fFNaJ1BWc24+0uqVkjAm0khKrvC8=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.1
Date:   Tue,  4 Oct 2022 19:14:14 +0200
Message-Id: <20221004171414.974585-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This changes improve user help for Landlock (documentation and sample).

Please pull this Landlock changes for v6.1-rc1 .  These 3 commits merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases.

Regards,
 Mickaël

--
The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc1

for you to fetch changes up to 2fff00c81d4c37a037cf704d2d219fbcb45aea3c:

  landlock: Fix documentation style (2022-09-29 18:43:04 +0200)

----------------------------------------------------------------
Landlock updates for v6.1-rc1

----------------------------------------------------------------
Mickaël Salaün (3):
      samples/landlock: Print hints about ABI versions
      landlock: Slightly improve documentation and fix spelling
      landlock: Fix documentation style

 Documentation/security/landlock.rst      |  8 +++----
 Documentation/userspace-api/landlock.rst | 33 +++++++++++++-------------
 include/uapi/linux/landlock.h            | 10 ++++----
 samples/landlock/sandboxer.c             | 37 ++++++++++++++++++++++-------
 security/landlock/fs.c                   |  2 +-
 security/landlock/syscalls.c             | 40 ++++++++++++++++----------------
 6 files changed, 76 insertions(+), 54 deletions(-)
