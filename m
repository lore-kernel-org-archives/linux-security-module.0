Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019EC32772
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Aug 2022 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350970AbiHSTBT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350588AbiHSTBS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 15:01:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC4107AD5
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y4so4887205plb.2
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=cXsSHHpnoTh2+F/5sCHLWMtTW4VH+4NF/mMlIkwDIfg=;
        b=ggBv9qFM7zXn0eUb/pwRHzZTrR4EqH6pCbu984mIrX/hWYDe8R+MSKXZVQb/S4PHQU
         2ttjysKIM+QdLbktXrxWJNNtR7FUN61zPG9evbLZN7KzRaY/SWvOpJgJy3Y7tzlQ34Ya
         gw7dSg0kibUFbVQkFj7kkKfyyGcNBvUhVl6GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=cXsSHHpnoTh2+F/5sCHLWMtTW4VH+4NF/mMlIkwDIfg=;
        b=blHrm+YtLv/djQKL+qC7P46fdQm4FhCU+3trntZKwXdR/iIiC7jRrt/FjboJuiUCCU
         mHDS17j9ZgkN4L3OcMnbERGnc9TGPTAlJOH1W0+vWqb03jZG8IqNjn7KfKA3uUVyjFms
         teL9xZgUwRgbKcsA0T/FfEIqfkhK9szSoKSXMWZP4m2HsMz9uUiOCkPRbIIIGSygBpF1
         xNdchesVhvN/BEw+FQCVLagJqg6Fam+csB4w3rSxHDjY/u4fwgeN0rTbmQ6ylrrqFWn5
         fRhqyUBo6AJLifjvdOHFB2s+8qqYCDAxLAykoGjKXrlZSiCi5W/t7J7DJzFX9kZKh+y3
         xuxA==
X-Gm-Message-State: ACgBeo2eqiwkKCrMuoDXA0fUM+U9RhVMcGtI54o++wsapdF28r2rE09x
        MZf+LFsZkzOyftME+mJUy3ig1g==
X-Google-Smtp-Source: AA6agR4d+h6ax+4AOqMh7T81NqJrBcgS7o8oaZ36P3VqJG2jgW7aZyd7vkb6EvK54pDa5fJ45vqQRg==
X-Received: by 2002:a17:902:b109:b0:170:9d92:4110 with SMTP id q9-20020a170902b10900b001709d924110mr8265278plr.32.1660935677172;
        Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b0016c6e360ff6sm3544018plf.303.2022.08.19.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:01:16 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:01:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Erhard Furtner <erhard_f@mailbox.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] hardening fixes for v6.0-rc2
Message-ID: <202208191200.C8B461644@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Please pull these two kernel hardening fixes for v6.0-rc2.

Thanks!

-Kees

The following changes since commit 27603a606fda0806d7c08914bc976931aa42020e:

  dm: verity-loadpin: Drop use of dm_table_get_num_targets() (2022-07-28 21:48:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.0-rc2

for you to fetch changes up to 012e8d2034f1bda8863435cd589636e618d6a659:

  gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file (2022-08-16 12:25:53 -0700)

----------------------------------------------------------------
hardening fixes for v6.0-rc2

- Also undef LATENT_ENTROPY_PLUGIN for per-file disabling (Andrew Donnellan)

- Return EFAULT on copy_from_user() failures in LoadPin (Kees Cook)

----------------------------------------------------------------
Andrew Donnellan (1):
      gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file

Kees Cook (1):
      LoadPin: Return EFAULT on copy_from_user() failures

 scripts/Makefile.gcc-plugins | 2 +-
 security/loadpin/loadpin.c   | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
Kees Cook
