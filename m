Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F032C05027
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Jan 2023 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjATVEv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Jan 2023 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjATVEu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Jan 2023 16:04:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDB8A63
        for <linux-security-module@vger.kernel.org>; Fri, 20 Jan 2023 13:04:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so6380378pll.9
        for <linux-security-module@vger.kernel.org>; Fri, 20 Jan 2023 13:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y172KwacIm4200KA0aG6WBm3XKs0N6jHhBKXK9WD9mI=;
        b=dPladbV/U1GCgz/wNJzUOoElEIPdmUvwE4kDWOjJjbDQQZMOKjXNsnc7gnxqSbhYKZ
         /Lhpq+lffC3UGqVkVkfj+B1dLPCpkLBaNmZokuMG1AV1R6hMBi9v1KrSp2Lmp9GdjMjS
         ouWjx4YdvjCeOhemuBcaEx4hDL8qhARp9pZ8/3YvsFAS+lEK96CBKjZYLevo2iy4P4BJ
         Wcl96HKNDP7F61wZJ+z1gkNRbgjija1ouMrRQhonT0mf6RUaDeuyluFubcfg17ljxzpf
         w4g2X1wMCGeoL8ZCybtmTgpxZGTiiE/mSH4Z7a5ogW0uYbpRbU2e11bJhaIHJ/vf2LUG
         jpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y172KwacIm4200KA0aG6WBm3XKs0N6jHhBKXK9WD9mI=;
        b=C4+za6+ng1UIRxvISClfyMTFRQwD9G3+W/EPRfmSITZwpLI9PkF/ki6gG9DYo4VfYq
         vuPDA1bylcvEMsOLa4TMrjmkgHh/8zPQV4Y6HNpSQ4bts3liMtez+ERif6km5bIvAgWe
         Xop0ThVUfNXDKHvt3N1VEMppfPgsrN2dYG/EQTKKqX4eYxoHlFQIP0lYCLRkeMixa/SA
         XHbolPSH4Mt98xH4N94s8vIMcyTTmDJMinD41NGTznJZQm7SCYpiMCtKOEFRUKF6+Rdh
         wikPDiFQ6U1S56zKdE5aBL5I9mUK9sFzCik11mbX28DrM/pO1FYsxsxBsEQ0+k7fH2+L
         TEGA==
X-Gm-Message-State: AFqh2kqKML9pcxgWqaEx5zzW3bxvkYi3HAQ7ByxWnR8GOOKEWp114gfB
        Uqxi0Vad4k8uU1SHCMkd2KiAH8uoiRqLtlctixW0
X-Google-Smtp-Source: AMrXdXs8Faave2YJu+g6n6M+4QYmBNMXF46Qu59oZgfKnPdvJ6mTQUJOkGwrJVa4sN47D3aEIVz8WuCvphKHlFQ05+A=
X-Received: by 2002:a17:902:bd97:b0:191:2b33:606f with SMTP id
 q23-20020a170902bd9700b001912b33606fmr1493982pls.32.1674248687946; Fri, 20
 Jan 2023 13:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com>
 <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
 <CAHC9VhSamRVpgrDrSuc2dsbbw3-pvjDi9BsFWoWssHkAD2W5vA@mail.gmail.com>
 <a764acb285d0616c8608eaab8671ceb9c22cb390.camel@huaweicloud.com>
 <058f1bdf4ba75c3a00918cefbf1be32477b51639.camel@linux.ibm.com> <e1a1fe029aea21ba533cb6196e64f29c7b052c57.camel@huaweicloud.com>
In-Reply-To: <e1a1fe029aea21ba533cb6196e64f29c7b052c57.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jan 2023 16:04:36 -0500
Message-ID: <CAHC9VhT--Q8QkFmKTpD3zjryDL19V9myfr3PuzSRo_bDzDRyqQ@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 13, 2023 at 5:53 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2023-01-12 at 12:45 -0500, Mimi Zohar wrote:
> > On Thu, 2023-01-12 at 13:36 +0100, Roberto Sassu wrote:
> > > On Wed, 2023-01-11 at 09:25 -0500, Paul Moore wrote:
> > > > On Wed, Jan 11, 2023 at 4:31 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Fri, 2023-01-06 at 16:14 -0500, Paul Moore wrote:
> > > > > > On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > >
> > > > > > > Commit 98de59bfe4b2f ("take calculation of final prot in
> > > > > > > security_mmap_file() into a helper") moved the code to update prot with the
> > > > > > > actual protection flags to be granted to the requestor by the kernel to a
> > > > > > > helper called mmap_prot(). However, the patch didn't update the argument
> > > > > > > passed to ima_file_mmap(), making it receive the requested prot instead of
> > > > > > > the final computed prot.
> > > > > > >
> > > > > > > A possible consequence is that files mmapped as executable might not be
> > > > > > > measured/appraised if PROT_EXEC is not requested but subsequently added in
> > > > > > > the final prot.
> > > > > > >
> > > > > > > Replace prot with mmap_prot(file, prot) as the second argument of
> > > > > > > ima_file_mmap() to restore the original behavior.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > ---
> > > > > > >  security/security.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/security/security.c b/security/security.c
> > > > > > > index d1571900a8c7..0d2359d588a1 100644
> > > > > > > --- a/security/security.c
> > > > > > > +++ b/security/security.c
> > > > > > > @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
> > > > > > >                                         mmap_prot(file, prot), flags);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > > -       return ima_file_mmap(file, prot);
> > > > > > > +       return ima_file_mmap(file, mmap_prot(file, prot));
> > > > > > >  }
> > > > > >
> > > > > > This seems like a reasonable fix, although as the original commit is
> > > > > > ~10 years old at this point I am a little concerned about the impact
> > > > > > this might have on IMA.  Mimi, what do you think?

So ... where do we stand on this patch, Mimi, Roberto?  I stand by my
original comment, but I would want to see an ACK from Mimi at the very
least before merging this upstream.  If this isn't ACK-able, do we
have a plan to resolve this soon?

-- 
paul-moore.com
