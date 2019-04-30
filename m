Return-Path: <SRS0=l2r+=TA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE013C43219
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E562147A
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfD3Ora (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:47:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3Or3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 10:47:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLU2X-0001yV-HS; Tue, 30 Apr 2019 16:47:25 +0200
Date:   Tue, 30 Apr 2019 16:47:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
Subject: Re: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20190430144725.gd6r3aketxuqdyir@linutronix.de>
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-04-28 16:56:59 [-0700], John Johansen wrote:
> So digging into why the history of the per cpu buffers in apparmor.
> We used to do buffer allocations via kmalloc and there were a few reasons
> for the switch 
> 
> * speed/lockless: speaks for it self, mediation is already slow enough

it is shared among all CPUs but it is a small/quick operation to
add/return a buffer.

> * some buffer allocations had to be done with GFP_ATOMIC, making them
>   more likely to fail. Since we fail closed that means failure would
>   block access. This actually became a serious problem in a couple
>   places. Switching to per cpu buffers and blocking pre-empt was
>   the solution.

GFP_KERNEL is allowed to use IO/SWAP and ATOMIC has emergency pools. The
new approach won't return a NULL pointer, simply spin to either allocate
new memory or get one which was just returned.

> * in heavy use cases we would see a lot of buffers being allocated
>   and freed. Which resulted in locking slow downs and also buffer
>   allocation failures. So having the buffers preallocated allowed us
>   to bound this potential problem.
> 
> This was all 6 years ago. Going to a mem pool certainly could help,
> reduce the memory foot print, and would definitely help with
> preempt/real time kernels.
> 
> A big concern with this patchset is reverting back to GFP_KERNEL
> for everything. We definitely were getting failures due to allocations
> in atomic context. There have been lots of changes in the kernel over
> the last six years so it possible these cases don't exist anymore. I
> went through and built some kernels with this patchset and have run
> through some testing without tripping that problem but I don't think
> it has seen enough testing yet.

Do you want apply #1 now and #2 later? I audited the ATOMIC->KERNEL
changes manually and I didn't see any atomic context. It looked like the
only reason for ATOMIC was the preempt_disable() due to the memory pool.

Sebastian
