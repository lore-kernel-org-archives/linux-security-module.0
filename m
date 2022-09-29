Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B918CC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 10:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiI2Kvd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 06:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2Kvd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 06:51:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3AAD9BA;
        Thu, 29 Sep 2022 03:51:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EAA5568BFE; Thu, 29 Sep 2022 12:51:28 +0200 (CEST)
Date:   Thu, 29 Sep 2022 12:51:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 23/29] xattr: use posix acl api
Message-ID: <20220929105128.GA16410@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-24-brauner@kernel.org> <20220929082535.GC3699@lst.de> <20220929091027.ddw6kbdy2s7ywvh4@wittgenstein> <20220929094623.ajw7kauqwwwovd44@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094623.ajw7kauqwwwovd44@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 29, 2022 at 11:46:23AM +0200, Christian Brauner wrote:
> +int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +	       struct xattr_ctx *ctx)

I'd just pass name, value an size instead of this weird context thing,
same for the read size.  Otherwise this looks fine, though.

> index 84180afd090b..b766ddfc6bc3 100644
> --- a/io_uring/xattr.c
> +++ b/io_uring/xattr.c
> @@ -8,6 +8,7 @@
>  #include <linux/namei.h>
>  #include <linux/io_uring.h>
>  #include <linux/xattr.h>
> +#include <linux/posix_acl_xattr.h>

This looks spurious.

