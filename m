Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72358C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Sep 2022 09:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiI3JnW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiI3JnV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Sep 2022 05:43:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B11406F6
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 02:43:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so7914224ejn.3
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K9BxadCBYBzaBTyQRyF/w6rBPEGeOhrH+tm0fSl5DRM=;
        b=kNP9aRNM3QO6PO+jNGGedT1/gfIo7tenrFk15eP7tS8Ong7YEIUlVxbhpWCp0tvg8P
         pMH699lyYfWQVX+3Y+lHf+4g6KfeF9zrweQB/K+bCEHnCuE8GvEPGf/ob3S0R0aUbT9F
         fQkHt6IS6G1+PQ6qhzaGPaOcRRyrnq5BP7hnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K9BxadCBYBzaBTyQRyF/w6rBPEGeOhrH+tm0fSl5DRM=;
        b=rrHX43mYPmPukorxWq0WgmsBa7M5t8L+AAd6FgfUdqiTFeuob6aVbsv9lGSUaXdEdB
         wpGA7MnYYF4SN7wjHVNbu/CUNLCY1ormZVwbI1JcI8Hzwiaec6e3qB/LdUp3nxf0m6qX
         YYsIXtY0FfJC4R+TA7RV2Z5avUA+YeoSsKx0SZU/RTRYrNabK4sVFQNKMkfJX3P4f/tf
         9Ili+BRiEdI9LpU1nI9zwIwiksQM11reyyANiIPPnKmX/iWWuZPAI75VWjYhfR9tRMrO
         KY3vkwi9L8fVavIhMDD532zFy0kythwb/TrczFlbMJjUKmT5Ec1TmgdKqnKpKt9xsYx+
         ED7w==
X-Gm-Message-State: ACrzQf07k8ICc5GphZnYHCj43rw/uw5wV92a317nnGhsV0S/UAD/8dFW
        eDUtJb5PCYOVW6cevDp7VbB+Ns+O2aJTSdZokHo82w==
X-Google-Smtp-Source: AMsMyM6/e9bKat+xexCpKn9P8ksCzV90qmbW3LJaH+3XUmspyG6GPPBL3FPFtFmD2ewFq9eCdpFgJF0q1tXhZFDehcQ=
X-Received: by 2002:a17:906:7315:b0:782:66dc:4b76 with SMTP id
 di21-20020a170906731500b0078266dc4b76mr5883321ejc.751.1664530998871; Fri, 30
 Sep 2022 02:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com> <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
In-Reply-To: <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 11:43:07 +0200
Message-ID: <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
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

On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > This adds a new ->get_acl() inode operations which takes a dentry
> > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > to get posix acls.
> >
> > This is confusing.   For example overlayfs ends up with two functions
> > that are similar, but not quite the same:
> >
> >  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> >
> >  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> >
> > So what's the difference and why do we need both?  If one can retrive
> > the acl without dentry, then why do we need the one with the dentry?
>
> The ->get_inode_acl() method is called during generic_permission() and
> inode_permission() both of which are called from various filesystems in
> their ->permission inode operations. There's no dentry available during
> the permission inode operation and there are filesystems like 9p and
> cifs that need a dentry.

This doesn't answer the question about why we need two for overlayfs
and what's the difference between them.

>
> > If a filesystem cannot implement a get_acl() without a dentry, then
> > what will happen to caller's that don't have a dentry?
>
> This happens today for cifs where posix acls can be created and read but
> they cannot be used for permission checking where no inode is available.
> New filesystems shouldn't have this issue.

That's weird, how does it make sense to set acl on a filesystem that
cannot use it for permission checking?   Maybe the permission checking
is done by the server?

Steve?

Thanks,
Miklos
