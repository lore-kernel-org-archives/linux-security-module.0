Return-Path: <SRS0=cbB2=A4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E3C433E2
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 06:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5D92070A
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 06:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RElEQ6K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgGQGB4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgGQGBz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 02:01:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88BC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 23:01:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e4so7149333oib.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uZsIItU1torl/Pirwom9ohJ1akFs0quDCi4aWlkuG28=;
        b=RElEQ6K7uo0nNaNQqeKkGH627EVU/FknDBB0WOZIIwSQsfjHml8XRls92+i1Ut4qSz
         /Tr4G3Ny/0ZD4gUKBg6A+teEm+wjs2oPRqlMbB1qA49L+bVUERsSFuTx7/gbUf33O2B+
         u3QxdBqE4eXM8sCo8mv1MsX+U88VHNwjKXB/9IyLI6wenwhzjVIgDzJNDENwS35YTGvA
         0wxBipnJSPEVjBw+b7a3migCFcnIuVphDD7Gp1WVTv6w4W+KubN+N55fqaAfk8JhW4Bk
         NIUF4kcSWphPtKt5AwE7ch8VK5p6cvTkCaFd4cGj1CkylseZ4SBih0b69aVHQ/+cUaOq
         LkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uZsIItU1torl/Pirwom9ohJ1akFs0quDCi4aWlkuG28=;
        b=Dip2PYSj8ph0W5EhFLkEz2CDFLKgt/qWlONRkNL5L5yVrjPTnWL0Pia9MuM5QiboT5
         BKqAphsooHEhfAPLuf6MTtHW1B2OMoEkItHgUwYzxilXzSv5Q/8FVTWCdgQj4Omeezqe
         7P5ciVE2lxUz+n6QyS13JNPY7nknMTE6sL+DNYLahCzkAp1OIZb37z+xy8KEG4V5ywAC
         5SwjQPep5J5nQ62O70zSzVsFeJXkJkas1tjo3iN95BRDHkzbvFabM+zXrC+0nNTMm5QQ
         R0fQwy8m9RnKjRrvZEmlkU1BpRuYd8dcaVlRVbpBIGb3LAvYMqUYt/Gg7Z50jm0+O8q7
         NtBA==
X-Gm-Message-State: AOAM5321KjaT1axkmDAiBOnWXwBP2rI/6FVhBNO3o2f7PzC+uxN1GPTA
        DQpFuEnomsU8mfOlHW06UxMv9bzOpKGBLiyr6spQOQ==
X-Google-Smtp-Source: ABdhPJzXNxfOsHNPtGWn9mB1FDKp6mGji91VxAHN446TGr1qoX7Cw0vLoQcldrqtwJh7XjDD5tZXE1vOKWZlL1yrAFE=
X-Received: by 2002:a54:4798:: with SMTP id o24mr6273523oic.148.1594965714875;
 Thu, 16 Jul 2020 23:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
 <20200716101827.162793-16-mtk.manpages@gmail.com> <CALQRfL6dAEgiUiEckUN9x_g0J+sywz+Q_zBfPqPFTBsf2zRt=A@mail.gmail.com>
In-Reply-To: <CALQRfL6dAEgiUiEckUN9x_g0J+sywz+Q_zBfPqPFTBsf2zRt=A@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 17 Jul 2020 08:00:00 +0200
Message-ID: <CAKgNAkjRZ_u6hPggRgZr4NeQK42mSFbWrH2m4gZyumtfvTRLDQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] capsh.c: Spelling fixes in usage() message
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 16 Jul 2020 at 17:08, Andrew G. Morgan <morgan@kernel.org> wrote:
>
> Thanks! Applied all of them except 07_16. Instead, I've hopefully
> clarified the intent of the text with some quotes.

Okay. Thanks, Andrew.

Cheers,

Michael

> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=34e4e00b983a2c0fc5f13b403871a8fb5860bb89
>
> On Thu, Jul 16, 2020 at 3:19 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> > ---
> >  progs/capsh.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/progs/capsh.c b/progs/capsh.c
> > index 94bf57d..7bed98e 100644
> > --- a/progs/capsh.c
> > +++ b/progs/capsh.c
> > @@ -879,10 +879,10 @@ int main(int argc, char *argv[], char *envp[])
> >                    "  --delamb=xxx   remove xxx,... capabilities from ambient\n"
> >                    "  --noamb        reset (drop) all ambient capabilities\n"
> >                    "  --caps=xxx     set caps as per cap_from_text()\n"
> > -                  "  --inh=xxx      set xxx,.. inheritiable set\n"
> > +                  "  --inh=xxx      set xxx,.. inheritable set\n"
> >                    "  --secbits=<n>  write a new value for securebits\n"
> >                    "  --iab=...      use cap_iab_from_text() to set iab\n"
> > -                  "  --keep=<n>     set keep-capabability bit to <n>\n"
> > +                  "  --keep=<n>     set keep-capability bit to <n>\n"
> >                    "  --uid=<n>      set uid to <n> (hint: id <username>)\n"
> >                    "  --cap-uid=<n>  libcap cap_setuid() to change uid\n"
> >                    "  --is-uid=<n>   exit 1 if uid != <n>\n"
> > --
> > 2.26.2
> >



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
