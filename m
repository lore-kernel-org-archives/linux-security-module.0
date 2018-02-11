From: willy@infradead.org (Matthew Wilcox)
Date: Sun, 11 Feb 2018 13:16:46 -0800
Subject: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <20180211031920.3424-4-igor.stoppa@huawei.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-4-igor.stoppa@huawei.com>
Message-ID: <20180211211646.GC4680@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Feb 11, 2018 at 05:19:17AM +0200, Igor Stoppa wrote:
> The struct page has a "mapping" field, which can be re-used, to store a
> pointer to the parent area. This will avoid more expensive searches.
> 
> As example, the function find_vm_area is reimplemented, to take advantage
> of the newly introduced field.

Umm.  Is it more efficient?  You're replacing an rb-tree search with a
page-table walk.  You eliminate a spinlock, which is great, but is the
page-table walk more efficient?  I suppose it'll depend on the depth of
the rb-tree, and (at least on x86), the page tables should already be
in cache.

Unrelated to this patch, I'm working on a patch to give us page_type,
and I think I'll allocate a bit to mark pages which are vmalloced.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
