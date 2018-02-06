From: willy@infradead.org (Matthew Wilcox)
Date: Tue, 6 Feb 2018 04:37:35 -0800
Subject: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <20180130151446.24698-4-igor.stoppa@huawei.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-4-igor.stoppa@huawei.com>
Message-ID: <20180206123735.GA6151@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 30, 2018 at 05:14:43PM +0200, Igor Stoppa wrote:
> @@ -1744,6 +1748,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  			const void *caller)
>  {
>  	struct vm_struct *area;
> +	unsigned int page_counter;
>  	void *addr;
>  	unsigned long real_size = size;
>  
> @@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  
>  	kmemleak_vmalloc(area, size, gfp_mask);
>  
> +	for (page_counter = 0; page_counter < area->nr_pages; page_counter++)
> +		area->pages[page_counter]->area = area;
> +
>  	return addr;
>  

LOCAL variable names should be short, and to the point.  If you have
some random integer loop counter, it should probably be called ``i``.
Calling it ``loop_counter`` is non-productive, if there is no chance of it
being mis-understood.  Similarly, ``tmp`` can be just about any type of
variable that is used to hold a temporary value.

(Documentation/process/coding-style.rst)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
