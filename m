From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Wed, 23 May 2018 18:24:28 -0400
Subject: [PATCH 4/6] openvswitch: convert to genradix
In-Reply-To: <20180523123401.GB19987@bombadil.infradead.org>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-4-kent.overstreet@gmail.com>
	<20180523123401.GB19987@bombadil.infradead.org>
Message-ID: <20180523222428.GC23040@kmo-pixel>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 23, 2018 at 05:34:01AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:19PM -0400, Kent Overstreet wrote:
> > the new generic radix trees have a simpler API and implementation, and
> > no limitations on number of elements, so all flex_array users are being
> > converted
> 
> This doesn't really feel like it should be a flexarray / genradix user.
> It just wants to allocate a lot of buckets and use them.  Maybe kvmalloc
> is the right approach for this user of flexarray?

Yeah probably, or a rhashtable.

Now that you mention it, I think the md code should definitely be using kvmalloc
too.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
