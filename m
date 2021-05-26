Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12961C47088
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED9F613BE
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhEZSvH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 May 2021 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhEZSux (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 May 2021 14:50:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96AFC06138F
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 11:49:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s6so2720977edu.10
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUw5EWsm6YpLZJa7t+q5jtkegb7JzdC7cLbi2HaDaSY=;
        b=Qa4+2I8bj+Rl4uorvYi/14nmt2vKj6hYAl7zSFojW6Kt3Nt8daf6Gpm4ZJJgyUNFWI
         xkCMAKH5NW4fxSZHUxXVEUeZGqV3qAKmIt2X/M0TvaEJyVLwexIv0T21EVajyvyO6nub
         PUaOy9tS3C89//WbcyVRpE6YWPS+N7CBNALIqPZJa7o3+FX7M8Hu2Ysql1iwx/TdO6E+
         WNikm8vzY9a+WHq+pwjhS03/CounnEJ3vgkX1e9x2Njpf9ls33p53q9xTOmQDxxF2901
         TEpQTn2TGh9aaLRKw0gbUCJR8ualRB1k8OmjD8DD5IRGpzz6W0AAUVJhXX3DTE7R0ivF
         u5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUw5EWsm6YpLZJa7t+q5jtkegb7JzdC7cLbi2HaDaSY=;
        b=Kw2PCrleeEefiNkQRDNGvd9H4AT9r9RIjg/o40CWNnhsGQkGYWMhwisoR8EOK524/L
         glpH0hiEcMl8gfihTuimyP1YDBGObMDqIOLaPjQY3ryaBVpJLUJiIpWSVnVZJEgQYeSs
         Q84y05nUtUTrjbu3K9qhcck6iTLKjE/Q3hM0r02dXeLrMnR0hyJr05xFd82IaBEv8npZ
         DRNYZDx7kcI3M7hNOKuzZ37wVNsSGdp+6FuH+d3MrBr0JKWBdtDLLmok77i8COr0v7LR
         rjuXRwhqGwLw2iHdoqa5WsJRJP2VN/1ICUzQSkigqVvp6K5zWHjagqdkeG4yrqX2e05d
         2G0g==
X-Gm-Message-State: AOAM531HfVZVwjcdFzP7HDmPkMuIXqiGIaxJISv2rBkkD7PPNbKmOCxy
        XGW9q3OnPLzmPhi176txV+8GV+sx0C4LorRmlCwj
X-Google-Smtp-Source: ABdhPJwv0Uq8DQfJkDvdzA4OniOiI+rWA9eT/CLl2cGg/DPPNpGOFUfGKO6SZKb3UqHq3VqSm/joAe+wfqQshG0/qkY=
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr39405253edt.12.1622054959225;
 Wed, 26 May 2021 11:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl> <x498s41o806.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498s41o806.fsf@segfault.boston.devel.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 14:49:07 -0400
Message-ID: <CAHC9VhQ9r7WHbq2ga+-PF0x5q29nkdNjbLouQETvxDtjE3QaQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 26, 2021 at 10:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > Also, any pointers to easy-to-run io_uring tests would be helpful.  I
> > am particularly interested in tests which make use of the personality
> > option, share urings across process boundaries, and make use of the
> > sqpoll functionality.
>
> liburing contains a test suite:
>   https://git.kernel.dk/cgit/liburing/
>
> You can run it via 'make runtests'.

Thanks Jeff, I'll take a look.  Quick question as I start sifting
through the tests, are there any tests in here which share a single
ring across process boundaries?

-- 
paul moore
www.paul-moore.com
