From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 10 Jul 2017 11:12:41 -0400
Subject: [Linux-ima-devel] [PATCH 3/4] ima: use existing read file
	operation method to calculate file hash
In-Reply-To: <CACE9dm8SVrkVm+5MmDg+BTGiJYzoqwB-jCCXJ5ac8xkG65qAcw@mail.gmail.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
	<CACE9dm8SVrkVm+5MmDg+BTGiJYzoqwB-jCCXJ5ac8xkG65qAcw@mail.gmail.com>
Message-ID: <1499699561.6034.129.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-07-10 at 17:03 +0300, Dmitry Kasatkin wrote:
> On Fri, Jun 9, 2017 at 9:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > The few filesystems that currently define the read file operation
> > method, either call seq_read() or have a filesystem specific read
> > method.  None of them, at least in the fs directory, take the
> > i_rwsem.
> >
> > Since some files on these filesystems were previously
> > measured/appraised, not measuring them would change the PCR hash
> > value(s), possibly breaking userspace.  For filesystems that do
> > not define the integrity_read file operation method and have a
> > read method, use the read method to calculate the file hash.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  security/integrity/iint.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index c5489672b5aa..e3ef3fba16dc 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -189,20 +189,29 @@ int integrity_kernel_read(struct file *file, loff_t offset,
> >         struct iovec iov = { .iov_base = addr, .iov_len = count };
> >         struct kiocb kiocb;
> >         struct iov_iter iter;
> > -       ssize_t ret;
> > +       ssize_t ret = -EBADF;
> >
> >         lockdep_assert_held(&inode->i_rwsem);
> >
> >         if (!(file->f_mode & FMODE_READ))
> >                 return -EBADF;
> > -       if (!file->f_op->integrity_read)
> > -               return -EBADF;
> >
> >         init_sync_kiocb(&kiocb, file);
> >         kiocb.ki_pos = offset;
> >         iov_iter_init(&iter, READ | ITER_KVEC, &iov, 1, count);
> >
> > -       ret = file->f_op->integrity_read(&kiocb, &iter);
> > +       if (file->f_op->integrity_read) {
> > +               ret = file->f_op->integrity_read(&kiocb, &iter);
> > +       } else if (file->f_op->read) {
> > +               mm_segment_t old_fs;
> > +               char __user *buf = (char __user *)addr;
> > +
> > +               old_fs = get_fs();
> > +               set_fs(get_ds());
> > +               ret = file->f_op->read(file, buf, count, &offset);
> > +               set_fs(old_fs);
> > +       }
> 
> Hi,
> 
> Original code was using "__vfs_read()".
> Patch 1 replaced use of it by ->integrity_read.
> This patch re-added f_op->read() directly...
> 
> While __vfs_read() did it differently
> 
> if (file->f_op->read)
>          return file->f_op->read(file, buf, count, pos);
> else if (file->f_op->read_iter)
>          return new_sync_read(file, buf, count, pos);
> 
> 
> Is avoiding use of __vfs_read() is intentional?

Yes, some filesystems ->read_iter attempt to take the i_rwsem, which
IMA has already taken. ?This patch set introduces a new file operation
method ->integrity_read, which reads the file without re-taking the
lock. ?(This method should probably be renamed ->integrity_read_iter.)

The next version of this patch set will remove this patch, unless
someone provides a reason for needing it. ?At that point, a new method
equivalent to ->read would need to be defined.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
