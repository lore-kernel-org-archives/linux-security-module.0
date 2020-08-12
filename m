Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968FAC433E3
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7445C20781
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RxZhkT3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHLHXh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHLHXg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Aug 2020 03:23:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BC8C061787
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 00:23:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so1115350ejb.11
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2020 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg7tpKojiLkoGCQU1MYzPSjyojMR+QIskvYi6fn1Dcc=;
        b=RxZhkT3nxyiQK9MroBnY+vSTlOURG9xdAu71zIWR1pg9vScRFKcIDuCBeQMUdFuU1A
         3wv0lvogAGNnDfaByrHt3tsVFN6Xhn5Pek99IKFvWIXr0Ps810awHCCXZ3Uuh8fzTK2b
         mPjF7t6mbAUVw21TFOvqFtyCMzyJ+j/Fzal8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg7tpKojiLkoGCQU1MYzPSjyojMR+QIskvYi6fn1Dcc=;
        b=G5PNC54N9uKJW9PGJsjwnewxCXA7/+ACrWDSdh5DRyGtfSextZLBRy7Pead76bIWrH
         jO4ZvCI0vPe50RkMffsaudZ31FwLrrdbbdh0VQYKjl1PMHW3Ov5k8wUb6c+KWLWOfOV/
         rt+DWrG6+XzwNHoi/TieTZEZ7NUEDE98xFln6GTEYBBDx+CJx1r8g8NcbUw6iqOkgVfQ
         22ZEBwttPKNiDpzQ2TIIPQFc9VZcRCnLKeoPVOponmnh4jg5VrxhWp8lpCUYC04uQrwX
         zc+vA6WiHUZ4+THUJJ9Ovd5lG0kMi7T6inpHSnuvHrzEyFJpmDi/yGxckkyJiJQOsfiI
         EyOQ==
X-Gm-Message-State: AOAM530JrZCpC3Gq1/V0l3SqzME1GSttq+Vmx6nMIC4ZM/3HnShim4nQ
        yYLX2UpoI5PP+S9Xn9kqicztsp7uIuQcqSMc5QrJDg==
X-Google-Smtp-Source: ABdhPJzm3HjwfP0ZZ1hhOcqQBxQCDqsXLhfMgQR7eK8xNsCMCgTf6AQcSZCyHkjDNgbYeD4fRI36L4Kyom2doR32tA4=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr29241264ejg.202.1597217014736;
 Wed, 12 Aug 2020 00:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com> <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
In-Reply-To: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 09:23:23 +0200
Message-ID: <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 11:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > So that's where O_ALT comes in.   If the application is consenting,
> > then that should prevent exploits.   Or?
>
> If the application is consenting AND GETS IT RIGHT it should prevent exploits.
>
> But that's a big deal.
>
> Why not just do it the way I suggested? Then you don't have any of these issues.

Will do.

I just want to understand the reasons why a unified namespace is
completely out of the question.   And I won't accept "it's just fugly"
or "it's the way it's always been done, so don't change it".  Those
are not good reasons.

Oh, I'm used to these "fights", had them all along.  In hindsight I
should have accepted others' advice in some of the cases, but in
others that big argument turned out to be a complete non-issue.   One
such being inode and dentry duplication in the overlayfs case vs.
in-built stacking in the union-mount case.  There were a lot of issues
with overlayfs, that's true, but dcache/icache size has NEVER actually
been reported as a problem.

While Al has a lot of experience, it's hard to accept all that
anecdotal evidence just because he says it.   Your worries are also
just those: worries.  They may turn out to be an issue or they may
not.

Anyway, starting with just introducing the alt namespace without
unification seems to be a good first step. If that turns out to be
workable, we can revisit unification later.

Thanks,
Miklos
