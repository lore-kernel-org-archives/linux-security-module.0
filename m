Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF345EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 17:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFSR5Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSR5P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 13:57:15 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989312A;
        Mon, 19 Jun 2023 10:57:12 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 808C4518; Mon, 19 Jun 2023 12:57:10 -0500 (CDT)
Date:   Mon, 19 Jun 2023 12:57:10 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] capabilities: fix sparse warning about __user access
Message-ID: <20230619175710.GA200481@mail.hallyn.com>
References: <20230619123535.324632-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619123535.324632-1-ben.dooks@codethink.co.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 19, 2023 at 01:35:35PM +0100, Ben Dooks wrote:
> The two syscalls for capget and capset are producing sparse warnings
> as sparse is thinking that the "struct __user_cap_data_struct" is marked
> user, which seems to be down to the declaration and typedef at the same
> time.
> 
> Fix the following warnings by splutting the struct declaration and then
> the user typedef into two:

I'm not a fan of making code changes to work around scanners'
shortcomings, mainly because eventually I assume the scanners
will learn to deal with it.

However, I don't like the all-in-one typedef+struct definition
either, so let's go with it :)

Paul, do you mind picking this up?

thanks,
-serge

> kernel/capability.c:191:35: warning: incorrect type in argument 2 (different address spaces)
> kernel/capability.c:191:35:    expected void const *from
> kernel/capability.c:191:35:    got struct __user_cap_data_struct [noderef] __user *
> kernel/capability.c:168:14: warning: dereference of noderef expression
> kernel/capability.c:168:45: warning: dereference of noderef expression
> kernel/capability.c:169:14: warning: dereference of noderef expression
> kernel/capability.c:169:45: warning: dereference of noderef expression
> kernel/capability.c:170:14: warning: dereference of noderef expression
> kernel/capability.c:170:45: warning: dereference of noderef expression
> kernel/capability.c:244:29: warning: incorrect type in argument 1 (different address spaces)
> kernel/capability.c:244:29:    expected void *to
> kernel/capability.c:244:29:    got struct __user_cap_data_struct [noderef] __user ( * )[2]
> kernel/capability.c:247:42: warning: dereference of noderef expression
> kernel/capability.c:247:64: warning: dereference of noderef expression
> kernel/capability.c:248:42: warning: dereference of noderef expression
> kernel/capability.c:248:64: warning: dereference of noderef expression
> kernel/capability.c:249:42: warning: dereference of noderef expression
> kernel/capability.c:249:64: warning: dereference of noderef expression
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  include/uapi/linux/capability.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 3d61a0ae055d..5bb906098697 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -41,11 +41,12 @@ typedef struct __user_cap_header_struct {
>  	int pid;
>  } __user *cap_user_header_t;
>  
> -typedef struct __user_cap_data_struct {
> +struct __user_cap_data_struct {
>          __u32 effective;
>          __u32 permitted;
>          __u32 inheritable;
> -} __user *cap_user_data_t;
> +};
> +typedef struct __user_cap_data_struct __user *cap_user_data_t;
>  
>  
>  #define VFS_CAP_REVISION_MASK	0xFF000000
> -- 
> 2.39.2
