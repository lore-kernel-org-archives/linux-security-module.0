From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:38:58 +0200
Subject: [PATCH v2 05/10] tmpfs: define integrity_read method
In-Reply-To: <1498069110-10009-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-6-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170628143858.GD2359@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 02:18:25PM -0400, Mimi Zohar wrote:
> Define an ->integrity_read file operation method to read data for
> integrity hash collection.

should be folded into patch 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
