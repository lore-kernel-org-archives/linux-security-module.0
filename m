From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 13 Jun 2017 10:17:45 -0400
Subject: [PATCH 3/4] ima: use existing read file operation method to
	calculate file hash
In-Reply-To: <20170613064658.GB31372@lst.de>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170613064658.GB31372@lst.de>
Message-ID: <1497363465.21594.395.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-06-13 at 08:46 +0200, Christoph Hellwig wrote:
> A strong and a weak NAK on this.  For one thing you should not
> call ->read for fs code at all - use read_iter where it fits
> (it does here) or the kernel_read() helper otherwise.

Calling ->read directly is intentional. ?Commit C0430e49b6e7c "ima:
introduce ima_kernel_read()" replaced the call to kernel_read with
ima_kernel_read(), the non-security checking version of kernel_read().
?Subsequently, commit e3c4abbfa97e "integrity: define a new function
integrity_read_file()" renamed ima_read_file() to
integrity_read_file().

> But once again I don't think this is correct - it's a potentially
> unsafe default, so please wire up the file systems actually tested
> and known to work manually.
> 
> E.g. this does the wrong thing for at least NFS and OCFS2.

Both NFS and OCFS define their own specific read_iter(),
nfs_file_read() and ocfs2_file_read_iter() respectively. ?As these
file systems have not yet been converted to use ->read_integrity, the
xfstests fail.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
