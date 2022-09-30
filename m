Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67011C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Sep 2022 12:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiI3MYz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiI3MYu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Sep 2022 08:24:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338CD6A
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 05:24:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so8692924ejc.4
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HUp6tY7BvFiK36PUZyugtk+P/q3Weh4h3BX2ULpDD6Y=;
        b=be9bYEFgXIONSG2q3vd7TXbJZVwafGFXbeJUj5TQ3ZC0F5JPvFK71a5HVbFuJ+69MX
         WhLFMkbEVdf/6Qhg0hdk1uyvSMz0QAlCz7bpWIJPMiUZ1hX6oT4hoFyjG+gaOQ7iF7a5
         B3Xwbj9aeuu87JYrU1N3veon8DjYCbHVLaI60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HUp6tY7BvFiK36PUZyugtk+P/q3Weh4h3BX2ULpDD6Y=;
        b=TAnTkwsJ7rm06bEbj3qYDV+pIiiDDeujmIOvTK0AJ/LI8xVGzxVjduEl+AZ3Vmygl6
         GqRlFPB4jxNt4vKWr7RvQMftT3Ox+NmU8ipMjAhnRpP5MujHxtPRlcEzEov/IhdZDu7n
         JiQNoAg1uLcnNjcbbRhyCgaJ4FBWRnWcgcXUum28GjyQN6x1lTXYo+dndelc5eGChWuM
         aw3mkM98xYzCpzvfwK+waqHu6u6euCbm2B0yGVkbMerxr57lrH8uescnEgYgZ4JkgeSr
         LZhpa9x8gpqZFIIF7KLTKrXmJPIcJlMALUnlm0BrJtBsO7JcL/IL8pKOFMbhD0SktCZk
         Gn2A==
X-Gm-Message-State: ACrzQf2B1OeRPdG+KhxrmfAXSmhsRrsK8su3T0QKIOrvebLwKXUORa4O
        epb1EENM6KWlgovrAMaQtKjz+K4TC/tz9WmXP4bRGg==
X-Google-Smtp-Source: AMsMyM6OvmiM71+JGp+MO6pATIntaRsnLf/VayvxlL7km/w2mkpnHlKCD3XGLHJxbGSXrozN/JWJrdhTJrBtKTjElpU=
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id
 i17-20020a1709064fd100b00787434fd755mr6119881ejw.356.1664540685052; Fri, 30
 Sep 2022 05:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <20220930100557.7hqjrz77s3wcbrxx@wittgenstein>
In-Reply-To: <20220930100557.7hqjrz77s3wcbrxx@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 14:24:33 +0200
Message-ID: <CAJfpegvJUSowMaS7s_vLWvznLmfpkEfbvZbb_Vo-H8VewucByA@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 30 Sept 2022 at 12:06, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 11:43:07AM +0200, Miklos Szeredi wrote:
> > On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > > > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > > This adds a new ->get_acl() inode operations which takes a dentry
> > > > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > > > to get posix acls.
> > > >
> > > > This is confusing.   For example overlayfs ends up with two functions
> > > > that are similar, but not quite the same:
> > > >
> > > >  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> > > >
> > > >  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> > > >
> > > > So what's the difference and why do we need both?  If one can retrive
> > > > the acl without dentry, then why do we need the one with the dentry?
> > >
> > > The ->get_inode_acl() method is called during generic_permission() and
> > > inode_permission() both of which are called from various filesystems in
> > > their ->permission inode operations. There's no dentry available during
> > > the permission inode operation and there are filesystems like 9p and
> > > cifs that need a dentry.
> >
> > This doesn't answer the question about why we need two for overlayfs
> > and what's the difference between them.
>
> Oh sorry, I misunderstood your questions then. The reason why I didn't
> consolidate them was simply the different in permission checking.
> So currently in current mainline overlayfs does acl = get_acl() in it's
> get acl method and does vfs_getxattr() in ovl_posix_acl_xattr_get().
>
> The difference is that vfs_getxattr() goes through regular lsm hooks
> checking whereas get_acl() does not. So I thought that using get_acl()
> was done to not call lsm hooks in there. If that's not the case then I
> can consolidate both into one implementation.

So there are two paths to getting an acl: 1) permission checking and
2) retrieving the value via getxattr(2).

This is a similar situation as reading a symlink vs. following it.
When following a symlink overlayfs always reads the link on the
underlying fs just as if it was a readlink(2) call, calling
security_inode_readlink() instead of security_inode_follow_link().
This is logical: we are reading the link from the underlying storage,
and following it on overlayfs.

Applying the same logic to acl: we do need to call the
security_inode_getxattr() on the underlying fs, even if just want to
check permissions on overlay.  This is currently not done, which is an
inconsistency.

Maybe adding the check to ovl_get_acl() is the right way to go, but
I'm a little afraid of a performance regression.  Will look into that.

So this patchset nicely reveals how acl retrieval could be done two
ways, and how overlayfs employed both for different purposes.  But
what would be even nicer if there was just one way to retrieve the acl
and overlayfs and cifs be moved over to that.

Thanks,
Miklos
