Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292BC38A02
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Oct 2022 00:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJZALP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZALO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 20:11:14 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6573B8C15
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 17:11:12 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DFC7286A; Tue, 25 Oct 2022 19:11:10 -0500 (CDT)
Date:   Tue, 25 Oct 2022 19:11:10 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, paul@paul-moore.com, jmorris@namei.org,
        ebiederm@xmission.com, brauner@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] security: commoncap: fix potential memleak on error
 path from vfs_getxattr_alloc
Message-ID: <20221026001110.GA12167@mail.hallyn.com>
References: <20221025133357.2404086-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025133357.2404086-1-cuigaosheng1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 09:33:57PM +0800, Gaosheng Cui wrote:
> In cap_inode_getsecurity(), we will use vfs_getxattr_alloc() to
> complete the memory allocation of tmpbuf, if we have completed
> the memory allocation of tmpbuf, but failed to call handler->get(...),
> there will be a memleak in below logic:
> 
>   |-- ret = (int)vfs_getxattr_alloc(mnt_userns, ...)  <-- alloc for tmpbuf
>     |-- value = krealloc(*xattr_value, error + 1, flags)  <-- alloc memory
>     |-- error = handler->get(handler, ...)  <-- if error
>     |-- *xattr_value = value <-- xattr_value is &tmpbuf  <-- memory leak
> 
> So we will try to free(tmpbuf) after vfs_getxattr_alloc() fails to fix it.
> 
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")

Acked-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2:
> - Update the Fixes tag, from 71bc356f93a1 to 8db6c34f1dbc. Thanks!
>  security/commoncap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5fc8986c3c77..bc751fa5adad 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -401,8 +401,10 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>  				      &tmpbuf, size, GFP_NOFS);
>  	dput(dentry);
>  
> -	if (ret < 0 || !tmpbuf)
> -		return ret;
> +	if (ret < 0 || !tmpbuf) {
> +		size = ret;
> +		goto out_free;
> +	}
>  
>  	fs_ns = inode->i_sb->s_user_ns;
>  	cap = (struct vfs_cap_data *) tmpbuf;
> -- 
> 2.25.1
