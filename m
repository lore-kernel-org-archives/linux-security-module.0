From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:38:25 +0200
Subject: [PATCH v2 02/10] ima: use fs method to read integrity data
In-Reply-To: <1498069110-10009-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170628143825.GC2359@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 02:18:22PM -0400, Mimi Zohar wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Add a new ->integrity_read file operation to read data for integrity
> hash collection.  This is defined to be equivalent to ->read_iter,
> except that it will be called with the i_rwsem held exclusively.
> 
> Changelog v2:
> - change iovec to kvec
> 
> Changelog v1:
> - update the patch description, removing the concept that the presence of
> ->integrity_read indicates that the file system can support IMA. (Mimi)

Changelog goes below the ---
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
