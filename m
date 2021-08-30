Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2BDC432BE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD51C60F3A
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 18:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhH3S2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbhH3S2v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 14:28:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8062C061575
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t42so12852176pfg.12
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Mz42W/Lx43y6CcuCJpr6nNW2Lf79xV+Oh1YYCpvYFXY=;
        b=jHyLx/jQQd0/go0ng9MmCROtCBvWRW1jJWRWt+5N4mZNdw08Art/r5RXbTKYhW02Pr
         gFozWUjOdbvKOLi18vnhwKFINft1ClPa8tq2Z/AxacTNomYgirniezgc3vwvrZqMp3zU
         HyARwx0oVGh80z/g7HDmifIWMmVsdHG6hDM5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Mz42W/Lx43y6CcuCJpr6nNW2Lf79xV+Oh1YYCpvYFXY=;
        b=FHQcQZ6Ug/qb3dBMIvpkfzPq11I30UhHelwc5pGUbMncLznEH9LTpyJF74mRtnvMFb
         6XtCud/YB/WUxk5y2mHMRGN+rgHX007HbnGs/+aMAFJ+LpV5RV7JYo98ZBVaUPpajCfJ
         N+BPN98P50TLKaKO6EpjXCr1m9pnkbu3KGJ9TPlvQI/nD7mn6D30PvyaT95qksZDinIA
         wYIWOyA+veaCiycuKIiFuCBtXEMi/tg43+td61fj390j8MKIXnGdSWsY36chiL1qf9RD
         mY5UtcDfsuweq8gxUFAlK3Hw3Qw4Fcswaq91AR2ggLevBfupj6he/ZNeW/hpolM7trdF
         vtBA==
X-Gm-Message-State: AOAM531EcKSlZILmwlqJbUiINl7ltOo+eoErlGUp9DeIm9YnFBVMmFXY
        8JGX7TSZkRtLffhecUDTstpCOA==
X-Google-Smtp-Source: ABdhPJxxZJQIBMc6Dsq5ghhAjnvEVvZ5nNMfDKrV02lD/0HepnMIzBryoTQXACy/mPtWNDY4mhBYeg==
X-Received: by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id a17-20020aa780d10000b0290399ce3ad617mr24408847pfn.16.1630348077240;
        Mon, 30 Aug 2021 11:27:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23sm177071pjs.16.2021.08.30.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:27:56 -0700 (PDT)
Date:   Mon, 30 Aug 2021 11:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, glider@google.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] hardening updates for v5.15-rc1
Message-ID: <202108301127.836C1F4D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Please pull these hardening updates for v5.15-rc1.

Thanks!

-Kees

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.15-rc1

for you to fetch changes up to a8fc576d4af2f23a87a586424252df97f0ad0b06:

  lib/test_stackinit: Add assigned initializers (2021-08-22 00:21:36 -0700)

----------------------------------------------------------------
hardening updates for v5.15-rc1

- Expand lib/test_stackinit to include more initialization styles

- Improve Kconfig for CLang's auto-var-init feature

- Introduce support for GCC's zero-call-used-regs feature

----------------------------------------------------------------
Kees Cook (5):
      hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
      hardening: Clarify Kconfig text for auto-var-init
      lib/test_stackinit: Fix static initializer test
      lib/test_stackinit: Allow building stand-alone
      lib/test_stackinit: Add assigned initializers

 Makefile                   |   5 +
 lib/test_stackinit.c       | 253 +++++++++++++++++++++++++++++++++------------
 security/Kconfig.hardening |  71 +++++++++----
 3 files changed, 242 insertions(+), 87 deletions(-)

-- 
Kees Cook
