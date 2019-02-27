Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84309C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE66213A2
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfB0UZN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:25:13 -0500
Received: from namei.org ([65.99.196.166]:54458 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfB0UZN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 15:25:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1RKP9F1008610;
        Wed, 27 Feb 2019 20:25:09 GMT
Date:   Thu, 28 Feb 2019 07:25:09 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] tomoyo: Change pathname calculation for read-only
 filesystems.
In-Reply-To: <1551277164-8715-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1902280724410.7990@namei.org>
References: <1551277164-8715-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 27 Feb 2019, Tetsuo Handa wrote:

> Commit 5625f2e3266319fd ("TOMOYO: Change pathname for non-rename()able
> filesystems.") intended to be applied to filesystems where the content is
> not controllable from the userspace (e.g. proc, sysfs, securityfs), based
> on an assumption that such filesystems do not support rename() operation.
> 
> But it turned out that read-only filesystems also do not support rename()
> operation despite the content is controllable from the userspace, and that
> commit is annoying TOMOYO users who want to use e.g. squashfs as the root
> filesystem due to use of local name which does not start with '/'.
> 
> Therefore, based on an assumption that filesystems which require the
> device argument upon mount() request is an indication that the content
> is controllable from the userspace, do not use local name if a filesystem
> does not support rename() operation but requires the device argument upon
> mount() request.

I'd definitely like Al's input on this.

> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/realpath.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
> index 85e6e31..e7832448 100644
> --- a/security/tomoyo/realpath.c
> +++ b/security/tomoyo/realpath.c
> @@ -295,7 +295,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
>  		 * or dentry without vfsmount.
>  		 */
>  		if (!path->mnt ||
> -		    (!inode->i_op->rename))
> +		    (!inode->i_op->rename &&
> +		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
>  			pos = tomoyo_get_local_path(path->dentry, buf,
>  						    buf_len - 1);
>  		/* Get absolute name for the rest. */
> 

-- 
James Morris
<jmorris@namei.org>

