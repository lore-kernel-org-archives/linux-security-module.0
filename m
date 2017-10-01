From: david@fromorbit.com (Dave Chinner)
Date: Mon, 2 Oct 2017 09:34:02 +1100
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
References: <20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	<1506859691.5691.211.camel@linux.vnet.ibm.com>
	<CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
Message-ID: <20171001223402.GG15067@dastard>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 01, 2017 at 11:41:48AM -0700, Linus Torvalds wrote:
> On Sun, Oct 1, 2017 at 5:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > Right, re-introducing the iint->mutex and a new i_generation field in
> > the iint struct with a separate set of locks should work.  It will be
> > reset if the file metadata changes (eg. setxattr, chown, chmod).
> 
> Note that the "inner lock" could possibly be omitted if the
> invalidation can be just a single atomic instruction.
> 
> So particularly if invalidation could be just an atomic_inc() on the
> generation count, there might not need to be any inner lock at all.
> 
> You'd have to serialize the actual measurement with the "read
> generation count", but that should be as simple as just doing a
> smp_rmb() between the "read generation count" and "do measurement on
> file contents".

We already have a change counter on the inode, which is modified on
any data or metadata write (i_version) under filesystem locks.  The
i_version counter has well defined semantics - it's required by
NFSv4 to increment on any metadata or data change - so we should be
able to rely on it's behaviour to implement IMA as well. Filesystems
that support i_version are marked with [SB|MS]_I_VERSION in the
superblock (IS_I_VERSION(inode)) so it should be easy to tell if IMA
can be supported on a specific filesystem (btrfs, ext4, fuse and xfs
ATM).

The IMA code should be able to sample that at measurement time and
either fail or be retried if i_version changes during measurement.
We can then simply make the IMA xattr write conditional on the
i_version value being unchanged from the sample the IMA code passes
into the filesystem once the filesystem holds all the locks it needs
to write the xattr...

I note that IMA already grabs the i_version in
ima_collect_measurement(), so this shouldn't be too hard to do.
Perhaps we don't need any new locks or counters at all, maybe just
the ability to feed a version cookie to the set_xattr method?

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
