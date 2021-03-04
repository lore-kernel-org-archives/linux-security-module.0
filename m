Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F3C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E8764FDD
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhCDXoJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhCDXoJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 18:44:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1819C061756
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 15:44:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bd6so123301edb.10
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pe1DDwe6/qeYUF+CpPc6ztTY8CQZJ3txOiTpTjCAFpA=;
        b=C+17KSq6aI5MndQhPnepfxNOZ8s8HsdutrUufunFJxj7noHOMqL2wu9H0xP63k5WVT
         v0B7CYfTYe4/1fjzoawmPj0pJAD6crraaH9r/O0J32JB7rz7uFK28UsfDLlPVcaiOSfv
         fWQ8o3s8cZsj7JEAXoEu1rwnBJA6/CsfbWk/XgWyFkiA+QRnrT2PEG9bVA9ynOyHPKWW
         bM9jw3P74J3fD/xrQtB/FZfdDs4fa4tU+iiNyMjLT0wdaFzDJPFjx7dJSmYey76SoEJr
         p0PYuiMcHBkH7IOZSk8k0ZpRDkdeM1U8zCn4ql0IEEDyfJlJ68K2Z9Hqw1zSXH4jDrAW
         H0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pe1DDwe6/qeYUF+CpPc6ztTY8CQZJ3txOiTpTjCAFpA=;
        b=hxV/ZQGNKs+i84iFkirKbHGGGFRr9YOp+uocEGtGzBVtC4UdVnC26HR1/cZClnT9yV
         8IzPNT43yR+BzeMzbIf+fWabDt8oQiXeMgUgxLq/Nmgk034zDFXvaKh5RYF/Tun1sHdJ
         3XgQZ1oaFgn90Tal08KxxAjqXbCAahEALaRg1YhUd6aOT08WQqJUplyrsKmvBpw//vjJ
         25wCN9F4KtLWhiSKz6+2OEGUnUH2G/E+qWtI3oRwsXVnPzDE/crwY19vXKS4zL/jdC8r
         WuefaWtrViInaNL2tWxeTxI5Urny56JXj5xIsuJzaFWLMcthpQ8GXlkyXPlD+T0jeRKi
         Wh4A==
X-Gm-Message-State: AOAM532OmZn3h3G5yQ5KgXrEaIZU1sxkfVjK0+17zpL3QAU7yarEfFOH
        CtNgw6v6mAeVgmELdxMaE+rnAglpD39SciHo9qh0
X-Google-Smtp-Source: ABdhPJwvmYMQTO+SQAXxsX2ErjiDOvV24hbtcbWaNwq69ofyVioPtD7li14KYlnalajtYAHDPD2dDRqA/y4RW2rA7Xg=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr3294584edb.135.1614901447369;
 Thu, 04 Mar 2021 15:44:07 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
 <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com> <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com>
In-Reply-To: <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 18:43:56 -0500
Message-ID: <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 4, 2021 at 5:04 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> On Sat, Feb 20, 2021 at 3:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> > > On Fri, 19 Feb 2021, Paul Moore wrote:
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index c119736ca56ac..39d501261108d 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > >               u32 secid;
> > > >               size_t added_size;
> > > >
> > > > -             security_task_getsecid(proc->tsk, &secid);
> > > > +             security_task_getsecid_subj(proc->tsk, &secid);
> > > >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > > >               if (ret) {
> > > >                       return_error = BR_FAILED_REPLY;
> > >
> > > Can someone from the Android project confirm this is correct for binder?
>
> This looks correct to me.

Thanks for the verification.  Should I assume the SELinux specific
binder changes looked okay too?

https://lore.kernel.org/selinux/84053ed8-4778-f246-2177-cf5c1b9516a9@canonical.com/T/#m4ae49d4a5a62d600fa3f3b1a5bba2d6611b1051c

-- 
paul moore
www.paul-moore.com
