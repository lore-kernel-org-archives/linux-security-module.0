Return-Path: <SRS0=03NR=MY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F064DC6787C
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Oct 2018 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9190F2077C
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Oct 2018 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9AMfgAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9190F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJMAvb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:51:31 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41636 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJMAvb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Oct 2018 20:51:31 -0400
Received: by mail-pf1-f181.google.com with SMTP id m77-v6so6516177pfi.8
        for <linux-security-module@vger.kernel.org>; Fri, 12 Oct 2018 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXKGUvsBIsHfC+bWM0ycsgSPx4MUBhea/BLf9ywmShw=;
        b=p9AMfgAAFpHxpyOE+mnmQTh8xcG/P0bNlh5DV7GUpXdfIL8+6rL3qYb1FQi1mZQXGC
         2WA193JQxC/Mq9zYWAsN9vy3Ii8/g5aj0E3wcPuUYlwapsSb29uIlPSXPlD0H5osRiPs
         dPKzN57jEQATRmRIvLnVl1tVD+cAjpMGerL5Qe/RUUQoVM/AHJzJaYpJvBAIY7pIAZqn
         DnoVzXpbVNemnqg76W2DtAflSGWkP92Fw+CA1UzAJEpjfD94AmDHeMUJDAbKus6n+H+k
         LV9joSu8FezTzjVJu/njLik9/e+a2FRfjo0S6WKtYPthlvDskQio5gjDczjR7iPrDJEv
         fO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXKGUvsBIsHfC+bWM0ycsgSPx4MUBhea/BLf9ywmShw=;
        b=RHGYmrRmh7/lrKRgl066eiSMHfR3akwONmZihfgzUUiRw4WirPNrVJzeQGHYq5LFuU
         WmhYJJfsqTZx8JKFai0dmM2ejLgG93B4e6k4g2cd1QeGhVKOaS3x9LzwY5x80b2MwWFy
         tbwBqsiPbh7v+4/Jjc1G6YkfdzQu749QW36t7YmzNtdiQhj7b+Cs/3cSpOLuTMwKBuUY
         w+MY53GlK0GmC5PoHoZ4+7bFmrnQBMShL9IpSXnnYAvrpISiEOKNwZMIxpnMJJysXVLO
         9Oullk2yWgpyF0gfHx51S6v7gONpt6vqnSP3kFZyVJVHbLb4YAxGj+BLsySkYveE4lWZ
         5A3g==
X-Gm-Message-State: ABuFfojHDz96JTZmGYUC/+JT47Wqki8oOcO8u/+5+JHEq2aVHEj0sArX
        8xnGYvMSzFPIupHctbYbqgMVljdDwNclb5WTtLWFIQ==
X-Google-Smtp-Source: ACcGV62x2jjMBg8v7UFcUYxDlPW5fOvMSZyV1tJNltPdhOEEaZiYC92AYZAHTTeeUhieiFigommhTxTHQO2lBzJqi+Y=
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr6418895pgd.302.1539364681413;
 Fri, 12 Oct 2018 10:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com> <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
In-Reply-To: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 10:17:50 -0700
Message-ID: <CAKwvOdnRJtHEUf-2kObUiUCc_ZPRdYHxMft3s1YE6=9EnHYMMg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     denkenz@gmail.com
Cc:     jejb@linux.ibm.com, dhowells@redhat.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 12, 2018 at 10:05 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Oct 12, 2018 at 8:14 AM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi James,
> >
> > >> So can't we simply use 'bool' or uint32 as the type for h3 instead
> > >> of re-ordering everything
> > >
> > > The problem is the standard is ambiguious.  The only thing that's
> > > guaranteed to work for all time is a char *.  If you want to keep the
> > > order, what I'd suggest is inserting a dummy pointer argument which is
> > > always expected to be NULL between the h3 and the varargs.
> >
> > So maybe I'm misunderstanding something, but the issue seems to be that
> > unsigned char is promoted to 'unsigned char *' by Clang and probably
> > unsigned int or int by gcc.
>
> No. This is extremely well defined behavior in C.  In C, integral
> types are NEVER promoted to pointer to integer types, only to larger
> integral types through rules more complicated than the correct flags
> to pass to `tar`.
> https://xkcd.com/1168/

And may have their signedness converted.
https://wiki.sei.cmu.edu/confluence/display/c/INT02-C.+Understand+integer+conversion+rules
is the reference I use, though I always feel like there's quite a bit
of mental gymnastics involved interpreting it.

>
> >
> > So instead of having unsigned char h3, can't we simply have bool h3 or
> > unsigned int h3?
>
> int is the default argument promotion. Proposed:
> https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339
>
> >
> > Regards,
> > -Denis
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
