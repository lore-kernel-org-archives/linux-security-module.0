From: jlayton@redhat.com (Jeff Layton)
Date: Mon, 02 Oct 2017 08:43:40 -0400
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <1506946195.5691.268.camel@linux.vnet.ibm.com>
References: <1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	<1506859691.5691.211.camel@linux.vnet.ibm.com>
	<CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
	<20171001223402.GG15067@dastard>
	<1506901362.5691.247.camel@linux.vnet.ibm.com>
	<20171002043554.GI15067@dastard>
	<1506946195.5691.268.camel@linux.vnet.ibm.com>
Message-ID: <1506948220.1719.11.camel@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-10-02 at 08:09 -0400, Mimi Zohar wrote:
> On Mon, 2017-10-02 at 15:35 +1100, Dave Chinner wrote:
> > On Sun, Oct 01, 2017 at 07:42:42PM -0400, Mimi Zohar wrote:
> > > On Mon, 2017-10-02 at 09:34 +1100, Dave Chinner wrote:
> > > > On Sun, Oct 01, 2017 at 11:41:48AM -0700, Linus Torvalds wrote:
> > > > > On Sun, Oct 1, 2017 at 5:08 AM, Mimi Zohar <zohar@linux.vnet.
> > > > > ibm.com> wrote:
> > > > > > 
> > > > > > Right, re-introducing the iint->mutex and a new
> > > > > > i_generation field in
> > > > > > the iint struct with a separate set of locks should
> > > > > > work.  It will be
> > > > > > reset if the file metadata changes (eg. setxattr, chown,
> > > > > > chmod).
> > > > > 
> > > > > Note that the "inner lock" could possibly be omitted if the
> > > > > invalidation can be just a single atomic instruction.
> > > > > 
> > > > > So particularly if invalidation could be just an atomic_inc()
> > > > > on the
> > > > > generation count, there might not need to be any inner lock
> > > > > at all.
> > > > > 
> > > > > You'd have to serialize the actual measurement with the "read
> > > > > generation count", but that should be as simple as just doing
> > > > > a
> > > > > smp_rmb() between the "read generation count" and "do
> > > > > measurement on
> > > > > file contents".
> > > > 
> > > > We already have a change counter on the inode, which is
> > > > modified on
> > > > any data or metadata write (i_version) under filesystem
> > > > locks.  The
> > > > i_version counter has well defined semantics - it's required by
> > > > NFSv4 to increment on any metadata or data change - so we
> > > > should be
> > > > able to rely on it's behaviour to implement IMA as well.
> > > > Filesystems
> > > > that support i_version are marked with [SB|MS]_I_VERSION in the
> > > > superblock (IS_I_VERSION(inode)) so it should be easy to tell
> > > > if IMA
> > > > can be supported on a specific filesystem (btrfs, ext4, fuse
> > > > and xfs
> > > > ATM).
> > > 
> > > Recently I received a patch to replace i_version with
> > > mtime/atime.
> > 

I assume you're talking here about the patch I sent a few months ago.

I specifically do _not_ want to replace i_version with the mtime/atime.
The point there was to stop trying to use i_version on filesystems that
don't properly implement it (which is most of them).

The next best approximation on those filesystems is the mtime. It's not
perfect, but it's better than nothing (which is what you have now on
filesystems that never increment i_version on writes). IOW, it just
added a fallback for when you can't count on the i_version changing.

(BTW: atime is worthless here -- who cares if the thing was accessed?
IIUC, we only care if something changed.)

Ideally, all filesystems would implement i_version properly. In
practice, that's a tall order as that may require on-disk changes for
some of them. That's not always possible where cross-OS compatibility
is necessary (e.g. FAT or NTFS).

