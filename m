Return-Path: <SRS0=99o1=TG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C8C04A6B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190B82087F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f20kg2QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEFPxW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 May 2019 11:53:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44504 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFPxW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 May 2019 11:53:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id j4so10692857ywk.11
        for <linux-security-module@vger.kernel.org>; Mon, 06 May 2019 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHqK8HxWJmkg838Ejsrk0tA5kqRCulCluaWXdXlo56E=;
        b=f20kg2QIE1Rlxrh4CiwM+uxgw2KRxHDkoexvliQuGqNrwoMIPX3mVmGwjXtuAHw1bZ
         jYFlcsasdGH2hbs6ttxN4F8qRke/0CNHSBdb5LeueADX/teUJRM8DehJH45hOzNByY+9
         5EIjUPdvGvaytvrPGC0z8y/3FYkT9WwkjZnW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHqK8HxWJmkg838Ejsrk0tA5kqRCulCluaWXdXlo56E=;
        b=lHI9F5caA+3ZMQdwnlpjRVyk5tlnhSbcfnJzB5Yh8xyvTrDYkx13VYrz3HAc6K1naI
         4WswvuzdY7/10gkKc+ZFP8J/bZOwxPZCg4Kt5oeE7bIhheSzxzcIa0Saz0JgV+vMLSxf
         q2ctjTuj2cdKt3hHRXzOubqBPwh29N3I0iUtcI3Y7Y4q9m42E6JBfXRIrsP7aVz383fX
         WH2ddqdEolxxRyzBV+xsylQfl8FNcMqehvtBm0W1hAsWamq9cvzG71N3cMwL8wP087in
         t09sjbAxtpXsPKnwO24pcV90ahD1b1rrZ3K83YpuxJST9SGIPpnwOjkHD9zp/9IhUilq
         aNhA==
X-Gm-Message-State: APjAAAWF2ySDQ21hQeiJ0GtUSAIKsKVHZ9f/xhXdIHJh6egA9qIWp3b9
        xLz6U5sBj/O9zpcoggQuxcgBh3csbrzRpIJV5JoWfw==
X-Google-Smtp-Source: APXvYqxRIxD47SQKRqEZvyca9VwI9jvrBgc4AGKK8zmx/LS8FB2IGoCnE7G9cG2ZJc8wHy5ujvC6PFOEAKcsjSWL1ZM=
X-Received: by 2002:a25:3609:: with SMTP id d9mr15524756yba.260.1557158001547;
 Mon, 06 May 2019 08:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165434.206579-1-mortonm@chromium.org> <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com>
In-Reply-To: <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 6 May 2019 08:53:10 -0700
Message-ID: <CAJ-EccPz3fZXR-485szP28kTsFLN=Y6040GacxdNuSn9io-kPw@mail.gmail.com>
Subject: Re: [PATCH 01/10] LSM: SafeSetID: fix pr_warn() to include newline
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These 10 patches got buried, but Jann, Kees and myself are in
agreement on how they look.

Could they get merged? Patches 8/10 and 9/10 have a v2 that should get
merged instead of the originals. I can respond on all the patches that
should get merged if that is helpful?

On Wed, Apr 10, 2019 at 10:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:54 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > Fix the pr_warn() calls in the SafeSetID LSM to have newlines at the end.
> > Without this, denial messages will be buffered as incomplete lines in
> > log_output(), and will then only show up once something else prints into
> > dmesg.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/lsm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index cecd38e2ac80..2daecab3a4c0 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -91,7 +91,7 @@ static int safesetid_security_capable(const struct cred *cred,
> >                          * to functionality other than calling set*uid() (e.g.
> >                          * allowing user to set up userns uid mappings).
> >                          */
> > -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
> > +                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> >                                 __kuid_val(cred->uid));
> >                         return -1;
> >                 }
> > @@ -103,7 +103,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
> >  {
> >         if (check_setuid_policy_hashtable_key_value(parent, child))
> >                 return 0;
> > -       pr_warn("UID transition (%d -> %d) blocked",
> > +       pr_warn("UID transition (%d -> %d) blocked\n",
> >                 __kuid_val(parent),
> >                 __kuid_val(child));
> >         /*
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
