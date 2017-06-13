From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 16:22:08 +0200
Subject: [PATCH 3/4] ima: use existing read file operation method to
	calculate file hash
In-Reply-To: <1497363465.21594.395.camel@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170613064658.GB31372@lst.de>
	<1497363465.21594.395.camel@linux.vnet.ibm.com>
Message-ID: <20170613142208.GA23872@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 13, 2017 at 10:17:45AM -0400, Mimi Zohar wrote:
> Calling ->read directly is intentional. ?Commit C0430e49b6e7c "ima:
> introduce ima_kernel_read()" replaced the call to kernel_read with
> ima_kernel_read(), the non-security checking version of kernel_read().
> ?Subsequently, commit e3c4abbfa97e "integrity: define a new function
> integrity_read_file()" renamed ima_read_file() to
> integrity_read_file().

Again, the point is you should not call ->read for in-kernel reads.

> Both NFS and OCFS define their own specific read_iter(),
> nfs_file_read() and ocfs2_file_read_iter() respectively. ?As these
> file systems have not yet been converted to use ->read_integrity, the
> xfstests fail.

So they will need to be converted.  The xfstests will not just fail,
it will deadlock the calling process with this code.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