> > mtime is not guaranteed to change on data writes - the resolution
> > of
> > the filesystem timestamps may mean mtime only changes once a second
> > regardless of the number of writes performed to that file. That's
> > why NFS can't use it as a change attribute, and hence we have
> > i_version....
> > 
> > >  Now, even more recently, I received a patch that claims that
> > > i_version is just a performance improvement.
> > 
> > Did you ask them to explain/quantify the performance improvement?
> 
> Using i_version is a performance improvement as opposed to always
> calculating the file hash and writing the xattr.  The patch is
> intended for filesystems that don't support i_version (eg. ubifs).
>  
> > e.g. Using i_version on XFS slows down performance on small
> > writes by 2-3% because i_version because all data writes log a
> > version change rather than only logging a change when mtime
> > updates.
> > We take that penalty because NFS requires specific change attribute
> > behaviour, otherwise we wouldn't have implemented it at all in
> > XFS...
> > 
> > >  For file systems that
> > > don't support i_version, assume that the file has changed.
> > > 
> > > For file systems that don't support i_version, instead of
> > > assuming
> > > that the file has changed, we can at least use i_generation.
> > 
> > I'm not sure what you mean here - the struct inode already has a
> > i_generation variable. It's a lifecycle indicator used to
> > discriminate between alloc/free cycles on the same inode number.
> > i.e. It only changes at inode allocation time, not whenever the
> > data
> > in the inode changes...
> 
> Sigh, my error.
> 
> > 
> > > With Linus' suggested changes, I think this will work nicely.
> > > 
> > > > The IMA code should be able to sample that at measurement time
> > > > and
> > > > either fail or be retried if i_version changes during
> > > > measurement.
> > > > We can then simply make the IMA xattr write conditional on the
> > > > i_version value being unchanged from the sample the IMA code
> > > > passes
> > > > into the filesystem once the filesystem holds all the locks it
> > > > needs
> > > > to write the xattr...
> > > > I note that IMA already grabs the i_version in
> > > > ima_collect_measurement(), so this shouldn't be too hard to do.
> > > > Perhaps we don't need any new locks or counterst all, maybe
> > > > just
> > > > the ability to feed a version cookie to the set_xattr method?
> > > 
> > > The security.ima xattr is normally written out in
> > > ima_check_last_writer(), not in ima_collect_measurement().
> > 
> > Which, if IIUC, does this to measure and update the xattr:
> > 
> > ima_check_last_writer
> >   -> ima_update_xattr
> >     -> ima_collect_measurement
> >     -> ima_fix_xattr
> > 
> > >  ima_collect_measurement() calculates the file hash for storing
> > > in the
> > > measurement list (IMA-measurement), verifying the hash/signature
> > > (IMA-
> > > appraisal) already stored in the xattr, and auditing (IMA-audit).
> > 
> > Yup, and it samples the i_version before it calculates the hash and
> > stores it in the iint, which then gets passed to ima_fix_xattr().
> > Looks like all that is needed is to pass the i_version back to the
> > filesystem through the xattr call....
> > 
> > IOWs, sample the i_version early while we hold the inode lock and
> > check the writer count, then if it is the last writer drop the
> > inode
> > lock and call ima_update_xattr(). The sampled i_version then tells
> > us if the file has changed before we write the updated xattr...
> > 
> > > The only time that ima_collect_measurement() writes the file
> > > xattr is
> > > in "fix" mode.  Writing the xattr will need to be deferred until
> > > after
> > > the iint->mutex is released.
> > 
> > ima_collect_measurement() doesn't write an xattr at all - it just
> > reads the file data and calculates the hash.
> 
> There's another call to ima_fix_xattr() from
> ima_appraise_measurement(). 
> 
> > > There should be no open writers in ima_check_last_writer(), so
> > > the
> > > file shouldn't be changing.
> > 
> > If that code is not holding the inode i_rwsem across
> > ima_update_xattr(), then the writer check is racy as hell.  We're
> > trying to get rid of the need for this code to hold the inode lock
> > to stabilise the writer count for the entire operation, and it
> > looks
> > to me like everything is there to use the i_version to ensure the
> > the IMA code doesn't need to hold the inode lock across
> > ima_collect_measurement() and ima_fix_xattr()...
> 
> Ok
> 
> Mimi
> 
-- 
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
