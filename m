Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AA0C433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Nov 2022 17:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKDRsr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiKDRsk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 13:48:40 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F732065
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 10:48:37 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N3p5H19tJzMpnTX;
        Fri,  4 Nov 2022 18:48:35 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N3p5G5ZzgzxM;
        Fri,  4 Nov 2022 18:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667584115;
        bh=iVDJr0LhXXdAELXpJxhjsS6rEhTZnKpe++oxRvcucnc=;
        h=From:To:Cc:Subject:Date:From;
        b=VQr44hrcj/MPfx7fm9tW8K6CqoDgm7q3NVKjgVUAGlI+NZwTtn+CsaTiYealZKz1F
         eu17Ji/urCPtR121AhjOEAslPPu2k3QZSJ1YDZQ4vg866OZxKAmICJ6zrJsEavj2A8
         OzNW+u1d0xRP1GHEgWPZ80BpqE58UIUhL4sZunhY=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.1 #2
Date:   Fri,  4 Nov 2022 18:48:30 +0100
Message-Id: <20221104174830.57435-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This change fixes test build for some distro.

Please pull this Landlock test build fix for v6.1-rc4 .  This commit
merged cleanly with your tree, and has been successfully tested in the
latest linux-next releases for two weeks.

Regards,
 Mickaël

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc4

for you to fetch changes up to 091873e47ef700e935aa80079b63929af599a0b2:

  selftests/landlock: Build without static libraries (2022-10-19 22:10:56 +0200)

----------------------------------------------------------------
Landlock fix for v6.1-rc4

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/landlock: Build without static libraries

 tools/testing/selftests/landlock/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
