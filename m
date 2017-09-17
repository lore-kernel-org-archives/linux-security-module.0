From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 17 Sep 2017 08:17:57 -0700
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
Message-ID: <20170917151757.GA14262@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 16, 2017 at 11:20:47AM -0700, Linus Torvalds wrote:
> Sure, generic_file_write_iter() does take that lock exclusively, but
> not everybody uses generic_file_write_iter() at all for writing.
> 
> For example, xfs still uses that i_rwsem, but for block-aligned writes
> it will only get it shared. And I'm not convinced some other
> filesystem might not end up using some other lock entirely.

Only for direct I/O, and IMA and direct I/O don't work together.
>From ima_collect_measurement:

		if (file->f_flags & O_DIRECT) {
			audit_cause = "failed(directio)";
			result = -EACCES;
			goto out;
		}

(and yes, it should be checking for IOCB_DIRECT to avoid racy
f_flags manipulations, but that's another issue)

> The filesystem can do its own locking, and I'm starting to think that
> it would be better to just pass this "this is an integrity read" down
> to the filesystem, and expect the filesystem to do the locking based
> on that.

Well, that's exactly the point of the new ->integrity_read routine
I proposed and prototype.  The important thing is that it is called
with i_rwsem held because code mugh higher in the chain already
acquired it, but except for that it's entirely up to the file system.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
