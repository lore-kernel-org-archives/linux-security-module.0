Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E2C4646F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641B464F5A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhCCX7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838575AbhCCTBD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 14:01:03 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B38C0613D8
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 11:00:21 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b10so25695966ybn.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrTqH4ir7YoYXBYJzhf0HnVg/dFc9dw61rsSlwrZYJc=;
        b=N7U0uNfWkVP4NW9gx+ZM7+WqO1PnpeOKwYdQn1NNZEUdkl+d5aPIzmGRnYsHY19r0w
         5VRqsNVVL1ROKyKEYEZW/SShJeLdRC8ZstAmFPWaGRB3D02vBkfwLlBnpj3KphmqMlxM
         GrQKAWdHFUFN457FWZRdPW2useEin+RkyWXW4ZeuBoGgDveJdm/gO9LA00Lcn9ABNX7s
         Z9qo8XeUSD+f03Pz72kJMplig1z6iAvBkSO2abbUUOQv1oawHbk9lFGmPA+DtI2rcw7G
         vbZkQku+GRWKMw0MW9QXHqMBVy4NKhFBN1r9BXlKNyUhJ9+xfSVWcaFJeCPHFZAvkEtK
         Cbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrTqH4ir7YoYXBYJzhf0HnVg/dFc9dw61rsSlwrZYJc=;
        b=oMgb7SCK5naSQgGilPWDA2pQ3ugn7taWgRpYIJrGqGpdOLhv0HlGXJi+EMrmdH7nB0
         pDOD7krtuJQJZ3b7J4nsV/D37drLXh31TkN51Dx+5PvXm6iaKJLC0qomaH7ByyUEnchD
         wT9i+jcpawvSaFHLD2qBCFqFwBYtYfPTZC19n9Ec7ipI+NGnCXPNOZ2f5/qCcovSZQBl
         HRn+vH/odU36+OhnNPvfKrq1uLAqwOeURq8qbgf3dLnQc7P/ebHACL+qI9fxDQLR2KSv
         9l929UAcWnhbmeY+r+DXoJ1JS/WcyYwnikXe8fXej/TNhwBzlxCcZvrAUsh188dexEdZ
         i/9g==
X-Gm-Message-State: AOAM533D1Z0y1Pv30gjye4Bp7CVKrSZppl6Jt0ukwoAdlwOrP3Yq3nJI
        xNrhLAvH1q9uq1m7SVLs2fLyw9JEdXOXCqzMb3Fp6A==
X-Google-Smtp-Source: ABdhPJx7+ZXPd+WcJe7i7kEkFZqQUi+39Hen0g6qCGc3kFjshEp+Kww5NDzgQqpOmvG1w5A2IBEgm9hEPG2vbTNt4gw=
X-Received: by 2002:a25:c503:: with SMTP id v3mr939685ybe.397.1614798021081;
 Wed, 03 Mar 2021 11:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com> <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz> <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
 <20210126135254.GP827@dhcp22.suse.cz> <CAJuCfpEnMyo9XAnoF+q1j9EkC0okZfUxxdAFhzhPJi+adJYqjw@mail.gmail.com>
 <CAJuCfpF861zhp8yR_pYx8gb+WMrORAZ0tbzcKtKxaj7L=jzw+Q@mail.gmail.com>
 <CAJuCfpFzxiBXp1rdY=H=bX+eOAVGOe72_FxwC-NTWF4fhUO26g@mail.gmail.com>
 <CAJuCfpEOE8=L1fT4FSauy65cS82M_kW3EzTgH89ewE9HudL=VA@mail.gmail.com>
 <20210302161716.89a65d3cb5b60dbc5074cfa7@linux-foundation.org> <CAJuCfpF72mevYd4zQ_q-Tyn+Bj-fa7ywudu=iM6L7e4B-42fpg@mail.gmail.com>
In-Reply-To: <CAJuCfpF72mevYd4zQ_q-Tyn+Bj-fa7ywudu=iM6L7e4B-42fpg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 Mar 2021 11:00:10 -0800
Message-ID: <CAJuCfpEg5jJec9FGyVddmxXKEduGdpO4KViqG0EJPhxMxTjSqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 2, 2021 at 4:19 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Mar 2, 2021 at 4:17 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 2 Mar 2021 15:53:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > Hi Andrew,
> > > A friendly reminder to please include this patch into mm tree.
> > > There seem to be no more questions or objections.
> > > The man page you requested is accepted here:
> > > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=a144f458bad476a3358e3a45023789cb7bb9f993
> > > stable is CC'ed and this patch should go into 5.10 and later kernels
> > > The patch has been:
> > > Acked-by: Minchan Kim <minchan@kernel.org>
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > If you want me to resend it, please let me know.
> >
> > This patch was tough.  I think it would be best to resend please, being
> > sure to cc everyone who commented.  To give everyone another chance to
> > get their heads around it.  If necessary, please update the changelog
> > to address any confusion/questions which have arisen thus far.
>
> Sure, will do. Thanks!

Posted v3 at https://lore.kernel.org/linux-mm/20210303185807.2160264-1-surenb@google.com/

>
> >
> > Thanks.
