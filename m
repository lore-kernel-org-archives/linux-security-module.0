From: dchinner@redhat.com (Dave Chinner)
Date: Tue, 20 Feb 2018 12:21:11 +1100
Subject: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
In-Reply-To: <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
	<CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
Message-ID: <20180220012111.GC3728@rh>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Feb 12, 2018 at 03:32:36PM -0800, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> > This patch-set introduces the possibility of protecting memory that has
> > been allocated dynamically.
> >
> > The memory is managed in pools: when a memory pool is turned into R/O,
> > all the memory that is part of it, will become R/O.
> >
> > A R/O pool can be destroyed, to recover its memory, but it cannot be
> > turned back into R/W mode.
> >
> > This is intentional. This feature is meant for data that doesn't need
> > further modifications after initialization.
> 
> This series came up in discussions with Dave Chinner (and Matthew
> Wilcox, already part of the discussion, and others) at LCA. I wonder
> if XFS would make a good initial user of this, as it could allocate
> all the function pointers and other const information about a
> superblock in pmalloc(), keeping it separate from the R/W portions?
> Could other filesystems do similar things?

I wasn't cc'd on this patchset, (please use david at fromorbit.com for
future postings) so I can't really say anything about it right
now. My interest for XFS was that we have a fair amount of static
data in XFS that we set up at mount time and it never gets modified
after that. I'm not so worried about VFS level objects (that's a
much more complex issue) but there is a lot of low hanging fruit in
the XFS structures we could convert to write-once structures.

Cheers,

Dave.
-- 
Dave Chinner
dchinner at redhat.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
