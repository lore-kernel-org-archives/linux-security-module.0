Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15061C7EE24
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jun 2023 03:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFFD3A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Jun 2023 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFD3A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Jun 2023 23:29:00 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1708711B;
        Mon,  5 Jun 2023 20:28:46 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id C18AD1D20; Mon,  5 Jun 2023 22:28:44 -0500 (CDT)
Date:   Mon, 5 Jun 2023 22:28:44 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH] capability: erase checker warnings about struct
 __user_cap_data_struct
Message-ID: <20230606032844.GA628899@mail.hallyn.com>
References: <20230602054527.290696-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602054527.290696-1-gongruiqi@huaweicloud.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 02, 2023 at 01:45:27PM +0800, GONG, Ruiqi wrote:
> Currently Sparse warns the following when compiling kernel/capability.c:
> 
> kernel/capability.c:191:35: warning: incorrect type in argument 2 (different address spaces)
> kernel/capability.c:191:35:    expected void const *from
> kernel/capability.c:191:35:    got struct __user_cap_data_struct [noderef] __user *
> kernel/capability.c:168:14: warning: dereference of noderef expression
> ...... (multiple noderef warnings on different locations)
> kernel/capability.c:244:29: warning: incorrect type in argument 1 (different address spaces)
> kernel/capability.c:244:29:    expected void *to
> kernel/capability.c:244:29:    got struct __user_cap_data_struct [noderef] __user ( * )[2]
> kernel/capability.c:247:42: warning: dereference of noderef expression
> ...... (multiple noderef warnings on different locations)
> 
> It seems that defining `struct __user_cap_data_struct` together with
> `cap_user_data_t` make Sparse believe that the struct is `noderef` as
> well. Separate their definitions to clarify their respective attributes.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Seems ok.

There's still so much noise in the make C=2 output even just for
kernel/capability.c that I'm not sure it's worth it, but no
objection.

Acked-by: Serge Hallyn <serge@hallyn.com>

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
> 2.25.1
