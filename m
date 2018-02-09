From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 9 Feb 2018 09:15:00 -0800
Subject: [PATCH 1/6] genalloc: track beginning of allocations
In-Reply-To: <947ea9c3-b045-17d3-51e5-df80b4fb27e6@huawei.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
	<20180204164732.28241-2-igor.stoppa@huawei.com>
	<60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
	<947ea9c3-b045-17d3-51e5-df80b4fb27e6@huawei.com>
Message-ID: <8b02744c-d527-f000-78c0-90142052b4ae@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/09/2018 08:18 AM, Igor Stoppa wrote:
> 
> 
> On 05/02/18 00:34, Randy Dunlap wrote:
>> On 02/04/2018 08:47 AM, Igor Stoppa wrote:
> 
> [...]
> 
>> It would be good for a lot of this to be in a source file or the
>> pmalloc.rst documentation file instead of living only in the git repository.
> 
> This is actually about genalloc. The genalloc documentation is high
> level and mostly about the API, while this talks about the guts of the
> library. The part modified by the patch. This text doesn't seem to
> belong to the generic genalloc documentation.
> I will move it to the .c file, but isn't it too much text in a source file?

No, that will be fine.

thanks,
-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
