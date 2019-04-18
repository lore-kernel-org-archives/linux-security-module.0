Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C0BC10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 22:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0E20693
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IDIcj4x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfDRWHn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:07:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45222 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfDRWHm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 18:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pG9se1HaWlSZ+DXQi3Pi/3sZPJFsOD15gEOGUdPXO4o=; b=IDIcj4x9mvvPQTrQYXHpVzGU1p
        TzVdpyBuYpJkySI/wzdvMv3FcoMnHL9MGh3smBmNL7zALHBhmjrp6XbCk0k4du7mnrO6Krcbx6/Aq
        b29+oedPRaIkarM/ioIejZadcm6Qn+/nv2moO1bTXWiZ+RBgGhRTg3ePo6hdvREzuXmvqxaQ51mbQ
        i7pxA8NZM8MWRlRUC6DoIgPksF9vO5pS0ebCNvVk9Atzyf0ylwheZRNh5bokHlMSzqGmCJFSI28z4
        3HzdVSLTQ74L80eu1V5PkpQ1kR2JlHTYYh8rGH47EQLKtBW93CsFHXouq5xWLnCbqu0iAP4NZ1/mO
        1vP6l9zQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHFBz-0007OA-IP; Thu, 18 Apr 2019 22:07:39 +0000
Subject: Re: [PATCH 0/3] RFC: add init_allocations=1 boot option
To:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        cl@linux.com, dvyukov@google.com, keescook@chromium.org,
        labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20190418154208.131118-1-glider@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79967fc5-fd7b-b16d-8ff7-0847396ff4f5@infradead.org>
Date:   Thu, 18 Apr 2019 15:07:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418154208.131118-1-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> Following the recent discussions here's another take at initializing
> pages and heap objects with zeroes. This is needed to prevent possible
> information leaks and make the control-flow bugs that depend on
> uninitialized values more deterministic.
> 
> The patchset introduces a new boot option, init_allocations, which
> makes page allocator and SL[AOU]B initialize newly allocated memory.
> init_allocations=0 doesn't (hopefully) add any overhead to the
> allocation fast path (no noticeable slowdown on hackbench).
> 
> With only the the first of the proposed patches the slowdown numbers are:
>  - 1.1% (stdev 0.2%) sys time slowdown building Linux kernel
>  - 3.1% (stdev 0.3%) sys time slowdown on af_inet_loopback benchmark
>  - 9.4% (stdev 0.5%) sys time slowdown on hackbench
> 
> The second patch introduces a GFP flag that allows to disable
> initialization for certain allocations. The third page is an example of

                                              third patch

> applying it to af_unix.c, which helps hackbench greatly.
> 
> Slowdown numbers for the whole patchset are:
>  - 1.8% (stdev 0.8%) on kernel build
>  - 6.5% (stdev 0.2%) on af_inet_loopback
>  - 0.12% (stdev 0.6%) on hackbench
> 
> 
> Alexander Potapenko (3):
>   mm: security: introduce the init_allocations=1 boot option
>   gfp: mm: introduce __GFP_NOINIT
>   net: apply __GFP_NOINIT to AF_UNIX sk_buff allocations
> 
>  drivers/infiniband/core/uverbs_ioctl.c |  2 +-
>  include/linux/gfp.h                    |  6 ++++-
>  include/linux/mm.h                     |  8 +++++++
>  include/linux/slab_def.h               |  1 +
>  include/linux/slub_def.h               |  1 +
>  include/net/sock.h                     |  5 +++++
>  kernel/kexec_core.c                    |  4 ++--
>  mm/dmapool.c                           |  2 +-
>  mm/page_alloc.c                        | 18 ++++++++++++++-
>  mm/slab.c                              | 14 ++++++------
>  mm/slab.h                              |  1 +
>  mm/slab_common.c                       | 15 +++++++++++++
>  mm/slob.c                              |  3 ++-
>  mm/slub.c                              |  9 ++++----
>  net/core/sock.c                        | 31 +++++++++++++++++++++-----
>  net/unix/af_unix.c                     | 13 ++++++-----
>  16 files changed, 104 insertions(+), 29 deletions(-)
> 


-- 
~Randy
