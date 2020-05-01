Return-Path: <SRS0=mFfD=6P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11575C4725A
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC26020857
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opqu5KGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgEAOqr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 May 2020 10:46:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45819 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729140AbgEAOqq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588344405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PAxMC2an+HuO6fwK0pHvsF8vFETkIJOxS2BSrwZIug=;
        b=Opqu5KGsejFH5haU727QzqNyIMruqX6ti3zOD09bBYpuW6V2dJ3tfuVOvI9CxC69wWj1wo
        J37bCkOswQec8zqstI1FUb3kzy6LT/OYYkHG9vRmXmSCedROqCVBTXoYC2xzKwJvS0kf8N
        jn8mbbenKiDVpHH/U435rPG/bs3hXss=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-lC8Ga8FRP5SydCfxSB_jBg-1; Fri, 01 May 2020 10:46:28 -0400
X-MC-Unique: lC8Ga8FRP5SydCfxSB_jBg-1
Received: by mail-oi1-f197.google.com with SMTP id u204so1953978oia.4
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2020 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PAxMC2an+HuO6fwK0pHvsF8vFETkIJOxS2BSrwZIug=;
        b=q0y2T/rx8r85UOXSOTIsKOdpvSv0ptNbyZ8LIQInLdBIdhJ+arnU7hjeORfQFxKhpd
         /Rw8/77DB1ciAG05TwcOXSlJ0AZikqKzqMCJHS/NQnwfGAB8W6FQ/EDppPJ6NCVfsPEX
         enZZD1jo+7c3Xhsq+M+ah80Zyqu5l+EKL8jbQqVnTolS+IDn1VIM7AvX8XhGRbAQXes0
         nh+RXKO+Hrr65UNDY+xY5COZdCRz5hlQDvgexibLRpVzYzFDL7uv6IZOxDIJYawmdb41
         98m69nKVihvXxGnr5EO32OnUdMt+g2hPp7O7iaSdUOsTiKNUpkHC0MFqN0sGpu78SPrb
         ZcPw==
X-Gm-Message-State: AGi0Pub9jSq12+AV00/1K2nGCDpkjXfynVWoYo0nTDLQN+oCnhZUHL1B
        TAzvR1zYUBic48tjgpJqvigLmcYr3sl5eJsk5qX/Z+vs4qitYmQK4QlZPTeCsGZX5NAH8kVmMv7
        UTxVdtaLw3gh2uK2gthx9F0OxRSmIzd1IdNKkIiriNcZ2YTgh7+as
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr3916392otq.66.1588344387511;
        Fri, 01 May 2020 07:46:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKDh3hGCI49P8v9DIB0pf8SQidMuRu0a5PX4JiBQLS3y/qnX6pw1k5XjASmHpGzODx7mlwPtfE2sRdsrcygTXg=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr3916376otq.66.1588344387215;
 Fri, 01 May 2020 07:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
In-Reply-To: <20200501073127.GB13131@miu.piliscsaba.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 May 2020 16:46:16 +0200
Message-ID: <CAFqZXNu8jsz_4eqgLOc8RGSSAWhiKc=YcByvoTiBeYUprT+kMw@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 1, 2020 at 9:31 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Whiteouts, unlike real device node should not require privileges to create.
> > >
> > > The general concern with device nodes is that opening them can have side
> > > effects.  The kernel already avoids zero major (see
> > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > explicitly forbids registering a char device with 0/0 number (see
> > > cdev_add()).
> > >
> > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > i.e. it won't have any side effect.
> >
> > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > >  {
> > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > >     int error = may_create(dir, dentry);
> > >
> > >     if (error)
> > >             return error;
> > >
> > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > +       !is_whiteout)
> > >             return -EPERM;
> >
> > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > end up with regressions for overlayfs on sufficiently weird setups?
>
> You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> distros/admins can.
>
> Can we just try this, and revert to calling ->mknod directly from overlayfs if
> it turns out to be a problem that people can't fix easily?
>
> I guess we could add a new ->whiteout security hook as well, but I'm not sure
> it's worth it.  Cc: LMS mailing list; patch re-added for context.
>
> Thanks,
> Miklos
>
> ---
>  fs/char_dev.c                 |    3 +++
>  fs/namei.c                    |   17 ++++-------------
>  include/linux/device_cgroup.h |    3 +++
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev,
>         p->dev = dev;
>         p->count = count;
>
> +       if (WARN_ON(dev == WHITEOUT_DEV))
> +               return -EBUSY;
> +
>         error = kobj_map(cdev_map, dev, count, NULL,
>                          exact_match, exact_lock, p);
>         if (error)
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
>
>  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> +       bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
>         int error = may_create(dir, dentry);
>
>         if (error)
>                 return error;
>
> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> +           !is_whiteout)

Sorry for sidetracking, but !capable(CAP_MKNOD) needs to be last in
the chain, otherwise you could get a bogus audit report of CAP_MKNOD
being denied in case is_whiteout is true.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

