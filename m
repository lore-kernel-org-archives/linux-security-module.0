Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9183C433B4
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Apr 2021 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9092861424
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Apr 2021 20:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbhDUUjH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbhDUUjG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Apr 2021 16:39:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F131BC06138A
        for <linux-security-module@vger.kernel.org>; Wed, 21 Apr 2021 13:38:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so65448029ejo.13
        for <linux-security-module@vger.kernel.org>; Wed, 21 Apr 2021 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=md3o4p7n3hM5uE+5WCGNtClm3RdZoyFagq0E7NLsAic=;
        b=jluoif0LUeWyHw6yXRzDm293OaeL1Gvzfs7lwWkF0kZ9iIB1xqqXcZBZzzI/nHk04R
         RJ5g0rXOaZVzvBmrxkjLX1UL2uAcE44TgBlZMGHdPQ6nibpmb/ZZgNzdIwqQWeaE4jwe
         X7GwFGRmJn4teKMZEas+gWWYQ6GPcmOqBAE1TKE0ELsYa+UL1L3STWfI7955RsmXxtZX
         iN3VPpRYPPbQVHaaquw/NaB2MZk+e1rO98iDD8P0RBMTASUUMSwY0li2YrNwYWvfizuR
         kW4otWYEy08FXf46qc1KQr9JcddGNgHgqd88tjlw3lYZDryYu2WR5b576MwjjpTbBKrI
         +Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md3o4p7n3hM5uE+5WCGNtClm3RdZoyFagq0E7NLsAic=;
        b=Of2QPQDT2AUugQOsDOduzVVwPmlBKa6KMxKpKLv6LEfbohlQLAQzOECE0qOeicpHBb
         owArIw2BPDlVPQl7dI4TwE8bOTqc8SVk0udoVudVzvOvv2SHrNdJYUcQ/VML63tBPce/
         ucWOLvpX/A8yL+g9VPG8nrZXAhBLIbbZj8Kggta28iw/rKLzskct3caAyonhpXFGi9av
         UoWn50ISwI6Sm/cc/J/JGjxJ5Ta84gqu7tf5FAOF+uWjS2PXNRWafaKai6d6JvilGTv7
         Ijfmmk4mic1Z9MHZoIPgFWj6Lf0FeJ0gfoZWr1Y3q2tv4V/hj7ky+OLRAheDIPiQzDSS
         Xu+g==
X-Gm-Message-State: AOAM531EyBKGMG3oFftu09gmNFrMriBnXXS3l+8usi1Zl9WZ0jjCrhR4
        U8xfrh69J3/SaQPLM23zymw+t2zrOUogCSC7p3oQ
X-Google-Smtp-Source: ABdhPJyFe9bNzV6/bc99zAfaqrVO1DebH0rgqEH8+mOVAiJ8K6bc6MFkmZrpd827WzqVo1ofdZuRb3cNGC3u1dwSFpY=
X-Received: by 2002:a17:906:f1cb:: with SMTP id gx11mr35468706ejb.106.1619037511266;
 Wed, 21 Apr 2021 13:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com>
In-Reply-To: <20210421171446.785507-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Apr 2021 16:38:20 -0400
Message-ID: <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series aims to correct a design flaw in the original anon_inode
> SELinux support that would make it hard to write policies for anonymous
> inodes once more types of them are supported (currently only userfaultfd
> inodes are). A more detailed rationale is provided in the second patch.
>
> The first patch extends the anon_inode_getfd_secure() function to accept
> an additional numeric identifier that represents the type of the
> anonymous inode being created, which is passed to the LSMs via
> security_inode_init_security_anon().
>
> The second patch then introduces a new SELinux policy capability that
> allow policies to opt-in to have a separate class used for each type of
> anon inode. That means that the "old way" will still

... will what? :)

I think it would be a very good idea if you could provide some
concrete examples of actual policy problems encountered using the
current approach.  I haven't looked at these patches very seriously
yet, but my initial reaction is not "oh yes, we definitely need this".

> I wish I had realized the practical consequences earlier, while the
> patches were still under review, but it only started to sink in after
> the authors themselves later raised the issue in an off-list
> conversation. Even then, I still hoped it wouldn't be that bad, but the
> more I thought about how to apply this in an actual policy, the more I
> realized how much pain it would be to work with the current design, so
> I decided to propose these changes.
>
> I hope this will be an acceptable solution.
>
> A selinux-testsuite patch that adapts the userfaultfd test to work also
> with the new policy capability enabled will follow.
>
> Ondrej Mosnacek (2):
>   LSM,anon_inodes: explicitly distinguish anon inode types
>   selinux: add capability to map anon inode types to separate classes
>
>  fs/anon_inodes.c                           | 42 +++++++++++++---------
>  fs/userfaultfd.c                           |  6 ++--
>  include/linux/anon_inodes.h                |  4 ++-
>  include/linux/lsm_hook_defs.h              |  3 +-
>  include/linux/security.h                   | 19 ++++++++++
>  security/security.c                        |  3 +-
>  security/selinux/hooks.c                   | 28 ++++++++++++++-
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  3 +-
>  security/selinux/include/security.h        |  7 ++++
>  11 files changed, 95 insertions(+), 23 deletions(-)
>
> --
> 2.30.2

-- 
paul moore
www.paul-moore.com
