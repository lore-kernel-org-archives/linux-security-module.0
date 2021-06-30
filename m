Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43626C11F65
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EA161454
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 20:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhF3UYy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhF3UYy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 16:24:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936BC061756
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 13:22:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l24so5007426edr.11
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=PImIOt51jDKDCmCJ/0hr5VWTombGFAivqhWe2AxFwn8=;
        b=QOxYdtn/vWyv8gwk/dWsQZjWjHT2G4lNmAfD/biG3tk5sy6DZUSmpiCGkYj/LpGkww
         8gA3xS19cxhZa7iNGZF6OvZFPtOMnYFxLdt3xvWYxnf149qH3eAj+GN1TQDfdQVp60Jb
         evhD6bMXLujlV/obFZn1I8sE2Mm3QvaSqIZBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PImIOt51jDKDCmCJ/0hr5VWTombGFAivqhWe2AxFwn8=;
        b=f4ijl7ZDcYmQl7joje/55AjMgCVTeMDkwMsl0ZyoUc4b1r/PrRRaG1BHbbtlJuA2HB
         T5ytpsn21ceJUD604YBuZLSL/5LXySXp0N9IJgGwh2Hga28vYX8GQi9kC29hxoPC0cgu
         lgo0phz7r/J1y+FcLCPMGA16UTzbUYyMZ79wcZ2Koj7Vj4OcJt/TfazvwbItQKaGCaP9
         Frq+5Rgf4ubMnHiQI13eEx+zkthhBeJ5zzGLN4G9FiWv42iUW3ORQ8bAS5pOs2qzlSdR
         YIWlHRq0c/hpkQhvrFeFX31SCPhX/yXaBFzpC9zR0626cOf+TNroOnwIjYheezkuo7Wg
         Laeg==
X-Gm-Message-State: AOAM532LEjTkLlufGp2xUEr5EqhIG7nvbJXBLwEdG1kQ8HUOG/VIRYXO
        ULUu63PEbdqyCuWoLt7FopJH9NaIGblCQ1X4gsyfaw==
X-Google-Smtp-Source: ABdhPJy7u84dJq/DmHkKhh2+ktLunIqakK5FT1750p6s3XEvk6F66J/QiB96iLt40pM7ZRmwckZk+cfrBJtZbwJ3F6Q=
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr49652298edu.328.1625084542606;
 Wed, 30 Jun 2021 13:22:22 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 30 Jun 2021 10:22:11 -1000
Message-ID: <CAJ-EccODUD45ZFgqqSxwZ9-DkqJL7F9fYOiHt+2tLZBss3VoAA@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-5.14

for you to fetch changes up to 1b8b719229197b7afa1b1191e083fb41ace095c5:

  LSM: SafeSetID: Mark safesetid_initialized as __initdata (2021-06-10
09:52:32 -0700)

----------------------------------------------------------------
Just a single change that marks a variable as __initdata.

This change has been in -next for a few weeks now.

No other work was done on SafeSetID for the 5.14 merge window.

----------------------------------------------------------------
Austin Kim (1):
      LSM: SafeSetID: Mark safesetid_initialized as __initdata

 security/safesetid/lsm.c | 2 +-
 security/safesetid/lsm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
