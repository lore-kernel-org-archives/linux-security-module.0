Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C6C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6C520786
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AcC/qQQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgHLIhV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLIhU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 04:37:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75063C06174A
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 01:37:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so1326560ejc.9
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5lKpdbRMPYHAYu1ae51I164qapzjNwIVzhn7ZJhmbg=;
        b=AcC/qQQCnxrUQDrRulzph4bIrPpKQ4hbVAqb0dQpE0YjsJg0S4AcKPqmLXQnYuZ8gQ
         9rMS2fX/xoMespxJ1EdabWK4zL1o2n2eaJ+IDZKcNAadf3DO9VvJI4IyDPUvT+oct/lD
         KK1tAvYAp2gilfvh3FiKoGKiqOV2rTwVpP3Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5lKpdbRMPYHAYu1ae51I164qapzjNwIVzhn7ZJhmbg=;
        b=un31Iwq84p6PIK7FD+ZwCb8y08Tf5KpyHRZo5aeYwyoYjBBgEtjTckKzGDipr/bPCH
         Wmjxf+vgr6lzWENmc0BgIK+FiyRZebsiq1SCb3AwYDc2aFztAhObaffE2Jl+9faErVzP
         2xnkw2eLwFFVmnyGmwEwAvHTEIcYlmGHBp14fwE6OXu6csSXruw5OHuWxCiY53vw1oB6
         8sT03Va7APD+gmQXB53rEblLkTAlDMA5SfT5ZVkIaS7VmoQlazfHOgBTaHvyTc/CHFNp
         83bA9KgWye4qspZPNp7VF1ylwBUkTLUBrm6zvQj9VlTRG/v26FN24h/hBsAZPz8OQgSr
         gbng==
X-Gm-Message-State: AOAM532Hy29bt5Pvzh9ABBmdRDDX6Xp/p6YLL3tr8l1urypPOZpwyWJS
        zBNoAQ1e6DSbsoSDUPEn+Kj4Xq1dqIS2LHQn0a1C5w==
X-Google-Smtp-Source: ABdhPJzWseLvjIX9yMZK1gWPtlrnfWCFKz8bLBOi+m92pGbohAATJNi/NlUhIAcvWT8riat4xaFeXZBq0E4EMOYrDOI=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr29546689ejb.113.1597221439198;
 Wed, 12 Aug 2020 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk>
In-Reply-To: <98802.1597220949@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 10:37:08 +0200
Message-ID: <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 12, 2020 at 10:29 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Worried about performance?  Io-uring will allow you to do all those
> > five syscalls (or many more) with just one I/O submission.
>
> io_uring isn't going to help here.  We're talking about synchronous reads.
> AIUI, you're adding a couple more syscalls to the list and running stuff in a
> side thread to save the effort of going in and out of the kernel five times.
> But you still have to pay the set up/tear down costs on the fds and do the
> pathwalks.  io_uring doesn't magically make that cost disappear.
>
> io_uring also requires resources such as a kernel accessible ring buffer to
> make it work.
>
> You're proposing making everything else more messy just to avoid a dedicated
> syscall.  Could you please set out your reasoning for that?

a) A dedicated syscall with a complex binary API is a non-trivial
maintenance burden.

b) The awarded performance boost is not warranted for the use cases it
is designed for.

Thanks,
Miklos
