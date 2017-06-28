From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:39:12 +0200
Subject: [PATCH v2 06/10] fs: define integrity_read method for ext2,
	gfs2, f2fs, jfs, ramfs
In-Reply-To: <1498069110-10009-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-7-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170628143912.GE2359@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 02:18:26PM -0400, Mimi Zohar wrote:
> Define ->integrity_read file operation methods to read data for
> integrity hash collection.

should be folded into patch 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
