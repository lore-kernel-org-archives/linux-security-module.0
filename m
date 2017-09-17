From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 17 Sep 2017 01:47:41 -0400
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
Message-ID: <1505627261.4200.161.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2017-09-16 at 11:20 -0700, Linus Torvalds wrote:
> On Fri, Sep 15, 2017 at 1:25 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > To resolve this locking problem, this patch defines a new
> > ->integrity_read file operation method, which is equivalent to
> > ->read_iter, except that it will not take the i_rwsem lock, but will
> > be called with the i_rwsem held exclusively.
> >
> > Since taking the i_rwsem exclusively is not required for reading the
> > file in order to calculate the file hash, the code only verifies
> > that the lock has been taken.
> 
> Ok, so I'm onboard with the commit message now, but realized that I'm
> not actually convinced that i_rwsem is even meaningful.
> 
> Sure, generic_file_write_iter() does take that lock exclusively, but
> not everybody uses generic_file_write_iter() at all for writing.

> For example, xfs still uses that i_rwsem, but for block-aligned writes
> it will only get it shared. And I'm not convinced some other
> filesystem might not end up using some other lock entirely.
> 
> So I'm basically not entirely convinced that these i_rwsem games make
> any sense at all.
> 
> The filesystem can do its own locking, and I'm starting to think that
> it would be better to just pass this "this is an integrity read" down
> to the filesystem, and expect the filesystem to do the locking based
> on that.

IMA would still need to take the i_rwsem to write the xattr. ?Unless
the i_rwsem was taken before calling the integrity_read, calculating
the file hash would be serialized, but would not prevent the file hash
from being calculated multiple times.

(Introducing a new lock would result in the locks being taken in
reverse order for setxattr, chown, chmod syscalls.)

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
