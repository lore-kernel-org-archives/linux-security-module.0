From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 18 Sep 2017 10:55:42 -0400
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <20170918101350.GI32516@quack2.suse.cz>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
	<20170917151757.GA14262@infradead.org>
	<CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
	<1505664935.4200.191.camel@linux.vnet.ibm.com>
	<CA+55aFyBhb_hQ84heyWnAP+1vn48Wjpnas0YSUY-R6Ej6bv_Dw@mail.gmail.com>
	<20170917163828.GE5426@ZenIV.linux.org.uk>
	<517c83a6-d7c5-9638-ebaa-52800ca0962c@redhat.com>
	<20170918101350.GI32516@quack2.suse.cz>
Message-ID: <1505746542.4200.242.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-09-18 at 12:13 +0200, Jan Kara wrote:
> On Mon 18-09-17 10:19:25, Steven Whitehouse wrote:
> > On 17/09/17 17:38, Al Viro wrote:
> > >On Sun, Sep 17, 2017 at 09:34:01AM -0700, Linus Torvalds wrote:
> > >>Now, I suspect most (all?) do, but that's a historical artifact rather
> > >>than "design". In particular, the VFS layer used to do the locking for
> > >>the filesystems, to guarantee the POSIX requirements (POSIX requires
> > >>that writes be seen atomically).
> > >>
> > >>But that lock was pushed down into the filesystems, since some
> > >>filesystems really wanted to have parallel writes (particularly for
> > >>direct IO, where that POSIX serialization requirement doesn't exist).
> > >>
> > >>That's all many years ago, though. New filesystems are likely to have
> > >>copied the pattern from old ones, but even then..
> > >>
> > >>Also, it's worth noting that "inode->i_rwlock" isn't even well-defined
> > >>as a lock. You can have the question of *which* inode gets talked
> > >>about when you have things like eoverlayfs etc. Normally it would be
> > >>obvious, but sometimes you'd use "file->f_mapping->host" (which is the
> > >>same thing in the simple cases), and sometimes it really wouldn't be
> > >>obvious at all..
> > >>
> > >>So... I'm really not at all convinced that i_rwsem is sensible. It's
> > >>one of those things that are "mostly right for the simple cases",
> > >>but...
> > >The thing pretty much common to all of them is that write() might need
> > >to modify permissions (suid removal), which brings ->i_rwsem in one
> > >way or another - notify_change() needs that held...
> > 
> > For GFS2, if we are to hold the inode info constant while it is checked, we
> > would need to take a glock (read lock in this case) across the relevant
> > operations. The glock will be happy under i_rwlock, since we have a lock
> > ordering that takes local locks ahead of cluster locks. I've not dug into
> > this enough to figure out whether the current proposal will allow this to
> > work with GFS2 though. Does IMA cache the results from the
> > ->read_integrity() operation?

Up to now, the hash calculation was stored in the iint structure,
which is then used to extend the TPM, verify the file's integrity
compared to the value stored in the xattr, and included in an audit
message.

A new patch set by Thiago Bauermann will add appended signature
support, re-using the kernel module signature appended method, which
might require re-calculating the file hash based on a different hash
algorithm.

> So I have asked Mimi about clustered filesystems before. And for now the
> answer was that IMA for clustered filesystems is not supported (it will
> return some error since ->integrity_read is NULL). If we would ever want to
> support those it would require larger overhaul of the IMA architecture to
> give filesystem more control over the locking (which is essentially what
> Linus wants).

For performance reasons, IMA is not on a write hook, but detects file
change on the last __fput() opened for write. ?At that point, the
cached info is reset. ?The file hash is re-calculated and written out
as an xattr. ?On the next file access (in policy), the file hash is
re-calculated and stored in the iint.

In terms of remote/clustered/fuse filesystems, we wouldn't be on the
__fput() path. ?Support for remote/clustered/fuse filesystems, would
be similar to filesystems that do not support i_version. ?Meaning only
the first file access (in policy) would be measured/appraised, but not
subsequent ones. ?Even if we could detect file change, we would be
dependent on the remote/clustered/fuse filesystem to inform us of the
change. ?What type of integrity guarantees would that provide?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
