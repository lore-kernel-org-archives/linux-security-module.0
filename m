From: why2jjj.linux@gmail.com (J Freyensee)
Date: Fri, 23 Feb 2018 14:42:57 -0800
Subject: [PATCH 2/7] genalloc: selftest
In-Reply-To: <20180223144807.1180-3-igor.stoppa@huawei.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
	<20180223144807.1180-3-igor.stoppa@huawei.com>
Message-ID: <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> +	locations[action->location] = gen_pool_alloc(pool, action->size);
> +	BUG_ON(!locations[action->location]);

Again, I'd think it through if you really want to use BUG_ON() or not:

https://lwn.net/Articles/13183/
https://lkml.org/lkml/2016/10/4/1

Thanks,
Jay

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
