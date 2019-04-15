Return-Path: <SRS0=ZVpt=SR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F7C10F0E
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Apr 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA528206B6
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Apr 2019 10:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfDOKuK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:50:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOKuK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Apr 2019 06:50:10 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hFzBd-0005YG-Mk; Mon, 15 Apr 2019 12:50:05 +0200
Date:   Mon, 15 Apr 2019 12:50:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     tglx@linutronix.de
Subject: Re: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20190415105005.t6omvm5irdjhzbfs@linutronix.de>
References: <20190405133458.4809-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405133458.4809-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-04-05 15:34:57 [+0200], To linux-security-module@vger.kernel.org wrote:
> The get_buffers() macro may provide one or two buffers to the caller.
> Those buffers are preallocated on init for each CPU. By default it
> allocates
> 	2* 2 * MAX_PATH * POSSIBLE_CPU
> 
> which equals 64KiB on a system with 4 CPUs or 1MiB with 64 CPUs and so
> on.
> 
> Replace the per-CPU buffers with a common memory pool which is shared
> across all CPUs. The pool grows on demand and never shrinks.
> By using this pool it is possible to request a buffer and keeping
> preemption enabled which avoids the hack in profile_transition().
> 
> During light testing I didn't get more than two buffers in total with
> this patch. So it seems to make sense to allocate the buffers on demand
> and keep them for further use for a quick access.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

a gentle ping.

Sebastian
