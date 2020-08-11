Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AAAC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C7F2078E
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RHsbOPLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgHKOWc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKOWb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 10:22:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB5AC061788
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 07:22:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so13305541ejx.6
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzcmWAX8jCtD02rUKXqb4jDkg1pG/t/2SdCoCWri0i0=;
        b=RHsbOPLKErKudyyVkI0V4WBg3g/e/AwSdYYNz7ERyMqdsGtU/TNdLpbNe8Rwq92uu1
         YqiWSVykozP45Monynqi4JD8jg46N/3ugkI18MzqXluT4ZhEHaI7kEqBACZl+teReLAw
         hAoNbEl8kOadhLCHGzz7ENI7iNyBfYiok5hH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzcmWAX8jCtD02rUKXqb4jDkg1pG/t/2SdCoCWri0i0=;
        b=Uo7vEZlPWnIW0UPhkhWaZ0sjak8qkSqMzF8E4pnZK1iK9+Sc1bg+/KJTkRIZ4+ZjFk
         ZRuay0ll1GCkf+wOVGrdMLYy8x7nBKFQn6YXbzI5AzUVVKzNueT4kcNfnZDfbbzgZIs9
         wPcmCGJw6GorT5wxsfH2Xw27z3psJaeuRq2BoayZ8DPq602+dbhg16fuRCGXOszedNw6
         vIifEn5PbOt1BQlm/V/X/a2C2sTeq/EuH+InhQZWbtT6zsgiuJj2ChyqSgC5IV1eo5Ep
         i6q2KQVmkRNEOcxgsBZoT8r6usa+97rxj3FcsVgPsSk/ywr+Mz3op5UfZ16k0IQKUFUh
         Hf4Q==
X-Gm-Message-State: AOAM531tesfHDoZZNi+jFZXAxyKGGe+BZcvefGNydItMfyL7rqZEO1fK
        +GGWl2w08XTSyrmvreDWKVVF6G1gxFsVE34t8I9+IA==
X-Google-Smtp-Source: ABdhPJwtjUZIBSyYZXWSJGJJGH3SkGerPXKC4xXr3G1y7wIriLyMaiXNyTwH0gWco/O/k+Wun4UiMgEd2S4g3VfqTco=
X-Received: by 2002:a17:906:4c46:: with SMTP id d6mr28057620ejw.14.1597155750007;
 Tue, 11 Aug 2020 07:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <20200811140833.GH1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811140833.GH1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 16:22:19 +0200
Message-ID: <CAJfpegsNj55pTXe97qE_i-=zFwca1=2W_NqFdn=rHqc_AJjr8Q@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 11, 2020 at 4:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 03:54:19PM +0200, Miklos Szeredi wrote:
> > On Wed, Aug 05, 2020 at 10:24:23AM +0200, Miklos Szeredi wrote:
> > > On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > > I think we already lost that with the xattr API, that should have been
> > > > done in a way that fits this philosophy.  But given that we  have "/"
> > > > as the only special purpose char in filenames, and even repetitions
> > > > are allowed, it's hard to think of a good way to do that.  Pity.
> > >
> > > One way this could be solved is to allow opting into an alternative
> > > path resolution mode.
> > >
> > > E.g.
> > >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> >
> > Proof of concept patch and test program below.
> >
> > Opted for triple slash in the hope that just maybe we could add a global
> > /proc/sys/fs/resolve_alt knob to optionally turn on alternative (non-POSIX) path
> > resolution without breaking too many things.  Will try that later...
> >
> > Comments?
>
> Hell, NO.  This is unspeakably tasteless.  And full of lovely corner cases wrt
> symlink bodies, etc.

It's disabled inside symlink body resolution.

Rules are simple:

 - strip off trailing part after first instance of ///
 - perform path lookup as normal
 - resolve meta path after /// on result of normal lookup

Thanks,
Miklos
