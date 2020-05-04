Return-Path: <SRS0=JC4w=6S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0452C47257
	for <linux-security-module@archiver.kernel.org>; Mon,  4 May 2020 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB86520661
	for <linux-security-module@archiver.kernel.org>; Mon,  4 May 2020 11:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pmQakzRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEDLTB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 May 2020 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLTA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 May 2020 07:19:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66175C061A0F
        for <linux-security-module@vger.kernel.org>; Mon,  4 May 2020 04:19:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id pg17so13536165ejb.9
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2020 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnhHp4z6/JfitEDp77Ovs3sPoUEeRYCqXcr3ouUaioY=;
        b=pmQakzRLRsJk/F4L60ClrnRIEH/nzG0J2iy0rKYUgm9VNbjh832jl9Yhbx2oimEt8s
         vFC1RO5ii4yZoiTtkjqe1eNFHGh/eW+SuC+6Q09N1w662AYyuOTJLe8VyjMhwhk3LiIB
         Ml5MAmKoGGI0sZPKcG5uSL6uzHCJDnFlRMuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnhHp4z6/JfitEDp77Ovs3sPoUEeRYCqXcr3ouUaioY=;
        b=t9GTDs2uxs9telnJfFBraLLrlAWapalbAt8zXAXyl6XDfZ/C7MFq6RbGgPsPzyi+oy
         +XP6G50FJ45PRU+Dz7WEZfessJwyOWCjZjyCtP13rxpMkoBTjyBuiSC5EYtaDy83auud
         feaSVYFUDj5evce9qAgsnb2ItoCHqnr9K42kM+CBZERwT97GUy9+lbBvSMF9txRLWieQ
         hiNUzrjxT+266sFQobe1DEnJVpmDdRztI0toYjPCZfoyhX3l3DOzyuUnMdp9C0zg71zW
         tUfcikVujXfumVgM7U2bqQxjXXaCAu7n1HaFn3FyiEEGYFpQxBGaVSznOTXiM/LWZ4JE
         Svmw==
X-Gm-Message-State: AGi0PuYuOQh1fQgFzYuJgEZGzTVs98hovf1Revjd9wETnB2aAFH4RyNK
        q8b0NxbEfWdrBGQrNI+kj8xomaazIimo4UGIZ2wCzA==
X-Google-Smtp-Source: APiQypKtOEJXmmcQClOPLZPgv4ey3QaTiM7LQBxA26hvnZWHW0kpfX0633B0Kl2NTByXsbhh2QEjpKZCaStzxta0jNg=
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr14957699ejx.43.1588591138981;
 Mon, 04 May 2020 04:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
 <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 4 May 2020 13:18:47 +0200
Message-ID: <CAJfpegvZ+ASrpbEpeKx-h3mK7fedd7EfgAfm7TL7dgPmy7tppg@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 1, 2020 at 8:40 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 1, 2020 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > > > Whiteouts, unlike real device node should not require privileges to create.
> > > >
> > > > The general concern with device nodes is that opening them can have side
> > > > effects.  The kernel already avoids zero major (see
> > > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > > explicitly forbids registering a char device with 0/0 number (see
> > > > cdev_add()).
> > > >
> > > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > > i.e. it won't have any side effect.
> > >
> > > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > > >  {
> > > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > > >     int error = may_create(dir, dentry);
> > > >
> > > >     if (error)
> > > >             return error;
> > > >
> > > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > > +       !is_whiteout)
> > > >             return -EPERM;
> > >
> > > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > > end up with regressions for overlayfs on sufficiently weird setups?
> >
> > You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> > distros/admins can.
> >
> > Can we just try this, and revert to calling ->mknod directly from overlayfs if
> > it turns out to be a problem that people can't fix easily?
> >
> > I guess we could add a new ->whiteout security hook as well, but I'm not sure
> > it's worth it.  Cc: LMS mailing list; patch re-added for context.
>
> I feel like I am still missing context but IIUC this change is
> allowing unprivileged userspace to explicitly call mknod(2) with the
> whiteout device number and skip all permission checks (except the LSM
> one). And then you are switching vfs_whiteout() over to using
> vfs_mknod() internally since it no longer does permission checking and
> that was why vfs_whiteout() was separate originally to avoid imposing
> any checks on overlayfs-internal creation of whiteouts?
>
> If that's correct, then it seems problematic since we have no way in
> the LSM hook to distinguish the two cases (userspace invocation of
> mknod(2) versus overlayfs-internal operation).  Don't know offhand
> what credential is in effect in the overlayfs case (mounter or
> current) but regardless Android seems to use current regardless, and
> that could easily fail.

The major point is: whiteouts are *not* device files, not in the real
sense, it just happens that whiteouts are represented by the file
having a char/0/0 type.

Also the fact that overlayfs invocation is indistinguishable from
userspace invocation is very much on purpose.  Whiteout creation was
the exception before this change, not the rule.

If you consider the above, how should this be handled from an LSM perspective?

Thanks,
Miklos
