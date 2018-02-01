From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Thu, 1 Feb 2018 14:42:24 +0200
Subject: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-4-igor.stoppa@huawei.com>
	<alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
Message-ID: <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 01/02/18 02:00, Christopher Lameter wrote:
> On Tue, 30 Jan 2018, Igor Stoppa wrote:
> 
>> @@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>
>>  	kmemleak_vmalloc(area, size, gfp_mask);
>>
>> +	for (page_counter = 0; page_counter < area->nr_pages; page_counter++)
>> +		area->pages[page_counter]->area = area;
>> +
>>  	return addr;
> 
> Well this introduces significant overhead for large sized allocation. Does
> this not matter because the areas are small?

Relatively significant?
I do not object to your comment, but in practice i see that:

- vmalloc is used relatively little
- allocations do not seem to be huge
- there seem to be way larger overheads in the handling of virtual pages
  (see my proposal for the LFS/m summit, about collapsing struct
   vm_struct and struct vmap_area)


> Would it not be better to use compound page allocations here?
> page_head(whatever) gets you the head page where you can store all sorts
> of information about the chunk of memory.

Can you please point me to this function/macro? I don't seem to be able
to find it, at least not in 4.15

During hardened user copy permission check, I need to confirm if the
memory range that would be exposed to userspace is a legitimate
sub-range of a pmalloc allocation.


So, I start with the pair (address, size) and I must end up to something
I can compare it against.
The idea here is to pass through struct_page and then the related
vm_struct/vmap_area, which already has the information about the
specific chunk of virtual memory.

I cannot comment on your proposal because I do not know where to find
the reference you made, or maybe I do not understand what you mean :-(

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
