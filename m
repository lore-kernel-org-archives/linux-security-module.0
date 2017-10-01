From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 01 Oct 2017 19:54:39 -0400
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFwD=+5trJbmuc2SL-DYcdmt2p4gq1uPBp8mznj1JYSVTg@mail.gmail.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	<87shf2jzfr.fsf@xmission.com>
	<CA+55aFwD=+5trJbmuc2SL-DYcdmt2p4gq1uPBp8mznj1JYSVTg@mail.gmail.com>
Message-ID: <1506902079.5691.256.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-10-01 at 15:20 -0700, Linus Torvalds wrote:
> On Sun, Oct 1, 2017 at 3:06 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Unless I misread something it was being pointed out there are some vfs
> > operations today on which ima writes an ima xattr as a side effect.  And
> > those operations hold the i_sem.  So perhaps I am misunderstanding
> > things or writing the ima xattr needs to happen at some point.  Which
> > implies something like queued work.
> 
> So the issue is indeed the inode semaphore, as it is used by IMA. But
> all these IMA patches to work around the issue are just horribly ugly.
> One adds a VFS-layer filesystem method that most filesystems end up
> not really needing (it's the same as the regular read), and other
> filesystems end up then having hacks with ("oh, I don't need to take
> this lock because it was already taken by the caller").
> 
> The second patch attempt avoided the need for a new filesystem method,
> but added a flag in an annoying place (for the same basic logic). The
> advantage is that now most filesystems don't actually need to care any
> more (and the filesystems that used to care now check that flag).
> 
> There was discussion about moving the flag to a mode convenient spot,
> which would have made it a lot less intrusive.
> 
> But the basic issue is that almost always when you see lock
> inversions, the problem can just be fixed by doing the locking
> differently instead.

This is what I've been missing. ?Thank you for taking the time to
understand the problem and explain how!

> And that's what I was/am pushing for.

> There really are two totally different issues:
> 
>  - the integrity _measurement_.
> 
>    This one wants to be serialized, so that you don't have multiple
> concurrent measurements, and the serialization fundamentally has to be
> around all the IO, so this lock pretty much has to be outside the
> i_sem.
> 
>  - the integrity invalidation on certain operations.
> 
>    This one fundamentally had to be inside the i_sem, since some of
> the operations that cause this end up already holding the i_sem at a
> VFS layer.
> 
> so you had these two different requirements (inside _and_ outside),
> and the IMA approach was basically to avoid the problem by making
> i_sem *the* lock, and then making the IO routines aware of it already
> being held. That does solve the inside/outside issue.
> 
> But the simpler way to fix it is to simply use two locks that nest
> inside each other, with i_sem nesting in the middle.  That just avoids
> the problem entirely, and doesn't require anybody to ever care about
> i_sem semantic changes, because i_sem semantics simply didn't change
> at all.
> 
> So that's the approach I'm pushing. I admittedly haven't actually
> looked at the IMA details, but from a high-level standpoint you can
> basically describe it (as above) without having to care too much about
> exactly what IMA even wants.
> 
> The two-lock approach does require that the operations that invalidate
> the integrity measurements always only invalidate it, and don't try to
> re-compute it. But I suspect that would be entirely insane anyway
> (imagine a world where "setxattr" would have to read the whole file
> contents in order to revalidate the integrity measurement - even if
> there is nobody who even *cares*).

Right, the setxattr, chmod, chown syscalls just resets the cached
flags, which indicate whether the file needs to be re-measured, re-
validated, or re-audited. ?The file hash is not re-calculated at this
point. ?That happens on the next access (in policy).

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
