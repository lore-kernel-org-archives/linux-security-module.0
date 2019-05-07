Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC469C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74420578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lne0dzOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEGPDz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:03:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45706 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGPDz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:03:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so13444563ywa.12
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aZKxjt79JdGhVc9hjSUz4OjS2z5Alhu7t+aE2RJ7Og=;
        b=lne0dzOeHaPZDNgt9dUK6rtLwdo0/bB+M/04RnrXhNBj3TiY2BpipoayNOMItVTXAy
         F4/I70/CKFgrxBWRD27I1fpRb8mSSMMXzEnZUVtJ1BZKD+BHtiUbrfhaVGxKoelTjllf
         XDjgT/7SJMfYbWQHVzbRVLAoZ5Yj5Z3pxgrQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aZKxjt79JdGhVc9hjSUz4OjS2z5Alhu7t+aE2RJ7Og=;
        b=RCJlucdP/cF1toN5nOJmdfIMab03mwMtb2Mxb4AY/D0KBDcWf/qhhtXdbKv1hgJt9O
         0GUcG/eO6p98AXQV2SHGz9+51ZqNu7egbNoV/lbhTtCGGvj1nmGRmPY3OTMQ8igNTceQ
         mR+DiM6ZgyYfjcx57Uuaf8FUT63pM3ejBymcG7SbzaGdOxzTmQNPwu1mhbRz0TOjgrw1
         HCr1fd70r7yN8o2a7FQb5rrMVZTFfh6AxxwVkpJBo9Pm/pQzO6xYj+7Wa/XLHUGFbjfD
         DRYPXaD7vcuceuxbouxOsO62Ag6KAeTE+u3dPOeVLy/gWnGvjteQoWOfXhpqXiThz6Q4
         RWTg==
X-Gm-Message-State: APjAAAXrOhUmH0eUXiiS8aSEOVSFYNVB9Y3S2em27IEOe/DN1NzMctcP
        BPEgrbJYA4dgcYk9gQ+scvmPogm9VoNy3nXrM8tQyHD4Tdg=
X-Google-Smtp-Source: APXvYqxpcNuVNDNKOnhFxABgRKF5IHrrdGU7fhnOLp2nw06PGeajfl80LD0GZ3UhDyBXrHtE4Wi/9yW6YUdayRgco60=
X-Received: by 2002:a25:14c1:: with SMTP id 184mr12029967ybu.17.1557241434501;
 Tue, 07 May 2019 08:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165627.212572-1-mortonm@chromium.org> <CAGXu5jLETb47pDRbmt4gRJN9+n1WPQAL9n9nhjDg8mhz9Vw8tA@mail.gmail.com>
In-Reply-To: <CAGXu5jLETb47pDRbmt4gRJN9+n1WPQAL9n9nhjDg8mhz9Vw8tA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:03:43 -0700
Message-ID: <CAJ-EccPtFnS9e3ZyayXADW2m+jb10omGASE+qUvkycqTPpQScQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: SafeSetID: fix use of literal -1 in capable hook
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Wed, Apr 10, 2019 at 10:29 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > The capable() hook returns an error number. -EPERM is actually the same as
> > -1, so this doesn't make a difference in behavior.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 4ab4d7cdba31..61b84e20f2dd 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -90,7 +90,7 @@ static int safesetid_security_capable(const struct cred *cred,
> >          */
> >         pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> >                 __kuid_val(cred->uid));
> > -       return -1;
> > +       return -EPERM;
> >  }
> >
> >  /*
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
