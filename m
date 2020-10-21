Return-Path: <SRS0=8N7l=D4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB6C4363D
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 01:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C5E22409
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 01:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WLDBkCPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439866AbgJUBR3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Oct 2020 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439859AbgJUBR3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Oct 2020 21:17:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE18C0613CE
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 18:17:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v19so676362edx.9
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEyd0fTbwnGq1j4mR/39y5YMzLAxT1RpmVEZDz9Z3mQ=;
        b=WLDBkCPqHeYGcvqVhE7x9bAwmmbNPSjZFwkxdnIXYyihDcvr7Ied3PFcAWuOZMUt7H
         ttvHpMCHf7p78/P4JtZXkxn597jQPI3QK0FMgKjVYiLwdB5OIPdlkT7BdBNLhfiNeOKA
         oN6kMul/uY1QudZ/RePQhfnOQwxxpxiLok0HkKqZknh+hYt70CFQ3BYE0nmviM0ZuFK+
         jaO+SYy/PzU2xyE9b2QYVqwwB9FLMsfn+oty4XlUF059oF48ga+hnN9tS3tkOSFqiN+u
         qQNzyiec3KRhgxJj5JNnPabHRk1MItkwIGNL6xdGQOIcr30FdB+2IZ7Juv1dKehTw+i7
         LZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEyd0fTbwnGq1j4mR/39y5YMzLAxT1RpmVEZDz9Z3mQ=;
        b=jcpPRgKQTRxnVuXrE1SKbv8uFC4SIwlr63+KDS09uiOAG6O4eiXUF7f7vhpoEr4G0J
         6WSkJVZ/XwH/88qdDRIJIxInwgNGIUF+984kv6N2i9csShETRF/8IoY+WDv0cDiLj2Fj
         DImm2+zGD0Ds0+sqxbmIFMm22euDw7tka1sDmd0ouUOwrFQsypfglKi6JYfPyt9cUwYF
         HVYtDKmk/rJkGbQqTZLB2IrqKOZWxGV79e3C1qq989pqujv90GN3sVv1kUvaGLvahW8J
         GclpV6ZTtpH+nrMGXkRkpy7lyjfSvp03kSjrQVGp80epInTx4w+KsDbPp94kwluFIVqn
         TTAg==
X-Gm-Message-State: AOAM533SkoVd/DyF6BVIYsIZC8pQnTFu3XCBHcPk/+eTtNQ2BteDFrar
        SEVZcr8X+f/zfFswNGWAtuaGZDdOWbLsS2ZLGnw5
X-Google-Smtp-Source: ABdhPJzwGQVgSAUDzKVyYnWsWrBgImjNghWSIyNpihdQ+CtpZg46PPEIPEhw7F5Lf3VKyq4jbX1AyUqbcClsH0NP+o8=
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr647617eds.269.1603243047445;
 Tue, 20 Oct 2020 18:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201020191732.4049987-1-salyzyn@android.com> <20201020191732.4049987-2-salyzyn@android.com>
In-Reply-To: <20201020191732.4049987-2-salyzyn@android.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Oct 2020 21:17:16 -0400
Message-ID: <CAHC9VhTZitGFRCnRgLJLNUnFEhM0kp7E_51No1aam3CRf-WCpg@mail.gmail.com>
Subject: Re: [PATCH v17 1/4] Add flags option to get xattr method paired to __vfs_getxattr
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Sterba <dsterba@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 20, 2020 at 3:17 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Add a flag option to get xattr method that could have a bit flag of
> XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
> set in the __vfs_getxattr path when called by security
> infrastructure.
>
> This handles the case of a union filesystem driver that is being
> requested by the security layer to report back the xattr data.
>
> For the use case where access is to be blocked by the security layer.
>
> The path then could be security(dentry) ->
> __vfs_getxattr(dentry...XATTR_NOSECURITY) ->
> handler->get(dentry...XATTR_NOSECURITY) ->
> __vfs_getxattr(lower_dentry...XATTR_NOSECURITY) ->
> lower_handler->get(lower_dentry...XATTR_NOSECURITY)
> which would report back through the chain data and success as
> expected, the logging security layer at the top would have the
> data to determine the access permissions and report back the target
> context that was blocked.
>
> Without the get handler flag, the path on a union filesystem would be
> the errant security(dentry) -> __vfs_getxattr(dentry) ->
> handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
> security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
> which would report back through the chain no data, and -EACCES.
>
> For selinux for both cases, this would translate to a correctly
> determined blocked access. In the first case with this change a correct avc
> log would be reported, in the second legacy case an incorrect avc log
> would be reported against an uninitialized u:object_r:unlabeled:s0
> context making the logs cosmetically useless for audit2allow.
>
> This patch series is inert and is the wide-spread addition of the
> flags option for xattr functions, and a replacement of __vfs_getxattr
> with __vfs_getxattr(...XATTR_NOSECURITY).
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Jan Kara <jack@suse.cz>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: David Sterba <dsterba@suse.com>
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> Acked-by: Mike Marshall <hubcap@omnibond.com>
> To: linux-fsdevel@vger.kernel.org
> To: linux-unionfs@vger.kernel.org
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com

