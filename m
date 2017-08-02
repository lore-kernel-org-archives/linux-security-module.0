From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 02 Aug 2017 13:11:52 -0400
Subject: [PATCH v4 2/5] ima: use fs method to read integrity data [updated]
In-Reply-To: <20170802080108.GB2732@quack2.suse.cz>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1501075375-29469-3-git-send-email-zohar@linux.vnet.ibm.com>
	<1501619070.3204.4.camel@linux.vnet.ibm.com>
	<20170802080108.GB2732@quack2.suse.cz>
Message-ID: <1501693912.20268.29.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-08-02 at 10:01 +0200, Jan Kara wrote:
> On Tue 01-08-17 16:24:30, Mimi Zohar wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Add a new ->integrity_read file operation to read data for integrity
> > hash collection.  This is defined to be equivalent to ->read_iter,
> > except that it will be called with the i_rwsem held exclusively.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Cc: Matthew Garrett <matthew.garrett@nebula.com>
> > Cc: Jan Kara <jack@suse.com>
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > Cc: Chao Yu <yuchao0@huawei.com>
> > Cc: Steven Whitehouse <swhiteho@redhat.com>
> > Cc: Bob Peterson <rpeterso@redhat.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Dave Kleikamp <shaggy@kernel.org>
> > Cc: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
> > Cc: Mark Fasheh <mfasheh@versity.com>
> > Cc: Joel Becker <jlbec@evilplan.org>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Chris Mason <clm@fb.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> ...
> 
> > +static ssize_t ext4_file_integrity_read_iter(struct kiocb *iocb,
> > +					     struct iov_iter *to)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	int o_direct = iocb->ki_flags & IOCB_DIRECT;
> > +
> > +	lockdep_assert_held(&inode->i_rwsem);
> > +	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> > +		return -EIO;
> > +
> > +	if (!iov_iter_count(to))
> > +		return 0; /* skip atime */
> > +
> > +#ifdef CONFIG_FS_DAX
> > +	if (IS_DAX(inode))
> > +		return dax_iomap_rw(iocb, to, &ext4_iomap_ops);
> > +#endif
> > +	if (o_direct)
> > +		return -EINVAL;
> > +	return generic_file_read_iter(iocb, to);
> > +}
> 
> I have noticed this o_direct check - why is it only in ext4 and shouldn't
> rather higher layers make sure IOCB_DIRECT iocbs cannot reach
> .integrity_read() methods?
 
This failure happens when opening a file with O_DIRECT on a block
device that does not support dax (eg. loop). xfs makes it to here too,
but the call to generic_file_read_iter() fails properly with -EINVAL.?
(Only tested on those filesystems included that support dax (eg. ext2,
ext4, and xfs).)

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
