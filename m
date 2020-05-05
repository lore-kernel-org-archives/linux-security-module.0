Return-Path: <SRS0=J6Hd=6T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A2C47254
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842F1206A5
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ihDJpaR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEKvL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 May 2020 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEEKvL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 06:51:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431EC061A0F
        for <linux-security-module@vger.kernel.org>; Tue,  5 May 2020 03:51:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id b20so1269645ejg.11
        for <linux-security-module@vger.kernel.org>; Tue, 05 May 2020 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiAYBMxYI8NU7mtb1mzz5f5Sdoka6Yab/wWBtaaJ4fk=;
        b=ihDJpaR9AYed4rtVB7Ykde5Q9tGgQkZvAm/Ie9ITAzbq6xK+wY+bP1MoqSzbWFfgfN
         kuUdHcddqD/XD0IRIybJX6+whUJHcQ2nF9RX6En/DBHOuqjVjJYjQAI5IikvYY6MTXYj
         Z4eH2tJZ2wKF3WBp3fNKSlOFt2CvbA+SH4nas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiAYBMxYI8NU7mtb1mzz5f5Sdoka6Yab/wWBtaaJ4fk=;
        b=Yg/WOo7X1AzzQ70urE+6u7aTr4rM4l19Ssk9tvh9TU1JPyajwl9Lni+OxYD0gr8kRZ
         W80BwgEWNugwhZ7AlmNaDwvNV+OBK2vv9g7Wwbs3Y9IHLsQ7lYeNqISRDvDVuPwbydF1
         0QfpM1Xl44XW43aGVfKd4v0DTyZAtHSR03fVDQkjMS8imHcVHHiHDGHQo+qj8V1VY+4q
         norJUy50BkaH9cEeB6R5vWiQSoAmFPw74ccAV5sY9V46Ilt3UGcj80+GPyblm3904Hsw
         ZO4SqvVITq6vRTXuNBCcEW8j6UK5LS0785JMNInRLGFPKRuFaWtdRGAGLy61+L7/uNpb
         x8sw==
X-Gm-Message-State: AGi0PuZJPEUSb6wsDz5eNlgkTOsSJQ8Tb9nS5DolZt5IpLeXhbgM+Bis
        l6Ot+OR68R9btsv1c695yVP5XcfqUBOhZK+nvoaopA==
X-Google-Smtp-Source: APiQypJSWUulzPC8TpwSFWx/zlrCFqpXOvahPn5HlH1fRKqJeL3GYoJvvbIC2tPJ+8vi7DfOknnxH2Doam1p2WQwXC8=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr1979896ejy.145.1588675868324;
 Tue, 05 May 2020 03:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
 <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
In-Reply-To: <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 5 May 2020 12:50:56 +0200
Message-ID: <CAJfpegs3QbWa3gDGNv1atmanP_SE1KE3RhehQ7A+n_cNOa3Bsg@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 1, 2020 at 4:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 1, 2020 at 9:31 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
> >
> >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> >  {
> > +       bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> >         int error = may_create(dir, dentry);
> >
> >         if (error)
> >                 return error;
> >
> > -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > +           !is_whiteout)
>
> Sorry for sidetracking, but !capable(CAP_MKNOD) needs to be last in
> the chain, otherwise you could get a bogus audit report of CAP_MKNOD
> being denied in case is_whiteout is true.

Thanks, fixed in the latest revision.

Miklos
