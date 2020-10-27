Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F1C64E8A
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039A820878
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3nDBG4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1819938AbgJ0RbX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:31:23 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36774 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819356AbgJ0R3r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 13:29:47 -0400
Received: by mail-il1-f194.google.com with SMTP id p10so2252773ile.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2020 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2duayH/emf1tIZ74YFLBA63A8FXzNhJlBfTaLBsHZo=;
        b=K3nDBG4oCwwGW5/t4RIjBwtwr28aC4oWCgPQOvlYCTrls84QzbizjcpmFGDjTvGm1b
         648Dnapx6vrV+5Q6R2aobyj7kXse9gDY9ACwIqSjGP/qmfkx7cSlEOxr7JFythxw9n/R
         nXM5oDLad75erNfqVh1J5mOwso8TZjLSR3FCRjZoh58lIUHjOMeg9RzeLJYEoh6sPbtZ
         wtR3zRjyAUF/VXL7/tdhCpQdnjwaOi+Bmp+X3dyZJOu9jfM0tAbu+6bH8DyxadzASKi0
         SJmJSBRSpH0GKkYm+jVCXDCi3HEm4YDqQ+JLN5rqsDcMcpZrtahU4VG1O/KSC9yP8Ncr
         piZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2duayH/emf1tIZ74YFLBA63A8FXzNhJlBfTaLBsHZo=;
        b=mvwqq1wC7qpZBAn3i8xdb6gRNbEtP2GsCIIpJhPXA7BFpDb3lq+M7kdvQSGfeNUXUH
         B6Yw7C4Iq7B3acnBblhWSPxhcCLfx/7eve6Tquq28GDQCwpr5Ac/JJn7pYwW0JlnmDRT
         ISzVjM5daWp8sfv4o1gHSCHTU0Kegahyjihzg7ZF3sF+kDJNaLIfnxsY3nFzAV2FX7wJ
         VYQXW0BrlcUA6K4HNQpQaon6YsaYuaOirW91yJZ24Gzo640+SQgnBFJozpEeTvgfZvnr
         z5E1dzerSCbN3ZOeHopu+bNF31MFB6WTMyWJsZFwFJGYqq/s3k8/PJgWUwvI9PzUQSl1
         Y2RQ==
X-Gm-Message-State: AOAM530i5AipdFrLEc8JifJQcJrox2lhFW4t4OtKItNPbqiENCkkHWF/
        FJxkB5JCm/VDL8iW7Q1QbqemZRogQe+FktlGcPUb0Q==
X-Google-Smtp-Source: ABdhPJx7ImpvHdJUKZ7vKScRwzDbzZ73EemxCHPT7yJhPL/b5KiR+dl+5hggsFyOrAiOomRmRVdeFvckjjRN5x0nTl8=
X-Received: by 2002:a92:7f10:: with SMTP id a16mr3008325ild.134.1603819786646;
 Tue, 27 Oct 2020 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201026125227.54520-1-a.nogikh@gmail.com> <20201026125227.54520-2-a.nogikh@gmail.com>
 <c768f42a-1370-5b38-4f89-357744fd9d5a@schaufler-ca.com>
In-Reply-To: <c768f42a-1370-5b38-4f89-357744fd9d5a@schaufler-ca.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 27 Oct 2020 20:29:35 +0300
Message-ID: <CANp29Y5w1ZxDShGQHvJ-F0bM_P4WSrvPoDQtPNnBCG38Ee-x-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] security: add fault injection capability
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, akinobu.mita@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, glider@google.com,
        keescook@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

(resending the previous message in a plain/text mode)

On Mon, Oct 26, 2020 at 7:20 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
[...]
> > -     int RC = IRC;                                           \
> > -     do {                                                    \
> > +     int RC = lsm_hooks_inject_fail();                       \
> > +     if (RC == 0) {                                                          \
>
> Injecting the failure here will prevent the loaded LSM hooks from
> being called.
In this RFC, fault injection was intentionally placed before the code that
invokes LSM hooks. The reasoning was that it would simultaneously check
how the kernel code reacts to LSM denials and the effect of fault injections
on LSM modules.

>
> >               struct security_hook_list *P;                   \
> > +             RC = IRC;                                                               \
> >                                                               \
> >               hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> >                       RC = P->hook.FUNC(__VA_ARGS__);         \
> >                       if (RC != 0)                            \
> >                               break;                          \
> >               }                                               \
> > -     } while (0);                                            \
> > +     }                                                       \
>
> Injecting the failure here would allow the loaded LSM hooks to
> be called. It shouldn't make a difference, but hooks with side-effects
> are always possible. I don't have an issue either way.
>
> >       RC;                                                     \
> >  })
> >
>
Should we expect LSM modules to properly handle the cases when their
hooks with side effects were not invoked (unlike the selinux crash that
is described in the cover letter)? From the source code it seems that a
failure/denial from one module prevents the execution of the subsequent
hooks, so this looks like a realistic scenario.

If that is not true in general and depends on the specific active modules,
then it probably makes sense to introduce an option to control whether to
inject faults at the beginning of call_int_hook() or after the hooks have
been invoked.
