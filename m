Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967AEC433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A04E619A4
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 16:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCVQwl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhCVQwK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 12:52:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171DFC061756
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 09:52:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so20137027edu.10
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TQd+DG5DK7GKR790ZQ/IR8XB7thSHl9oxqPLUyu5X30=;
        b=sQQtwdtknuPswfoN2PMQqY3poclxpLp/+bhNFuLzq2Gi7DaFo0KKqrl4wmkcWSsNTf
         ijpUo5li5bWNW838CBZ2E77mkpnHA3h0TGK69tD7t6k1wqCu+TYNoy/SpExy7VExwtfn
         4pBr7kCf25Bfbln/fwnKWk24nlVBwf6p+/FXG0NIBmIUWtYY4ZwMaJFmRCqMvWQPNOK4
         YPbxJgVj5WBiO955rYZ2lySL1xbWxHo+hfihltppc8OSjDIn5OckVCqZ8j6GUTcggoSQ
         C0UwoU3k+306ziFnAO6Ta3YETibV2MVT5wkzp7k2xgXyNLrlUzEXYQqxXNTkGXdPWhh9
         /Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TQd+DG5DK7GKR790ZQ/IR8XB7thSHl9oxqPLUyu5X30=;
        b=C0shWCpQ66q8Hbsr9oI/b5OSwLDqGuG/e7k6nB8mXIYplIHHgR0mG6X1jz5ZspD7Oi
         QUsHlwVgrpJmssRW6sng4lRMgcjN4fVeRxdbJiv0/2Y1u53gUIG+cih7txkV788JPCKA
         ay6oWDWaDRj+r0Z7YFEoliRwfJ0wGIUrfyE5db2zdXoTzbBBBvcu0VhUJFFA8SQmoplh
         bfCIA9j1W+F1O2ody+Ipv6w1NNghhD7bURrmacs3Iof6UUE3SaxWv/RyakdNnlEtXDJs
         RK3F6EKAsMQ7zrOpt4xh7iPfUNRuh+YxYX/X10KquZEPeaAUMlLXDjbkg6lIkfmFWUDU
         78hg==
X-Gm-Message-State: AOAM533695wPxh/mrUAmfJdczcTY/N8t3+mqvx6fP0ZaDwyIAXx25cV6
        vThQNQAsT7wEJU1zgpsU/amtvHEttAPgskLZ4aZA
X-Google-Smtp-Source: ABdhPJwSvaGQeC3mi4EKYRPrd7U6RZ/kAZb0AudXzvomm6MVCh0LuAAYLveP9CYVDldKaNNIekNT8IvZDkcDKHz1N+s=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr492609edb.135.1616431928741;
 Mon, 22 Mar 2021 09:52:08 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 12:51:58 -0400
Message-ID: <CAHC9VhRQmoo45x8nLH-C-+L=+6W7Jtjm-ex8vgLjNhPmFTyDJg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.12 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Three SELinux patches to address problems in v5.12, and earlier, kernels:

* Fix a problem where a local variable is used outside its associated
function.  Thankfully this can only be triggered by reloading the
SELinux policy, which is a restricted operation for other obvious
reasons.

* Fix some incorrect, and inconsistent, audit and printk messages when
loading the SELinux policy.

All three patches are relatively minor and have been through our
testing with no failures, please merge them for the next v5.12-rcX
release.

Thanks.

--
The following changes since commit 365982aba1f264dba26f0908700d62bfa046918c:

 fs: anon_inodes: rephrase to appropriate kernel-doc
   (2021-01-15 12:17:25 -0500)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210322

for you to fetch changes up to ee5de60a08b7d8d255722662da461ea159c15538:

 selinuxfs: unify policy load error reporting (2021-03-18 23:26:59 -0400)

----------------------------------------------------------------
selinux/stable-5.12 PR 20210322

----------------------------------------------------------------
Ondrej Mosnacek (3):
     selinux: don't log MAC_POLICY_LOAD record on failed policy load
     selinux: fix variable scope issue in live sidtab conversion
     selinuxfs: unify policy load error reporting

security/selinux/include/security.h | 15 ++++++---
security/selinux/selinuxfs.c        | 22 ++++++-------
security/selinux/ss/services.c      | 63 +++++++++++++++++++++------------
3 files changed, 59 insertions(+), 41 deletions(-)

-- 
paul moore
www.paul-moore.com
