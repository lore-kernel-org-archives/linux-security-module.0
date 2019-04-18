Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05674C10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38A721479
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfDRQwW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:52:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:25973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbfDRQwW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 12:52:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 09:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="292660378"
Received: from ray.jf.intel.com (HELO [10.7.201.126]) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2019 09:52:21 -0700
Subject: Re: [PATCH 2/3] gfp: mm: introduce __GFP_NOINIT
To:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        cl@linux.com, dvyukov@google.com, keescook@chromium.org,
        labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20190418154208.131118-1-glider@google.com>
 <20190418154208.131118-3-glider@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <7bf6bd62-c8e0-df3d-8e98-70063f2d175a@intel.com>
Date:   Thu, 18 Apr 2019 09:52:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418154208.131118-3-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> __GFP_NOINIT basically defeats the hardening against information leaks
> provided by the init_allocations feature, so one should use it with
> caution.

Even more than that, shouldn't we try to use it only in places where
there is a demonstrated benefit, like performance data?

> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be84f5f95c97..f9d1f1236cd0 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -302,7 +302,7 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
>  {
>  	struct page *pages;
>  
> -	pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
> +	pages = alloc_pages((gfp_mask & ~__GFP_ZERO) | __GFP_NOINIT, order);
>  	if (pages) {
>  		unsigned int count, i;

While this is probably not super security-sensitive, it's also not
performance sensitive.

> diff --git a/mm/slab.c b/mm/slab.c
> index dcc5b73cf767..762cb0e7bcc1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1393,7 +1393,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  	struct page *page;
>  	int nr_pages;
>  
> -	flags |= cachep->allocflags;
> +	flags |= (cachep->allocflags | __GFP_NOINIT);
>  
>  	page = __alloc_pages_node(nodeid, flags, cachep->gfporder);
>  	if (!page) {
> diff --git a/mm/slob.c b/mm/slob.c
> index 18981a71e962..867d2d68a693 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -192,6 +192,7 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
>  {
>  	void *page;
>  
> +	gfp |= __GFP_NOINIT;
>  #ifdef CONFIG_NUMA
>  	if (node != NUMA_NO_NODE)
>  		page = __alloc_pages_node(node, gfp, order
> diff --git a/mm/slub.c b/mm/slub.c
> index e4efb6575510..a79b4cb768a2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1493,6 +1493,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,
>  	struct page *page;
>  	unsigned int order = oo_order(oo);
>  
> +	flags |= __GFP_NOINIT;
>  	if (node == NUMA_NO_NODE)
>  		page = alloc_pages(flags, order);
>  	else
> 

These sl*b ones seem like a bad idea.  We already have rules that sl*b
allocations must be initialized by callers, and we have reasonably
frequent bugs where the rules are broken.

Setting __GFP_NOINIT might be reasonable to do, though, for slabs that
have a constructor.  We have much higher confidence that *those* are
going to get initialized properly.
