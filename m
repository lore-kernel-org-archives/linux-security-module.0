Return-Path: <SRS0=c21G=UL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858BC31E46
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DA4208C2
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 20:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N2HZ4/L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfFLU7T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:59:19 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39675 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389499AbfFLU7T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jun 2019 16:59:19 -0400
Received: by mail-lj1-f175.google.com with SMTP id v18so16361139ljh.6
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jun 2019 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=l3VEyWUIpz19ynNy/N2qHdEiDLqpzuYJDD7NorzZ7xc=;
        b=N2HZ4/L5uWJ8QNMKDSq0FO7tTwa7rTy4QL45jcK35gfpeeQw2qQZq01cIdQtxhG41D
         2568TNO1fhu46tbEeVx1JoKSvpG1NG9yKiBzsUnlaQvbSXsi6kG+f2qTAtU1drEbSEiF
         xcRbsYkmZVCjE/j1Xzk7FxQ8fm+layLakyIpAGLaBKzo1aPTI036n5Lhdb+eYBvzyQl8
         FxcUURBFsI0JNdOrhm5UA7otbbT2VU9ymTBIkZfejGahJUObQ6EIu5+7f0odQKDyGGJi
         Odpv5uATkGYtakdyOZfZwZb1ly1DEEjcIt5Lkko583FlfQtaHO+57aosTnFqar5y8tky
         2RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=l3VEyWUIpz19ynNy/N2qHdEiDLqpzuYJDD7NorzZ7xc=;
        b=d4L74WWepfuS+dsn6w6uScJDbLRwwuWMOGwTZn9Zv5Jzq2Of6FqTiWjg//TZiJYvEO
         2JiPOA6JAntDQmXzqzIJG/UTX6Wr62u2tsBZaTHtibaGNMl6ta0Zly9LDC3pKmFWlF85
         cqHVCLftVerIcM67wk3RsH1BsMn6hkflChjfHYLcbXB3id2wopWPprzMJ4X2JfeWdoi+
         zoNLWdtBSHV/ZK+Ez/o9bi5FoaWzAZHmZS8pgpmMKOtjPFnyOvMRtm+D1ESVxDkZpvNh
         nawRAnFd9C4s68w/cUxyJdodr+InnY9U0Kf6IgNL0I7QBcmAnJ7Oa3qHAZMLU6YMfHfE
         kYjg==
X-Gm-Message-State: APjAAAWh/lzEDk5HPc2gUVsh/yZKx650g+wPSlc8EeTvQpmJo39BK6At
        ny49ZGaQYzgxGQywReiriVAnK0a/8c4uMMoCBA/W
X-Google-Smtp-Source: APXvYqyQ9xRqxco6pzmg3Kllok/kjb/RUNCEP+XpYPOK05OKF32F7Ru4shBbfMW+WyLGgAMoWcG0oW76u5p69zhqhcw=
X-Received: by 2002:a2e:9106:: with SMTP id m6mr31118354ljg.164.1560373156513;
 Wed, 12 Jun 2019 13:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 16:59:05 -0400
Message-ID: <CAHC9VhT8tYyUt_gtUR-jD-33LMW2RmzSXwP_OgPrh5ujQSiuUA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.2 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Three patches for v5.2; one fixes a problem where we weren't correctly
logging raw SELinux labels, the other two fix problems where we
weren't properly checking calls to kmemdup().  Please merge for the
next v5.2-rc release.

Thanks,
-Paul
--
The following changes since commit 05174c95b83f8aca0c47b87115abb7a6387aafa5:

 selinux: do not report error on connect(AF_UNSPEC) (2019-05-20 21:46:02 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190612

for you to fetch changes up to fec6375320c6399c708fa9801f8cfbf950fee623:

 selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
   (2019-06-12 12:27:26 -0400)

----------------------------------------------------------------
selinux/stable-5.2 PR 20190612

----------------------------------------------------------------
Gen Zhang (2):
     selinux: fix a missing-check bug in selinux_add_mnt_opt( )
     selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()

Ondrej Mosnacek (1):
     selinux: log raw contexts as untrusted strings

security/selinux/avc.c   | 10 ++++++++--
security/selinux/hooks.c | 39 ++++++++++++++++++++++++++++-----------
2 files changed, 36 insertions(+), 13 deletions(-)

-- 
paul moore
www.paul-moore.com
