Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8308C7EE22
	for <linux-security-module@archiver.kernel.org>; Thu, 11 May 2023 05:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjEKFbc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 May 2023 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjEKFb2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 May 2023 01:31:28 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 22:31:24 PDT
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4AFE65
        for <linux-security-module@vger.kernel.org>; Wed, 10 May 2023 22:31:24 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1804045D; Thu, 11 May 2023 00:25:27 -0500 (CDT)
Date:   Thu, 11 May 2023 00:25:27 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] capability: fix kernel-doc warnings in capability.c
Message-ID: <20230511052527.GA115075@mail.hallyn.com>
References: <20230511012715.3692211-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511012715.3692211-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 11, 2023 at 09:27:15AM +0800, Gaosheng Cui wrote:
> Fix all kernel-doc warnings in capability.c:
> 
> kernel/capability.c:477: warning: Function parameter or member 'idmap'
> not described in 'privileged_wrt_inode_uidgid'
> kernel/capability.c:493: warning: Function parameter or member 'idmap'
> not described in 'capable_wrt_inode_uidgid'
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  kernel/capability.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 3e058f41df32..1a2795102ae4 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -467,6 +467,7 @@ EXPORT_SYMBOL(file_ns_capable);
>  /**
>   * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
>   * @ns: The user namespace in question
> + * @idmap: idmap of the mount @inode was found from
>   * @inode: The inode in question
>   *
>   * Return true if the inode uid and gid are within the namespace.
> @@ -481,6 +482,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
>  
>  /**
>   * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
> + * @idmap: idmap of the mount @inode was found from
>   * @inode: The inode in question
>   * @cap: The capability in question
>   *
> -- 
> 2.25.1
