Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62479C54EE9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 22:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiI0Wzk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI0Wzi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 18:55:38 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D22A70E73
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:37 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s125so13541413oie.4
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0dKIPiA3h3dTDTVddQ4V1TbvxqYxwlHOgxPm+H9dxCc=;
        b=CMb00Ya5CzSCl2dFciNJgV7Oh9fQw8TZmymZ9hTPy8WERwyinnnVNrhAHAXUPwUNYF
         ev5JKKpdsoQiMVyNTPUknJNtlSVjxBD6c7nOsJG5pHSmlzkiMwiC5UZfIUUWj1irEg2c
         GfTtaKe9z8N1WqZDcFXHmCrQthZhVgJhSvW+Osa0DypQiVooKF4ORPITEozr28DcJENW
         4xn2jS4cafTFIyjBHBE0bqvbZtBkEF37HekCT4wprh9VqYlOjxd/Tkuae78/PuB/8YrT
         qsPtODagZTC6hnjA7M4rtnlqSQWSxj1+cleA+8be9p50ucsz3I42sfKXPqHblpBA7kBr
         uu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0dKIPiA3h3dTDTVddQ4V1TbvxqYxwlHOgxPm+H9dxCc=;
        b=mDEJs/gfutds0V+rQbFCUW81wkhBGTS5vdQssMStmvRYPNxQXugHCiEDK+KXMLeo1K
         vaZWp2M+YCHRDYbA1jb3EFtN8Rz6nu7Dqwi+FFR/YBIYvAQocEMlLMKKXkimMRxgLPtT
         icyFpSMIYZuALTwAYDcCn5tKoAHwjmSADyrPWKSNAfTip4l2trjP3Qs+kffbOKJVEBxD
         ycyCmK1p+KFaJiJOM+NqDTZ6jBU5UaeQkYjN+jCq8VTWu8ffh0FuXQV0EaYLVeynVmg0
         3aZewA5RMyUjeaRGgcRta5kKPUqYKC7ZSayb7NgIlwhx3bW3u9GOY31cyuX2hYQnSQ7I
         Z3Tg==
X-Gm-Message-State: ACrzQf0wh51w1CPOb2h3UA1tdta7NfF1ryIlLVEsyescIoIwglFzuwXs
        cKH1GlG1+0YxrKiM81AqT/3K/jvZ0TY0euMPCsXhpfqcUw==
X-Google-Smtp-Source: AMsMyM5bFev165GgI3qrOmaDNBkcJclRJwSLZNBj6+RTRBjtHySeid26mTDZWPez3QJ2NvZxo6E9O8P4HAZohjTvyzU=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr2944496oic.172.1664319336690; Tue, 27
 Sep 2022 15:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-17-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-17-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:55:25 -0400
Message-ID: <CAHC9VhSyf9c-EtD_V856ZGTbFamwWh=bxPh7aPdarkqhdE7WZw@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] acl: add vfs_get_acl()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> In previous patches we implemented get and set inode operations for all
> non-stacking filesystems that support posix acls but didn't yet
> implement get and/or set acl inode operations. This specifically
> affected cifs and 9p.
>
> Now we can build a posix acl api based solely on get and set inode
> operations. We add a new vfs_get_acl() api that can be used to get posix
> acls. This finally removes all type unsafety and type conversion issues
> explained in detail in [1] that we aim to get rid of.
>
> After we finished building the vfs api we can switch stacking
> filesystems to rely on the new posix api and then finally switch the
> xattr system calls themselves to rely on the posix acl api.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  fs/posix_acl.c                  | 131 ++++++++++++++++++++++++++++++--
>  include/linux/posix_acl.h       |   9 +++
>  include/linux/posix_acl_xattr.h |  10 +++
>  3 files changed, 142 insertions(+), 8 deletions(-)

...

> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index ef0908a4bc46..18873be583a9 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1369,3 +1439,48 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
>         return error;
>  }
>  EXPORT_SYMBOL(vfs_set_acl);
> +
> +/**
> + * vfs_get_acl - get posix acls
> + * @mnt_userns: user namespace of the mount
> + * @dentry: the dentry based on which to retrieve the posix acls
> + * @acl_name: the name of the posix acl
> + *
> + * This function retrieves @kacl from the filesystem. The caller must all
> + * posix_acl_release() on @kacl.
> + *
> + * Return: On success POSIX ACLs in VFS format, on error negative errno.
> + */
> +struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
> +                             struct dentry *dentry, const char *acl_name)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       struct posix_acl *acl;
> +       int acl_type, error;
> +
> +       acl_type = posix_acl_type(acl_name);
> +       if (acl_type < 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       /*
> +        * The VFS has no restrictions on reading POSIX ACLs so calling
> +        * something like xattr_permission() isn't needed. Only LSMs get a say.
> +        */
> +       error = security_inode_getxattr(dentry, acl_name);
> +       if (error)
> +               return ERR_PTR(error);

I understand the desire to reuse the security_inode_getxattr() hook
here, it makes perfect sense, but given that this patchset introduces
an ACL specific setter hook I think it makes sense to have a matching
getter hook.  It's arguably a little silly given the current crop of
LSMs and their approach to ACLs, but if we are going to differentiate
on the write side I think we might as well be consistent and
differentiate on the read side as well.


> +       if (!IS_POSIXACL(inode))
> +               return ERR_PTR(-EOPNOTSUPP);
> +       if (S_ISLNK(inode->i_mode))
> +               return ERR_PTR(-EOPNOTSUPP);
> +
> +       acl = __get_acl(mnt_userns, dentry, inode, acl_type);
> +       if (IS_ERR(acl))
> +               return acl;
> +       if (!acl)
> +               return ERR_PTR(-ENODATA);
> +
> +       return acl;
> +}
> +EXPORT_SYMBOL(vfs_get_acl);

--
paul-moore.com
