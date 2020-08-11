Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D34C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2544D20838
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="b/1GrCuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgHKOrz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgHKOry (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 10:47:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D74C06174A
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 07:47:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so13408577ejr.1
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlI3wwMv00NWAKa4U5L5YIW/C1hPZtgfWHscUycMhMg=;
        b=b/1GrCuy3zsT+xu5hfBEofJfyyKQre91pqNlsX0MOiaTmfxSPwy7IGLslRBMr1FYKY
         zI3t+/pBjNn/cWUYAhxg2ybd+V693B7WeKqrlAhEyzJ+Wc8nUDESQI2IF1QON3Jh9uVT
         YZ8yQWu+czbgj3GVSDUvltitl5HM0LYJ+TUMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlI3wwMv00NWAKa4U5L5YIW/C1hPZtgfWHscUycMhMg=;
        b=ZUAk25aKpJIxNHy9L5oKEPpKIh2KDfEQKHFaR4lmO+hdh3iEgA44YL46Ozdsn08B9A
         MYJFuizjDU0RPd46dTJgmZcuupalIFq4WFKfdXAWMcJr0aTimpwWTmsFuaJZVUL/uVQ7
         OipZ/6u059nKN234JiU9UMnKSKzqvHycXnerh6lshtVcPB6JUeGfaV7ffrybP1oqwGBy
         TkOw6jYt3yhcnFE3Omyeq8Zt8VKPpfb0EbTl/1Dw25i3DJPzbmqLXIqdx6iWY1nBYEdM
         wEAuJL0SZcKzI1bcnCXQ2XjH9lrrMAnKwKRKFDWVEVntSnbtg706TwcaT8MuKLo+o5Gy
         D+8Q==
X-Gm-Message-State: AOAM530k9auk83C3zEKThLB9xxqUTXxo8wPzU03VvYEorOxjY+paEOI/
        kbOPQ7s+73uxzbS9hhdSQiJ3/Zhd8/P/5OIh82YlsA==
X-Google-Smtp-Source: ABdhPJyzKi8DHXr7w4yVAeEpF1qKnBzFBfVBk8wgiswCZWAR8v6h3A2J/MoGxuGyvmtaDdoLAlCOJpZxXZxjkYlm3EU=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr26135160ejg.202.1597157272920;
 Tue, 11 Aug 2020 07:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <20200811140833.GH1236603@ZenIV.linux.org.uk>
 <CAJfpegsNj55pTXe97qE_i-=zFwca1=2W_NqFdn=rHqc_AJjr8Q@mail.gmail.com>
 <20200811143107.GI1236603@ZenIV.linux.org.uk> <CAJfpegvAVOYg03q7n24d6faX33rd16WWi5+LLDdfwj_gRYaJLQ@mail.gmail.com>
 <20200811144247.GK1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811144247.GK1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 16:47:41 +0200
Message-ID: <CAJfpegv3chrvqoGJLUM7JgUYKMWdqU+5h6if1ZFiKELZ1-NFqw@mail.gmail.com>
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

On Tue, Aug 11, 2020 at 4:42 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 04:36:32PM +0200, Miklos Szeredi wrote:
>
> > > >  - strip off trailing part after first instance of ///
> > > >  - perform path lookup as normal
> > > >  - resolve meta path after /// on result of normal lookup
> > >
> > > ... and interpolation of relative symlink body into the pathname does change
> > > behaviour now, *including* the cases when said symlink body does not contain
> > > that triple-X^Hslash garbage.  Wonderful...
> >
> > Can you please explain?
>
> Currently substituting the body of a relative symlink in place of its name
> results in equivalent pathname.

Except proc symlinks, that is.

>  With your patch that is not just no longer
> true, it's no longer true even when the symlink body does not contain that
> /// kludge - it can come in part from the symlink body and in part from the
> rest of pathname.  I.e. you can't even tell if substitution is an equivalent
> replacement by looking at the symlink body alone.

Yes, that's true not just for symlink bodies but any concatenation of
two path segments.

That's why it's enabled with RESOLVE_ALT.  I've said that I plan to
experiment with turning this on globally, but that doesn't mean it's
necessarily a good idea.  The posted patch contains nothing of that
sort.

Thanks,
Miklos
