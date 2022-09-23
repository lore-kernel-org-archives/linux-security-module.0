Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552EECAAD8
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 10:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiIWKnn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiIWKnc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 06:43:32 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F9106F7B
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 03:43:29 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYpf75bC2zMqBrF;
        Fri, 23 Sep 2022 12:43:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYpf71WHBzMpnPk;
        Fri, 23 Sep 2022 12:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663929807;
        bh=uSg7A5h8Ds8U3JESiel2hWeoIMHZGPIKjv8p4UrWwvg=;
        h=From:To:Cc:Subject:Date:From;
        b=jEVqym8Jnw4LyNOzTSRyROirzSZM4326S4ySqaLhO4Q/w1O3hJXCepNHYNlQjHkqi
         sVgCHGcw0pzAq6tEN2S01B0jYRyZ+Gm4j+R3z2vRXaImC247k91d6q1vAo3Q+uuOxw
         GjHOLZS0Zhd0Wm3s+WgOiCU/piIULJSfcUaNA0h4=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.0 #2
Date:   Fri, 23 Sep 2022 12:43:22 +0200
Message-Id: <20220923104322.3182116-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This change fixes out-of-tree builds for Landlock tests, which was
initially identified here:
https://lore.kernel.org/r/CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com

Please pull this Landlock fix for v6.0-rc7 .  This change merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases for a week.

Regards,
 Mickaël

--
The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.0-rc7

for you to fetch changes up to a52540522c9541bfa3e499d2edba7bc0ca73a4ca:

  selftests/landlock: Fix out-of-tree builds (2022-09-14 16:37:38 +0200)

----------------------------------------------------------------
Landlock fix for v6.0-rc7

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/landlock: Fix out-of-tree builds

 tools/testing/selftests/landlock/Makefile | 19 ++++++++++---------
 tools/testing/selftests/lib.mk            |  4 ++++
 2 files changed, 14 insertions(+), 9 deletions(-)
