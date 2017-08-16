From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 13:43:45 -0400
Subject: [PATCH v6 4/6] ima: use fs method to read integrity data
In-Reply-To: <20170816131748.GB4898@quack2.suse.cz>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-5-git-send-email-zohar@linux.vnet.ibm.com>
	<20170816131748.GB4898@quack2.suse.cz>
Message-ID: <1502905425.21278.3.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-08-16 at 15:17 +0200, Jan Kara wrote:
> On Tue 15-08-17 10:43:55, Mimi Zohar wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Add a new ->integrity_read file operation to read data for integrity
> > hash collection.  This is defined to be equivalent to ->read_iter,
> > except that it will be called with the i_rwsem held exclusively.
> > 
> > (Based on Christoph's original patch.)
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
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
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
