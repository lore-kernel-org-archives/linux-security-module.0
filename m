From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Wed, 28 Feb 2018 22:35:35 +0300
Subject: [PATCH] security: mark kmem caches as __ro_after_init
In-Reply-To: <050858c8-2a7d-d53d-d50a-a3218364d140@tycho.nsa.gov>
References: <20180226203747.GB6886@avx2>
	<CAHC9VhSx4--OpFNv_NXb9LYrKTqRG6jR1WKuyWhVHO=YSjK3kA@mail.gmail.com>
	<050858c8-2a7d-d53d-d50a-a3218364d140@tycho.nsa.gov>
Message-ID: <20180228193535.GA2083@avx2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 28, 2018 at 09:34:07AM -0500, Stephen Smalley wrote:
> On 02/27/2018 05:19 PM, Paul Moore wrote:
> > This is why we don't mark avtab_cache_init() with the __init macro.
> 
> NB My "selinux: wrap global selinux state" patch moves this
> initialization to selinux_init(), at which point we can in fact mark
> these caches this way.  I think that is more correct anyway, but it was
> specifically motivated by the fact that we only want to perform this
> initialization once and first policy load becomes a per-state/namespace
> operation.

I got confused by SLAB_PANIC markings.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
