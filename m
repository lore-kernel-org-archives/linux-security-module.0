Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33ECC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708BB64FCE
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhCJIVd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCJIVX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 03:21:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35176C06174A
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 00:21:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r25so24393846ljk.11
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 00:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DphxTuMCEpgHKRaen67zVxU/WlSz40n3RnzWZz5fZ/U=;
        b=hkB98JNi6GVUaUzi+cDGghcuo8+TkXWgycu1DMSFaMpSwWDIIFX5XFpv1jh22axdAL
         B+liBAyMhoNbXQStTb4tOpCeZBz9G50U0Olrga54KXKY/HIKAUnn51n93mAf1bXZ84Uj
         A4W3G1ew+AaUVetM7mAAEDiHNpkoF6XBsV2wr0LFxcE7wsQhicU1wSxEfgEMrkMdmpuh
         YUNZy5+cx9zgMdBQmxA/nGn5P5zJV6t8iFoGR3oMAbo5HSgsqNLnNaLrv5PxThdeMR4q
         LpviLjlHJkmvkQYmtE8r3oiYvjrx4x5mQQ9vhp/Jg9QJoXTFKIljR6ZvEi24Jp2vn4/H
         gcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DphxTuMCEpgHKRaen67zVxU/WlSz40n3RnzWZz5fZ/U=;
        b=iwnUuIzvzgPpvUbEQnrZQEZ87JAnhb0paNZSjYOdkKd87GBQ/ARqLaDhTg/3P4YUmu
         1QWCZRRU8UITSGdq5Jbex8JIe4hAWJ36Q6BU1jg3jvYwvvkw9si41lPBQ8ikr5ioFAn7
         i/jB3w2/ZJdb78m8MwU79XxQJJNWe63xWxUI87RW0DhmvGUCz3PLB9AU/WRQ0aH/2j0c
         6I3tI5PbRXf0Hjucux7Ndt8wcrRYH8Q2hWHcru2Jqj04iIg/Wf288iNASuuj9vJgBCzV
         Gy5JbB63/XeJH8pFhnSSPPSWNGi1K3fu7dvs/10G+3wxY48truSSUZjQTwqABPg8BgfX
         Z3dw==
X-Gm-Message-State: AOAM532yHzs8yNbjDVg9EcpSvMEgJ3utSOPHKjqQEYrpzU53Q5cJbJcP
        50ehPl9MjGbM1YRs4LpIfHeC8A0aL+tjh0wfbehYdM7Y3Q8=
X-Google-Smtp-Source: ABdhPJwhjLj6sQ6ZjEKwaRzEHOKoqu9UHbgNBLzLvQO/EGBmh1THPhSxBLGTtUEArL0AHLOR0qKXzBhP2SjgDDUl1Vw=
X-Received: by 2002:a2e:7a11:: with SMTP id v17mr1156617ljc.403.1615364481490;
 Wed, 10 Mar 2021 00:21:21 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
 <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
 <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com> <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Wed, 10 Mar 2021 09:21:10 +0100
Message-ID: <CABXk95AodFLLH+ay7tF8fUhScBAMUPjbABr3CdK=M50hB0z4sA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 5, 2021 at 12:44 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Mar 4, 2021 at 5:04 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> > On Sat, Feb 20, 2021 at 3:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> > > > On Fri, 19 Feb 2021, Paul Moore wrote:
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index c119736ca56ac..39d501261108d 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > > >               u32 secid;
> > > > >               size_t added_size;
> > > > >
> > > > > -             security_task_getsecid(proc->tsk, &secid);
> > > > > +             security_task_getsecid_subj(proc->tsk, &secid);
> > > > >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > > > >               if (ret) {
> > > > >                       return_error = BR_FAILED_REPLY;
> > > >
> > > > Can someone from the Android project confirm this is correct for binder?
> >
> > This looks correct to me.
>
> Thanks for the verification.  Should I assume the SELinux specific
> binder changes looked okay too?
>
Yes, those also look good to me.
> https://lore.kernel.org/selinux/84053ed8-4778-f246-2177-cf5c1b9516a9@canonical.com/T/#m4ae49d4a5a62d600fa3f3b1a5bba2d6611b1051c
>
> --
> paul moore
> www.paul-moore.com
