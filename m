Return-Path: <SRS0=FyGa=TC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2AC43219
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0152120652
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 13:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBNrg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 May 2019 09:47:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBNrg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 May 2019 09:47:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hMC3e-0008Gb-Vm; Thu, 02 May 2019 15:47:31 +0200
Date:   Thu, 2 May 2019 15:47:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
Subject: Re: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20190502134730.d3ya46ave6a7bvom@linutronix.de>
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
 <20190430144725.gd6r3aketxuqdyir@linutronix.de>
 <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
 <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-05-02 22:17:35 [+0900], Tetsuo Handa wrote:
> There is 'The "too small to fail" memory-allocation rule'
> ( https://lwn.net/Articles/627419/ ) where GFP_KERNEL allocation for
> size <= 32768 bytes never fails unless current thread was killed by
> the OOM killer. This means that kmalloc() in
> 
> +char *aa_get_buffer(void)
> +{
> +	union aa_buffer *aa_buf;
> +
> +try_again:
> +	spin_lock(&aa_buffers_lock);
> +	if (!list_empty(&aa_global_buffers)) {
> +		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
> +					  list);
> +		list_del(&aa_buf->list);
> +		spin_unlock(&aa_buffers_lock);
> +		return &aa_buf->buffer[0];
> +	}
> +	spin_unlock(&aa_buffers_lock);
> +
> +	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL);
> +	if (WARN_ON_ONCE(!aa_buf))
> +		goto try_again;
> +	return &aa_buf->buffer[0];
> +}
> 
> can't return NULL unless current thread was killed by the OOM killer
> if aa_g_path_max <= 32768. On the other hand, if aa_g_path_max > 32768,
> this allocation can easily fail, and retrying forever is very bad.

as I pointed out in the other email, it shouldn't retry forever because
we should have something in the pool which will be returned.

> If current thread was killed by the OOM killer, current thread should be
> able to bail out without retrying. If allocation can never succeed (e.g.
> aa_g_path_max == 1073741824 was specified), we must bail out.

okay. That is obviously too much and we would loop, indeed.

> By the way, did you really test your patch?

I booted Debian on a 112 core which has apparmor enabled and debian
ships a few profiles. And then I used the box for a while.

> > @@ -1399,6 +1404,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
> >  		return -EPERM;
> >  
> >  	error = param_set_uint(val, kp);
> > +	aa_g_path_max = min_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));
> 
> I think that this will guarantee that aa_g_path_max <= sizeof(struct list_head)
> which is too small to succeed. :-(

Ach right, this should have been max instead of min. Btw: are there any
sane upper/lower limits while at it?

> >  	pr_info("AppArmor: buffer size set to %d bytes\n", aa_g_path_max);
> >  
> >  	return error;

Sebastian
