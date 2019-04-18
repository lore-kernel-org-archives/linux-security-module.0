Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D7C10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 22:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521D220693
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 22:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O4nOZ1ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfDRWIj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:08:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfDRWIj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 18:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b6tmuUkZe+DtpkR/zgdgO+AIem8MXOPJbKQ2qk7t24Q=; b=O4nOZ1akpkIJOV8mffrDymL9iE
        CDfASismBTa7bxM6DgR7c5zCSI2qfxWYoMg9qA//sfz9KJX9JmaE+vKRlk/7Wd2q081Eg8meJ3dE9
        00lEyFLRiEjXksPny/LhMKUVKtmzlnCsK1Iin1aOJ8JHQA13P4jWINk0Vx/R+4wFLnz9fKC6mvdIx
        vIvJBY6k+pvYrgQ5hz+MOv4k9wRmtLiKC1E+b5m8Dy+LjlEX034bJBI/WoelDIpTrvZ+4GX0tBGoT
        bN5QgQbvDxoPbF5ejvON9jQoWaukWILfXD7/mcOoGPYvgI/IQTIFGId/C0i80WAnQqw+3NsuzXg2Z
        cRqv7rWg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHFCw-0007Oc-LL; Thu, 18 Apr 2019 22:08:38 +0000
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot
 option
To:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        cl@linux.com, dvyukov@google.com, keescook@chromium.org,
        labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20190418154208.131118-1-glider@google.com>
 <20190418154208.131118-2-glider@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff1f408b-cf37-7df0-2393-7bc2078f6c63@infradead.org>
Date:   Thu, 18 Apr 2019 15:08:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418154208.131118-2-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> This option adds the possibility to initialize newly allocated pages and
> heap objects with zeroes. This is needed to prevent possible information
> leaks and make the control-flow bugs that depend on uninitialized values
> more deterministic.
> 
> Initialization is done at allocation time at the places where checks for
> __GFP_ZERO are performed. We don't initialize slab caches with
> constructors to preserve their semantics. To reduce runtime costs of
> checking cachep->ctor we replace a call to memset with a call to
> cachep->poison_fn, which is only executed if the memory block needs to
> be initialized.
> 
> For kernel testing purposes filling allocations with a nonzero pattern
> would be more suitable, but may require platform-specific code. To have
> a simple baseline we've decided to start with zero-initialization.
> 
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  drivers/infiniband/core/uverbs_ioctl.c |  2 +-
>  include/linux/mm.h                     |  8 ++++++++
>  include/linux/slab_def.h               |  1 +
>  include/linux/slub_def.h               |  1 +
>  kernel/kexec_core.c                    |  2 +-
>  mm/dmapool.c                           |  2 +-
>  mm/page_alloc.c                        | 18 +++++++++++++++++-
>  mm/slab.c                              | 12 ++++++------
>  mm/slab.h                              |  1 +
>  mm/slab_common.c                       | 15 +++++++++++++++
>  mm/slob.c                              |  2 +-
>  mm/slub.c                              |  8 ++++----
>  net/core/sock.c                        |  2 +-
>  13 files changed, 58 insertions(+), 16 deletions(-)
> 

Hi,
Please document init_allocations=N in Documentation/admin-guide/kernel-parameters.txt.

thanks.
-- 
~Randy
