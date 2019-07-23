Return-Path: <SRS0=ig/x=VU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0770BC76190
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 06:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E42239E
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfGWGs5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:48:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44677 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbfGWGs5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jul 2019 02:48:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so4497602otl.11
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2019 23:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8rFK+AmzSO6vqLaQ/7uOy+cqgQKBpkWkT02u2erFgg=;
        b=NBKKu0m5kIszxBZ8/SIqXULv7HNxZs1MnE0oHga7bQD3BDzrNVc6i4ljxeVTytGIti
         7zz8GcYesKp8Tn+/yto0Ir4PY1kk6q0f3E5EoVliR44mnq2dmYlaYYbBoaHATy2wNbK4
         5CJLaeQ/u7eMpy59rX4DxWHpd6dkWabpaHW6kfI1/mTg/sE1mFw+MUqpU1OOxIx941+l
         YvNu2FvOACa40Wn7TMAJuxf22uV/7Y00mKrCxoGJse56KaEQhYsYpYjPcPzoEVHodR2S
         E7NRfAUlREZFc7oQhiKURs/Q5MitxC5AJnQGP0bf92Ug1D3XM+qjV1FMz2CW7ZQxePNQ
         o1aA==
X-Gm-Message-State: APjAAAXKRZ3wXqYRkCBFbiLYO7u7+0SOi6c5tx3B5YyiChUryR+3o0AD
        sP+DWCPgeVnUbmyJfiBVqWO76BIJpcTtDA2B/8bfpA==
X-Google-Smtp-Source: APXvYqyiqKYY0HE59VWbxE4FrpnxvD4NxAFiDhK5ANqxW/V63mYbnrK3mDoxN/AJVxU9xTHF4Q5EToDReX9NcyoLjKc=
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr10332937otf.367.1563864536429;
 Mon, 22 Jul 2019 23:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190722132111.25743-1-omosnace@redhat.com> <201907220949.AFB5B68@keescook>
In-Reply-To: <201907220949.AFB5B68@keescook>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Jul 2019 08:48:45 +0200
Message-ID: <CAFqZXNu2RiTtTDvnCCwG5PnJ28LqGXPDhdAQkn4Xypx=+oWHOg@mail.gmail.com>
Subject: Re: [PATCH] selinux: check sidtab limit before adding a new entry
To:     Kees Cook <keescook@chromium.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 22, 2019 at 6:50 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 22, 2019 at 03:21:11PM +0200, Ondrej Mosnacek wrote:
> > We need to error out when trying to add an entry above SIDTAB_MAX in
> > sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> > happens.
> >
> > Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Is this reachable from unprivileged userspace?
>
> > ---
> >  security/selinux/ss/sidtab.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index e63a90ff2728..54c1ba1e79ab 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> >               ++count;
> >       }
> >
> > +     /* bail out if we already reached max entries */
> > +     rc = -ENOMEM;
> > +     if (count == SIDTAB_MAX)
>
> Do you want to use >= here instead?

Makes sense. Also staged for v2.

>
> -Kees
>
> > +             goto out_unlock;
> > +
> >       /* insert context into new entry */
> >       rc = -ENOMEM;
> >       dst = sidtab_do_lookup(s, count, 1);
> > --
> > 2.21.0
> >
>
> --
> Kees Cook

Thanks,
-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
