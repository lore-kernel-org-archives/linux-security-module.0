From: willy@infradead.org (Matthew Wilcox)
Date: Mon, 26 Mar 2018 19:31:10 -0700
Subject: [PATCH 3/6] Protectable Memory
In-Reply-To: <20180327015524.14318-4-igor.stoppa@huawei.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
	<20180327015524.14318-4-igor.stoppa@huawei.com>
Message-ID: <20180327023110.GD10054@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 27, 2018 at 04:55:21AM +0300, Igor Stoppa wrote:
> +static inline void *pmalloc_array_align(struct pmalloc_pool *pool,
> +					size_t n, size_t size,
> +					short int align_order)
> +{

You're missing:

        if (size != 0 && n > SIZE_MAX / size)
                return NULL;

> +	return pmalloc_align(pool, n * size, align_order);
> +}

> +static inline void *pcalloc_align(struct pmalloc_pool *pool, size_t n,
> +				  size_t size, short int align_order)
> +{
> +	return pzalloc_align(pool, n * size, align_order);
> +}

Ditto.

> +static inline void *pcalloc(struct pmalloc_pool *pool, size_t n,
> +			    size_t size)
> +{
> +	return pzalloc_align(pool, n * size, PMALLOC_ALIGN_DEFAULT);
> +}

If you make this one:

	return pcalloc_align(pool, n, size, PMALLOC_ALIGN_DEFAULT)

then you don't need the check in this function.

Also, do we really need 'align' as a parameter to the allocator functions
rather than to the pool?

I'd just reuse ARCH_KMALLOC_MINALIGN from slab.h as the alignment, and
then add the special alignment options when we have a real user for them.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