...

> diff --git a/fs/xattr.c b/fs/xattr.c
> index cd7a563e8bcd..d6bf5a7e2420 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -345,7 +345,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
>                 return PTR_ERR(handler);
>         if (!handler->get)
>                 return -EOPNOTSUPP;
> -       error = handler->get(handler, dentry, inode, name, NULL, 0);
> +       error = handler->get(handler, dentry, inode, name, NULL, 0, 0);
>         if (error < 0)
>                 return error;
>
> @@ -356,32 +356,20 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
>                 memset(value, 0, error + 1);
>         }
>
> -       error = handler->get(handler, dentry, inode, name, value, error);
> +       error = handler->get(handler, dentry, inode, name, value, error, 0);
>         *xattr_value = value;
>         return error;
>  }
>
>  ssize_t
>  __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
> -              void *value, size_t size)
> +              void *value, size_t size, int flags)
>  {
>         const struct xattr_handler *handler;
> -
> -       handler = xattr_resolve_name(inode, &name);
> -       if (IS_ERR(handler))
> -               return PTR_ERR(handler);
> -       if (!handler->get)
> -               return -EOPNOTSUPP;
> -       return handler->get(handler, dentry, inode, name, value, size);
> -}
> -EXPORT_SYMBOL(__vfs_getxattr);
> -
> -ssize_t
> -vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
> -{
> -       struct inode *inode = dentry->d_inode;
>         int error;
>
> +       if (flags & XATTR_NOSECURITY)
> +               goto nolsm;
>         error = xattr_permission(inode, name, MAY_READ);
>         if (error)
>                 return error;
> @@ -403,7 +391,19 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
>                 return ret;
>         }
>  nolsm:
> -       return __vfs_getxattr(dentry, inode, name, value, size);
> +       handler = xattr_resolve_name(inode, &name);
> +       if (IS_ERR(handler))
> +               return PTR_ERR(handler);
> +       if (!handler->get)
> +               return -EOPNOTSUPP;
> +       return handler->get(handler, dentry, inode, name, value, size, flags);
> +}
> +EXPORT_SYMBOL(__vfs_getxattr);
> +
> +ssize_t
> +vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
> +{
> +       return __vfs_getxattr(dentry, dentry->d_inode, name, value, size, 0);
>  }
>  EXPORT_SYMBOL_GPL(vfs_getxattr);

[NOTE: added the SELinux list to the CC line]

I'm looking at this patchset in earnest for the first time and I'm a
little uncertain about the need for the new XATTR_NOSECURITY flag;
perhaps you can help me understand it better.  Looking over this
patch, and quickly looking at the others in the series, it seems as
though XATTR_NOSECURITY is basically used whenever a filesystem has to
call back into the vfs layer (e.g. overlayfs, ecryptfs, etc).  Am I
understanding that correctly?  If that assumption is correct, I'm not
certain why the new XATTR_NOSECURITY flag is needed; why couldn't
_vfs_getxattr() be used by all of the callers that need to bypass
DAC/MAC with vfs_getxattr() continuing to perform the DAC/MAC checks?
If for some reason _vfs_getxattr() can't be used, would it make more
sense to create a new stripped/special getxattr function for use by
nested filesystems?  Based on the number of revisions to this
patchset, I'm sure it can't be that simple so please educate me :)

-- 
paul moore
www.paul-moore.com
