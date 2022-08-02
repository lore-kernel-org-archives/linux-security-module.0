Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB11C00144
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Aug 2022 02:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiHBCkn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Aug 2022 22:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiHBCkm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Aug 2022 22:40:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0760FC
        for <linux-security-module@vger.kernel.org>; Mon,  1 Aug 2022 19:40:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rq15so17581884ejc.10
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=xPuuf8+PAYoavldmY5b0ibEHAIh5Ld0JS+AL2+6BUHg=;
        b=A8wfm0/Lj6UP6J2JryDD1irUewuyEwBm3U9jUrGLoMk6ihhA52fQ1xstY+87Rg/3Pg
         81rDvRy8AvrKkvVCpTVR1CZb4VdhUO7vUCMrbzCc+paxTDLjZXArzlgyvj6kIlAHZn0Y
         /VUOR1t1JvAwXes35KTGoJpaLzQM4dV31mrq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xPuuf8+PAYoavldmY5b0ibEHAIh5Ld0JS+AL2+6BUHg=;
        b=ULr+E1zIOpcl7FWBMgReUA/SDJMo6oiHIc1tnFgFx8/UCbkNPDHgetrqNcusM9rLrU
         xeXOFJHA6QKMPqmBEHPXHk1x40lcSGEUOYEtiUj3aNibFc2ldt8p25X9yjOO+plyMH/G
         6ue5jkU6BBu3odG697aHaTtD0TZ1L1TNa9H6Ij8fCUV0E+IxF/LHEJy+IvTZkYmcA8PJ
         AhmT8vSn+jN4Z60Jr9LCDuDoQIH69FXvk0H6yPGHXO6+MfP4qIhMuMzEpZtBf2f5Mkg7
         d55ID+i7GCrv/khp94KfZKygZFVVqZ2zsPem0aA6OyG05VVpaG02TIJXHsb1+BgOu+Qz
         IxIA==
X-Gm-Message-State: AJIora8yPJyp+L14HpB+aGkBPQSmaiqxvBAFCnWxBra7++rIs8UPIazQ
        MzzzvhJmdKQQ5uRMFmb/5cZRSnTXpdhEUzCExz7HGLe5PZFKTg==
X-Google-Smtp-Source: AGRyM1ssOTfG0ulGVLlHvsfyQwduJLPLytNCncGY7BXeiV9DslnFDGR/nwnfEhce0TWJka/kMUnxWwF6omDezNqnpLA=
X-Received: by 2002:a17:907:2ccb:b0:72b:52bb:fd51 with SMTP id
 hg11-20020a1709072ccb00b0072b52bbfd51mr14600021ejc.118.1659408038916; Mon, 01
 Aug 2022 19:40:38 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 1 Aug 2022 19:42:26 -0700
Message-ID: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:


  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)


are available in the Git repository at:


  https://github.com/micah-morton/linux.git tags/safesetid-6.0


for you to fetch changes up to 64b634830c919979de4b18163e15d30df66e64a8:


  LSM: SafeSetID: add setgroups() testing to selftest (2022-07-15
18:24:42 +0000)


----------------------------------------------------------------

This pull request contains one commit that touches common kernel code,

one that adds functionality internal to the SafeSetID LSM code, and a

few other commits that only modify the SafeSetID LSM selftest.


The commit that touches common kernel code simply adds an LSM hook in

the setgroups() syscall that mirrors what is done for the existing LSM

hooks in the setuid() and setgid() syscalls. This commit combined with

the SafeSetID-specific one allow the LSM to filter setgroups() calls

according to configured rule sets in the same way that is already done

for setuid() and setgid().


The changes are based on v5.19-rc6 and have been in -next.


----------------------------------------------------------------

Micah Morton (6):

      LSM: SafeSetID: fix userns bug in selftest

      LSM: SafeSetID: selftest cleanup and prepare for GIDs

      LSM: SafeSetID: add GID testing to selftest

      security: Add LSM hook to setgroups() syscall

      LSM: SafeSetID: Add setgroups() security policy handling

      LSM: SafeSetID: add setgroups() testing to selftest


 include/linux/lsm_hook_defs.h                      |   1 +

 include/linux/lsm_hooks.h                          |   7 +

 include/linux/security.h                           |   7 +

 kernel/groups.c                                    |  13 +

 security/safesetid/lsm.c                           |  39 ++-

 security/security.c                                |   5 +

 tools/testing/selftests/safesetid/Makefile         |   2 +-

 tools/testing/selftests/safesetid/safesetid-test.c | 295 ++++++++++++++++++---

 8 files changed, 315 insertions(+), 54 deletions(-)
