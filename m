From: rdunlap@infradead.org (Randy Dunlap)
Date: Sun, 4 Feb 2018 16:14:01 -0800
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <20180204230346.GA12502@bombadil.infradead.org>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
	<20180204164732.28241-3-igor.stoppa@huawei.com>
	<e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
	<20180204230346.GA12502@bombadil.infradead.org>
Message-ID: <02f42250-949b-83af-f030-159fc46f6f81@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/04/2018 03:03 PM, Matthew Wilcox wrote:
> On Sun, Feb 04, 2018 at 02:19:22PM -0800, Randy Dunlap wrote:
>>> +#ifndef __GENALLOC_SELFTEST_H__
>>> +#define __GENALLOC_SELFTEST_H__
>>
>> Please use _LINUX_GENALLOC_SELFTEST_H_
> 
> willy at bobo:~/kernel/linux$ git grep define.*_H__$ include/linux/*.h |wc -l
> 98
> willy at bobo:~/kernel/linux$ git grep define.*_H_$ include/linux/*.h |wc -l
> 110
> willy at bobo:~/kernel/linux$ git grep define.*_H$ include/linux/*.h |wc -l
> 885
> 
> No trailing underscore is 8x as common as one trailing underscore.

OK, ack.

thanks,
-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
