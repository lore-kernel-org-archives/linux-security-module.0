From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Fri, 26 Jan 2018 21:41:35 +0200
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180124175631.22925-5-igor.stoppa@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
	<20180124175631.22925-5-igor.stoppa@huawei.com>
Message-ID: <c5ae2b4f-4a60-1526-0512-51f1c9a5e4a8@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 24/01/18 19:56, Igor Stoppa wrote:

[...]

> +bool pmalloc_prealloc(struct gen_pool *pool, size_t size)
> +{

[...]

> +abort:
> +	vfree(chunk);

this should be vfree_atomic()

[...]

> +void *pmalloc(struct gen_pool *pool, size_t size, gfp_t gfp)
> +{

[...]

> +free:
> +	vfree(chunk);

and this one too

I will fix them in the next iteration.
I am waiting to see if any more comments arrive.
Otherwise, I'll send it out probably next Tuesday.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
