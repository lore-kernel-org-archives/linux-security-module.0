From: willy@infradead.org (Matthew Wilcox)
Date: Tue, 6 Mar 2018 06:13:17 -0800
Subject: [PATCH 1/7] genalloc: track beginning of allocations
In-Reply-To: <20180306131856.GD19349@rapoport-lnx>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
	<20180228200620.30026-2-igor.stoppa@huawei.com>
	<20180306131856.GD19349@rapoport-lnx>
Message-ID: <20180306141317.GC13722@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 06, 2018 at 02:19:03PM +0100, Mike Rapoport wrote:
> > +/**
> > + * gen_pool_create() - create a new special memory pool
> > + * @min_alloc_order: log base 2 of number of bytes each bitmap entry
> > + *		     represents
> > + * @nid: node id of the node the pool structure should be allocated on,
> > + *	 or -1
> > + *
> > + * Create a new special memory pool that can be used to manage special
> > + * purpose memory not managed by the regular kmalloc/kfree interface.
> > + *
> > + * Return:
> > + * * pointer to the pool	- success
> > + * * NULL			- otherwise
> > + */
> 
> If I'm not mistaken, several kernel-doc descriptions are duplicated now.
> Can you please keep a single copy? ;-)

I think the problem is that Igor has chosen to put the kernel-doc with
the function declaration.  I think we usually recommend putting it with
the definition so it's more likely to be updated.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
