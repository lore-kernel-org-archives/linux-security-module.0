Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5CC43334
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Jul 2022 14:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiGWODv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Jul 2022 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiGWODl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Jul 2022 10:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7118352;
        Sat, 23 Jul 2022 07:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27411B80933;
        Sat, 23 Jul 2022 14:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446A9C341C0;
        Sat, 23 Jul 2022 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658585016;
        bh=XqGMGbWcq/P/xI62FKVCA6GKm6TlYQEjhChvhcH8c6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2v4Ogmb1fTi6SwT/Cl8Yh7GOWTfgYMWnRtwFzv4NkzAvLBEQ4id717IHS/adN5rmh
         ScFUmUAENhzejbd4i51Tmupu3c2iNmwZxV75dfibaN3amEb+eP2d10ZlngTPGZVDpV
         tHnNtGv970qVPIm8c6jnOVFxSNJyNyM8ylAXKHOA=
Date:   Sat, 23 Jul 2022 16:03:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <Ytv/tUrdK1ZTn4Uk@kroah.com>
References: <20220723135447.199557-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723135447.199557-1-code@siddh.me>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jul 23, 2022 at 07:24:47PM +0530, Siddh Raman Pant via Linux-kernel-mentees wrote:
> If not done, a reference to a freed pipe remains in the watch_queue,
> as this function is called before freeing a pipe in free_pipe_info()
> (see line 834 of fs/pipe.c).
> 
> This causes a UAF when post_one_notification tries to access the pipe on
> a key update, which is reported by syzbot.
> 
> Bug report: https://syzkaller.appspot.com/bug?id=1870dd7791ba05f2ea7f47f7cbdde701173973fc
> Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  kernel/watch_queue.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index bb9962b33f95..bab9e09c74cf 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -637,8 +637,17 @@ void watch_queue_clear(struct watch_queue *wqueue)
>  		spin_lock_bh(&wqueue->lock);
>  	}
>  
> -	spin_unlock_bh(&wqueue->lock);
>  	rcu_read_unlock();
> +
> +	/* Clearing the watch queue, so we should clean the associated pipe. */
> +#ifdef CONFIG_WATCH_QUEUE

You should not use #ifdef in .c files, it's unmaintainable over time.

thanks,

greg k-h
