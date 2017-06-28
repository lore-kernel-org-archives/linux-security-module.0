From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:39:43 +0200
Subject: [PATCH v2 09/10] ubifs: define integrity_read method
In-Reply-To: <1498069110-10009-10-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-10-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170628143943.GH2359@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 02:18:29PM -0400, Mimi Zohar wrote:
> Define an ->integrity_read file operation method to read data for
> integrity hash collection.

should be folded into patch 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
