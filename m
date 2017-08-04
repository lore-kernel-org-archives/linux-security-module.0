From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 4 Aug 2017 10:12:40 +0200
Subject: [RFC] Tagging of vmalloc pages for supporting the pmalloc
	allocator
In-Reply-To: <abe0c086-8c5a-d6fb-63c4-bf75528d0ec5@huawei.com>
References: <07063abd-2f5d-20d9-a182-8ae9ead26c3c@huawei.com>
	<20170802170848.GA3240@redhat.com>
	<8e82639c-40db-02ce-096a-d114b0436d3c@huawei.com>
	<20170803114844.GO12521@dhcp22.suse.cz>
	<c3a250a6-ad4d-d24d-d0bf-4c43c467ebe6@huawei.com>
	<20170803135549.GW12521@dhcp22.suse.cz>
	<20170803144746.GA9501@redhat.com>
	<ab4809cd-0efc-a79d-6852-4bd2349a2b3f@huawei.com>
	<20170803151550.GX12521@dhcp22.suse.cz>
	<abe0c086-8c5a-d6fb-63c4-bf75528d0ec5@huawei.com>
Message-ID: <20170804081240.GF26029@dhcp22.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri 04-08-17 11:02:46, Igor Stoppa wrote:
> 
> 
> On 03/08/17 18:15, Michal Hocko wrote:
> 
> > I would check the one where we have mapping. It is rather unlikely
> > vmalloc users would touch this one.
> 
> That was also the initial recommendation from Jerome Glisse, but it
> seemed unusable, because of the related comment.
> 
> I should have asked for clarifications back then :-(
> 
> But it's never too late ...
> 
> 
> struct page {
>   /* First double word block */
>   unsigned long flags;		/* Atomic flags, some possibly
> 				 * updated asynchronously */
> union {
> 	struct address_space *mapping;	/* If low bit clear, points to
> 					 * inode address_space, or NULL.
> 					 * If page mapped as anonymous
> 					 * memory, low bit is set, and
> 					 * it points to anon_vma object:
> 					 * see PAGE_MAPPING_ANON below.
> 					 */
> ...
> }
> 
> mapping seems to be used exclusively in 2 ways, based on the value of
> its lower bit.

Not really. The above applies to LRU pages. Please note that Slab pages
use s_mem and huge pages use compound_mapcount. If vmalloc pages are
using none of those already you can add a new field there.

-- 
Michal Hocko
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
