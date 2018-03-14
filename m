From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 14 Mar 2018 06:04:18 -0700
Subject: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
In-Reply-To: <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
	<20180314115653.GD29631@bombadil.infradead.org>
	<8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
Message-ID: <20180314130418.GG29631@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 14, 2018 at 02:55:10PM +0200, Igor Stoppa wrote:
> >  The page_frag allocator seems like a much better place to
> > start than genalloc.  It has a significantly lower overhead and is
> > much more suited to the kind of probably-identical-lifespan that the
> > pmalloc API is going to persuade its users to have.
> 
> Could you please provide me a pointer?
> I did a quick search on 4.16-rc5 and found the definition of page_frag
> and sk_page_frag(). Is this what you are referring to?

It's a blink-and-you'll-miss-it allocator buried deep in mm/page_alloc.c:
void *page_frag_alloc(struct page_frag_cache *nc,
                      unsigned int fragsz, gfp_t gfp_mask)
void page_frag_free(void *addr)

I don't necessarily think you should use it as-is, but the principle it uses
seems like a better match to me than the rather complex genalloc.  Just
allocate some pages and track the offset within those pages that is the
current allocation point.  It's less than 100 lines of code!
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
