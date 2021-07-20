Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4996C07E95
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48E061019
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 02:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbhGTCRI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jul 2021 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhGTCQW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jul 2021 22:16:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89FC0613DB
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jul 2021 19:57:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qb4so32037258ejc.11
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jul 2021 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/TjJ11+mGqv0YTZQILPTlTbnMuqu1sgIatUTm4EDowI=;
        b=hnQU7KTLH/aX0omnwkEQkfzvKNKseAdXeBZwXCEkrxeZFoAypBDRBkv81LMgvGorKa
         LUym5vqJoKXWMX+quvGvrM9D9PQCoM8RVbUe3WsXxz99JokSIprBIcfyGInB0kl/Qzgt
         sNSfsb+U+6P1vw8dr8/3NXNhxygEhFteJOmuEAkIps2IbIxBhwxt+Fe3Lc82+ZH0LYNx
         GeteuL6LCT1ZvEKnF2MvAhtlXI1EGmDH824eKGC50dZQeoG40IK7Xcl4IOk2z64d6Y4X
         tr3/UHQVv/tlm5XD7v0zCIW2636hWkiqyXFcXddBXoT/pTQ8ltCkX2pFT/8Es0dbKFBq
         IL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/TjJ11+mGqv0YTZQILPTlTbnMuqu1sgIatUTm4EDowI=;
        b=SEf3qQYeiTl9QczPfYI1x0tPmTIAi+NBpq/8fwstq0RL0QVtFVOTBubFq00GMTJOpb
         nBm/AYQwDF/v6J/4ay0tp6rmZYAhg7cqQfS+25UmPXfKweDz68sO+OzwDlvghoskqahe
         hkLKb0KNZZBi3CLkMRjIz+FE69DU1YB1vILDKWW2R59viIhoz3OFeXK0WhtRozfpxq+b
         AoVIzCHtUSov3BfSlB5LF+jDWYLYyajtJ1nVWeQFCkJs04JJcs8ce3iLDqEHKPgX9YQQ
         psxe91ytU8Cl1ve/gTHQi8+6kUJcOnsFOabYibud1To4dxiTa/zoYtazOueQ7tE6vxS8
         +1Fw==
X-Gm-Message-State: AOAM532rmDuiHlCEUPDjDdzyDEv0lNT93sf/ui0O9RNdsPPliJ3kS6+C
        cCox2YfOQwEBt/auQ2cXSWkoSoWPVHKLaE6vtad8
X-Google-Smtp-Source: ABdhPJxDLvp2yIiHA1FaQDtOHdqVvtMYGHN/3oRWC0YEHLKqZbpFUBZaPZhQsEpB4ND+yH2ngWZYEpJdn2JO0yhcy7M=
X-Received: by 2002:a17:906:814f:: with SMTP id z15mr30528199ejw.178.1626749818592;
 Mon, 19 Jul 2021 19:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <22c0d7a1-b658-64ce-f099-0b3617ef8e38@huawei.com>
 <CAEjxPJ5-w83HMRGuDHHqMthkju3bxT0gZ-EiiTE=t5UhQqQ_ug@mail.gmail.com> <ec36e53f-5a6d-b86e-790c-d58b7b503aae@huawei.com>
In-Reply-To: <ec36e53f-5a6d-b86e-790c-d58b7b503aae@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jul 2021 22:56:47 -0400
Message-ID: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
Subject: Re: issues about selinux namespace
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        jamorris@linux.microsoft.com, "Likun(OSLab)" <hw.likun@huawei.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 19, 2021 at 9:55 AM xiujianfeng <xiujianfeng@huawei.com> wrote:
>
> thanks stepthen,  I've found James's patch in
> https://lwn.net/Articles/737949/,
>
> but it seems can't resolve my questions, so any futher discussion would
> be helpfull and welcome.
>
> =E5=9C=A8 2021/7/14 20:11, Stephen Smalley =E5=86=99=E9=81=93:
> > Please take your email to the selinux@vger.kernel.org. You are the
> > second person to ask about selinux namespaces within the past week or
> > so. I did upstream the refactoring and encapsulation of the data
> > structures and code via the selinux_state patches, so those are in the
> > mainline kernel these days, and Paul Moore and I have periodically
> > re-based the remaining patches on top of upstream over in the
> > https://github.com/SELinuxProject/selinux-kernel/tree/working-selinuxns
> > branch. However, I had to drop the inode and superblock per-ns patches
> > temporarily because of changes to LSM (inode blob management moved to
> > the LSM framework out of the security modules), so that would need to
> > be revisited. There was a separate patch from James Morris to support
> > per-namespace security.selinux extended attributes; you can dig that
> > out from the history or mailing lists if you want to revive that. I
> > won't be able to look at it again until October at the earliest.
> >
> > On Wed, Jul 14, 2021 at 6:54 AM xiujianfeng <xiujianfeng@huawei.com> wr=
ote:
> >> Hi Stephen,
> >>
> >> I am writing to discuss about selinux namespace because I found your
> >> previous work on github and I think selinux namespace is helpful to
> >> harden container security. So I try to do further work but there are
> >> some issues mentioned in the commit message and I have no idea how to
> >> fix them, it would be great if I can get help from you.
> >> First is about selinux hook functions, we need to update each hook to
> >> perform its processing on current namespace and all of its ancestors,
> >> for object, we can have different sid/tag in different namespace based
> >> on inode namespace support, but for task, do we need to maintain each
> >> security context generated in the corresponding namespace?
> >> Second is the lifecycle management of on-disk inode labels. it's not
> >> easy to handle this, should we clean all corresponding labels on disk
> >> when namespace exit? if we do this, it may cost long time to iterate
> >> inode on disk and must relabel files when container restart, if not, t=
he
> >> inode xattr space maybe full and cannot write label again when new
> >> namespace starts.
> >> BTW, do you have plan to finish the work?
> >>
> >> I look forward to receiving your reply.
> >>
> >> Best wishes.

I understand that many mail clients do not encourage inline/bottom
replies, but when posting to the various Linux Kernel mailing lists
please make the effort to reply inline, or at the bottom, as
appropriate.

Namespacing the SELinux kernel code is a rather tricky thing, both
with respect to the design and the mechanics of the implementation.  I
don't think we have a concrete idea yet on how we want to proceed in
all of the areas mentioned; designs - and implementations - have been
offered, but I think we are missing someone to drive the topic forward
with demonstrations, sample implementations, etc.  It is never a bad
idea to ask how you can help a project, but in this case I think the
answer is to step back for a moment, describe your use-case/problem,
explain how you envision a namespaced SELinux helping you resolve
this, and finally how you would want the namespaced SELinux
implementation to work (how would you interact with it both via policy
and runtime management).

On a personal note, the regular rebasing of the SELinux namespace work
has suffered lately due to other time commitments at work.  I have
recently (today) started a new position which should allow me to
dedicate much more of my working hours to upstream development; it may
take me a couple of weeks to get settled in, but you can expect the
regular rebasing of selinux/working-selinuxns to resume in the future.

--=20
paul moore
www.paul-moore.com
