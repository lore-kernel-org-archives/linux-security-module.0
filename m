From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 26 Feb 2018 18:37:36 +0200
Subject: [PATCH 3/7] struct page: add field for vm_struct
In-Reply-To: <20180225033808.GB15796@bombadil.infradead.org>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
	<20180223144807.1180-4-igor.stoppa@huawei.com>
	<20180225033808.GB15796@bombadil.infradead.org>
Message-ID: <5ec5d25a-dbf2-5be4-b449-3704254f8117@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 25/02/18 05:38, Matthew Wilcox wrote:
> On Fri, Feb 23, 2018 at 04:48:03PM +0200, Igor Stoppa wrote:
>> @@ -1769,6 +1771,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>  
>>  	kmemleak_vmalloc(area, size, gfp_mask);
>>  
>> +	for (i = 0; i < area->nr_pages; i++)
>> +		area->pages[i]->area = area;
>> +
>>  	return addr;
>>  
>>  fail:
> 
> IMO, this is the wrong place to initialise the page->area.  It should be
> done in __vmalloc_area_node() like so:
> 
>                         area->nr_pages = i;
>                         goto fail;
>                 }
> +		page->area = area;
>                 area->pages[i] = page;
>                 if (gfpflags_allow_blocking(gfp_mask))
>                         cond_resched();
> 


ok

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
