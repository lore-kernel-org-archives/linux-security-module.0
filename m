From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 08:46:58 +0200
Subject: [PATCH 3/4] ima: use existing read file operation method to
	calculate file hash
In-Reply-To: <1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170613064658.GB31372@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A strong and a weak NAK on this.  For one thing you should not
call ->read for fs code at all - use read_iter where it fits
(it does here) or the kernel_read() helper otherwise.

But once again I don't think this is correct - it's a potentially
unsafe default, so please wire up the file systems actually tested
and known to work manually.

E.g. this does the wrong thing for at least NFS and OCFS2.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
