From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 26 Feb 2018 14:11:58 +0200
Subject: [PATCH 2/7] genalloc: selftest
In-Reply-To: <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
	<20180223144807.1180-3-igor.stoppa@huawei.com>
	<76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
Message-ID: <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 24/02/18 00:42, J Freyensee wrote:
> 
>> +	locations[action->location] = gen_pool_alloc(pool, action->size);
>> +	BUG_ON(!locations[action->location]);
> 
> Again, I'd think it through if you really want to use BUG_ON() or not:
> 
> https://lwn.net/Articles/13183/
> https://lkml.org/lkml/2016/10/4/1

Is it acceptable to display only a WARNing, in case of risking damaging
a mounted filesystem?

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
