From: jack@suse.cz (Jan Kara)
Date: Tue, 8 Aug 2017 13:17:56 +0200
Subject: [PATCH v4 2/5] ima: use fs method to read integrity data [updated]
In-Reply-To: <1502136771.24050.30.camel@linux.vnet.ibm.com>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1501075375-29469-3-git-send-email-zohar@linux.vnet.ibm.com>
	<1501619070.3204.4.camel@linux.vnet.ibm.com>
	<20170802080108.GB2732@quack2.suse.cz>
	<1501693912.20268.29.camel@linux.vnet.ibm.com>
	<20170803105631.GB2579@quack2.suse.cz>
	<1501880831.27872.153.camel@linux.vnet.ibm.com>
	<20170807100445.GB6470@quack2.suse.cz>
	<1502136771.24050.30.camel@linux.vnet.ibm.com>
Message-ID: <20170808111756.GA20321@quack2.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon 07-08-17 16:12:51, Mimi Zohar wrote:
> On Mon, 2017-08-07 at 12:04 +0200, Jan Kara wrote:
> > > For DAX, unlike do_blockdev_direct_IO() which takes the lock, reading
> > > the file with O_DIRECT is fine, as dax_iomap_rw() only checks that the
> > > lock has been taken. ?Assuming the file system is mounted with
> > > i_version, the file hash is updated properly.
> > 
> > Yes, for DAX direct IO is basically no different but frankly I would just
> > refuse O_DIRECT on DAX inodes as well just for the consistency sake.
> 
> Ok. ?So I shouldn't revert the original commit, which fails the
> O_DIRECT open for either the buffered read or DAX. ?I'll just move the
> code to a bit later, so that the failure is added to the measurement
> list.
> 
> The original commit returned -EACCES.??On xfs, the open for direct IO
> buffer read fails with -EINVAL.??Do you have a preference IMA should
> return?

Not really. -EINVAL is more traditional when direct IO is not supported but
since IMA denies access to the file, -EACCES makes sense as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
