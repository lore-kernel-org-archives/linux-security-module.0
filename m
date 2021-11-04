Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A7DC433F5
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Nov 2021 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9903F61212
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Nov 2021 11:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhKDLn6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDLn5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Nov 2021 07:43:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828EC061714;
        Thu,  4 Nov 2021 04:41:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k4so6738028plx.8;
        Thu, 04 Nov 2021 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n1KhtkqwaiQeXN8wz3FjznNjYcnDj30fnMJ2MENI/bM=;
        b=KQNGVR1HjSVGE5tz7qTLIvpjqQmLLIXvMhmUIX1v/H8T4POwg3YJlXuwBujn9osnWj
         zwUKG4bSbCO9BgN1ndXpwTOC4ZGshqEWCg2lUGB8mwheuuw3MsSD+l7jKUhCldT36KXy
         /k+r2TbeILGTORLc1FUyD7r1XJfAkLjs7d8jJLNGKjtvgQKr3is4JqDwRGIGopEq0+jX
         +hS5vJlUKgC6+8uTX9zIdpyTV+t1BCtqKYmSLRGeB2mg6auVXh9QJsVu2smc//mJfXY5
         7l57qf1pd8uhCGqTG2XK/ogtCeD6SniUuGi1iWTUJbGpIuUuHxZeotOqwczi6Jm3sVPt
         /yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n1KhtkqwaiQeXN8wz3FjznNjYcnDj30fnMJ2MENI/bM=;
        b=1PkcShVkJHCCSzj+Dq+FSuRE5QAeMxV+F6ORLUi2HKqC/ebSqHCl2mTKrdYZCkJzSs
         uHMZMB224t271JpvfL9a8ZWAeUFI0NWrtIag9JQE9pqeAGi2WAZpPhyp6diU2c0+ch6k
         QG61p4CSG4PtLgstVmAN2CH4mJljkBtLiTcz6WYmauhYlzrmmjarqFqenWHR14aFrTVA
         xWPKemo7Y5Zmxu/1qtV53e68+2YRRuwopyVMhQtrVR/NBdtcIsnUeQCjdgvarecDBgMM
         vZchyMXEc0n+HldeBnLYuQ92iE4E9idGgKcF2dlAxdJJnGcv/syj0KqNwbPtaIlSs4yj
         huHA==
X-Gm-Message-State: AOAM530iRUAVxkt8uYLv/DwdmyZi+eb1hCrhiuMGfY6piAZgjbBxD0ij
        H52O6/vOQoixRmhgFVA2aEkNLEke+2MHEgqZ8t+/SLoSTQ///w==
X-Google-Smtp-Source: ABdhPJwOv4LPU3RKWOoS5+kuHDOdoN+7OnHiHrrn/6kVi403ziyQaRqP7FjghbHi7bOfN/2po0nV/z/t/BWcZAqGON0=
X-Received: by 2002:a17:90a:b296:: with SMTP id c22mr21364719pjr.13.1636026079704;
 Thu, 04 Nov 2021 04:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211103071427.GA13854@raspberrypi> <7a71215c-58f4-081b-6a2e-030073f2737e@digikod.net>
In-Reply-To: <7a71215c-58f4-081b-6a2e-030073f2737e@digikod.net>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 4 Nov 2021 20:41:10 +0900
Message-ID: <CADLLry4zYn-NZBtC3pdQpb4c_3vvzNfc71rBrXc-oXqgSZNHaQ@mail.gmail.com>
Subject: Re: [PATCH] landlock: Initialize kernel stack variables properly
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 11=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:14, M=
icka=C3=ABl Sala=C3=BCn <mic@digikod.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Hi Austin,
>
> On 03/11/2021 08:14, Austin Kim wrote:
> > In case kernel stack variables are not initialized properly, there migh=
t
> > be a little chance of kernel information disclosure. So it is better fo=
r
> > kernel stack variables to be initialized with null characters.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  security/landlock/syscalls.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.=
c
> > index 32396962f04d..50a6f7091428 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -320,6 +320,8 @@ SYSCALL_DEFINE4(landlock_add_rule,
> >       if (rule_type !=3D LANDLOCK_RULE_PATH_BENEATH)
> >               return -EINVAL;
> >
> > +     memset(&path_beneath_attr, 0, sizeof(path_beneath_attr));
> > +
>
> This memset is already done with the copy_from_user() call just below.
>

It seems that memset() is done inside copy_from_user().
Thanks for feedback.

BR,
Austin Kim

> >       /* Copies raw user space buffer, only one type for now. */
> >       res =3D copy_from_user(&path_beneath_attr, rule_attr,
> >                       sizeof(path_beneath_attr));
> >
