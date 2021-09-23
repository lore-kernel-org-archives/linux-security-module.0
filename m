Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85008C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB1161241
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbhIWU0G (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIWU0F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Sep 2021 16:26:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3442C061574
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 13:24:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so27453084edt.7
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nMzcp/8joR6kTSo7ETzEZ9Ek7QuPuXXM7c+XEqSTszY=;
        b=k90zC2dDnOWMj1ojN2z5cwtMiHENl0n9hahhuAs1vIhflh5w2sgJiZjW+bYqbmccNz
         S6I9ng3ak36HQ9v5edxRLITAwXPL1rgimE5JYeB0Y552u6dwI/MeDUfSEupeeKpmK4A3
         ix1Hkwffoj6vEl/v65bX7Q1IRmRdKEps54qSHER6Q9hN575KY6nAc71x0DRCRVly5u09
         PZmZg4XEc50XIwGLJvgiVcE4/mc6mRxOa7DjThJH9QUCsABo2COmmgEam0tOga94fIkW
         qCicuafOMTP7lqVoITloVlQQHd2A1OsuSo2jjmrGUDYh1O8rjAr4JWkEtRLz03xkpXGl
         qmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nMzcp/8joR6kTSo7ETzEZ9Ek7QuPuXXM7c+XEqSTszY=;
        b=A0GC6ivAbzQIhIZSEJf9ZjsiiOoL39G3z3PSFV0Wv61nnvpbiTk+oxpXN0nVw/RPhK
         l2sUSqL3bSNQP3O/Iz2rUfryFmeqJLsfrJgVVFSI3EpInrymxClKvKofTqRc22BJjSch
         7Hs82Vsel64uJVIsCsciCr0uH2nPogRWTIKTRc6J7KFPuMxBe045B2OTbeNda5DBrgSH
         +TSjjGD9rA8siH3IHckjPMCiFTtTXXpqhoBqjMUrOOIfJ1znsMLidXcKXfjk5UdCq1MV
         0lgHs3s+F2WGUsx2/eps1KJY/0oNBiVKKPI7IxDeQVVs1P1pd3uvNZNcqXSRaRVpFsYr
         Xk1g==
X-Gm-Message-State: AOAM533zOQnw0DL/qr10N8suFDMb/Jp3pUcJGwhJ+/JkOuOof90IMnMM
        9CDe5Irsrn24yvlG9K+RIia/JzEhf5foIuqtIQSC8E4zm0K+
X-Google-Smtp-Source: ABdhPJzjfVn2kJzHgPgX66bIldWuZc1mF4G8aWl7bssVGl4Ij9cybr/bXTM1hHJq4NbXfqrofi44jEvLdRy+HCvc0Ng=
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr866912edc.362.1632428672314;
 Thu, 23 Sep 2021 13:24:32 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 16:24:21 -0400
Message-ID: <CAHC9VhSDOQpQPfzMfvEd+hCZeyJiZ4WbvjjG7rGgYAUS=7vZBQ@mail.gmail.com>
Subject: [GIT PULL] SELinux/Smack fixes for v5.15 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Another one patch PR for SELinux, as well as Smack, that should be
merged during the v5.15-rcX cycle.  It fixes some credential misuse
and is explained reasonably well in the patch description.  Please
merge.

-Paul
--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

 Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210923

for you to fetch changes up to a3727a8bac0a9e77c70820655fd8715523ba3db7:

 selinux,smack: fix subjective/objective credential use mixups
   (2021-09-23 12:30:59 -0400)

----------------------------------------------------------------
selinux/stable-5.15 PR 20210923

----------------------------------------------------------------
Paul Moore (1):
     selinux,smack: fix subjective/objective credential use mixups

security/selinux/hooks.c   | 4 ++--
security/smack/smack_lsm.c | 4 ++--
2 files changed, 4 insertions(+), 4 deletions(-)

-- 
paul moore
www.paul-moore.com
