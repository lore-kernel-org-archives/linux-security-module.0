From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 25 Jan 2018 21:35:42 -0800
Subject: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
	<20180124175631.22925-5-igor.stoppa@huawei.com>
	<CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
Message-ID: <20180126053542.GA30189@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 24, 2018 at 08:10:53PM +0100, Jann Horn wrote:
> I'm not entirely convinced by the approach of marking small parts of
> kernel memory as readonly for hardening.

It depends how significant the data stored in there are.  For example,
storing function pointers in read-only memory provides significant
hardening.

> You're allocating with vmalloc(), which, as far as I know, establishes
> a second mapping in the vmalloc area for pages that are already mapped
> as RW through the physmap. AFAICS, later, when you're trying to make
> pages readonly, you're only changing the protections on the second
> mapping in the vmalloc area, therefore leaving the memory writable
> through the physmap. Is that correct? If so, please either document
> the reasoning why this is okay or change it.

Yes, this is still vulnerable to attacks through the physmap.  That's also
true for marking structs as const.  We should probably fix that at some
point, but at least they're not vulnerable to heap overruns by small
amounts ... you have to be able to overrun some other array by terabytes.

It's worth having a discussion about whether we want the pmalloc API
or whether we want a slab-based API.  We can have a separate discussion
about an API to remove pages from the physmap.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
