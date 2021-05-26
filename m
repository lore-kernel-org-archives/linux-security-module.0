Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35FC47088
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 19:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D040613B5
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 19:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhEZTMi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 May 2021 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhEZTMd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 May 2021 15:12:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E8C061760
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k14so4189237eji.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=rrEpfN2eSUWFwTnN59H3JQhAB5eFLKAJCg2tSavS1ZnxCW60lgzt33IwObabQh2Fiu
         R8otedpGlExOIZh5g2t3KeDEHthFgNq1Tw5Tl27NvK/Ol5bCJAu0NtWwcAaDGALwhO/A
         bOBmrwLBshkHZB8xUhrMI1yIP2wvejtGOyxHPdwD85dbPnHecSxw/UJV9E6KSGPlbGNn
         YFMesNoT/acoDSs5GvcbN7ez6HpdH129AZcY1OlbklrTQPR5ANzn7wdWVaXScc9ZcKDd
         d2DctUe3Woib8fuZANmiFmn3S+7eNKMuWsFxjXbOWuVZQSJC/jKuj3i0PmeX6GWLwsFj
         wxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=B5fboYeq9s5qczH7QMsmj4DhkiNReuTtIOtMZw78OvYp0anu1zXeRkh2YDRS45+zkL
         WJIQCIx8KrpGyb3CY6q0678s1AcLWl+bmIjszSHqOmtCHuHMB/P1fr2NzTc49Ll7od/K
         azBorrODBnVRN3/cGOQ+w5s66pa9+Fj0pniPfnprR3fZHBvKh2e2B7AlfL7cmZJjuw3F
         1IYKX/SpywbJ6RSBknRCM4Oz5smRWwPcljckCVWgrhq4nvh+kjbTVL22ZkaqBuku2P+n
         0sMBFYNjkbBna4xXL9BHsWF2vv75vvWgq04TgymbdmJeIcTzSMJ0RPS5guqlzefVfdDo
         NSug==
X-Gm-Message-State: AOAM5324UqRKVlhjlgaDhr+pXjrro2yZUHzTKCBhW9N+c6sftFWPqXz2
        2C6OWlz7YFg4FY/ZL7kmy+cBGXxw9z7wgfOu/MKP
X-Google-Smtp-Source: ABdhPJw5Uo6wSn4k4zz/jz3Ayrk4WGYUWInTcmg7vYqy+K7NbwQFUmlxJqbAcL8Cf1k2FEX+enTA83rXl0PTreAKR3g=
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr34549005ejr.398.1622056258166;
 Wed, 26 May 2021 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <x498s41o806.fsf@segfault.boston.devel.redhat.com> <CAHC9VhQ9r7WHbq2ga+-PF0x5q29nkdNjbLouQETvxDtjE3QaQg@mail.gmail.com>
 <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 15:10:46 -0400
Message-ID: <CAHC9VhS-R-bNtoOZnENN4TJX7ztpjWBUsnLMbCfXJDpe42JdqQ@mail.gmail.com>
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

On Wed, May 26, 2021 at 3:06 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, May 26, 2021 at 10:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >>
> >> > Also, any pointers to easy-to-run io_uring tests would be helpful.  I
> >> > am particularly interested in tests which make use of the personality
> >> > option, share urings across process boundaries, and make use of the
> >> > sqpoll functionality.
> >>
> >> liburing contains a test suite:
> >>   https://git.kernel.dk/cgit/liburing/
> >>
> >> You can run it via 'make runtests'.
> >
> > Thanks Jeff, I'll take a look.  Quick question as I start sifting
> > through the tests, are there any tests in here which share a single
> > ring across process boundaries?
>
> Yes.  At the very least, this one:
>
> test/across-fork.c

Great, thanks!

-- 
paul moore
www.paul-moore.com
