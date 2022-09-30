Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46DDC4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Sep 2022 08:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiI3IxX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Sep 2022 04:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiI3IxV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Sep 2022 04:53:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40037166F3D
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 01:53:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lh5so7610181ejb.10
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K8KYCzJbYIonb5+JjExfvqHNImT94GXAowWxcjjUc7w=;
        b=UbVe2z+e99x30ztqmjuZaau50NzRYpAXXdcigzuCF5BNCUIbVBhbJfcQWvhlX8D/U5
         eItiTp4HfYmDOKMpeU0EQ0E5Jav8uAuBcIF3YZd9nK3ilHz8B+0Mz5F0EPxWtbetvNYS
         kaZiR/miCc4Jb9Uf9pVGizA2kCCGKyrjYhM9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K8KYCzJbYIonb5+JjExfvqHNImT94GXAowWxcjjUc7w=;
        b=Mr9P5DILQDFbjV7/5lTFeBmIEQzx9R4cc97T+wPdndB9iZ1uUE7I3m9yjCyTG55KrN
         jIpx+b+teUBer7b4k3+saQDyLegDyHwyMe3NrjGHL990V013xJtMzrbC3TxmWLQiOT+m
         d+4hKSgU7zFYoVLyLQtfJ3us2T3ieSUEW4mbVi1OPGzm25zkVKbIV9IrhN0mFvUo3F0c
         TYr2AueLdf7VaDsbcsmowHZlqeGTVdn7b6XvbRiehv5GJSxG6LusaTj/CB05Z2w6pXUt
         bKaK+Z/wtLF+Af2jRexsF8M21cVgQo2yusj/RUiG7PaBTHdauMTflF1FdMZV5MNsfd9z
         TTxQ==
X-Gm-Message-State: ACrzQf1WxfMbDemBe91vlc0WZhug6QOOC+KgLbizYa7mI9AkkgN4yZFh
        oIuQUW9Z2pLRzycs73fSdqKYzxrtmGV7Ai1XXAV20w==
X-Google-Smtp-Source: AMsMyM7acy/+/V1jGIdnMmBrA7NWTJ3L9r00p2DzykegLSnUX1KkGVSMv2aly2+YOcIN5vzawkqnZ4Kzcmli1dYauKI=
X-Received: by 2002:a17:906:478d:b0:783:2270:e85a with SMTP id
 cw13-20020a170906478d00b007832270e85amr5745460ejc.371.1664527996814; Fri, 30
 Sep 2022 01:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-5-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 10:53:05 +0200
Message-ID: <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:

> This adds a new ->get_acl() inode operations which takes a dentry
> argument which filesystems such as 9p, cifs, and overlayfs can implement
> to get posix acls.

This is confusing.   For example overlayfs ends up with two functions
that are similar, but not quite the same:

 ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)

 ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)

So what's the difference and why do we need both?  If one can retrive
the acl without dentry, then why do we need the one with the dentry?
(BTW in both cases the mnt_userns for the underlying fs is available
and used to translate the acl.)

If a filesystem cannot implement a get_acl() without a dentry, then
what will happen to caller's that don't have a dentry?

Thanks,
Miklos
