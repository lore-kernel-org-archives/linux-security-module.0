Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C49C48BDF
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8176060231
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJWfq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFJWfp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 18:35:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74922C061574;
        Thu, 10 Jun 2021 15:33:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j12so888285pgh.7;
        Thu, 10 Jun 2021 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lugcbuxkrChZyEnzTfnVK2MptC5yQKam5ahevcJu0YU=;
        b=snoCWNXSRJAxUP91EbC+Kk7qUaZobiVEcS/9FEgPpLE1v/FaA0jzCnP0fACDgBn6uE
         jx9dNo/4slT7Du/OkVN5gn2AcvjAbCRmGnVbLriBwHt2x+BZ+WVy804Mo7yJzFrDYuLS
         x5ClwtOOhENvZQNqwCplq1BOXJqhQblFpFJez+592rmIGnkfieR5s+9VAFUgi2ofr8Zl
         fSkDCJfxl2sSXKrCs+vsNbOxL3Smn2mtTbShP2g2wH/mWwRnnqQDH7ZDnqFOTPszkI4L
         mr+VvpBXBdFPd1AUJ22ImYuq2R5/C76A4jaVCKW1RfBjGKS2E4Ph+5H1jLQgbSptPtld
         Zd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lugcbuxkrChZyEnzTfnVK2MptC5yQKam5ahevcJu0YU=;
        b=NJdiyy900AnRDNg4+gulYAveRUGskQKb1Z1MftaA+7UaOrMFCIQUh3l/IHkoyr4Cb4
         SOifQyD/NaEfKXVrhS2DeInhHaNuwjJKzjRJla3Cl2Cc8L3g5FHHWOwefDreYmoYkir4
         4aCi8tEdTLLsmMH62r1gfzIDeBXJpqA/xuQvb3KKeIf7tAsh6baHkm+dHmSseOpziK+y
         9mNWFz8AsOC3IPe4lTo3vvJMTnskjUCpVAiH6pUnJfwujDunu56BxOe/wJ0v9bT4fqPi
         rRusD4VaAbp/iROHSEwTX4vwcOZhM/JKtlvsmvzLwn7gH+n3k7Uedt85Jf0tPCVaI8uy
         yH3g==
X-Gm-Message-State: AOAM533/N6cr7sbtzHENw2bInofVNEn7XAYoPVT50z/OqpC3OUVfDCs1
        B6FyQ03Afk9azqqUfJ7Pq7lLL4lqt2vS4QUCILI=
X-Google-Smtp-Source: ABdhPJzw/M+Rbz6xspkYNtyTYZlV5R4GDO5w5DIIsku5bQHN59XgVwtOsrMYPoLBJOQmzOxqvSbXfeVUGKBA41SaEbU=
X-Received: by 2002:a63:f815:: with SMTP id n21mr621499pgh.2.1623364411976;
 Thu, 10 Jun 2021 15:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210608230929.GA1214@raspberrypi> <CAJ-EccMvTNpnZXAF6n2x7oXu_hsSOnbJvvQA6NsK1VG26t5CeQ@mail.gmail.com>
In-Reply-To: <CAJ-EccMvTNpnZXAF6n2x7oXu_hsSOnbJvvQA6NsK1VG26t5CeQ@mail.gmail.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Fri, 11 Jun 2021 07:33:23 +0900
Message-ID: <CADLLry6p+NvQFqXSunZ645DiRYSAsuT5vMe6F2Tofj8+Dcrxyw@mail.gmail.com>
Subject: Re: [PATCH] LSM: SafeSetID: Mark safesetid_initialized as __initdata
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:50, M=
icah Morton <mortonm@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thanks for the patch. Looks right, since that variable is only used in
> safesetid_security_init() and safesetid_init_securityfs(), which are
> both marked __init. I can merge it to the safesetid-next branch today
> and send the patch through my tree during the 5.14 merge window.

Great. Thanks!

>
> On Tue, Jun 8, 2021 at 1:09 PM Austin Kim <austindh.kim@gmail.com> wrote:
> >
> > Mark safesetid_initialized as __initdata since it is only used
> > in initialization routine.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  security/safesetid/lsm.c | 2 +-
> >  security/safesetid/lsm.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 1079c6d54784..963f4ad9cb66 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -22,7 +22,7 @@
> >  #include "lsm.h"
> >
> >  /* Flag indicating whether initialization completed */
> > -int safesetid_initialized;
> > +int safesetid_initialized __initdata;
> >
> >  struct setid_ruleset __rcu *safesetid_setuid_rules;
> >  struct setid_ruleset __rcu *safesetid_setgid_rules;
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > index bde8c43a3767..d346f4849cea 100644
> > --- a/security/safesetid/lsm.h
> > +++ b/security/safesetid/lsm.h
> > @@ -19,7 +19,7 @@
> >  #include <linux/hashtable.h>
> >
> >  /* Flag indicating whether initialization completed */
> > -extern int safesetid_initialized;
> > +extern int safesetid_initialized __initdata;
> >
> >  enum sid_policy_type {
> >         SIDPOL_DEFAULT, /* source ID is unaffected by policy */
> > --
> > 2.20.1
> >
