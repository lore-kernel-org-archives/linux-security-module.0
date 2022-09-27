Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD0AC07E9D
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 22:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiI0Wzy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI0Wzv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 18:55:51 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D667B2A2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1319573379eso2369337fac.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pXQ78AAdTDST6MN/uNB1/oNlC/v7qf73J3QFhqE0a5c=;
        b=E4c8aKWYKso8wa6FTMwrNgu6HFyldja58tHb7CzLi/zwt52W/+8NzrirDp0f/NrA3m
         1PEs5epYzbJmIuav8aDN/UELqO221JSNjCXDyV6JiIuEerf9PC4m5VKPzsOElmpZbP1S
         Bs+m9nseTNUmow5uOplR1ftvM8YArOz5gFW49smYbod1R7DwQbGGSqfjSDWYivzbRX7Y
         8i/ni1khLdGUxUSarS2FezlNEgK+BFQonfVFUzsAxsfz50tkqm3b1UMNelAhtJ0xIMaK
         V5nG2H1DXv2ly0VYRaBYH9YaOyUC2fEdiqHOOC28/xc11peGO3SprZpApdnLogWjMOWS
         993g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pXQ78AAdTDST6MN/uNB1/oNlC/v7qf73J3QFhqE0a5c=;
        b=ZTOGbYNuVC5d+IcOoVI/+xaj5Q8JpAq18omLn7MxCBp0ADtT0Ybbx8o9eIefcenABM
         nZ/ZfwXl4IWuTseWTXA22WgIyed9OB5CETsSXRllghHJkI5xUOB14Tsd3/HX0P+anCS6
         p5/Ph+MzHcHh6tBz0AU+h1gp561KlU5GNOQzYhjv/XybLY2oyVwX15uZt8M8qBTD220/
         LMh4VSg2KerLcbtYfEN43L+zkMHwW9JDdMOgxA61INwSvn1VoXxdc/88xWRGBRRt8ZTz
         E0cvJg0FlRM48d7zJRHzkjEKfrM44O3Ur34BYyPAdvCP4FmHZV/JHGTxlsqCwyfILCBg
         Z+CQ==
X-Gm-Message-State: ACrzQf1mFCUIuszGBlILDH71TnBBT2+lVrKISXulaYF4xSQaSsnGaTzr
        tA9zGS+Z+6EOFHLcoiKUW8wd/7ibolOgjCDhTLvn
X-Google-Smtp-Source: AMsMyM4NZT9ybIQF9aJDYlc6OPNxFaRDSPfUeGDU1tHk5YMuKgVIpWIMG4Mql0Q+bayYM8SsL7xity8y9hA1C/dhJPE=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr1655732oac.51.1664319348918; Tue, 27
 Sep 2022 15:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-18-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-18-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:55:37 -0400
Message-ID: <CAHC9VhRZBP6fXtBseJJ_zHy+yoHMkVkSUbAFXmer7bKpt1Qvow@mail.gmail.com>
Subject: Re: [PATCH v2 17/30] acl: add vfs_remove_acl()
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
> operations. We add a new vfs_remove_acl() api that can be used to set
> posix acls. This finally removes all type unsafety and type conversion
> issues explained in detail in [1] that we aim to get rid of.
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
>  fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/posix_acl.h |  8 +++++
>  2 files changed, 73 insertions(+)

...

> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 18873be583a9..40038851bfe1 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1484,3 +1484,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
>         return acl;
>  }
>  EXPORT_SYMBOL(vfs_get_acl);
> +
> +/**
> + * vfs_remove_acl - remove posix acls
> + * @mnt_userns: user namespace of the mount
> + * @dentry: the dentry based on which to retrieve the posix acls
> + * @acl_name: the name of the posix acl
> + *
> + * This function removes posix acls.
> + *
> + * Return: On success 0, on error negative errno.
> + */
> +int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +                  const char *acl_name)
> +{
> +       int acl_type;
> +       int error;
> +       struct inode *inode = d_inode(dentry);
> +       struct inode *delegated_inode = NULL;
> +
> +       acl_type = posix_acl_type(acl_name);
> +       if (acl_type < 0)
> +               return -EINVAL;
> +
> +retry_deleg:
> +       inode_lock(inode);
> +
> +       /*
> +        * We only care about restrictions the inode struct itself places upon
> +        * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
> +        */
> +       error = xattr_permission(mnt_userns, inode, acl_name, MAY_WRITE);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       error = security_inode_removexattr(mnt_userns, dentry, acl_name);
> +       if (error)
> +               goto out_inode_unlock;

Similar to my comments in patch 16/30 for vfs_get_acl(), I would
suggest a dedicated ACL remove hook here.  Yes, it's still a little
bit silly, but if we are going to make one dedicated hook, we might as
well do them all.


> +       error = try_break_deleg(inode, &delegated_inode);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       if (inode->i_opflags & IOP_XATTR)
> +               error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
> +       else if (unlikely(is_bad_inode(inode)))
> +               error = -EIO;
> +       else
> +               error = -EOPNOTSUPP;
> +       if (!error) {
> +               fsnotify_xattr(dentry);
> +               evm_inode_post_removexattr(dentry, acl_name);
> +       }
> +
> +out_inode_unlock:
> +       inode_unlock(inode);
> +
> +       if (delegated_inode) {
> +               error = break_deleg_wait(&delegated_inode);
> +               if (!error)
> +                       goto retry_deleg;
> +       }
> +
> +       return error;
> +}
> +EXPORT_SYMBOL(vfs_remove_acl);

--
paul-moore.com
